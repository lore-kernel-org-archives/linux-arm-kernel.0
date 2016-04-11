From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 11 Apr 2016 22:41:44 +0800
Subject: [PATCH] ARM: dts: imx6qdl-udoo: add 7 inch LCD touchscreen panel
 support
In-Reply-To: <56F80171.40708@maciej.szmigiero.name>
References: <56F80171.40708@maciej.szmigiero.name>
Message-ID: <20160411144144.GB15818@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 27, 2016 at 05:51:13PM +0200, Maciej S. Szmigiero wrote:
> The official UDOO board kit has 7 and 15.6 inch touchscreen LCD panels
> as options.
> 
> This patch adds support for 7 inch panel only, but the 15.6 inch one
> should be easy to add using the same regulator, backlight device and
> LVDS channel.
> 
> Since this panel is an option for UDOO board it is disabled by default
> and can be enabled (for example) by the following U-Boot commands:
> fdt set backlight status okay
> fdt set panelchan status okay
> fdt set panel7 status okay
> fdt set touchscreenp7 status okay
> 
> The LVDS channel is also disabled by default to avoid warning from its
> driver.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>  arch/arm/boot/dts/imx6qdl-udoo.dtsi | 96 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
> index d3e54e40a017..6a0a7ddb59ae 100644
> --- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
> @@ -10,6 +10,13 @@
>   */
>  
>  / {
> +	aliases {
> +		backlight = &backlight;
> +		panelchan = &panelchan;
> +		panel7 = &panel7;
> +		touchscreenp7 = &touchscreenp7;
> +	};
> +
>  	chosen {
>  		stdout-path = &uart2;
>  	};
> @@ -33,6 +40,14 @@
>  			startup-delay-us = <2>; /* USB2415 requires a POR of 1 us minimum */
>  			gpio = <&gpio7 12 0>;
>  		};
> +
> +		reg_panel: regulator at 1 {
> +			compatible = "regulator-fixed";
> +			reg = <1>;
> +			regulator-name = "lcd_panel";
> +			enable-active-high;
> +			gpio = <&gpio1 2 0>;
> +		};
>  	};
>  
>  	sound {
> @@ -46,6 +61,34 @@
>  		mux-int-port = <1>;
>  		mux-ext-port = <6>;
>  	};
> +
> +	backlight: backlight {
> +		compatible = "gpio-backlight";
> +		gpios = <&gpio1 4 0>;
> +		default-on;
> +		status = "disabled";
> +	};
> +
> +	panel7: panel7 {
> +		/*
> +		 * in reality it is a -20t (parallel) model,
> +		 * but with LVDS bridge chip attached,
> +		 * so it is equivalent to -19t model in drive
> +		 * characteristics
> +		 */
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_panel>;
> +		compatible = "urt,umsh-8596md-19t";

We generally let 'compatible' be the first property.

> +		power-supply = <&reg_panel>;
> +		backlight = <&backlight>;
> +		status = "disabled";
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&lvds0_out>;
> +			};
> +		};
> +	};
>  };
>  
>  &fec {
> @@ -151,6 +194,27 @@
>  				MX6QDL_PAD_EIM_EB2__GPIO2_IO30		0x1b0b0
>  			>;
>  		};
> +
> +		pinctrl_panel: panelgrp {

Please sort pinctrl entries alphabetically.

> +			fsl,pins = <
> +				MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x70
> +				MX6QDL_PAD_GPIO_4__GPIO1_IO04		0x70
> +			>;
> +		};
> +
> +		pinctrl_i2c3: i2c3grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_GPIO_5__I2C3_SCL		0x4001f8b1
> +				MX6QDL_PAD_GPIO_6__I2C3_SDA		0x4001f8b1
> +			>;
> +		};
> +
> +		pinctrl_touchscreenp7: touchscreenp7grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD2_DAT0__GPIO1_IO15		0x70
> +				MX6QDL_PAD_SD2_DAT2__GPIO1_IO13		0x1b0b0
> +			>;
> +		};
>  	};
>  };
>  
> @@ -189,3 +253,35 @@
>  	ac97-gpios = <&gpio4 19 0 &gpio4 18 0 &gpio2 30 0>;
>  	status = "okay";
>  };
> +
> +&ldb {

Please try to keep the node alphabetically in label name.

Shawn

> +	status = "okay";
> +
> +	panelchan: lvds-channel at 0 {
> +		port at 4 {
> +			reg = <4>;
> +
> +			lvds0_out: endpoint {
> +				remote-endpoint = <&panel_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c3 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +
> +	touchscreenp7: touchscreenp7 at 55 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_touchscreenp7>;
> +		compatible = "sitronix,st1232";
> +		reg = <0x55>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <13 8>;
> +		gpios = <&gpio1 15 0>;
> +		status = "disabled";
> +	};
> +};
> 
> 
