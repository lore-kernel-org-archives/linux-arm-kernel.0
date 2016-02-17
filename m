From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Wed, 17 Feb 2016 14:09:02 +0100
Subject: Using i.MX6 quad's IPU#1/DI#1 to drive parallel port #1 failed
In-Reply-To: <201602171210.14545.jbe@pengutronix.de>
References: <201602171210.14545.jbe@pengutronix.de>
Message-ID: <20160217140902.5e24c074@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 17 Feb 2016 12:10:14 +0100 Juergen Borleis wrote:
> Hi,
> 
> someone here who has a working display (or similar) connected to i.MX6 quad's 
> parallel port #1 and driven by IPU#1/DI#1? It seems there is currently no user 
> in the mainline supported boards.
> 
I've got a working configuration with two DVI adapters connected to the
DI0 and DI1 ports on an i.MX6Q board.

The relevant portion of the .dts file looks like this:
	ipu1_disp0: display at di0 {
		compatible = "fsl,imx-parallel-display";
		pinctrl-names = "default";
		pinctrl-0 = <&pinctrl_disp0_1>;
		interface-pix-fmt = "rgb24";
		status = "okay";

		display-timings {
			native-mode = <&vga0>;

			full-hd {
				clock-frequency = <138500000>;
				hactive = <1920>;
				vactive = <1080>;
				hback-porch = <88>;
				hsync-len = <128>;
				hfront-porch = <40>;
				vback-porch = <33>;
				vsync-len = <2>;
				vfront-porch = <10>;
				hsync-active = <0>;
				vsync-active = <0>;
				de-active = <1>;
				pixelclk-active = <1>;
			};

			vga0: VGA {
				clock-frequency = <25200000>;
				hactive = <640>;
				vactive = <480>;
				hback-porch = <48>;
				hsync-len = <96>;
				hfront-porch = <16>;
				vback-porch = <31>;
				vsync-len = <2>;
				vfront-porch = <12>;
				hsync-active = <0>;
				vsync-active = <0>;
				de-active = <1>;
				pixelclk-active = <0>;
			};
		};

		port {
			display0_in: endpoint {
				remote-endpoint = <&ipu1_di0_disp0>;
			};
		};
	};

	ipu1_disp1: display at di1 {
		compatible = "fsl,imx-parallel-display";
		interface-pix-fmt = "rgb24";
		pinctrl-names = "default";
		pinctrl-0 = <&pinctrl_disp1>;
		status = "okay";

		display-timings {
			native-mode = <&vga1>;

			full-hd {
				clock-frequency = <138500000>;
				hactive = <1920>;
				vactive = <1080>;
				hback-porch = <88>;
				hsync-len = <128>;
				hfront-porch = <40>;
				vback-porch = <33>;
				vsync-len = <2>;
				vfront-porch = <10>;
				hsync-active = <0>;
				vsync-active = <0>;
				de-active = <1>;
				pixelclk-active = <1>;
			};

			vga1: VGA {
				clock-frequency = <25200000>;
				hactive = <640>;
				vactive = <480>;
				hback-porch = <48>;
				hsync-len = <96>;
				hfront-porch = <16>;
				vback-porch = <31>;
				vsync-len = <2>;
				vfront-porch = <12>;
				hsync-active = <0>;
				vsync-active = <0>;
				de-active = <1>;
				pixelclk-active = <0>;
			};
		};

		port {
			display1_in: endpoint {
				remote-endpoint = <&ipu1_di0_disp1>;
			};
		};
	};

	lcd0_panel: panel0 {
		compatible = "auo,b133htn01", "simple-panel";
		power-supply = <&reg_lcd1_pwr>;
		ddc-i2c-bus = <&i2c2>;
	};

	lcd1_panel: lcd-panel {
		compatible = "auo,b133htn01", "simple-panel";
		power-supply = <&reg_lcd1_pwr>;
		ddc-i2c-bus = <&i2c1>;
	};


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
