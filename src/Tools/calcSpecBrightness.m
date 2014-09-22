function out = calcSpecBrightness(spec,fHz,cutoffHz)
%calcSpecBrightness   Compute the spectral birghtness, which is related to
%   the amount of energy above a predefined cutoff frequency. 
%   
%USAGE
%        out = calcSpecBrightness(spec,fHz,cutoffHz)
%
%INPUT ARGUMENTS
%       spec : spectrum [nFrames x nFreq]
%        fHz : frequency vector in Hertz [nFreq x 1]
%   cutoffHz : cutoff frequency in Hertz (default, cutoffHz = 1500)
% 
%OUTPUT ARGUMENTS
%        out : spectral brightness in Hertz [nFrames x 1]
% 
%REFERENCES
%   [1] K. Friedrichs and C. Weihs (2012). "Comparing timbre estimation
%       using auditory models with and without hearing loss", SFB 823, Nr.
%       51.


%   Developed with Matlab 8.1.0.604 (R2013a). Please send bug reports to:
%   
%   Author  :  Tobias May, � 2013
%              Technical University of Denmark
%              tobmay@elektro.dtu.dk
%
%   History :
%   v.0.1   2013/09/06
%   ***********************************************************************
   
    
%% ***********************  CHECK INPUT ARGUMENTS  ************************
% 
% 
% Check for proper input arguments
if nargin < 2 || nargin > 3
    help(mfilename);
    error('Wrong number of input arguments!')
end

% Set default parameter
if nargin < 3 || isempty(cutoffHz); cutoffHz = 1500; end

% Determine size of input data
nFreqReal = size(spec,2);

% Check size of frequency vector
if nFreqReal ~= numel(fHz)
    error('Frequency vector does not match size of spectrum!')
else
    % Ensure fHz is a row vector
    fHz = fHz(:).';
end

% Check if cutoffHz is within a valid frequency range
if cutoffHz < fHz(1) || cutoffHz > fHz(end)
    error('Cutoff must be within the spectrum frequency range.')
end


%% **************************  COMPUTE FEATURE  ***************************
% 
%
% Prevent division by zero
epsilon = 1E-15;

% Spectral brightness
out = sum(spec(:,fHz > cutoffHz),2) ./ (sum(spec,2) + epsilon);


%   ***********************************************************************
%   This program is free software: you can redistribute it and/or modify
%   it under the terms of the GNU General Public License as published by
%   the Free Software Foundation, either version 3 of the License, or
%   (at your option) any later version.
% 
%   This program is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%   GNU General Public License for more details.
% 
%   You should have received a copy of the GNU General Public License
%   along with this program.  If not, see <http://www.gnu.org/licenses/>.
%   ***********************************************************************