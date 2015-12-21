From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 21 Dec 2015 21:35:19 +0800
Subject: [PATCH 1/2] ARM: dts: ts-4800: Add LCD support
In-Reply-To: <1450458033-30471-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1450458033-30471-1-git-send-email-damien.riegel@savoirfairelinux.com>
Message-ID: <20151221133519.GC18410@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 12:00:32PM -0500, Damien Riegel wrote:
> This commit adds LCD support for the TS-4800. The panel is an Okaya
> RS800480T-7X0WQ and the timings have been extracted from Technologic
> Systems' tree.
> 
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> ---
>  arch/arm/boot/dts/imx51-ts4800.dts | 109 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx51-ts4800.dts b/arch/arm/boot/dts/imx51-ts4800.dts
> index 83352cb..4951ebd 100644
> --- a/arch/arm/boot/dts/imx51-ts4800.dts
> +++ b/arch/arm/boot/dts/imx51-ts4800.dts
> @@ -30,6 +30,60 @@
>  			clock-frequency = <24576000>;
>  		};
>  	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		backlight_reg: regulator at 0 {
> +			compatible = "regulator-fixed";
> +			reg = <0>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_enable_lcd>;
> +			regulator-name = "enable_lcd_reg";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			gpio = <&gpio4 9 GPIO_ACTIVE_HIGH>;
> +			enable-active-high;
> +		};
> +	};

DT maintainers dislike this fake simple-bus container.  Let's put the
regulator directly under root like below.

        backlight_reg: regulator-backlight {
                compatible = "regulator-fixed";
                pinctrl-names = "default";
                pinctrl-0 = <&pinctrl_enable_lcd>;
                regulator-name = "enable_lcd_reg";
                regulator-min-microvolt = <3300000>;
                regulator-max-microvolt = <3300000>;
                gpio = <&gpio4 9 GPIO_ACTIVE_HIGH>;
                enable-active-high;
        };

I fixed it up and applied both patches.

Shawn

> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm1 0 78770>;
> +		brightness-levels = <0 150 200 255>;
> +		default-brightness-level = <1>;
> +		power-supply = <&backlight_reg>;
> +	};
> +
> +	display0: display at di0 {
> +		compatible = "fsl,imx-parallel-display";
> +		interface-pix-fmt = "rgb24";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_lcd>;
> +
> +		display-timings {
> +			800x480p60 {
> +				native-mode;
> +				clock-frequency = <30066000>;
> +				hactive = <800>;
> +				vactive = <480>;
> +				hfront-porch = <50>;
> +				hback-porch = <70>;
> +				hsync-len = <50>;
> +				vback-porch = <0>;
> +				vfront-porch = <0>;
> +				vsync-len = <50>;
> +			};
> +		};
> +
> +		port at 0 {
> +			display0_in: endpoint {
> +				remote-endpoint = <&ipu_di0_disp0>;
> +			};
> +		};
> +	};
>  };
>  
>  &esdhc1 {
> @@ -60,6 +114,16 @@
>  	};
>  };
>  
> +&ipu_di0_disp0 {
> +	remote-endpoint = <&display0_in>;
> +};
> +
> +&pwm1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm_backlight>;
> +	status = "okay";
> +};
> +
>  &uart1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart1>;
> @@ -115,6 +179,12 @@
>  		>;
>  	};
>  
> +	pinctrl_enable_lcd: enablelcdgrp {
> +		fsl,pins = <
> +			MX51_PAD_CSI2_D12__GPIO4_9		0x1c5
> +		>;
> +	};
> +
>  	pinctrl_esdhc1: esdhc1grp {
>  		fsl,pins = <
>  			MX51_PAD_SD1_CMD__SD1_CMD		0x400020d5
> @@ -159,6 +229,45 @@
>  		>;
>  	};
>  
> +	pinctrl_lcd: lcdgrp {
> +		fsl,pins = <
> +			MX51_PAD_DISP1_DAT0__DISP1_DAT0		0x5
> +			MX51_PAD_DISP1_DAT1__DISP1_DAT1		0x5
> +			MX51_PAD_DISP1_DAT2__DISP1_DAT2		0x5
> +			MX51_PAD_DISP1_DAT3__DISP1_DAT3		0x5
> +			MX51_PAD_DISP1_DAT4__DISP1_DAT4		0x5
> +			MX51_PAD_DISP1_DAT5__DISP1_DAT5		0x5
> +			MX51_PAD_DISP1_DAT6__DISP1_DAT6		0x5
> +			MX51_PAD_DISP1_DAT7__DISP1_DAT7		0x5
> +			MX51_PAD_DISP1_DAT8__DISP1_DAT8		0x5
> +			MX51_PAD_DISP1_DAT9__DISP1_DAT9		0x5
> +			MX51_PAD_DISP1_DAT10__DISP1_DAT10	0x5
> +			MX51_PAD_DISP1_DAT11__DISP1_DAT11	0x5
> +			MX51_PAD_DISP1_DAT12__DISP1_DAT12	0x5
> +			MX51_PAD_DISP1_DAT13__DISP1_DAT13	0x5
> +			MX51_PAD_DISP1_DAT14__DISP1_DAT14	0x5
> +			MX51_PAD_DISP1_DAT15__DISP1_DAT15	0x5
> +			MX51_PAD_DISP1_DAT16__DISP1_DAT16	0x5
> +			MX51_PAD_DISP1_DAT17__DISP1_DAT17	0x5
> +			MX51_PAD_DISP1_DAT18__DISP1_DAT18	0x5
> +			MX51_PAD_DISP1_DAT19__DISP1_DAT19	0x5
> +			MX51_PAD_DISP1_DAT20__DISP1_DAT20	0x5
> +			MX51_PAD_DISP1_DAT21__DISP1_DAT21	0x5
> +			MX51_PAD_DISP1_DAT22__DISP1_DAT22	0x5
> +			MX51_PAD_DISP1_DAT23__DISP1_DAT23	0x5
> +			MX51_PAD_DI1_PIN2__DI1_PIN2		0x5
> +			MX51_PAD_DI1_PIN3__DI1_PIN3		0x5
> +			MX51_PAD_DI2_DISP_CLK__DI2_DISP_CLK	0x5
> +			MX51_PAD_DI_GP4__DI2_PIN15		0x5
> +		>;
> +	};
> +
> +	pinctrl_pwm_backlight: backlightgrp {
> +		fsl,pins = <
> +			MX51_PAD_GPIO1_2__PWM1_PWMO		0x80000000
> +		>;
> +	};
> +
>  	pinctrl_uart1: uart1grp {
>  		fsl,pins = <
>  			MX51_PAD_UART1_RXD__UART1_RXD		0x1c5
> -- 
> 2.5.0
> 
> 
