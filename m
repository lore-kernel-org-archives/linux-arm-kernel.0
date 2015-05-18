From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 18 May 2015 19:31:35 +0800
Subject: [PATCH v2] arm, imx6, dts: add DT for aristainetos2 board
In-Reply-To: <1431334974-27531-1-git-send-email-hs@denx.de>
References: <1431334974-27531-1-git-send-email-hs@denx.de>
Message-ID: <20150518113135.GD1071@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 11, 2015 at 11:02:54AM +0200, Heiko Schocher wrote:
> This patch add support for the imx6dl based aristainetos2 board

What are the differences between aristainetos2 and aristainetos board?

> with following configuration:
> 
> CPU:   Freescale i.MX6DL rev1.1 at 792 MHz
> MReset cause: POR
> MBoard: aristaitenos2
> DRAM:  1 GiB
> NAND:  1024 MiB
> MMC:   FSL_SDHC: 0, FSL_SDHC: 1
> SF: Detected N25Q128A with page size 256 Bytes, erase size 64 KiB, total 16 MiB
> Display: lb07wv8 (800x480)
> 
> As this board can used with 2 different display types, the
> differences between them are extracted into 2 DTS files, and
> the common settings are collected in a common file.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> 
> Changes in v2:
> - add comments from Sascha Hauer:
>   - remove "clock-frequency" property in i2c nodes
>   - correct indentation in some pinctrl nodes
>   - move pin settings out of "gpiogrp" where it was possible
>     led pins not moved, as they used through sysfs
> 
>  arch/arm/boot/dts/imx6dl-aristainetos2_4.dts | 124 ++++++
>  arch/arm/boot/dts/imx6dl-aristainetos2_7.dts |  63 +++
>  arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi | 627 +++++++++++++++++++++++++++
>  3 files changed, 814 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
>  create mode 100644 arch/arm/boot/dts/imx6dl-aristainetos2_7.dts

Add them as DTB target into arch/arm/boot/dts/Makefile.

>  create mode 100644 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
> 
> diff --git a/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts b/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
> new file mode 100644
> index 0000000..43916a0
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
> @@ -0,0 +1,124 @@
> +/*
> + * support fot the imx6 based aristainetos2 board
> + *
> + * Copyright (C) 2015 Heiko Schocher <hs@denx.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */

GPL/X11 dual licence is suggested for new DTS files.  See
arch/arm/boot/dts/imx6sl-warp.dts for an example.

