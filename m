From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 16 Nov 2015 10:19:12 +0100
Subject: [PATCH] ARM: dts: imx6q-icore-rqs: Add Engicam IMX6 Q7 initial
 support
In-Reply-To: <1447584853-12560-1-git-send-email-michael@amarulasolutions.com>
References: <1447584853-12560-1-git-send-email-michael@amarulasolutions.com>
Message-ID: <1447665552.3144.6.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, den 15.11.2015, 11:54 +0100 schrieb Michael Trimarchi:
> www.engicam.com/en/products/embedded/som/standard/i-core-rqs-m6s-dl-d-q
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  arch/arm/boot/dts/Makefile               |   1 +
>  arch/arm/boot/dts/imx6q-icore-rqs.dts    |  36 +++
>  arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi | 372 +++++++++++++++++++++++++++++++
>  3 files changed, 409 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6q-icore-rqs.dts
>  create mode 100644 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index bb8fa02..7c4706d 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -284,6 +284,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6dl-gw551x.dtb \
>  	imx6dl-gw552x.dtb \
>  	imx6dl-hummingboard.dtb \
> +	imx6q-icore-rqs.dtb \

Alphabetical ordering, please. Quad boards must not be added in between
DL boards.

>  	imx6dl-nitrogen6x.dtb \
>  	imx6dl-phytec-pbab01.dtb \
>  	imx6dl-rex-basic.dtb \
> diff --git a/arch/arm/boot/dts/imx6q-icore-rqs.dts b/arch/arm/boot/dts/imx6q-icore-rqs.dts
> new file mode 100644
> index 0000000..cded07d
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-icore-rqs.dts
> @@ -0,0 +1,36 @@
> +/*
> + * Copyright (C) 2015 Amarula Solutions B.V.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6q.dtsi"
> +#include "imx6qdl-icore-rqs.dtsi"
> +
> +/ {
> +	model = "Engicam i.CoreM6 Quad SOM";
> +	compatible = "fsl,imx6-icore-rqs", "fsl,imx6q";
> +	cpus {
> +		cpu at 0 {
> +			operating-points = <
> +				/* kHz    uV */
> +				792000  1150000
> +				396000  1150000
> +			>;
> +
> +			fsl,soc-operating-points = <
> +				/* ARM kHz  SOC-PU uV */
> +				792000        1175000
> +				396000        1175000
> +			>;
> +		};
Why do you need to edit the OPPS here? Just to fix them on a specific
voltage? Why?

