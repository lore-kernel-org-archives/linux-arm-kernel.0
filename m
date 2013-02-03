From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 3 Feb 2013 18:58:32 +0800
Subject: [PATCH 1/2] ARM: dts: add support for some modules in imx6q
 sabresd
In-Reply-To: <1359701198-23900-1-git-send-email-b13634@freescale.com>
References: <1359701198-23900-1-git-send-email-b13634@freescale.com>
Message-ID: <20130203105830.GC26233@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 01, 2013 at 02:46:38PM +0800, Gary Zhang wrote:
> add I2C/I2S/clk/fixed regulator/sound card and
> other related supports in imx6q sabresd
> 
> Signed-off-by: Gary Zhang <b13634@freescale.com>
> ---
>  arch/arm/boot/dts/imx6q-sabresd.dts |   76 +++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx6q.dtsi        |   23 ++++++++++
>  2 files changed, 99 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-sabresd.dts b/arch/arm/boot/dts/imx6q-sabresd.dts
> index a424025..383fcf0 100644
> --- a/arch/arm/boot/dts/imx6q-sabresd.dts
> +++ b/arch/arm/boot/dts/imx6q-sabresd.dts
> @@ -29,6 +29,10 @@
>  					pinctrl-0 = <&pinctrl_uart1_1>;
>  					status = "okay";
>  				};
> +				ssi2: ssi at 0202c000 {

We generally have a blank line between nodes, so please follow the
pattern.

> +					fsl,mode = "i2s-slave";
> +					status = "okay";
> +				};
>  			};
>  
>  			iomuxc at 020e0000 {
> @@ -73,6 +77,33 @@
>  				wp-gpios = <&gpio2 1 0>;
>  				status = "okay";
>  			};
> +
> +			audmux at 021d8000 {
> +				status = "okay";

Nit: we usually have "status" be the last one in the property list.

> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_audmux_2>;
> +			};
> +
> +			i2c at 021a0000 { /* I2C1 */
> +				status = "okay";
> +				clock-frequency = <100000>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_i2c1_2>;
> +
> +				codec: wm8962 at 1a {
> +					compatible = "fsl,wm8962";

This does not seem right, as wm8962 is not a codec produced by FSL.
I suspect you can have your driver work even without this compatible
since it's a I2C device.  If so, you can choose to simply drop it.

Shawn

> +					reg = <0x1a>;
> +					clocks = <&clks 169>;
> +					DCVDD-supply = <&reg_1p8v>;
> +					DBVDD-supply = <&reg_1p8v>;
> +					AVDD-supply = <&reg_1p8v>;
> +					CPVDD-supply = <&reg_1p8v>;
> +					MICVDD-supply = <&reg_3p3v>;
> +					PLLVDD-supply = <&reg_1p8v>;
> +					SPKVDD1-supply = <&reg_4p2v>;
> +					SPKVDD2-supply = <&reg_4p2v>;
> +				};
> +			};
>  		};
>  	};
>  
> @@ -91,4 +122,49 @@
>  			linux,code = <114>; /* KEY_VOLUMEDOWN */
>  		};
>  	};
> +	regulators {
> +		compatible = "simple-bus";
> +
> +		reg_1p8v: 1p8v {
> +			compatible = "regulator-fixed";
> +			regulator-name = "1P8V";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-always-on;
> +			enable-active-high;
> +		};
> +		reg_3p3v: 3p3v {
> +			compatible = "regulator-fixed";
> +			regulator-name = "3P3V";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +			enable-active-high;
> +		};
> +		reg_4p2v: 4p2v {
> +			compatible = "regulator-fixed";
> +			regulator-name = "4P2V";
> +			regulator-min-microvolt = <4200000>;
> +			regulator-max-microvolt = <4200000>;
> +			gpio = <&gpio4 10 0>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			enable-active-high;
> +		};
> +	};
> +
> +	sound {
> +		compatible = "fsl,imx6q-sabresd-wm8962",
> +			     "fsl,imx-audio-wm8962";
> +		model = "imx6q-sabresd-wm8962";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_clko_1>;
> +		ssi-controller = <&ssi2>;
> +		audio-codec = <&codec>;
> +		audio-routing =
> +			"Headphone Jack", "HPOUTL",
> +			"Headphone Jack", "HPOUTR";
> +		mux-int-port = <2>;
> +		mux-ext-port = <3>;
> +	};
>  };
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index d6265ca..b612269 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -582,6 +582,23 @@
>  							3    0x80000000	/* MX6Q_PAD_SD2_DAT1__AUDMUX_AUD4_TXFS */
>  						>;
>  					};
> +
> +					pinctrl_audmux_2: audmux-2 {
> +						fsl,pins = <
> +							1117 0x80000000	/* MX6Q_PAD_CSI0_DAT7__AUDMUX_AUD3_RXD */
> +							1093 0x80000000	/* MX6Q_PAD_CSI0_DAT4__AUDMUX_AUD3_TXC */
> +							1101 0x80000000	/* MX6Q_PAD_CSI0_DAT5__AUDMUX_AUD3_TXD */
> +							1109 0x80000000	/* MX6Q_PAD_CSI0_DAT6__AUDMUX_AUD3_TXFS */
> +						>;
> +					};
> +				};
> +
> +				clko {
> +					pinctrl_clko_1: clkogrp-1 {
> +						fsl,pins = <
> +							953 0x130b0  /* MX6Q_PAD_GPIO_0__CCM_CLKO */
> +						>;
> +					};
>  				};
>  
>  				ecspi1 {
> @@ -670,6 +687,12 @@
>  							196 0x4001b8b1	/* MX6Q_PAD_EIM_D28__I2C1_SDA */
>  						>;
>  					};
> +					pinctrl_i2c1_2: i2c1grp-2 {
> +						fsl,pins = <
> +							1125 0x4001b8b1	/* MX6Q_PAD_CSI0_DAT8__I2C1_SDA */
> +							1133 0x4001b8b1 /* MX6Q_PAD_CSI0_DAT9__I2C1_SCL */
> +						>;
> +					};
>  				};
>  
>  				uart1 {
> -- 
> 1.7.0.4
> 
> 
