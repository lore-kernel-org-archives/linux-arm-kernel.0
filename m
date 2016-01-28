From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 28 Jan 2016 10:04:05 +0800
Subject: [PATCH V5] ARM: dts: imx6q-icore-rqs: Add Engicam IMX6 Q7
 initial support
In-Reply-To: <20151224092439.GA9078@panicking>
References: <1447674695.3144.21.camel@pengutronix.de>
 <20151116115421.GC10464@panicking> <20151116172318.GA513@panicking>
 <1447752697.3144.47.camel@pengutronix.de>
 <20151118151030.GA11558@panicking> <20151211083512.GB11252@tiger>
 <20151214084456.GA4305@panicking>
 <20151216181159.GC20121@panicking> <20151223022707.GG26290@tiger>
 <20151224092439.GA9078@panicking>
Message-ID: <20160128020405.GC9070@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 24, 2015 at 10:24:47AM +0100, Michael Trimarchi wrote:
> www.engicam.com/en/products/embedded/som/standard/i-core-rqs-m6s-dl-d-q
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
> Test on top of ARM: dts: imx6q: clean up unused ipu2grp
> 
> Changes in v5:
> 	- None
> 
> Changes in v4:
> 	- update regulator name
> 	- using flat pins,fsl
> 	- move iomuxc
> 	- add X11 license
> 	- better alphabetic order
> 
> Changes in v3:
> 	- add sgtl audio support
> 	- add ethernet gigabit tuning
> 	- use hub reset only in usbhub and not
> 	 in otg vbus
> 
> Changes in v2:
> 	- add the board in alphabetic order
> 	- remove cpu operating point
> 	- remove simple-bus and adjust regulaotor
> 	- add gpios to correct pinctrl
> 	- remove no mainline binding of gpc
> 
>  arch/arm/boot/dts/Makefile               |   1 +
>  arch/arm/boot/dts/imx6q-icore-rqs.dts    |  78 ++++++
>  arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi | 410 +++++++++++++++++++++++++++++++
>  3 files changed, 489 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6q-icore-rqs.dts
>  create mode 100644 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index bb8fa02..7e8f29c 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -312,6 +312,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6q-gw551x.dtb \
>  	imx6q-gw552x.dtb \
>  	imx6q-hummingboard.dtb \
> +	imx6q-icore-rqs.dtb \
>  	imx6q-nitrogen6x.dtb \
>  	imx6q-phytec-pbab01.dtb \
>  	imx6q-rex-pro.dtb \
> diff --git a/arch/arm/boot/dts/imx6q-icore-rqs.dts b/arch/arm/boot/dts/imx6q-icore-rqs.dts
> new file mode 100644
> index 0000000..0053188
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-icore-rqs.dts
> @@ -0,0 +1,78 @@
> +/*
> + * Copyright (C) 2015 Amarula Solutions B.V.
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License
> + *     version 2 as published by the Free Software Foundation.
> + *
> + *     This file is distributed in the hope that it will be useful
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6q.dtsi"
> +#include "imx6qdl-icore-rqs.dtsi"
> +
> +/ {
> +	model = "Engicam i.CoreM6 Quad SOM";
> +	compatible = "engicam,imx6-icore-rqs", "fsl,imx6q";
> +
> +	sound {
> +		compatible = "fsl,imx-audio-sgtl5000";
> +		model = "imx-audio-sgtl5000";
> +		ssi-controller = <&ssi1>;
> +		audio-codec = <&codec>;
> +		audio-routing =
> +			"MIC_IN", "Mic Jack",
> +			"Mic Jack", "Mic Bias",
> +			"Headphone Jack", "HP_OUT";
> +		mux-int-port = <1>;
> +		mux-ext-port = <4>;
> +	};
> +};
> +
> +&i2c3 {
> +	codec: sgtl5000 at 0a {
> +		compatible = "fsl,sgtl5000";
> +		reg = <0x0a>;
> +		clocks = <&clks IMX6QDL_CLK_CKO>;
> +		VDDA-supply = <&reg_2p5v>;
> +		VDDIO-supply = <&reg_3p3v>;
> +		VDDD-supply = <&reg_1p8v>;
> +	};
> +};
> +
> +&sata {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
> new file mode 100644
> index 0000000..b984128
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
> @@ -0,0 +1,410 @@
> +/*
> + * Copyright (C) 2015 Amarula Solutions B.V.
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License
> + *     version 2 as published by the Free Software Foundation.
> + *
> + *     This file is distributed in the hope that it will be useful
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/clock/imx6qdl-clock.h>
> +
> +/ {
> +	memory {
> +		reg = <0x10000000 0x80000000>;
> +	};
> +
> +	reg_1p8v: regulator-1p8v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "1P8V";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	reg_2p5v: regulator-2p5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "2P5V";
> +		regulator-min-microvolt = <2500000>;
> +		regulator-max-microvolt = <2500000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	reg_3p3v: regulator-3p3v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "3P3V";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	reg_sd3_vmmc: sd3-vmmc {

Why are the regulator nodes starting from this one not following the
naming schema regulator-xxx any more?

> +		compatible = "regulator-fixed";
> +		regulator-name = "P3V3_SD3_SWITCHED";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio1 4 GPIO_ACTIVE_LOW>;
> +		enable-active-high;
> +	};
> +
> +	reg_sd4_vmmc: sd4-vmmc {
> +		compatible = "regulator-fixed";
> +		regulator-name = "P3V3_SD4_SWITCHED";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	reg_usb_h1_vbus: usb-h1-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_h1_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	reg_usb_otg_vbus: usb-otg-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_otg_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	usb_hub: usb-hub {
> +		compatible = "smsc,usb3503a";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_usbhub>;
> +		reset-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
> +		clocks = <&clks IMX6QDL_CLK_LVDS2_GATE>;
> +		clock-names = "refclk";
> +	};
> +};
> +
> +&clks {
> +	assigned-clocks = <&clks IMX6QDL_CLK_LVDS2_SEL>;
> +	assigned-clock-parents = <&clks IMX6QDL_CLK_OSC>;
> +};
> +
> +&audmux {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_audmux>;
> +	status = "okay";
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet_3>;
> +	phy-handle = <&eth_phy>;
> +	phy-mode = "rgmii";
> +	status = "okay";

Have a new line between properties and sub-node.

> +	mdio {
> +		eth_phy: ethernet-phy {
> +			rxc-skew-ps = <1140>;
> +			txc-skew-ps = <1140>;
> +			txen-skew-ps = <600>;
> +			rxdv-skew-ps = <240>;
> +			rxd0-skew-ps = <420>;
> +			rxd1-skew-ps = <600>;
> +			rxd2-skew-ps = <420>;
> +			rxd3-skew-ps = <240>;
> +			txd0-skew-ps = <60>;
> +			txd1-skew-ps = <60>;
> +			txd2-skew-ps = <60>;
> +			txd3-skew-ps = <240>;
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1_1>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2_2>;
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3_4>;
> +	status = "okay";
> +};
> +
> +&pcie {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pcie>;
> +	reset-gpio = <&gpio3 29 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&ssi1 {
> +	fsl,mode = "i2s-slave";
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart4_1>;
> +	status = "okay";
> +};
> +
> +&usbh1 {
> +	vbus-supply = <&reg_usb_h1_vbus>;
> +	disable-over-current;
> +	clocks = <&clks IMX6QDL_CLK_USBOH3>;
> +	status = "okay";
> +};
> +
> +&usbotg {
> +	vbus-supply = <&reg_usb_otg_vbus>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbotg_2>;
> +	disable-over-current;
> +	status = "okay";
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc1_1>;
> +	no-1-8-v;
> +	status = "okay";
> +};
> +
> +&usdhc3 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc3_2>;
> +	pinctrl-1 = <&pinctrl_usdhc3_2_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc3_2_200mhz>;
> +	vmcc-supply = <&reg_sd3_vmmc>;
> +	cd-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
> +	bus-witdh=<4>;
> +	no-1-8-v;
> +	status = "okay";
> +};
> +
> +&usdhc4 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc4_1>;
> +	pinctrl-1 = <&pinctrl_usdhc4_1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc4_1_200mhz>;
> +	vmcc-supply = <&reg_sd4_vmmc>;
> +	bus-witdh=<8>;
> +	no-1-8-v;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_audmux: audmux {
> +		fsl,pins = <
> +			MX6QDL_PAD_DISP0_DAT20__AUD4_TXC  0x130b0
> +			MX6QDL_PAD_DISP0_DAT21__AUD4_TXD  0x110b0
> +			MX6QDL_PAD_DISP0_DAT22__AUD4_TXFS 0x130b0
> +			MX6QDL_PAD_DISP0_DAT23__AUD4_RXD  0x130b0
> +		>;
> +	};
> +
> +	pinctrl_enet_3: enetgrp-3 {

The suffix number means nothing here.  Please drop them.

	pinctrl_enet: enetgrp

> +		fsl,pins = <
> +			MX6QDL_PAD_ENET_MDIO__ENET_MDIO       0x1b0b0
> +			MX6QDL_PAD_ENET_MDC__ENET_MDC         0x1b0b0
> +			MX6QDL_PAD_RGMII_TXC__RGMII_TXC       0x1b0b0
> +			MX6QDL_PAD_RGMII_TD0__RGMII_TD0       0x1b0b0
> +			MX6QDL_PAD_RGMII_TD1__RGMII_TD1       0x1b0b0
> +			MX6QDL_PAD_RGMII_TD2__RGMII_TD2       0x1b0b0
> +			MX6QDL_PAD_RGMII_TD3__RGMII_TD3       0x1b0b0
> +			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x1b0b0
> +			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0b0
> +			MX6QDL_PAD_RGMII_RXC__RGMII_RXC       0x1b0b0
> +			MX6QDL_PAD_RGMII_RD0__RGMII_RD0       0x1b0b0
> +			MX6QDL_PAD_RGMII_RD1__RGMII_RD1       0x1b0b0
> +			MX6QDL_PAD_RGMII_RD2__RGMII_RD2       0x1b0b0
> +			MX6QDL_PAD_RGMII_RD3__RGMII_RD3       0x1b0b0
> +			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
> +			MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN     0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_i2c1_1: i2c1grp-1 {

	pinctrl_i2c1: i2c1grp

Please check all the pinctrl nodes below.

Shawn

> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_D21__I2C1_SCL 0x4001b8b1
> +			MX6QDL_PAD_EIM_D28__I2C1_SDA 0x4001b8b1
> +		>;
> +	};
> +
> +	pinctrl_i2c2_2: i2c2grp-2 {
> +		fsl,pins = <
> +			MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b8b1
> +			MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b8b1
> +		>;
> +	};
> +
> +	pinctrl_i2c3_4: i2c3grp-4 {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_5__I2C3_SCL  0x4001b8b1
> +			MX6QDL_PAD_EIM_D18__I2C3_SDA 0x4001b8b1
> +			MX6QDL_PAD_GPIO_0__CCM_CLKO1    0x130b0
> +		>;
> +	};
> +
> +	pinctrl_pcie: pciegrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_D29__GPIO3_IO29 0x1f059	/* PCIe Reset */
> +		>;
> +	};
> +
> +	pinctrl_uart4_1: uart4grp-1 {
> +		fsl,pins = <
> +			MX6QDL_PAD_KEY_COL0__UART4_TX_DATA 0x1b0b1
> +			MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA 0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_usbhub: usbhubgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_6__GPIO1_IO06  0x1f059	/* HUB USB Reset */
> +		>;
> +	};
> +
> +	pinctrl_usbotg_2: usbotggrp-2 {
> +		fsl,pins = <
> +			MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID 0x17059
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_1: usdhc1grp-1 {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17071
> +			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10071
> +			MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17071
> +			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17071
> +			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17071
> +			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17071
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_2: usdhc3grp-2 {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD3_CMD__SD3_CMD    0x17070
> +			MX6QDL_PAD_SD3_CLK__SD3_CLK    0x10070
> +			MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x17070
> +			MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x17070
> +			MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x17070
> +			MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x17070
> +			MX6QDL_PAD_GPIO_1__GPIO1_IO01  0x1f059	/* CD */
> +			MX6QDL_PAD_GPIO_4__GPIO1_IO04  0x1f059	/* PWR */
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_2_100mhz: usdhc3grp-2_100mhz {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD3_CMD__SD3_CMD    0x170B1
> +			MX6QDL_PAD_SD3_CLK__SD3_CLK    0x100B1
> +			MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x170B1
> +			MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x170B1
> +			MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x170B1
> +			MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x170B1
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_2_200mhz: usdhc3grp-2_200mhz {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD3_CMD__SD3_CMD    0x170F9
> +			MX6QDL_PAD_SD3_CLK__SD3_CLK    0x100F9
> +			MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x170F9
> +			MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x170F9
> +			MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x170F9
> +			MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x170F9
> +		>;
> +	};
> +
> +	pinctrl_usdhc4_1: usdhc4grp-1 {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD4_CMD__SD4_CMD    0x17070
> +			MX6QDL_PAD_SD4_CLK__SD4_CLK    0x10070
> +			MX6QDL_PAD_SD4_DAT0__SD4_DATA0 0x17070
> +			MX6QDL_PAD_SD4_DAT1__SD4_DATA1 0x17070
> +			MX6QDL_PAD_SD4_DAT2__SD4_DATA2 0x17070
> +			MX6QDL_PAD_SD4_DAT3__SD4_DATA3 0x17070
> +			MX6QDL_PAD_SD4_DAT4__SD4_DATA4 0x17070
> +			MX6QDL_PAD_SD4_DAT5__SD4_DATA5 0x17070
> +			MX6QDL_PAD_SD4_DAT6__SD4_DATA6 0x17070
> +			MX6QDL_PAD_SD4_DAT7__SD4_DATA7 0x17070
> +		>;
> +	};
> +
> +	pinctrl_usdhc4_1_100mhz: usdhc4grp-1_100mhz {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD4_CMD__SD4_CMD    0x170B1
> +			MX6QDL_PAD_SD4_CLK__SD4_CLK    0x100B1
> +			MX6QDL_PAD_SD4_DAT0__SD4_DATA0 0x170B1
> +			MX6QDL_PAD_SD4_DAT1__SD4_DATA1 0x170B1
> +			MX6QDL_PAD_SD4_DAT2__SD4_DATA2 0x170B1
> +			MX6QDL_PAD_SD4_DAT3__SD4_DATA3 0x170B1
> +			MX6QDL_PAD_SD4_DAT4__SD4_DATA4 0x170B1
> +			MX6QDL_PAD_SD4_DAT5__SD4_DATA5 0x170B1
> +			MX6QDL_PAD_SD4_DAT6__SD4_DATA6 0x170B1
> +			MX6QDL_PAD_SD4_DAT7__SD4_DATA7 0x170B1
> +		>;
> +	};
> +
> +	pinctrl_usdhc4_1_200mhz: usdhc4grp-2_200mhz {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD4_CMD__SD4_CMD    0x170F9
> +			MX6QDL_PAD_SD4_CLK__SD4_CLK    0x100F9
> +			MX6QDL_PAD_SD4_DAT0__SD4_DATA0 0x170F9
> +			MX6QDL_PAD_SD4_DAT1__SD4_DATA1 0x170F9
> +			MX6QDL_PAD_SD4_DAT2__SD4_DATA2 0x170F9
> +			MX6QDL_PAD_SD4_DAT3__SD4_DATA3 0x170F9
> +			MX6QDL_PAD_SD4_DAT4__SD4_DATA4 0x170F9
> +			MX6QDL_PAD_SD4_DAT5__SD4_DATA5 0x170F9
> +			MX6QDL_PAD_SD4_DAT6__SD4_DATA6 0x170F9
> +			MX6QDL_PAD_SD4_DAT7__SD4_DATA7 0x170F9
> +		>;
> +	};
> +};
> -- 
> 2.6.4
> 
> 
