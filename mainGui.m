function varargout = mainGui(varargin)
% MAINGUI MATLAB code for mainGui.fig
%      MAINGUI, by itself, creates a new MAINGUI or raises the existing
%      singleton*.
%
%      H = MAINGUI returns the handle to a new MAINGUI or the handle to
%      the existing singleton*.
%
%      MAINGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINGUI.M with the given input arguments.
%
%      MAINGUI('Property','Value',...) creates a new MAINGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mainGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mainGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mainGui

% Last Modified by GUIDE v2.5 22-Apr-2015 13:45:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mainGui_OpeningFcn, ...
                   'gui_OutputFcn',  @mainGui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before mainGui is made visible.
function mainGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mainGui (see VARARGIN)

% Choose default command line output for mainGui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mainGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mainGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenuX.
function popupmenuX_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuX contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuX


% --- Executes during object creation, after setting all properties.
function popupmenuX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuY.
function popupmenuY_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuY contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuY


% --- Executes during object creation, after setting all properties.
function popupmenuY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonLoadXLS.
function pushbuttonLoadXLS_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonLoadXLS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.fileName = uigetfile('*.xlsx');
guidata(hObject, handles);
setPopupmenuString(handles.popupmenuX, eventdata, handles);
setPopupmenuString(handles.popupmenuY, eventdata, handles);
set(handles.popupmenuX,'callback',@(hObject,eventdata)mainGui('updateAxes',hObject,eventdata,guidata(hObject)));
set(handles.popupmenuY,'callback',@(hObject,eventdata)mainGui('updateAxes',hObject,eventdata,guidata(hObject)));



function setPopupmenuString(hObject, eventdata, handles);
fileName = handles.fileName;
[numbers, colNames] = xlsread(fileName);
set(hObject, 'string', colNames);


function [x, y] = read_excel(fileName, xcol, ycol)

a = xlsread(fileName);
x = a(:,xcol);
y = a(:,ycol);

function updateAxes(hObject, eventdata, handles)

xcol = get(handles.popupmenuX, 'value');
ycol = get(handles.popupmenuY, 'value');
fileName = handles.fileName;

[x, y] = read_excel(fileName, xcol, ycol);

plot(handles.axes1, x,y, 'r+');


xlabel_struct = get(handles.popupmenuX);
ylabel_struct = get(handles.popupmenuY);
xlabel_string = xlabel_struct.String{xcol,1};
ylabel_string = ylabel_struct.String{ycol,1};
set(handles.textXaxis, 'string', xlabel_string);
set(handles.textYaxis, 'string', ylabel_string);

