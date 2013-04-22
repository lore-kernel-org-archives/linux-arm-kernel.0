From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 22 Apr 2013 13:19:19 +0800
Subject: [PATCH 8/8] ARM: mx5: Add support for DENX M53EVK
In-Reply-To: <1366579808-12067-8-git-send-email-marex@denx.de>
References: <1366579808-12067-1-git-send-email-marex@denx.de>
 <1366579808-12067-8-git-send-email-marex@denx.de>
Message-ID: <20130422051916.GF10821@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 21, 2013 at 11:30:08PM +0200, Marek Vasut wrote:
> This patch adds support for the DENX M53EVK board. The board currently supports
> NAND, Ethernet, UART, CAN, I2C.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/boot/dts/Makefile         |    1 +
>  arch/arm/boot/dts/imx53-m53evk.dts |  282 ++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-imx/mach-imx53.c     |   16 +-
>  3 files changed, 297 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx53-m53evk.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 4fd1f62..1fbec6b 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -107,6 +107,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
>  	imx51-babbage.dtb \
>  	imx53-ard.dtb \
>  	imx53-evk.dtb \
> +	imx53-m53evk.dtb \
>  	imx53-mba53.dtb \
>  	imx53-qsb.dtb \
>  	imx53-smd.dtb \
> diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
> new file mode 100644
> index 0000000..32f8ff4
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx53-m53evk.dts
> @@ -0,0 +1,282 @@
> +/*
> + * Copyright (C) 2013 Marek Vasut <marex@denx.de>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +#include "imx53.dtsi"
> +
> +/ {
> +	model = "DENX M53EVK";
> +	compatible = "denx,imx53-m53evk", "fsl,imx53";
> +
> +	memory {
> +		reg = <0x70000000 0x20000000>;
> +	};
> +
> +	soc {
> +		display at di0 {
> +			compatible = "fsl,imx-parallel-display";
> +			crtcs = <&ipu 0>;
> +			interface-pix-fmt = "rgb24";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_ipu_disp1_1>;
> +
> +			display-timings {
> +				800x480p60 {
> +					native-mode;
> +					clock-frequency = <31500000>;
> +					hactive = <800>;
> +					vactive = <480>;
> +					hfront-porch = <40>;
> +					hback-porch = <88>;
> +					hsync-len = <128>;
> +					vback-porch = <33>;
> +					vfront-porch = <9>;
> +					vsync-len = <3>;
> +					vsync-active = <1>;
> +				};
> +			};
> +		};
> +
> +		display at di1 {
> +			compatible = "fsl,imx-parallel-display";
> +			crtcs = <&ipu 1>;
> +			interface-pix-fmt = "rgb24";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_ipu_disp2_1>;
> +
> +			display-timings {
> +				800x480p60 {
> +					native-mode;
> +					clock-frequency = <31500000>;
> +					hactive = <800>;
> +					vactive = <480>;
> +					hfront-porch = <40>;
> +					hback-porch = <88>;
> +					hsync-len = <128>;
> +					vback-porch = <33>;
> +					vfront-porch = <9>;
> +					vsync-len = <3>;
> +					vsync-active = <1>;
> +				};
> +			};
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&led_pin_gpio>;
> +
> +		user1 {
> +			label = "user1";
> +			gpios = <&gpio2 8 0>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		user2 {
> +			label = "user2";
> +			gpios = <&gpio2 9 0>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +
> +		reg_3p2v: 3p2v {
> +			compatible = "regulator-fixed";
> +			regulator-name = "3P2V";
> +			regulator-min-microvolt = <3200000>;
> +			regulator-max-microvolt = <3200000>;
> +			regulator-always-on;
> +		};
> +	};
> +
> +	sound {
> +		compatible = "fsl,imx53-m53evk-sgtl5000",
> +			     "fsl,imx-audio-sgtl5000";
> +		model = "imx53-m53evk-sgtl5000";
> +		ssi-controller = <&ssi2>;
> +		audio-codec = <&sgtl5000>;
> +		audio-routing =
> +			"MIC_IN", "Mic Jack",
> +			"Mic Jack", "Mic Bias",
> +			"LINE_IN", "Line In Jack",
> +			"Headphone Jack", "HP_OUT",
> +			"Ext Spk", "LINE_OUT";
> +		mux-int-port = <2>;
> +		mux-ext-port = <4>;
> +	};
> +
> +	backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm1 0 3000>;
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		default-brightness-level = <6>;
> +	};

I'm going to be picky on new board dts file on the node sorting.  Please
put "backlight" before "leds".

> +};
> +
> +&esdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_esdhc1_1>;
> +	cd-gpios = <&gpio1 1 0>;
> +	wp-gpios = <&gpio1 9 0>;
> +	status = "okay";
> +};
> +
Please sort all these nodes per label names.

> +&ssi2 {
> +	fsl,mode = "i2s-slave";
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3_1>;
> +	status = "okay";
> +};
> +
> +&pwm1 {
> +/*	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm1_1>;*/