> +/dts-v1/;
> +#include "imx6dl.dtsi"
> +#include "imx6qdl-aristainetos2.dtsi"
> +
> +/ {
> +	model = "aristainetos2 i.MX6 Dual Lite Board 4";
> +	compatible = "fsl,imx6dl";
> +
> +	backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm1 0 5000000>;
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		default-brightness-level = <7>;
> +		status = "okay";

status = "okay" is mostly used in board level dts to enable device that
is by default disabled in <soc>.dtsi.  In your case here, it can just be
saved.

> +	};
> +
> +	memory {
> +		reg = <0x10000000 0x40000000>;
> +	};
> +
> +	soc {
> +		display0: display at di0 {
> +			compatible = "fsl,imx-parallel-display";
> +			interface-pix-fmt = "rgb24";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_ipu1_1_80Ohm_clk>;
> +			fsl,panel = <&lcd_panel>;

What is this?  I failed to find it in Documentation/devicetree/bindings/

> +			status = "okay";

Can be saved?

> +
> +			port {
> +				display0_in: endpoint {
> +					remote-endpoint = <&ipu1_di0_disp0>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&ecspi1 {
> +	lcd_panel: display at 0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "lg,lg4573";
> +		spi-max-frequency = <10000000>;
> +		reg = <0>;
> +		power-on-delay = <10>;
> +		display-timings {
> +			480x800p57 {
> +				native-mode;
> +				clock-frequency = <27000027>;
> +				hactive = <480>;
> +				vactive = <800>;
> +				hfront-porch = <10>;
> +				hback-porch = <59>;
> +				hsync-len = <10>;
> +				vback-porch = <15>;
> +				vfront-porch = <15>;
> +				vsync-len = <15>;
> +				hsync-active = <1>;
> +				vsync-active = <1>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c3 {
> +	atmel: atmel_mxt_ts at 4b {

Node name should be generic.

> +		compatible = "atmel,maxtouch";
> +		reg = <0x4b>;
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <9 8>;
> +	};
> +};
> +
> +&iomuxc {
> +	ipu_disp1 {

LinusW queued patch 5fcdf6a7ed95 ("pinctrl: imx: Allow parsing DT
without function nodes") on pinctrl tree for 4.2 merge window.  With
that, we can save one level of the sub-node.

> +		pinctrl_ipu1_1_80Ohm_clk: ipudisp1grp {

The '1' suffix after 'ipu1' is meaningless.  Please drop it.  Also, will
you use other pad configuration for CLK for this board?  Otherwise, the
suffix '_80Ohm_clk' can be saved too?

> +			fsl,pins = <
> +				MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK 0x31
> +				MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15       0xE1
> +				MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02        0x10
> +				MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03        0x10
> +				MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00   0xE1
> +				MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01   0xE1
> +				MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02   0xE1
> +				MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03   0xE1
> +				MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04   0xE1
> +				MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05   0xE1
> +				MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06   0xE1
> +				MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07   0xE1
> +				MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08   0xE1
> +				MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09   0xE1
> +				MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10  0xE1
> +				MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11  0xE1
> +				MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12  0xE1
> +				MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13  0xE1
> +				MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14  0xe1
> +				MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15  0xE1
> +				MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16  0xE1
> +				MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17  0xE1
> +				MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18  0xE1
> +				MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19  0xE1
> +				MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20  0xE1
> +				MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21  0xE1
> +				MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22  0xE1
> +				MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23  0xE1
> +			>;
> +		};
> +	};
> +};
> +
> +&ipu1_di0_disp0 {
> +	remote-endpoint = <&display0_in>;
> +};
> diff --git a/arch/arm/boot/dts/imx6dl-aristainetos2_7.dts b/arch/arm/boot/dts/imx6dl-aristainetos2_7.dts
> new file mode 100644
> index 0000000..e1eaf5a
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-aristainetos2_7.dts
> @@ -0,0 +1,63 @@
> +/*
> + * support fot the imx6 based aristainetos2 board
> + *
> + * Copyright (C) 2015 Heiko Schocher <hs@denx.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +/dts-v1/;
> +#include "imx6dl.dtsi"
> +#include "imx6qdl-aristainetos2.dtsi"
> +
> +/ {
> +	model = "aristainetos2 i.MX6 Dual Lite Board 7";
> +	compatible = "fsl,imx6dl";
> +
> +	backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm1 0 3000>;
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		default-brightness-level = <6>;
> +	};
> +
> +	memory {
> +		reg = <0x10000000 0x40000000>;
> +	};
> +};
> +
> +&i2c3 {
> +	atmel: atmel_mxt_ts at 4d {
> +		compatible = "atmel,maxtouch";
> +		reg = <0x4d>;
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <9 8>;
> +	};

It seems the touch device is identical between
imx6dl-aristainetos2_4.dts and imx6dl-aristainetos2_7.dts.  Why don't
you put it into imx6qdl-aristainetos2.dtsi?

> +};
> +
> +&ldb {
> +	status = "okay";
> +
> +	lvds-channel at 0 {
> +		fsl,data-mapping = "spwg";
> +		fsl,data-width = <24>;
> +		status = "okay";
> +
> +		display-timings {
> +			native-mode = <&timing0>;
> +			timing0: 800x480p60 {
> +				clock-frequency = <33246000>;
> +				hactive = <800>;
> +				vactive = <480>;
> +				hfront-porch = <88>;
> +				hback-porch = <88>;
> +				hsync-len = <80>;
> +				vback-porch = <10>;
> +				vfront-porch = <10>;
> +				vsync-len = <25>;
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
> new file mode 100644
> index 0000000..561dbea
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
> @@ -0,0 +1,627 @@
> +/*
> + * support fot the imx6 based aristainetos2 board
> + *
> + * Copyright (C) 2015 Heiko Schocher <hs@denx.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	regulators {
> +		compatible = "simple-bus";
> +
> +		reg_2p5v: 2p5v {
> +			compatible = "regulator-fixed";
> +			regulator-name = "2P5V";
> +			regulator-min-microvolt = <2500000>;
> +			regulator-max-microvolt = <2500000>;
> +			regulator-always-on;
> +		};
> +
> +		reg_3p3v: 3p3v {
> +			compatible = "regulator-fixed";
> +			regulator-name = "3P3V";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};
> +
> +		reg_usbh1_vbus: usb-h1-vbus {
> +			compatible = "regulator-fixed";
> +			enable-active-high;
> +			gpio = <&gpio1 0 0>;

You included dt-bindings/gpio/gpio.h but did not use the macros?

> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_aristainetos2_usbh1_vbus>;
> +			regulator-name = "usb_h1_vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +		};
> +
> +		reg_usbotg_vbus: usb-otg-vbus {
> +			compatible = "regulator-fixed";
> +			enable-active-high;
> +			gpio = <&gpio4 15 0>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_aristainetos2_usbotg_vbus>;
> +			regulator-name = "usb_otg_vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +		};
> +
> +	};
> +};
> +
> +&audmux {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_audmux>;
> +	status = "okay";
> +};
> +
> +&can1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan1>;
> +	status = "okay";
> +};
> +
> +&can2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan2>;
> +	status = "okay";
> +};
> +
> +&ecspi1 {
> +	fsl,spi-num-chipselects = <3>;
> +	cs-gpios = <&gpio4 9 0 &gpio4 10 0 &gpio4 11 0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi1>;
> +	dma-names;

The dma-names should be a property with string value.

> +	status = "okay";
> +};
> +
> +&ecspi2 {
> +	fsl,spi-num-chipselects = <2>;
> +	cs-gpios = <&gpio2 26 0 &gpio2 27 0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi2>;
> +	dma-names;
> +	status = "okay";
> +};
> +
> +&ecspi4 {
> +	fsl,spi-num-chipselects = <2>;
> +	cs-gpios = <&gpio3 29 0 &gpio5 2 0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi4>;
> +	dma-names;
> +	status = "okay";
> +
> +	flash: m25p80 at 1 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "micron,n25q128a11";
> +		spi-max-frequency = <20000000>;
> +		reg = <1>;
> +	};
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	pmic at 58 {
> +		compatible = "dialog,da9063";
> +		reg = <0x58>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <04 0x8>;
> +
> +		regulators {
> +			bcore1 {
> +				regulator-name = "bcore1";
> +				regulator-always-on = <1>;
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			bcore2 {
> +				regulator-name = "bcore2";
> +				regulator-always-on = <1>;
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			bpro {
> +				regulator-name = "bpro";
> +				regulator-always-on = <1>;
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			bperi {
> +				regulator-name = "bperi";
> +				regulator-always-on = <1>;
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			bmem {
> +				regulator-name = "bmem";
> +				regulator-always-on = <1>;
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			ldo2 {
> +				regulator-name = "ldo2";
> +				regulator-always-on = <1>;
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <1800000>;
> +			};
> +
> +			ldo3 {
> +				regulator-name = "ldo3";
> +				regulator-always-on = <1>;
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			ldo4 {
> +				regulator-name = "ldo4";
> +				regulator-always-on = <1>;
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			ldo5 {
> +				regulator-name = "ldo5";
> +				regulator-always-on = <1>;
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			ldo6 {
> +				regulator-name = "ldo6";
> +				regulator-always-on = <1>;
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			ldo7 {
> +				regulator-name = "ldo7";
> +				regulator-always-on = <1>;
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			ldo8 {
> +				regulator-name = "ldo8";
> +				regulator-always-on = <1>;
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			ldo9 {
> +				regulator-name = "ldo9";
> +				regulator-always-on = <1>;
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			ldo10 {
> +				regulator-name = "ldo10";
> +				regulator-always-on = <1>;
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			ldo11 {
> +				regulator-name = "ldo11";
> +				regulator-always-on = <1>;
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			bio {
> +				regulator-name = "bio";
> +				regulator-always-on = <1>;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +			};
> +		};
> +	};

Have a new line between nodes.

> +	tmp103: tmp103 at 71 {
> +		compatible = "ti,tmp103";
> +		reg = <0x71>;
> +	};
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +
> +	expander: tca6416 at 20 {
> +		compatible = "ti,tca6416";
> +		reg = <0x20>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +	};
> +
> +	rtc at 68 {
> +		compatible = "dallas,m41t00";
> +		reg = <0x68>;
> +	};
> +};
> +
> +&i2c4 {
> +	clocks = <&clks 116>;

Use macro for clock ID.

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c4>;
> +	status = "okay";
> +	eeprom at 50{
> +		compatible = "atmel,24c64";
> +		reg = <0x50>;
> +	};

Have new line between nodes.

> +	eeprom at 57{
> +		compatible = "atmel,24c64";
> +		reg = <0x57>;
> +	};
> +};
> +
> +&iomuxc {

I suggest you put iomuxc node at the bottom of the file to improve the
readability of the file.

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_backlight &pinctrl_gpio>;

These pins should be configured by client device node, not the hog
group. 

> +
> +	audmux {
> +		pinctrl_audmux: audmux {
> +			fsl,pins = <
> +				MX6QDL_PAD_CSI0_DAT7__AUD3_RXD  0x80000000
> +				MX6QDL_PAD_CSI0_DAT4__AUD3_TXC  0x80000000
> +				MX6QDL_PAD_CSI0_DAT5__AUD3_TXD  0x80000000
> +				MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS 0x80000000

Provide a proper pad configuration value rather than 0x8000000.

> +			>;
> +		};
> +	};
> +
> +	backlight {
> +		pinctrl_backlight: backlightgrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_GPIO_9__PWM1_OUT	0x1b0b0
> +				MX6QDL_PAD_EIM_BCLK__GPIO6_IO31	0x1b0b0 /* backlight enable */
> +			>;
> +		};
> +	};
> +
> +	ecspi1 {
> +		pinctrl_ecspi1: ecspi1grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_D17__ECSPI1_MISO 0x100b1
> +				MX6QDL_PAD_EIM_D18__ECSPI1_MOSI 0x100b1
> +				MX6QDL_PAD_EIM_D16__ECSPI1_SCLK 0x100b1
> +				MX6QDL_PAD_KEY_ROW1__GPIO4_IO09 0x100b1 /* SS0# */
> +				MX6QDL_PAD_KEY_COL2__GPIO4_IO10 0x100b1 /* SS1# */
> +				MX6QDL_PAD_KEY_ROW2__GPIO4_IO11 0x100b1 /* SS2# */
> +			>;
> +		};
> +	};
> +
> +	ecspi2 {
> +		pinctrl_ecspi2: ecspi2grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_OE__ECSPI2_MISO  0x100b1
> +				MX6QDL_PAD_EIM_CS0__ECSPI2_SCLK 0x100b1
> +				MX6QDL_PAD_EIM_CS1__ECSPI2_MOSI 0x100b1
> +				MX6QDL_PAD_EIM_RW__GPIO2_IO26   0x100b1 /* SS0# */
> +				MX6QDL_PAD_EIM_LBA__GPIO2_IO27  0x100b1 /* SS1# */
> +			>;
> +		};
> +	};
> +
> +	ecspi4 {
> +		pinctrl_ecspi4: ecspi4grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_D21__ECSPI4_SCLK 0x100b1
> +				MX6QDL_PAD_EIM_D22__ECSPI4_MISO 0x100b1
> +				MX6QDL_PAD_EIM_D28__ECSPI4_MOSI 0x100b1
> +				MX6QDL_PAD_EIM_D29__GPIO3_IO29  0x100b1 /* SS0# */
> +				MX6QDL_PAD_EIM_A25__GPIO5_IO02  0x100b1 /* SS1# */
> +				MX6QDL_PAD_SD4_DAT7__GPIO2_IO15 0x1b0b0 /* WP pin */
> +			>;
> +		};
> +	};
> +
> +	enet {
> +		pinctrl_enet: enetgrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_ENET_MDIO__ENET_MDIO       0x1b0b0
> +				MX6QDL_PAD_ENET_MDC__ENET_MDC         0x1b0b0
> +				MX6QDL_PAD_RGMII_TXC__RGMII_TXC       0x1b0b0
> +				MX6QDL_PAD_RGMII_TD0__RGMII_TD0       0x1b0b0
> +				MX6QDL_PAD_RGMII_TD1__RGMII_TD1       0x1b0b0
> +				MX6QDL_PAD_RGMII_TD2__RGMII_TD2       0x1b0b0
> +				MX6QDL_PAD_RGMII_TD3__RGMII_TD3       0x1b0b0
> +				MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x1b0b0
> +				MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0b0
> +				MX6QDL_PAD_RGMII_RXC__RGMII_RXC       0x1b0b0
> +				MX6QDL_PAD_RGMII_RD0__RGMII_RD0       0x1b0b0
> +				MX6QDL_PAD_RGMII_RD1__RGMII_RD1       0x1b0b0
> +				MX6QDL_PAD_RGMII_RD2__RGMII_RD2       0x1b0b0
> +				MX6QDL_PAD_RGMII_RD3__RGMII_RD3       0x1b0b0
> +				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
> +			>;
> +		};
> +	};
> +
> +	flexcan1 {
> +		pinctrl_flexcan1: flexcan1grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD3_CLK__FLEXCAN1_RX 0x80000000
> +				MX6QDL_PAD_SD3_CMD__FLEXCAN1_TX 0x80000000
> +			>;
> +		};
> +	};
> +
> +	flexcan2 {
> +		pinctrl_flexcan2: flexcan2grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD3_DAT0__FLEXCAN2_TX 0x80000000
> +				MX6QDL_PAD_SD3_DAT1__FLEXCAN2_RX 0x80000000

Ditto

> +			>;
> +		};
> +	};
> +
> +	gpio {
> +		pinctrl_gpio: gpiogrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25	0x1b0b0 /* led enable */
> +				MX6QDL_PAD_NANDF_CS2__GPIO6_IO15	0x1b0b0 /* LCD power enable */
> +				MX6QDL_PAD_NANDF_CS3__GPIO6_IO16	0x1b0b0 /* led yellow */
> +				MX6QDL_PAD_EIM_EB0__GPIO2_IO28		0x1b0b0 /* led red */
> +				MX6QDL_PAD_EIM_A24__GPIO5_IO04		0x1b0b0 /* led green */
> +				MX6QDL_PAD_EIM_EB1__GPIO2_IO29		0x1b0b0 /* led blue */
> +				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00		0x1b0b0 /* Profibus IRQ */
> +				MX6QDL_PAD_SD3_DAT6__GPIO6_IO18		0x1b0b0 /* FPGA IRQ */
> +				MX6QDL_PAD_EIM_A23__GPIO6_IO06		0x1b0b0 /* spi bus #2 SS driver enable */
> +				MX6QDL_PAD_GPIO_18__GPIO7_IO13		0x1b0b0 /* RST_LOC# PHY reset input (has pull-down!)*/
> +				MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID	0x1b0b0 /* USB_OTG_ID = GPIO1_24*/
> +				MX6QDL_PAD_SD4_DAT1__GPIO2_IO09		0x1b0b0 /* Touchscreen IRQ */
> +				MX6QDL_PAD_EIM_A22__GPIO2_IO16		0x1b0b0 /* PCIe reset */
> +			>;
> +		};
> +	};
> +
> +	gpmi-nand {
> +		pinctrl_gpmi_nand: gpmi-nand {
> +			fsl,pins = <
> +				MX6QDL_PAD_NANDF_CLE__NAND_CLE     0xb0b1
> +				MX6QDL_PAD_NANDF_ALE__NAND_ALE     0xb0b1
> +				MX6QDL_PAD_NANDF_WP_B__NAND_WP_B   0xb0b1
> +				MX6QDL_PAD_NANDF_RB0__NAND_READY_B 0xb000
> +				MX6QDL_PAD_NANDF_CS0__NAND_CE0_B   0xb0b1
> +				MX6QDL_PAD_SD4_CMD__NAND_RE_B      0xb0b1
> +				MX6QDL_PAD_SD4_CLK__NAND_WE_B      0xb0b1
> +				MX6QDL_PAD_NANDF_D0__NAND_DATA00   0xb0b1
> +				MX6QDL_PAD_NANDF_D1__NAND_DATA01   0xb0b1
> +				MX6QDL_PAD_NANDF_D2__NAND_DATA02   0xb0b1
> +				MX6QDL_PAD_NANDF_D3__NAND_DATA03   0xb0b1
> +				MX6QDL_PAD_NANDF_D4__NAND_DATA04   0xb0b1
> +				MX6QDL_PAD_NANDF_D5__NAND_DATA05   0xb0b1
> +				MX6QDL_PAD_NANDF_D6__NAND_DATA06   0xb0b1
> +				MX6QDL_PAD_NANDF_D7__NAND_DATA07   0xb0b1
> +			>;
> +		};
> +	};
> +
> +	i2c1 {
> +		pinctrl_i2c1: i2c1grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_CSI0_DAT8__I2C1_SDA 0x4001b8b1
> +				MX6QDL_PAD_CSI0_DAT9__I2C1_SCL 0x4001b8b1
> +			>;
> +		};
> +	};
> +
> +	i2c2 {
> +		pinctrl_i2c2: i2c2grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b8b1
> +				MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b8b1
> +			>;
> +		};
> +	};
> +
> +	i2c3 {
> +		pinctrl_i2c3: i2c3grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_GPIO_5__I2C3_SCL 0x4001b8b1
> +				MX6QDL_PAD_GPIO_6__I2C3_SDA 0x4001b8b1
> +			>;
> +		};
> +	};
> +
> +	i2c4 {
> +		pinctrl_i2c4: i2c4grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_GPIO_7__I2C4_SCL 0x4001b8b1
> +				MX6QDL_PAD_GPIO_8__I2C4_SDA 0x4001b8b1
> +			>;
> +		};
> +	};
> +
> +	uart1 {
> +		pinctrl_uart1: uart1grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA	0x1b0b1
> +				MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA	0x1b0b1
> +				MX6QDL_PAD_EIM_D20__UART1_RTS_B		0x1b0b1
> +				MX6QDL_PAD_EIM_D19__UART1_CTS_B		0x1b0b1
> +			>;
> +		};
> +	};
> +
> +	uart2 {
> +		pinctrl_uart2: uart2grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_D26__UART2_TX_DATA 0x1b0b1
> +				MX6QDL_PAD_EIM_D27__UART2_RX_DATA 0x1b0b1
> +			>;
> +		};
> +	};
> +
> +	uart3 {
> +		pinctrl_uart3: uart3grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_D24__UART3_TX_DATA 0x1b0b1
> +				MX6QDL_PAD_EIM_D25__UART3_RX_DATA 0x1b0b1
> +				MX6QDL_PAD_EIM_D31__UART3_RTS_B	  0x1b0b1
> +				MX6QDL_PAD_EIM_D23__UART3_CTS_B	  0x1b0b1
> +			>;
> +		};
> +	};
> +
> +	uart4 {
> +		pinctrl_uart4: uart4grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_KEY_COL0__UART4_TX_DATA 0x1b0b1
> +				MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA 0x1b0b1
> +			>;
> +		};
> +	};
> +
> +	usbotg {
> +		pinctrl_usbotg: usbotggrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x17059
> +			>;
> +		};

