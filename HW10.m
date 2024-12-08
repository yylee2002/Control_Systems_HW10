close all; clear; clc;

%% The system
s = tf('s');
sysG = 5 / (s * (s+1) * (s/5+1));

fig = figure(Name = "G Bode Plot");
bode(sysG);
margin(sysG);
lines = findobj(gcf, 'Type', 'line');
set(lines, 'LineWidth', 2);  % Set all lines to a thicker width of 2
grid on;
% title("");
% axis([-inf, 2, -inf, inf]);
legend("$G(s)$", 'Interpreter', 'latex');
set(fig, "position", [100, 150, 800, 450]);
%saveas(fig, "HW10/Fig/G_Bode_Plot");
%saveas(fig, "HW10/Fig/G_Bode_Plot.png");

%% The lead compensation
wmax = 5;
alpha = 1/11;
TD = 1 / wmax / sqrt(alpha);
sysD = (TD * s + 1) / (alpha * TD * s + 1);

sysDG = (sysD * sysG); % The forward gain

fig2 = figure(Name = "DG Bode Plot");
bode(sysDG);
margin(sysDG);
lines = findobj(gcf, 'Type', 'line');
set(lines, 'LineWidth', 2);  % Set all lines to a thicker width of 2
grid on;
% title("");
% axis([-inf, 2, -inf, inf]);
wval = sprintf("%g", wmax);
aval = sprintf("%g", alpha);
legend("$\omega\_\mathrm{max}=" + wval + "$ rad/s; $\alpha=" + aval + "$", 'interpreter', 'latex');
set(fig2, "position", [200, 150, 800, 450]);
%figname = strrep("HW10/Fig/H_Bode_Plot_" + wval + "_" + aval, '.', 'p');
%saveas(fig2, figname);
%saveas(fig2, figname + ".png");

%% The closed-loop system
sysHcls = sysDG / (1 + sysDG);

fig3 = figure(Name = "H Bode Plot");
bode(sysHcls);
lines = findobj(gcf, 'Type', 'line');
set(lines, 'LineWidth', 2);  % Set all lines to a thicker width of 2
grid on;
% title("");
% axis([-inf, 2, -inf, inf]);
set(fig3, "position", [300, 150, 800, 450]);
%figname = "HW10/Fig/Hcls_Bode_Plot";
%saveas(fig3, figname);
%saveas(fig3, figname + ".png");

fig4 = figure(Name = "H Step Response");
step(sysHcls);
lines = findobj(gcf, 'Type', 'line');
set(lines, 'LineWidth', 2);  % Set all lines to a thicker width of 2
grid on;
% title("");
axis([-inf, 5, -inf, inf]);
set(fig4, "position", [400, 150, 800, 450]);
%figname = "HW10/Fig/Hcls_Step_Response";
%saveas(fig4, figname);
%saveas(fig4, figname + ".png");