Please remove it, either the commenting or the lines.

> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1_2>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2_1>;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;
> +
> +	hog {
> +		pinctrl_hog: hoggrp {
> +			fsl,pins = <
> +				MX53_PAD_GPIO_0__CCM_SSI_EXT1_CLK	0x80000000
> +				MX53_PAD_EIM_EB3__GPIO2_31		0x80000000
> +				MX53_PAD_PATA_DA_0__GPIO7_6		0x80000000
> +				MX53_PAD_DISP0_DAT8__PWM1_PWMO		0x5
> +
> +			>;
> +		};
> +
> +		led_pin_gpio: led_gpio at 0 {
> +			fsl,pins = <
> +				MX53_PAD_PATA_DATA8__GPIO2_8		0x80000000
> +				MX53_PAD_PATA_DATA9__GPIO2_9		0x80000000
> +			>;
> +		};
> +	};
> +};
> +
> +&can1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_can1_3>;
> +	status = "okay";
> +};
> +
> +&can2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_can2_1>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1_2>;
> +	status = "okay";
> +
> +	sgtl5000: codec at 0a {
> +		compatible = "fsl,sgtl5000";
> +		reg = <0x0a>;
> +		VDDA-supply = <&reg_3p2v>;
> +		VDDIO-supply = <&reg_3p2v>;
> +	};
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2_2>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	stmpe610 at 41 {
> +		compatible = "st,stmpe610";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x41>;
> +		irq-over-gpio;
> +		irq-gpios = <&gpio7 6 0>;
> +		id = <0>;
> +		blocks = <0x5>;
> +		irq-trigger = <0x1>;
> +
> +		stmpe_touchscreen {
> +			compatible = "stmpe,ts";
> +			reg = <0>;
> +			ts,sample-time = <4>;
> +			ts,mod-12b = <1>;
> +			ts,ref-sel = <0>;
> +			ts,adc-freq = <1>;
> +			ts,ave-ctrl = <3>;
> +			ts,touch-det-delay = <3>;
> +			ts,settling = <4>;
> +			ts,fraction-z = <7>;
> +			ts,i-drive = <1>;
> +		};
> +	};
> +
> +	eeprom: eeprom at 50 {
> +		compatible = "atmel,24c128";
> +		reg = <0x50>;
> +		pagesize = <32>;
> +	};
> +
> +	rtc: rtc at 68 {
> +		compatible = "stm,m41t62";
> +		reg = <0x68>;
> +	};
> +};
> +
> +&i2c3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3_1>;
> +	status = "okay";
> +};
> +
> +&audmux {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_audmux_2>;
> +	status = "okay";
> +};
> +
> +&nfc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_nand_1>;
> +	nand-bus-width = <8>;
> +	nand-ecc-mode = "hw";
> +	status = "okay";
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec_1>;
> +	phy-mode = "rmii";
> +	status = "okay";
> +};
> diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
> index f579c61..4effe59 100644
> --- a/arch/arm/mach-imx/mach-imx53.c
> +++ b/arch/arm/mach-imx/mach-imx53.c
> @@ -23,7 +23,7 @@
>  #include "common.h"
>  #include "mx53.h"
>  
> -static void __init imx53_qsb_init(void)
> +static void __init imx53_ssi_clk_init(const char *device)
>  {
>  	struct clk *clk;
>  
> @@ -33,11 +33,23 @@ static void __init imx53_qsb_init(void)
>  		return;
>  	}
>  
> -	clk_register_clkdev(clk, NULL, "0-000a");
> +	clk_register_clkdev(clk, NULL, device);

I just sent a patch (you are on CC) to move the lookup into DT.  With
it, you do not need to touch mach-imx53.c but just add the clk in your
board dts instead.

Shawn

> +}
> +
> +static void __init imx53_qsb_init(void)
> +{
> +	imx53_ssi_clk_init("0-000a");
> +}
> +
> +static void __init imx53_m53evk_init(void)
> +{
> +	imx53_ssi_clk_init("2-000a");
>  }
>  
>  static void __init imx53_dt_init(void)
>  {
> +	if (of_machine_is_compatible("denx,imx53-m53evk"))
> +		imx53_m53evk_init();
>  	if (of_machine_is_compatible("fsl,imx53-qsb"))
>  		imx53_qsb_init();
>  
> -- 
> 1.7.10.4
> 
