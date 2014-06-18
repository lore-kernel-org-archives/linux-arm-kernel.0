From: balbi@ti.com (Felipe Balbi)
Date: Wed, 18 Jun 2014 14:31:13 -0500
Subject: [PATCH v2 2/2] arm: dts: add support for AM437x StarterKit
In-Reply-To: <53A1BADD.7050309@ti.com>
References: <1403106200-777-1-git-send-email-balbi@ti.com>
 <1403106200-777-3-git-send-email-balbi@ti.com>
 <53A1BADD.7050309@ti.com>
Message-ID: <20140618193113.GC4570@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 11:14:21AM -0500, Nishanth Menon wrote:
> On 06/18/2014 10:43 AM, Felipe Balbi wrote:
> > Add support for TI's AM437x StarterKit Evaluation
> > Module.
> 
> is there a link for this platform?

internal only

> > Cc: Josh Elliot <jelliott@ti.com>
> > Cc: Darren Etheridge <detheridge@ti.com>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  .../devicetree/bindings/arm/omap/omap.txt          |   3 +
> >  arch/arm/boot/dts/Makefile                         |   1 +
> >  arch/arm/boot/dts/am437x-sk-evm.dts                | 583 +++++++++++++++++++++
> >  3 files changed, 587 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/am437x-sk-evm.dts
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> > index d22b216..0edc903 100644
> > --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> > +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> > @@ -129,6 +129,9 @@ Boards:
> >  - AM437x GP EVM
> >    compatible = "ti,am437x-gp-evm", "ti,am4372", "ti,am43"
> >  
> > +- AM437x SK EVM: AM437x StarterKit Evaluation Module
> > +  compatible = "ti,am437x-sk-evm", "ti,am4372", "ti,am43"
> > +
> >  - DRA742 EVM:  Software Development Board for DRA742
> >    compatible = "ti,dra7-evm", "ti,dra742", "ti,dra74", "ti,dra7"
> >  
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 621c6c5..a85a4b8 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -306,6 +306,7 @@ dtb-$(CONFIG_ARCH_OMAP4) += omap4-duovero-parlor.dtb \
> >  	omap4-var-dvk-om44.dtb \
> >  	omap4-var-stk-om44.dtb
> >  dtb-$(CONFIG_SOC_AM43XX) += am43x-epos-evm.dtb \
> > +	am437x-sk-evm.dtb \
> >  	am437x-gp-evm.dtb
> >  dtb-$(CONFIG_SOC_OMAP5) += omap5-cm-t54.dtb \
> >  	omap5-sbc-t54.dtb \
> > diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
> > new file mode 100644
> > index 0000000..e7a2bbe
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/am437x-sk-evm.dts
> > @@ -0,0 +1,583 @@
> > +/*
> > + * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com/
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +/* AM437x SK EVM */
> ??
> > +
> > +/dts-v1/;
> > +
> > +#include "am4372.dtsi"
> > +#include <dt-bindings/pinctrl/am43xx.h>
> > +#include <dt-bindings/pwm/pwm.h>
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/input.h>
> > +
> > +/ {
> > +	model = "TI AM437x SK EVM";
> > +	compatible = "ti,am437x-sk-evm","ti,am4372","ti,am43";
> > +
> > +	aliases {
> > +		display0 = &lcd0;
> > +	};
> > +
> > +	backlight {
> > +		compatible = "pwm-backlight";
> > +		pwms = <&ecap0 0 50000 PWM_POLARITY_INVERTED>;
> > +		brightness-levels = <0 51 53 56 62 75 101 152 255>;
> > +		default-brightness-level = <8>;
> > +	};
> > +
> > +	sound {
> > +		compatible = "ti,da830-evm-audio";
> > +		ti,model = "AM437x-SK-EVM";
> > +		ti,audio-codec = <&tlv320aic3106>;
> > +		ti,mcasp-controller = <&mcasp1>;
> > +		ti,codec-clock-rate = <24000000>;
> > +		ti,audio-routing =
> > +			"Headphone Jack",       "HPLOUT",
> > +			"Headphone Jack",       "HPROUT";
> > +	};
> > +
> > +	matrix_keypad: matrix_keypad at 0 {
> > +		compatible = "gpio-matrix-keypad";
> 
> no pinctrl needed?

pins are gpio by default

> > +		debounce-delay-ms = <5>;
> > +		col-scan-delay-us = <1500>;
> > +
> > +		row-gpios = <&gpio5 5 GPIO_ACTIVE_HIGH		/* Bank5, pin5 */
> > +				&gpio5 6 GPIO_ACTIVE_HIGH>;	/* Bank5, pin6 */
> > +
> > +		col-gpios = <&gpio5 13 GPIO_ACTIVE_HIGH		/* Bank5, pin13 */
> > +				&gpio5 4 GPIO_ACTIVE_HIGH>;	/* Bank5, pin4 */
> > +
> > +		linux,keymap = <
> > +				MATRIX_KEY(0, 0, KEY_DOWN)
> > +				MATRIX_KEY(0, 1, KEY_RIGHT)
> > +				MATRIX_KEY(1, 0, KEY_LEFT)
> > +				MATRIX_KEY(1, 1, KEY_UP)
> > +			>;
> > +	};
> > +
> > +	leds {
> > +		compatible = "gpio-leds";
> no pinctrl needed?

likewise

> > +		led at 0 {
> > +			label = "am437x-sk:red:heartbeat";
> > +			gpios = <&gpio5 0 GPIO_ACTIVE_HIGH>;	/* Bank 5, pin 0 */
> > +			linux,default-trigger = "heartbeat";
> > +			default-state = "off";
> > +		};
> > +
> > +		led at 1 {
> > +			label = "am437x-sk:green:mmc1";
> > +			gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;	/* Bank 5, pin 1 */
> > +			linux,default-trigger = "mmc0";
> > +			default-state = "off";
> > +		};
> > +
> > +		led at 2 {
> > +			label = "am437x-sk:blue:cpu0";
> > +			gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;	/* Bank 5, pin 2 */
> > +			linux,default-trigger = "cpu0";
> > +			default-state = "off";
> > +		};
> > +
> > +		led at 3 {
> > +			label = "am437x-sk:blue:usr3";
> > +			gpios = <&gpio5 3 GPIO_ACTIVE_HIGH>;	/* Bank 5, pin 3 */
> > +			default-state = "off";
> > +		};
> > +	};
> > +
> > +	lcd0: display {
> > +		compatible = "osddisplays,osd057T0559-34ts", "panel-dpi";
> > +		label = "lcd";
> > +
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&lcd_pins>;
> > +
> > +		enable-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
> > +
> > +		panel-timing {
> > +			clock-frequency = <9000000>;
> > +			hactive = <480>;
> > +			vactive = <272>;
> > +			hfront-porch = <8>;
> > +			hback-porch = <43>;
> > +			hsync-len = <4>;
> > +			vback-porch = <12>;
> > +			vfront-porch = <4>;
> > +			vsync-len = <10>;
> > +			hsync-active = <0>;
> > +			vsync-active = <0>;
> > +			de-active = <1>;
> > +			pixelclk-active = <1>;
> > +		};
> > +
> > +		port {
> > +			lcd_in: endpoint {
> > +				remote-endpoint = <&dpi_out>;
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&am43xx_pinmux {
> > +	i2c0_pins: i2c0_pins {
> > +		pinctrl-single,pins = <
> > +			0x188 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)  /* i2c0_sda.i2c0_sda */
> > +			0x18c (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)  /* i2c0_scl.i2c0_scl */
> > +		>;
> > +	};
> > +
> > +	i2c1_pins: i2c1_pins {
> > +		pinctrl-single,pins = <
> > +			0x15c (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE2)  /* spi0_cs0.i2c1_scl */
> > +			0x158 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE2)  /* spi0_d1.i2c1_sda  */
> > +		>;
> > +	};
> > +
> > +	mmc1_pins: pinmux_mmc1_pins {
> > +		pinctrl-single,pins = <
> > +			0x160 (PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
> > +		>;
> > +	};
> > +
> > +	ecap0_pins: backlight_pins {
> > +		pinctrl-single,pins = <
> > +			0x164 MUX_MODE0       /* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
> pin direction?



> > +		>;
> > +	};
> > +
> > +	edt_ft5306_ts_pins: edt_ft5306_ts_pins {
> > +		pinctrl-single,pins = <
> > +			0x74 (PIN_INPUT | MUX_MODE7)	/* gpmc_wpn.gpio0_31 */
> > +			0x78 (PIN_OUTPUT | MUX_MODE7)	/* gpmc_be1n.gpio1_28 */
> > +		>;
> > +	};
> > +
> > +	cpsw_default: cpsw_default {
> > +		pinctrl-single,pins = <
> > +			/* Slave 1 */
> > +			0x12c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txclk.rmii1_tclk */
> > +			0x114 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
> > +			0x128 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
> > +			0x124 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
> > +			0x120 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_td2 */
> > +			0x11c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_td3 */
> > +			0x130 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxclk.rmii1_rclk */
> > +			0x118 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
> > +			0x140 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rd0 */
> > +			0x13c (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rd1 */
> > +			0x138 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rd2 */
> > +			0x134 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rd3 */
> > +
> > +			/* Slave 2 */
> > +			0x58 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a6.rgmii2_tclk */
> > +			0x40 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a0.rgmii2_tctl */
> > +			0x54 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a5.rgmii2_td0 */
> > +			0x50 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a4.rgmii2_td1 */
> > +			0x4c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a3.rgmii2_td2 */
> > +			0x48 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a2.rgmii2_td3 */
> > +			0x5c (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a7.rgmii2_rclk */
> > +			0x44 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a1.rgmii2_rtcl */
> > +			0x6c (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a11.rgmii2_rd0 */
> > +			0x68 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a10.rgmii2_rd1 */
> > +			0x64 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a9.rgmii2_rd2 */
> > +			0x60 (PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a8.rgmii2_rd3 */
> > +		>;
> > +	};
> > +
> > +	cpsw_sleep: cpsw_sleep {
> > +		pinctrl-single,pins = <
> > +			/* Slave 1 reset value */
> > +			0x12c (PIN_INPUT_PULLDOWN | MUX_MODE7)
> > +			0x114 (PIN_INPUT_PULLDOWN | MUX_MODE7)
> > +			0x128 (PIN_INPUT_PULLDOWN | MUX_MODE7)
> > +			0x124 (PIN_INPUT_PULLDOWN | MUX_MODE7)
> > +			0x120 (PIN_INPUT_PULLDOWN | MUX_MODE7)
> > +			0x11c (PIN_INPUT_PULLDOWN | MUX_MODE7)
> > +			0x130 (PIN_INPUT_PULLDOWN | MUX_MODE7)
> > +			0x118 (PIN_INPUT_PULLDOWN | MUX_MODE7)
> > +			0x140 (PIN_INPUT_PULLDOWN | MUX_MODE7)
> > +			0x13c (PIN_INPUT_PULLDOWN | MUX_MODE7)
> > +			0x138 (PIN_INPUT_PULLDOWN | MUX_MODE7)
> > +			0x134 (PIN_INPUT_PULLDOWN | MUX_MODE7)
> > +
> > +			/* Slave 2 reset value */
> > +			0x58 (PIN_INPUT_PULLDOWN | MUX_MODE7)
> > +			0x40 (PIN_INPUT_PULLDOWN | MUX_MODE7)
> > +			0x54 (PIN_INPUT_PULLDOWN | MUX_MODE7)
> > +			0x50 (PIN_INPUT_PULLDOWN | MUX_MODE7)
> > +			0x4c (PIN_INPUT_PULLDOWN | MUX_MODE7)
> > +			0x48 (PIN_INPUT_PULLDOWN | MUX_MODE7)
> > +			0x5c (PIN_INPUT_PULLDOWN | MUX_MODE7)
> > +			0x44 (PIN_INPUT_PULLDOWN | MUX_MODE7)
> > +			0x6c (PIN_INPUT_PULLDOWN | MUX_MODE7)
> > +			0x68 (PIN_INPUT_PULLDOWN | MUX_MODE7)
> > +			0x64 (PIN_INPUT_PULLDOWN | MUX_MODE7)
> > +			0x60 (PIN_INPUT_PULLDOWN | MUX_MODE7)
> > +		>;
> > +	};
> > +
> > +	davinci_mdio_default: davinci_mdio_default {
> > +		pinctrl-single,pins = <
> > +			/* MDIO */
> > +			0x148 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
> > +			0x14c (PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
> > +		>;
> > +	};
> > +
> > +	davinci_mdio_sleep: davinci_mdio_sleep {
> > +		pinctrl-single,pins = <
> > +			/* MDIO reset value */
> > +			0x148 (PIN_INPUT_PULLDOWN | MUX_MODE7)
> > +			0x14c (PIN_INPUT_PULLDOWN | MUX_MODE7)
> > +		>;
> > +	};
> > +
> > +	dss_pins: dss_pins {
> > +		pinctrl-single,pins = <
> > +			0x020 (PIN_OUTPUT_PULLUP | MUX_MODE1)	/* gpmc ad 8 -> DSS DATA 23 */
> > +			0x024 (PIN_OUTPUT_PULLUP | MUX_MODE1)
> > +			0x028 (PIN_OUTPUT_PULLUP | MUX_MODE1)
> > +			0x02c (PIN_OUTPUT_PULLUP | MUX_MODE1)
> > +			0x030 (PIN_OUTPUT_PULLUP | MUX_MODE1)
> > +			0x034 (PIN_OUTPUT_PULLUP | MUX_MODE1)
> > +			0x038 (PIN_OUTPUT_PULLUP | MUX_MODE1)
> > +			0x03c (PIN_OUTPUT_PULLUP | MUX_MODE1)	/* gpmc ad 15 -> DSS DATA 16 */
> > +			0x0a0 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* DSS DATA 0 */
> > +			0x0a4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
> > +			0x0a8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
> > +			0x0ac (PIN_OUTPUT_PULLUP | MUX_MODE0)
> > +			0x0b0 (PIN_OUTPUT_PULLUP | MUX_MODE0)
> > +			0x0b4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
> > +			0x0b8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
> > +			0x0bc (PIN_OUTPUT_PULLUP | MUX_MODE0)
> > +			0x0c0 (PIN_OUTPUT_PULLUP | MUX_MODE0)
> > +			0x0c4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
> > +			0x0c8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
> > +			0x0cc (PIN_OUTPUT_PULLUP | MUX_MODE0)
> > +			0x0d0 (PIN_OUTPUT_PULLUP | MUX_MODE0)
> > +			0x0d4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
> > +			0x0d8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
> > +			0x0dc (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* DSS DATA 15 */
> > +			0x0e0 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* DSS VSYNC */
> > +			0x0e4 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* DSS HSYNC */
> > +			0x0e8 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* DSS PCLK */
> > +			0x0ec (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* DSS AC BIAS EN */
> > +
> > +		>;
> > +	};
> > +
> > +	qspi_pins: qspi_pins {
> > +		pinctrl-single,pins = <
> > +			0x7c (PIN_OUTPUT_PULLUP | MUX_MODE3)	/* gpmc_csn0.qspi_csn */
> > +			0x88 (PIN_OUTPUT | MUX_MODE2)		/* gpmc_csn3.qspi_clk */
> > +			0x90 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_advn_ale.qspi_d0 */
> > +			0x94 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_oen_ren.qspi_d1 */
> > +			0x98 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_wen.qspi_d2 */
> > +			0x9c (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_be0n_cle.qspi_d3 */
> > +		>;
> > +	};
> > +
> > +	mcasp1_pins: mcasp1_pins {
> > +		pinctrl-single,pins = <
> > +			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* mii1_crs.mcasp1_aclkx */
> > +			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* mii1_rxerr.mcasp1_fsx */
> > +			0x108 (PIN_OUTPUT_PULLDOWN | MUX_MODE4)	/* mii1_col.mcasp1_axr2 */
> > +			0x144 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* rmii1_ref_clk.mcasp1_axr3 */
> > +		>;
> > +	};
> > +
> > +	lcd_pins: lcd_pins {
> > +		pinctrl-single,pins = <
> > +			/* GPIO 5_8 to select LCD / HDMI */
> > +			0x238 (PIN_OUTPUT_PULLUP | MUX_MODE7)
> > +		>;
> > +	};
> > +};
> > +
> > +&i2c0 {
> > +        status = "okay";
> > +        pinctrl-names = "default";
> > +        pinctrl-0 = <&i2c0_pins>;
> 
> what speed are you running this on? -> also can you align these to 1

100kHz ?

> tab instead of spaces?

weird, I remember aligning everything with tabs. Will fix that up.

> > +	tps at 24 {
> > +		compatible = "ti,tps65218";
> > +		reg = <0x24>;
> > +		interrupt-parent = <&gic>;
> > +		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> 
> is this muxed?

there's no configuration for this. This pin is a single function.

> > +		interrupt-controller;
> > +		#interrupt-cells = <2>;
> > +
> > +		dcdc1: regulator-dcdc1 {
> > +			compatible = "ti,tps65218-dcdc1";
> > +			/* VDD_CORE limits min of OPP50 and max of OPP100 */
> > +			regulator-name = "vdd_core";
> > +			regulator-min-microvolt = <912000>;
> > +			regulator-max-microvolt = <1144000>;
> > +			regulator-boot-on;
> > +			regulator-always-on;
> > +		};
> > +
> > +		dcdc2: regulator-dcdc2 {
> > +			compatible = "ti,tps65218-dcdc2";
> > +			/* VDD_MPU limits min of OPP50 and max of OPP_NITRO */
> > +			regulator-name = "vdd_mpu";
> > +			regulator-min-microvolt = <912000>;
> > +			regulator-max-microvolt = <1378000>;
> > +			regulator-boot-on;
> > +			regulator-always-on;
> > +		};
> > +
> > +		dcdc3: regulator-dcdc3 {
> > +			compatible = "ti,tps65218-dcdc3";
> > +			regulator-name = "vdds_ddr";
> no voltage ?

has no users in kernel. Also, it comes out with default, and correct,
voltage.

> > +			regulator-boot-on;
> > +			regulator-always-on;
> > +		};
> > +
> > +		dcdc4: regulator-dcdc4 {
> > +			compatible = "ti,tps65218-dcdc4";
> > +			regulator-name = "v3_3d";
> > +			regulator-min-microvolt = <3300000>;
> > +			regulator-max-microvolt = <3300000>;
> > +			regulator-boot-on;
> > +			regulator-always-on;
> > +		};
> > +
> > +		ldo1: regulator-ldo1 {
> > +			compatible = "ti,tps65218-ldo1";
> > +			regulator-name = "v1_8d";
> > +			regulator-min-microvolt = <1800000>;
> > +			regulator-max-microvolt = <1800000>;
> > +			regulator-boot-on;
> > +			regulator-always-on;
> > +		};
> > +
> > +	};
> > +
> > +	at24 at 50 {
> > +		compatible = "at24,24c256";
> > +		pagesize = <64>;
> > +		reg = <0x50>;
> > +	};
> > +};
> > +
> > +&i2c1 {
> > +        status = "okay";
> > +        pinctrl-names = "default";
> > +        pinctrl-0 = <&i2c1_pins>;
> ^^ alignment problem
> 
> Also speed please.

will add.

> > +	edt-ft5306 at 38 {
> > +		status = "okay";
> > +		compatible = "edt,edt-ft5306", "edt,edt-ft5x06";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&edt_ft5306_ts_pins>;
> > +		reg = <0x38>;
> > +		interrupt-parent = <&gpio0>;
> > +		interrupts = <31 0>;
> > +
> > +		wake-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
> 
> why wake-gpios? we should be using pinctrl with interrupt-extended to
> do wakeup sequence, no?

sure, can you patch the edt driver ? I'll fix the DTS after that gets
merged

> > +		touchscreen-size-x = <480>;
> > +		touchscreen-size-y = <272>;
> > +	};
> > +
> > +	tlv320aic3106: tlv320aic3106 at 1b {
> > +		compatible = "ti,tlv320aic3106";
> > +		reg = <0x1b>;
> > +		status = "okay";
> > +
> > +		/* Regulators */
> > +		AVDD-supply = <&dcdc4>;
> > +		IOVDD-supply = <&dcdc4>;
> > +		DRVDD-supply = <&dcdc4>;
> > +		DVDD-supply = <&ldo1>;
> > +	};
> > +
> > +	lis331dlh at 18 {
> > +		compatible = "st,lis331dlh";
> > +		reg = <0x18>;
> > +		status = "okay";
> > +
> > +		Vdd-supply = <&dcdc4>;
> > +		Vdd_IO-supply = <&dcdc4>;
> > +		interrupts-extended = <&gpio1 6 0>, <&gpio2 1 0>;
> > +	};
> > +};
> > +
> > +&epwmss0 {
> > +	status = "okay";
> > +};
> > +
> > +&ecap0 {
> > +	status = "okay";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&ecap0_pins>;
> > +};
> > +
> > +&gpio0 {
> > +	status = "okay";
> > +};
> > +
> > +&gpio1 {
> > +	status = "okay";
> > +};
> > +
> > +&gpio5 {
> > +	status = "okay";
> > +};
> > +
> > +&mmc1 {
> > +	status = "okay";
> > +	vmmc-supply = <&dcdc4>;
> > +	bus-width = <4>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&mmc1_pins>;
> 
> just for style, wonder if moving the pinctrl just after status is better?

why ? makes no difference.

> > +	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
> > +};
> > +
> > +&usb2_phy1 {
> > +	status = "okay";
> > +};
> > +
> > +&usb1 {
> > +	dr_mode = "peripheral";
> > +	status = "okay";
> > +};
> > +
> > +&usb2_phy2 {
> > +	status = "okay";
> > +};
> > +
> > +&usb2 {
> > +	dr_mode = "host";
> > +	status = "okay";
> > +};
> none of the above need pinctrl? no regulator supplies?

pins in default states, drivers don't use regulators.

> > +&qspi {
> > +	status = "okay";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&qspi_pins>;
> > +
> > +	spi-max-frequency = <48000000>;
> > +	m25p80 at 0 {
> > +		compatible = "mx66l51235l";
> > +		spi-max-frequency = <48000000>;
> > +		reg = <0>;
> > +		spi-cpol;
> > +		spi-cpha;
> > +		spi-tx-bus-width = <1>;
> > +		spi-rx-bus-width = <4>;
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +
> > +		/* MTD partition table.
> /*
>  * MTD partition table.
> ?

can be fixed.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/f684b8a9/attachment-0001.sig>
