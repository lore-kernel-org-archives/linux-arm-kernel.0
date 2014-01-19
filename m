From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 19 Jan 2014 10:40:07 +0800
Subject: [PATCH] ARM: dts: imx6q: Add support for Zealz GK802
In-Reply-To: <1389876499-24247-1-git-send-email-s.hauer@pengutronix.de>
References: <1389876499-24247-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20140119024005.GA16158@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 01:48:19PM +0100, Sascha Hauer wrote:
> Add support for the GK802 'QUAD CORE Mini PC', which seems to be loosely
> based on the Freescale i.MX6Q HDMI dongle reference design.
> It is supposedly identical to the Hiapad Hi802.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>

The patch has a couple of minor things like we did for patch 'ARM: dts:
imx6: Add DFI FS700-M60 board support' to fix up.  I fixed them up and
apply the patch.

Shawn

> ---
>  arch/arm/boot/dts/Makefile        |   1 +
>  arch/arm/boot/dts/imx6q-gk802.dts | 151 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 152 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6q-gk802.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index aeb8053..9ed00a0 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -171,6 +171,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
>  	imx6q-arm2.dtb \
>  	imx6q-cm-fx6.dtb \
>  	imx6q-dmo-edmqmx6.dtb \
> +	imx6q-gk802.dtb \
>  	imx6q-gw51xx.dtb \
>  	imx6q-gw52xx.dtb \
>  	imx6q-gw53xx.dtb \
> diff --git a/arch/arm/boot/dts/imx6q-gk802.dts b/arch/arm/boot/dts/imx6q-gk802.dts
> new file mode 100644
> index 0000000..0d010df
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-gk802.dts
> @@ -0,0 +1,151 @@
> +/*
> + * Copyright (C) 2013 Philipp Zabel
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +#include "imx6q.dtsi"
> +
> +/ {
> +	model = "Zealz GK802";
> +	compatible = "zealz,imx6q-gk802", "fsl,imx6q";
> +
> +	chosen {
> +		linux,stdout-path = &uart4;
> +	};
> +
> +	memory {
> +		reg = <0x10000000 0x40000000>;
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +
> +		reg_3p3v: 3p3v {
> +			compatible = "regulator-fixed";
> +			regulator-name = "3P3V";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		recovery-button {
> +			label = "recovery";
> +			gpios = <&gpio3 16 1>;
> +			linux,code = <0x198>; /* KEY_RESTART */
> +			gpio-key,wakeup;
> +		};
> +	};
> +};
> +
> +/* Internal I2C */
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2_gk802>;
> +	clock-frequency = <100000>;
> +	status = "okay";
> +
> +	/* SDMC DM2016 1024 bit EEPROM + 128 bit OTP */
> +	eeprom: dm2016 at 51 {
> +		compatible = "sdmc,dm2016";
> +		reg = <0x51>;
> +	};
> +};
> +
> +/* External I2C via HDMI */
> +&i2c3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3_gk802>;
> +	clock-frequency = <100000>;
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
> +				/* Recovery button, active-low */
> +				MX6QDL_PAD_EIM_D16__GPIO3_IO16  0x100b1
> +				/* RTL8192CU enable GPIO, active-low */
> +				MX6QDL_PAD_NANDF_D0__GPIO2_IO00 0x1b0b0
> +			>;
> +		};
> +	};
> +
> +	i2c {
> +		pinctrl_i2c2_gk802: i2c2grp-1 {
> +			fsl,pins = <MX6QDL_I2C2_PINGRP2>;
> +		};
> +
> +		pinctrl_i2c3_gk802: i2c3grp-1 {
> +			fsl,pins = <MX6QDL_I2C3_PINGRP3>;
> +		};
> +	};
> +
> +	uart {
> +		pinctrl_uart4: uart4grp {
> +			fsl,pins = <MX6QDL_UART4_PINGRP1>;
> +		};
> +	};
> +
> +	usdhc {
> +		pinctrl_usdhc3: usdhc3grp {
> +			fsl,pins = <MX6QDL_USDHC3_PINGRP_D4>;
> +		};
> +
> +		pinctrl_usdhc4: usdhc4grp {
> +			fsl,pins = <MX6QDL_USDHC4_PINGRP_D4>;
> +		};
> +	};
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart4>;
> +	status = "okay";
> +};
> +
> +/* External USB-A port (USBOTG) */
> +&usbotg {
> +	disable-over-current;
> +	status = "okay";
> +};
> +
> +/* Internal USB port (USBH1), connected to RTL8192CU */
> +&usbh1 {
> +	disable-over-current;
> +	status = "okay";
> +};
> +
> +/* External microSD */
> +&usdhc3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	bus-width = <4>;
> +	cd-gpios = <&gpio6 11 0>;
> +	vmmc-supply = <&reg_3p3v>;
> +	status = "okay";
> +};
> +
> +/* Internal microSD */
> +&usdhc4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc4>;
> +	bus-width = <4>;
> +	vmmc-supply = <&reg_3p3v>;
> +	status = "okay";
> +};
> -- 
> 1.8.5.2
> 
