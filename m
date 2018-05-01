From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 1 May 2018 16:58:22 +0530
Subject: [PATCH V2] DTS: davinci: da850evm: Enable LCD and Backlight
In-Reply-To: <20180427021854.12850-1-aford173@gmail.com>
References: <20180427021854.12850-1-aford173@gmail.com>
Message-ID: <4831b4f3-fe08-2cb1-a95d-8c83bb9fcc2f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Adam,

On Friday 27 April 2018 07:48 AM, Adam Ford wrote:
> When using the board files the LCD works, but not with the DT.
> This adds enables the original da850-evm to work with the same
> LCD in device tree mode.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Can you please cc the devicetree list too for next time? Also, please
watch the subject prefix. Just do 'git log --oneline' on the file you
are touching - its impossible to remember the right one to use.

> ---
> V2:  Add regulator and GPIO enable pins. Remove PWM backlight and replace with GPIO  
>  arch/arm/boot/dts/da850-evm.dts | 63 +++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> index 11cf3765214f..4c59dab3362e 100644
> --- a/arch/arm/boot/dts/da850-evm.dts
> +++ b/arch/arm/boot/dts/da850-evm.dts
> @@ -164,6 +164,51 @@
>  			status = "okay";
>  		};
>  	};
> +
> +	backlight {
> +		compatible = "gpio-backlight";
> +		enable-gpios = <&gpio 48 GPIO_ACTIVE_HIGH>;

Which schematic symbol does this correspond to? In the schematic I have
GP3[0] does not look connected to anything related to LCD.

> +		default-on;
> +	};
> +
> +	panel {
> +		compatible = "ti,tilcdc,panel";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&lcd_pins>;
> +		status = "okay";
		
		/* M_LCD_BACKLIGHT_PWR */
> +		enable-gpios = <&gpio 47 GPIO_ACTIVE_HIGH>;
> +
> +		panel-info {
> +			ac-bias		= <255>;
> +			ac-bias-intrpt	= <0>;
> +			dma-burst-sz	= <16>;
> +			bpp		= <16>;
> +			fdd		= <0x80>;
> +			sync-edge	= <0>;
> +			sync-ctrl	= <1>;
> +			raster-order	= <0>;
> +			fifo-th		= <0>;
> +		};
> +
> +		display-timings {
> +			480x272 {
> +				clock-frequency = <9000000>;
> +				hactive = <480>;
> +				vactive = <272>;
> +				hfront-porch = <3>;
> +				hback-porch = <2>;
> +				hsync-len = <42>;
> +				vback-porch = <3>;
> +				vfront-porch = <4>;
> +				vsync-len = <11>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <1>;
> +			};
> +		};
> +	};
> +
>  	vbat: fixedregulator0 {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vbat";
> @@ -172,6 +217,16 @@
>  		regulator-boot-on;
>  	};
>  
> +	lcd_reg: lcdregulator {

lcd-regulator is more readable.

> +		compatible = "regulator-fixed";
> +		regulator-name = "m_lcd_panel_pwr"

Just "lcd_panel_pwr" should be fine. The "m_" prefix seems to be related
to the fact that its the signal before the resistor pack (or some such
temporary state).

> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio 40 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;

why always on? It cannot be disabled?

> +	};
> +
>  	sound {
>  		compatible = "simple-audio-card";
>  		simple-audio-card,name = "DA850/OMAP-L138 EVM";
> @@ -255,6 +310,14 @@
>  	};
>  };
>  
> +&gpio {
> +	status = "okay";
> +};

We already have this in the file.

Thanks,
Sekhar