> +	};
> +};
> +
> +&sata {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
> new file mode 100644
> index 0000000..59c416e
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
> @@ -0,0 +1,372 @@
> +/*
> + * Copyright 2015 Amarula Solutions B.V.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/clock/imx6qdl-clock.h>
> +
> +/ {
> +	memory {
> +		reg = <0x10000000 0x80000000>;
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +
> +		reg_usb_h1_vbus: usb_h1_vbus {
> +			compatible = "regulator-fixed";
> +			regulator-name = "usb_h1_vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			gpio = <&gpio1 6 GPIO_ACTIVE_HIGH>;
> +			enable-active-high;
> +		};
> +
> +		reg_usb_otg_vbus: usb_otg_vbus {
> +			compatible = "regulator-fixed";
> +			regulator-name = "usb_otg_vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
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
> +		reg_2p5v: 2p5v {
> +			compatible = "regulator-fixed";
> +			regulator-name = "2P5V";
> +			regulator-min-microvolt = <2500000>;
> +			regulator-max-microvolt = <2500000>;
> +			regulator-always-on;
> +		};
> +
> +		reg_1p8v: 1p8v {
> +			compatible = "regulator-fixed";
> +			regulator-name = "1P8V";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-always-on;
> +		};
> +
> +		reg_sd4_vmmc: sd4_vmmc {
> +			compatible = "regulator-fixed";
> +			regulator-name = "P3V3_SD4_SWITCHED";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-boot-on;
> +			regulator-always-on;
> +		};
> +
> +		reg_sd3_vmmc: sd3_vmmc {
> +			compatible = "regulator-fixed";
> +			regulator-name = "P3V3_SD3_SWITCHED";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			gpio = <&gpio1 4 GPIO_ACTIVE_LOW>;
> +			regulator-boot-on;
> +			regulator-always-on;
> +		};

A lot of those regulators look like they don't need to be always-on.

Also the use of a simple-bus, while giving some structure to the DT is
considered bad style as it doesn't reflect any real hardware.

> +	};
> +
> +	usb_hub: usb-hub {
> +		compatible = "smsc,usb3503a";
> +		clocks = <&clks IMX6QDL_CLK_LVDS2_GATE>;
> +		clock-names = "refclk";
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;
> +
> +	imx6qdl-icore-rqs {
> +		pinctrl_hog: hoggrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_D29__GPIO3_IO29 0x1f059		/* PCIe Reset */

Add a pcie pincontrol for this.
> +				MX6QDL_PAD_GPIO_1__GPIO1_IO01  0x1f059		/* SD3_CD */
> +				MX6QDL_PAD_GPIO_4__GPIO1_IO04  0x1f059		/* SD3_PWR */

Add to USDHC3 pincontrol.
> +				MX6QDL_PAD_GPIO_6__GPIO1_IO06  0x1f059		/* HUB USB Reset */

Add to USB pincontrol where the hub is conntected.
> +			>;
> +		};
> +
> +		pinctrl_audmux_4: audmux-4 {
> +			fsl,pins = <
> +				MX6QDL_PAD_DISP0_DAT20__AUD4_TXC  0x130b0
> +				MX6QDL_PAD_DISP0_DAT21__AUD4_TXD 0x110b0
> +				MX6QDL_PAD_DISP0_DAT22__AUD4_TXFS  0x130b0
> +				MX6QDL_PAD_DISP0_DAT23__AUD4_RXD  0x130b0
> +			>;
> +		};
> +
> +		pinctrl_usdhc1_1: usdhc1grp-1 {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17071
> +				MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10071
> +				MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17071
> +				MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17071
> +				MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17071
> +				MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17071
> +			>;
> +		};
> +
> +		pinctrl_usdhc3_2: usdhc3grp-2 {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD3_CMD__SD3_CMD    0x17070
> +				MX6QDL_PAD_SD3_CLK__SD3_CLK    0x10070
> +				MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x17070
> +				MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x17070
> +				MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x17070
> +				MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x17070
> +			>;
> +		};
> +
> +		pinctrl_usdhc3_2_100mhz: usdhc3grp-2_100mhz {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD3_CMD__SD3_CMD    0x170B1
> +				MX6QDL_PAD_SD3_CLK__SD3_CLK    0x100B1
> +				MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x170B1
> +				MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x170B1
> +				MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x170B1
> +				MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x170B1
> +			>;
> +		};
> +
> +		pinctrl_usdhc3_2_200mhz: usdhc3grp-2_200mhz {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD3_CMD__SD3_CMD    0x170F9
> +				MX6QDL_PAD_SD3_CLK__SD3_CLK    0x100F9
> +				MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x170F9
> +				MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x170F9
> +				MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x170F9
> +				MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x170F9
> +			>;
> +		};
> +
> +		pinctrl_usdhc4_1: usdhc4grp-1 {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD4_CMD__SD4_CMD    0x17070
> +				MX6QDL_PAD_SD4_CLK__SD4_CLK    0x10070
> +				MX6QDL_PAD_SD4_DAT0__SD4_DATA0 0x17070
> +				MX6QDL_PAD_SD4_DAT1__SD4_DATA1 0x17070
> +				MX6QDL_PAD_SD4_DAT2__SD4_DATA2 0x17070
> +				MX6QDL_PAD_SD4_DAT3__SD4_DATA3 0x17070
> +				MX6QDL_PAD_SD4_DAT4__SD4_DATA4 0x17070
> +				MX6QDL_PAD_SD4_DAT5__SD4_DATA5 0x17070
> +				MX6QDL_PAD_SD4_DAT6__SD4_DATA6 0x17070
> +				MX6QDL_PAD_SD4_DAT7__SD4_DATA7 0x17070
> +			>;
> +		};
> +
> +		pinctrl_usdhc4_1_100mhz: usdhc4grp-1_100mhz {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD4_CMD__SD4_CMD    0x170B1
> +				MX6QDL_PAD_SD4_CLK__SD4_CLK    0x100B1
> +				MX6QDL_PAD_SD4_DAT0__SD4_DATA0 0x170B1
> +				MX6QDL_PAD_SD4_DAT1__SD4_DATA1 0x170B1
> +				MX6QDL_PAD_SD4_DAT2__SD4_DATA2 0x170B1
> +				MX6QDL_PAD_SD4_DAT3__SD4_DATA3 0x170B1
> +				MX6QDL_PAD_SD4_DAT4__SD4_DATA4 0x170B1
> +				MX6QDL_PAD_SD4_DAT5__SD4_DATA5 0x170B1
> +				MX6QDL_PAD_SD4_DAT6__SD4_DATA6 0x170B1
> +				MX6QDL_PAD_SD4_DAT7__SD4_DATA7 0x170B1
> +			>;
> +		};
> +
> +		pinctrl_usdhc4_1_200mhz: usdhc4grp-2_200mhz {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD4_CMD__SD4_CMD    0x170F9
> +				MX6QDL_PAD_SD4_CLK__SD4_CLK    0x100F9
> +				MX6QDL_PAD_SD4_DAT0__SD4_DATA0 0x170F9
> +				MX6QDL_PAD_SD4_DAT1__SD4_DATA1 0x170F9
> +				MX6QDL_PAD_SD4_DAT2__SD4_DATA2 0x170F9
> +				MX6QDL_PAD_SD4_DAT3__SD4_DATA3 0x170F9
> +				MX6QDL_PAD_SD4_DAT4__SD4_DATA4 0x170F9
> +				MX6QDL_PAD_SD4_DAT5__SD4_DATA5 0x170F9
> +				MX6QDL_PAD_SD4_DAT6__SD4_DATA6 0x170F9
> +				MX6QDL_PAD_SD4_DAT7__SD4_DATA7 0x170F9
> +			>;
> +		};
> +
> +		pinctrl_enet_3: enetgrp-3 {
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
> +				MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN     0x1b0b0
> +			>;
> +		};
> +
> +		pinctrl_i2c1_1: i2c1grp-1 {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_D21__I2C1_SCL 0x4001b8b1
> +				MX6QDL_PAD_EIM_D28__I2C1_SDA 0x4001b8b1
> +			>;
> +		};
> +
> +		pinctrl_i2c2_2: i2c2grp-2 {
> +			fsl,pins = <
> +				MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b8b1
> +				MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b8b1
> +			>;
> +		};
> +
> +		pinctrl_i2c3_4: i2c3grp-4 {
> +			fsl,pins = <
> +				MX6QDL_PAD_GPIO_5__I2C3_SCL  0x4001b8b1
> +				MX6QDL_PAD_EIM_D18__I2C3_SDA 0x4001b8b1
> +				MX6QDL_PAD_GPIO_0__CCM_CLKO1    0x130b0
> +			>;
> +		};
> +
> +		pinctrl_uart4_1: uart4grp-1 {
> +			fsl,pins = <
> +				MX6QDL_PAD_KEY_COL0__UART4_TX_DATA 0x1b0b1
> +				MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA 0x1b0b1
> +			>;
> +		};
> +
> +		pinctrl_usbotg_1: usbotggrp-1 {
> +			fsl,pins = <
> +				MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x17059
> +			>;
> +		};
> +
> +		pinctrl_usbotg_2: usbotggrp-2 {
> +			fsl,pins = <
> +				MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID 0x17059
> +			>;
> +		};
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
> +	pinctrl-0 = <&pinctrl_audmux_4>;
> +	status = "okay";
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet_3>;
> +	phy-mode = "rgmii";
> +	status = "okay";
> +};
> +
> +&gpc {
> +	fsl,cpu_pupscr_sw2iso = <0xf>;
> +	fsl,cpu_pupscr_sw = <0xf>;
> +	fsl,cpu_pdnscr_iso2sw = <0x1>;
> +	fsl,cpu_pdnscr_iso = <0x1>;

Those properties are not present in the mainline binding. Remove.

> +};
> +
> +&i2c1 {
> +	status = "okay";
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1_1>;
> +
> +};
> +
> +&i2c2 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2_2>;
> +	status = "okay";
> +
> +};
> +
> +&i2c3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3_4>;
> +	status = "okay";
> +};
> +
> +&pcie {
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
> +	bus-witdh=<4>;
> +	no-1-8-v;
> +	non-removable;
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

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
