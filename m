From: balbi@ti.com (Felipe Balbi)
Date: Wed, 12 Nov 2014 18:59:34 -0600
Subject: [PATCH 2/2] ARM: dts: Add devicetree for NovaTech OrionLXm
In-Reply-To: <1415832094-20991-2-git-send-email-george.mccollister@gmail.com>
References: <1415832094-20991-1-git-send-email-george.mccollister@gmail.com>
 <1415832094-20991-2-git-send-email-george.mccollister@gmail.com>
Message-ID: <20141113005908.GA27381@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 12, 2014 at 04:41:33PM -0600, George McCollister wrote:
> diff --git a/arch/arm/boot/dts/am335x-lxm.dts b/arch/arm/boot/dts/am335x-lxm.dts
> new file mode 100644
> index 0000000..0f7cbae
> --- /dev/null
> +++ b/arch/arm/boot/dts/am335x-lxm.dts
> @@ -0,0 +1,354 @@
> +/*
> + * Copyright (C) 2014 NovaTech LLC - http://www.novatechweb.com
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +/dts-v1/;
> +
> +#include "am33xx.dtsi"
> +
> +/ {
> +	model = "NovaTech OrionLXm";
> +	compatible = "novatech,am335x-lxm", "ti,am33xx";
> +
> +	cpus {
> +		cpu at 0 {
> +			cpu0-supply = <&vdd1_reg>;
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x80000000 0x20000000>; /* 512 MB */
> +	};
> +
> +	vbat: fixedregulator at 0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vbat";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-boot-on;
> +	};

I suppose this is the 5V on a power jack, or something like that ?

> +	vmmcsd_fixed: fixedregulator at 0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vmmcsd_fixed";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;

but this... I know every other board devices this as a fixed regulator,
but is it really a fixed regulator or is supplied by one of the LDOs on
the PMIC ?

> +	};
> +};
> +
> +&am33xx_pinmux {
> +	mmc1_pins: pinmux_mmc1_pins {
> +		pinctrl-single,pins = <
> +			0xf0 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3 */
> +			0xf4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2 */
> +			0xf8 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1 */
> +			0xfc (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0 */
> +			0x100 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk */
> +			0x104 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd */
> +		>;
> +	};
> +
> +	i2c0_pins: pinmux_i2c0_pins {
> +		pinctrl-single,pins = <
> +			0x188 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
> +			0x18c (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
> +		>;
> +	};
> +
> +	i2c2_pins: pinmux_i2c2_pins {
> +		pinctrl-single,pins = <
> +			0x178 (PIN_INPUT_PULLUP | MUX_MODE3)	/* uart1_ctsn.i2c2_sda */
> +			0x17c (PIN_INPUT_PULLUP | MUX_MODE3)	/* uart1_rtsn.i2c2_scl */

on thing to keep in mind, if you already have external pullups, you
might not want to add internal pullups as you'd end up with both
resistors in parallel. For I2C the danger is minimal (unless you have a
ton of bus capacitance, then it changes high/low time), but it's best to
write a more "pristine" DTS. (and sure, I know pretty much every board
makes this mistake, but it's best if we don't proliferate the error)

> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_pins>;
> +
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	serial_config1: serial_config1 at 20 {
> +		compatible = "nxp,pca9539";
> +		reg = <0x20>;
> +	};
> +
> +	serial_config2: serial_config2 at 21 {
> +		compatible = "nxp,pca9539";
> +		reg = <0x21>;
> +	};
> +
> +	tps: tps at 2d {
> +		reg = <0x2d>;

which TPS device ? no compatible ?

> +/include/ "tps65910.dtsi"

oh... okay.

> +&tps {
> +	vcc1-supply = <&vbat>;
> +	vcc2-supply = <&vbat>;
> +	vcc3-supply = <&vbat>;
> +	vcc4-supply = <&vbat>;
> +	vcc5-supply = <&vbat>;
> +	vcc6-supply = <&vbat>;
> +	vcc7-supply = <&vbat>;
> +	vccio-supply = <&vbat>;
> +
> +	regulators {
> +		vrtc_reg: regulator at 0 {
> +			regulator-always-on;

this should not be always on, you want to pass this as supply to the RTC
module so it can manage it. It's also best to give names to all
regulators, so people know what they're used for.

> +		};
> +
> +		vio_reg: regulator at 1 {
> +			regulator-always-on;
> +		};
> +
> +		vdd1_reg: regulator at 2 {
> +			regulator-name = "vdd_mpu";
> +			regulator-min-microvolt = <600000>;
> +			regulator-max-microvolt = <1500000>;
> +			regulator-boot-on;
> +			regulator-always-on;
> +		};
> +
> +		vdd2_reg: regulator at 3 {
> +			regulator-always-on;
> +		};
> +
> +		vdd3_reg: regulator at 4 {
> +			regulator-always-on;
> +		};
> +
> +		vdig1_reg: regulator at 5 {
> +			regulator-always-on;
> +		};
> +
> +		vdig2_reg: regulator at 6 {
> +			regulator-always-on;
> +		};
> +
> +		vpll_reg: regulator at 7 {
> +			regulator-always-on;
> +		};
> +
> +		vdac_reg: regulator at 8 {
> +			regulator-always-on;
> +		};
> +
> +		vaux1_reg: regulator at 9 {
> +			regulator-always-on;
> +		};
> +
> +		vaux2_reg: regulator at 10 {
> +			regulator-always-on;
> +		};
> +
> +		vaux33_reg: regulator at 11 {

isn't this the supply to the other MMC slot ?

> +			regulator-always-on;
> +		};
> +
> +		vmmc_reg: regulator at 12 {
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};
> +	};
> +};
> +
> +&sham {
> +	status = "okay";
> +};
> +
> +&aes {
> +	status = "okay";
> +};

just making sure, are you really using them ?

> +&mmc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc1_pins>;
> +	bus-width = <4>;
> +	status = "okay";
> +	vmmc-supply = <&vmmc_reg>;
> +	ti,vcc-aux-disable-is-sleep;

this binding isn't documented anywhere. What was it supposed to do ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141112/59b37c4f/attachment-0001.sig>