New line between nodes.

> +		pinctrl_aristainetos2_usbh1_vbus: aristainetos-usbh1-vbus {
> +			fsl,pins = <MX6QDL_PAD_GPIO_0__USB_H1_PWR 0x130b0>;
> +		};
> +		pinctrl_aristainetos2_usbotg_vbus: aristainetos-usbotg-vbus {
> +			fsl,pins = <MX6QDL_PAD_KEY_ROW4__USB_OTG_PWR 0x130b0>;
> +		};
> +	};
> +
> +	usdhc1 {
> +		pinctrl_usdhc1: usdhc1grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17059
> +				MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10059
> +				MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17059
> +				MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17059
> +				MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17059
> +				MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17059
> +				MX6QDL_PAD_ENET_RXD0__GPIO1_IO27	0x1b0b0 /* SD1 card detect input */
> +				MX6QDL_PAD_DI0_PIN4__GPIO4_IO20		0x1b0b0 /* SD1 write protect input */
> +			>;
> +		};
> +	};
> +
> +	usdhc2 {
> +		pinctrl_usdhc2: usdhc2grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD2_CMD__SD2_CMD    0x71
> +				MX6QDL_PAD_SD2_CLK__SD2_CLK    0x71
> +				MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x71
> +				MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x71
> +				MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x71
> +				MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x71
> +				MX6QDL_PAD_SD3_RST__GPIO7_IO08		0x1b0b0 /* SD2 level shifter output enable */
> +				MX6QDL_PAD_GPIO_19__GPIO4_IO05		0x1b0b0 /* SD2 card detect input */
> +				MX6QDL_PAD_SD4_DAT2__GPIO2_IO10		0x1b0b0 /* SD2 write protect input */
> +			>;
> +		};
> +	};
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet>;
> +	phy-mode = "rgmii";
> +	phy-reset-gpios = <&gpio7 18 0>;

All the gpio properties need to be check for using the macros defined in
gpio.h.

Shawn

> +	txd0-skew-ps = <0>;
> +	txd1-skew-ps = <0>;
> +	txd2-skew-ps = <0>;
> +	txd3-skew-ps = <0>;
> +	status = "okay";
> +};
> +
> +&gpmi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gpmi_nand>;
> +	status = "okay";
> +};
> +
> +&pcie {
> +	reset-gpio = <&gpio2 16 0>;
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	fsl,uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	fsl,uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart4>;
> +	status = "okay";
> +};
> +
> +&usbh1 {
> +	vbus-supply = <&reg_usbh1_vbus>;
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +&usbotg {
> +	vbus-supply = <&reg_usbotg_vbus>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbotg>;
> +	disable-over-current;
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	cd-gpios = <&gpio1 27 0>;
> +	no-1-8-v;
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	cd-gpios = <&gpio4 5 0>;
> +	wp-gpios = <&gpio2 10 0>;
> +	no-1-8-v;
> +	status = "okay";
> +};
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
