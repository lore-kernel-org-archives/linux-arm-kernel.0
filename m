From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 28 Feb 2018 13:34:33 +0800
Subject: [PATCH] ARM: dts: imx6q: Add support for the DHCOM iMX6 SoM and
 PDK2
In-Reply-To: <20180224210429.18606-1-marex@denx.de>
References: <20180224210429.18606-1-marex@denx.de>
Message-ID: <20180228053432.GG3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 24, 2018 at 10:04:29PM +0100, Marek Vasut wrote:
> Add support for the DH i.MX6 Quad based SoM and a PDK2 evaluation board.
> The evaluation board features three serial ports, USB OTG, USB host with
> an USB hub, Fast or Gigabit ethernet, eMMC, uSD, SD, mSATA, analog audio,
> PCIe and HDMI video output.
> 
> All of the aforementioned features are supported by this patch.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> ---
>  arch/arm/boot/dts/Makefile             |   1 +
>  arch/arm/boot/dts/imx6q-dhcom-pdk2.dts | 168 ++++++++++++
>  arch/arm/boot/dts/imx6q-dhcom-som.dtsi | 481 +++++++++++++++++++++++++++++++++
>  3 files changed, 650 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6q-dhcom-pdk2.dts
>  create mode 100644 arch/arm/boot/dts/imx6q-dhcom-som.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 26e2e290ec28..995b54a9946b 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -438,6 +438,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6q-cubox-i-som-v15.dtb \
>  	imx6q-dfi-fs700-m60.dtb \
>  	imx6q-display5-tianma-tm070-1280x768.dtb \
> +	imx6q-dhcom-pdk2.dtb \
>  	imx6q-dmo-edmqmx6.dtb \
>  	imx6q-evi.dtb \
>  	imx6q-gk802.dtb \
> diff --git a/arch/arm/boot/dts/imx6q-dhcom-pdk2.dts b/arch/arm/boot/dts/imx6q-dhcom-pdk2.dts
> new file mode 100644
> index 000000000000..5dbd2030aeaa
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-dhcom-pdk2.dts
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: (GPL-2.0+)
> +/*
> + * Copyright (C) 2015 DH electronics GmbH
> + * Copyright (C) 2018 Marek Vasut <marex@denx.de>
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6q-dhcom-som.dtsi"
> +
> +/ {
> +	model = "Freescale i.MX6 Quad DHCOM Premium Developer Kit (2)";
> +	compatible = "dh,imx6q-dhcom-pdk2", "dh,imx6q-dhcom-som", "fsl,imx6q";
> +
> +	chosen {
> +		stdout-path = &uart1;
> +	};
> +
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		clk_ext_audio_codec: clock at 0 {
> +			compatible = "fixed-clock";
> +			reg = <0>;
> +			#clock-cells = <0>;
> +			clock-frequency = <24000000>;
> +		};
> +	};

We are suggested by DT maintainers to put fixed clock node directly
under root, with a unique node name like clock-xxx.

	clk_ext_audio_codec: clock-audcodec {
		compatible = "fixed-clock";
		#clock-cells = <0>;
		clock-frequency = <24000000>;
	};


> +
> +	regulators {
> +		reg_3p3v: 3P3V {
> +			compatible = "regulator-fixed";
> +			regulator-name = "3P3V";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};
> +	};

Same as fixed clock above, this can be directly under root node.

	reg_3p3v: regulator-3P3V {
		...
	};

> +
> +	sound {
> +		compatible = "fsl,imx-audio-sgtl5000";
> +		model = "imx-sgtl5000";
> +		ssi-controller = <&ssi1>;
> +		audio-codec = <&codec>;
> +		audio-routing =
> +			"MIC_IN", "Mic Jack",
> +			"Mic Jack", "Mic Bias",
> +			"LINE_IN", "Line In Jack",
> +			"Headphone Jack", "HP_OUT";
> +		mux-int-port = <1>;
> +		mux-ext-port = <3>;
> +	};
> +};
> +
> +&audmux {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_audmux_ext>;
> +	status = "okay";
> +};
> +
> +&hdmi {
> +	ddc-i2c-bus = <&i2c2>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	codec: sgtl5000 at 0a {

Drop the leading zero in unit-address.  Also it's suggested to use a
generic name for node and specific one for label.

	sgtl5000: codec at a {
		...
	};

> +		compatible = "fsl,sgtl5000";
> +		reg = <0x0a>;
> +		clocks = <&clk_ext_audio_codec>;
> +		VDDA-supply = <&reg_3p3v>;
> +		VDDIO-supply = <&reg_3p3v>;
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog_base &pinctrl_hog>;
> +
> +	imx6q-dhcom-pdk2 {

This container code can be dropped to save one level of indent.

> +		pinctrl_hog: hog_grp {

While underscore is used in label name, we generally use hyphen in node name.

> +			fsl,pins = <
> +				MX6QDL_PAD_GPIO_2__GPIO1_IO02       0x400120B0
> +				MX6QDL_PAD_GPIO_4__GPIO1_IO04       0x400120B0
> +				MX6QDL_PAD_GPIO_5__GPIO1_IO05       0x400120B0
> +				MX6QDL_PAD_CSI0_DAT17__GPIO6_IO03   0x400120B0
> +				MX6QDL_PAD_GPIO_19__GPIO4_IO05      0x120B0
> +				MX6QDL_PAD_DI0_PIN4__GPIO4_IO20     0x400120B0
> +				MX6QDL_PAD_EIM_D27__GPIO3_IO27      0x120B0
> +				MX6QDL_PAD_KEY_ROW0__GPIO4_IO07     0x120B0
> +				MX6QDL_PAD_KEY_COL1__GPIO4_IO08     0x400120B0
> +				MX6QDL_PAD_NANDF_CS1__GPIO6_IO14    0x400120B0
> +				MX6QDL_PAD_NANDF_CS2__GPIO6_IO15    0x400120B0
> +				MX6QDL_PAD_KEY_ROW1__GPIO4_IO09     0x400120B0
> +				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00     0x400120B0
> +				MX6QDL_PAD_SD3_DAT4__GPIO7_IO01     0x400120B0
> +				MX6QDL_PAD_CSI0_VSYNC__GPIO5_IO21   0x400120B0
> +				MX6QDL_PAD_GPIO_18__GPIO7_IO13      0x400120B0
> +				MX6QDL_PAD_SD1_CMD__GPIO1_IO18      0x400120B0
> +				MX6QDL_PAD_SD1_DAT0__GPIO1_IO16     0x400120B0
> +				MX6QDL_PAD_SD1_DAT1__GPIO1_IO17     0x400120B0
> +				MX6QDL_PAD_SD1_DAT2__GPIO1_IO19     0x400120B0
> +				MX6QDL_PAD_SD1_CLK__GPIO1_IO20      0x400120B0
> +				MX6QDL_PAD_CSI0_PIXCLK__GPIO5_IO18  0x400120B0
> +				MX6QDL_PAD_CSI0_MCLK__GPIO5_IO19    0x400120B0
> +				MX6QDL_PAD_KEY_COL0__GPIO4_IO06     0x400120B0
> +			>;
> +		};
> +
> +		pinctrl_audmux_ext: audmux_ext_grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_CSI0_DAT7__AUD3_RXD      0x130b0
> +				MX6QDL_PAD_CSI0_DAT4__AUD3_TXC      0x130b0
> +				MX6QDL_PAD_CSI0_DAT5__AUD3_TXD      0x110b0
> +				MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS     0x130b0
> +			>;
> +		};
> +
> +		pinctrl_enet_1G: enet_1G_grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_ENET_MDIO__ENET_MDIO       0x100b0
> +				MX6QDL_PAD_ENET_MDC__ENET_MDC         0x100b0
> +				MX6QDL_PAD_RGMII_TXC__RGMII_TXC       0x100b0
> +				MX6QDL_PAD_RGMII_TD0__RGMII_TD0       0x100b0
> +				MX6QDL_PAD_RGMII_TD1__RGMII_TD1       0x100b0
> +				MX6QDL_PAD_RGMII_TD2__RGMII_TD2       0x100b0
> +				MX6QDL_PAD_RGMII_TD3__RGMII_TD3       0x100b0
> +				MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x100b0
> +				MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK  0x100b0
> +				MX6QDL_PAD_RGMII_RXC__RGMII_RXC       0x1b0b0
> +				MX6QDL_PAD_RGMII_RD0__RGMII_RD0       0x1b0b0
> +				MX6QDL_PAD_RGMII_RD1__RGMII_RD1       0x1b0b0
> +				MX6QDL_PAD_RGMII_RD2__RGMII_RD2       0x1b0b0
> +				MX6QDL_PAD_RGMII_RD3__RGMII_RD3       0x1b0b0
> +				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
> +				MX6QDL_PAD_EIM_D29__GPIO3_IO29        0x000b0
> +				MX6QDL_PAD_GPIO_0__GPIO1_IO00         0x000b1
> +				MX6QDL_PAD_EIM_D26__GPIO3_IO26        0x000b1
> +			>;
> +		};
> +
> +		pinctrl_pcie: pcie_grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_CSI0_DATA_EN__GPIO5_IO20 0x1b0b1
> +			>;
> +		};
> +	};
> +};
> +
> +&pcie {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pcie>;
> +	reset-gpio = <&gpio6 14 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&ssi1 {
> +	status = "okay";
> +};
> +
> +&sata {
> +	status = "okay";
> +};
> +
> +&usdhc3 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx6q-dhcom-som.dtsi b/arch/arm/boot/dts/imx6q-dhcom-som.dtsi
> new file mode 100644
> index 000000000000..535feb10241a
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-dhcom-som.dtsi
> @@ -0,0 +1,481 @@
> +// SPDX-License-Identifier: (GPL-2.0+)
> +/*
> + * Copyright (C) 2015 DH electronics GmbH
> + * Copyright (C) 2018 Marek Vasut <marex@denx.de>
> + */
> +
> +#include "imx6q.dtsi"
> +#include <dt-bindings/pwm/pwm.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/clock/imx6qdl-clock.h>
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	model = "Freescale i.MX6 Quad DHCOM SoM";
> +	compatible = "dh,imx6q-dhcom-som", "fsl,imx6q";

We do not need these properties, as this is just a .dtsi which needs to
be included by board dts that has model and compatible anyway, right?

> +
> +	aliases {
> +		mmc0 = &usdhc2;
> +		mmc1 = &usdhc3;
> +		mmc2 = &usdhc4;
> +		mmc3 = &usdhc1;
> +	};
> +
> +	memory {
> +		reg = <0x10000000 0x40000000>;
> +	};

Making dtb with W=1, you will get DTC warning on this.

> +
> +	regulators {
> +		compatible = "simple-bus";
> +
> +		reg_usb_otg_vbus: usb_otg_vbus {
> +			compatible = "regulator-fixed";
> +			regulator-name = "usb_otg_vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +		};
> +
> +		reg_usb_h1_vbus: usb_h1_vbus {
> +			compatible = "regulator-fixed";
> +			regulator-name = "usb_h1_vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			gpio = <&gpio3 31 GPIO_ACTIVE_LOW>;

Shouldn't it be GPIO_ACTIVE_HIGH as per enable-active-high property
below?

> +			enable-active-high;
> +		};
> +
> +		reg_3p3v: 3P3V {
> +			compatible = "regulator-fixed";
> +			regulator-name = "3P3V";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};
> +	};

Please drop the regulators container node and name the fixed regulators
like:

	reg_xxx: regulator-xxx {
		...
	};

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
> +	fsl,spi-num-chipselects = <2>;

This property is obsolete.
Check Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt.

> +	cs-gpios = <&gpio2 30 1>, <&gpio4 11 1>;

Use GPIO_ACTIVE_XXX define for polarity.

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi1>;
> +	status = "okay";
> +
> +	s25fl116k at 0 {

Can we use a generic node name which can tell what it is?  Maybe flash
or nor-flash?

> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";
> +		spi-max-frequency = <50000000>;
> +		reg = <0>;
> +		m25p,fast-read;
> +	};
> +};
> +
> +&ecspi2 {
> +	fsl,spi-num-chipselects = <1>;
> +	cs-gpios = <&gpio5 29 1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi2>;
> +	status = "okay";
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet_100M>;
> +	phy-mode = "rmii";
> +	phy-handle = <&ethphy0>;
> +	power-gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy0: ethernet-phy at 0 {	/* SMSC LAN8710Ai */
> +			reg = <0>;
> +			max-speed = <100>;
> +			reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
> +			reset-delay-us = <1000>;
> +			reset-post-delay-us = <1000>;
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +
> +	pmic: ltc3676 at 3c {

	ltc3676: pmic at 3c

> +		compatible = "lltc,ltc3676";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pmic_hw300>;
> +		reg = <0x3c>;
> +		interrupt-parent = <&gpio5>;
> +		interrupts = <2 2>;
> +
> +		regulators {
> +			sw1_reg: sw1 {
> +				regulator-min-microvolt = <787500>;
> +				regulator-max-microvolt = <1527272>;
> +				lltc,fb-voltage-divider = <100000 110000>;
> +				regulator-suspend-mem-microvolt = <1040000>;
> +				regulator-ramp-delay = <7000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			sw2_reg: sw2 {
> +				regulator-min-microvolt = <1885714>;
> +				regulator-max-microvolt = <3657142>;
> +				lltc,fb-voltage-divider = <100000 28000>;
> +				regulator-ramp-delay = <7000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			sw3_reg: sw3 {
> +				regulator-min-microvolt = <787500>;
> +				regulator-max-microvolt = <1527272>;
> +				lltc,fb-voltage-divider = <100000 110000>;
> +				regulator-suspend-mem-microvolt = <980000>;
> +				regulator-ramp-delay = <7000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			sw4_reg: sw4 {
> +				regulator-min-microvolt = <855571>;
> +				regulator-max-microvolt = <1659291>;
> +				lltc,fb-voltage-divider = <100000 93100>;
> +				regulator-ramp-delay = <7000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo1_reg: ldo1 {
> +				regulator-min-microvolt = <3240306>;
> +				regulator-max-microvolt = <3240306>;
> +				lltc,fb-voltage-divider = <102000 29400>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo2_reg: ldo2 {
> +				regulator-min-microvolt = <2484708>;
> +				regulator-max-microvolt = <2484708>;
> +				lltc,fb-voltage-divider = <100000 41200>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +
> +	tsc2004 at 49 {

s/tsc2004/touchscreen?

> +		compatible = "ti,tsc2004";
> +		reg = <0x49>;
> +		vio-supply = <&reg_3p3v>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_tsc2004_hw300>;
> +		interrupts-extended = <&gpio4 14 IRQ_TYPE_EDGE_FALLING>;
> +		status = "disabled";
> +	};
> +
> +	eeprom at 50 {
> +		compatible = "atmel,24c02";
> +		reg = <0x50>;
> +		pagesize = <16>;
> +	};
> +
> +	rtc at 56 {

The node name says it's a RTC ...

> +		compatible = "rv3029c2";

... the compatible is defined in bindings/i2c/i2c-gpio.txt and should be
a I2C GPIO expander.  Confused.

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_rtc_hw300>;
> +		reg = <0x56>;
> +		interrupt-parent = <&gpio7>;
> +		interrupts = <12 2>;
> +		irq-gpios = <&gpio7 12 0>;

I cannot find this irq-gpios property in any binding doc.

> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog_base>;

The board dts file will have these property anyway, so they can be saved
here?

> +
> +	imx6qdl-dhcom_base {

Drop the container node.

> +		pinctrl_hog_base: hog_base_grp {

Use hyphen in node name.

> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_A19__GPIO2_IO19      0x120B0
> +				MX6QDL_PAD_EIM_A23__GPIO6_IO06      0x120B0
> +				MX6QDL_PAD_EIM_A22__GPIO2_IO16      0x120B0
> +				MX6QDL_PAD_EIM_A16__GPIO2_IO22      0x120B0
> +				MX6QDL_PAD_EIM_A17__GPIO2_IO21      0x120B0

Please consistently use lowercase for hex value.

> +			>;
> +		};
> +
> +		pinctrl_ecspi1: ecspi1_grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_D17__ECSPI1_MISO     0x100b1
> +				MX6QDL_PAD_EIM_D18__ECSPI1_MOSI     0x100b1
> +				MX6QDL_PAD_EIM_D16__ECSPI1_SCLK     0x100b1
> +				MX6QDL_PAD_EIM_EB2__GPIO2_IO30      0x1b0b0
> +				MX6QDL_PAD_KEY_ROW2__GPIO4_IO11     0x1b0b0
> +			>;
> +		};
> +
> +		pinctrl_ecspi2: ecspi2_grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_CSI0_DAT10__ECSPI2_MISO  0x100b1
> +				MX6QDL_PAD_CSI0_DAT9__ECSPI2_MOSI   0x100b1
> +				MX6QDL_PAD_CSI0_DAT8__ECSPI2_SCLK   0x100b1
> +				MX6QDL_PAD_CSI0_DAT11__GPIO5_IO29   0x1b0b0
> +			>;
> +		};
> +
> +		pinctrl_enet_100M: enet_100M_grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_ENET_MDIO__ENET_MDIO     0x1b0b0
> +				MX6QDL_PAD_ENET_MDC__ENET_MDC       0x1b0b0
> +				MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN  0x1b0b0
> +				MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER   0x1b0b0
> +				MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0 0x1b0b0
> +				MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1 0x1b0b0
> +				MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN   0x1b0b0
> +				MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0 0x1b0b0
> +				MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1 0x1b0b0
> +				MX6QDL_PAD_GPIO_16__ENET_REF_CLK    0x4001b0a8
> +				MX6QDL_PAD_EIM_WAIT__GPIO5_IO00     0x000b0
> +				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15     0x000b1
> +				MX6QDL_PAD_GPIO_7__GPIO1_IO07       0x120B0
> +			>;
> +		};
> +
> +		pinctrl_flexcan1: flexcan1_grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX    0x1b0b0
> +				MX6QDL_PAD_GPIO_8__FLEXCAN1_RX      0x1b0b0
> +			>;
> +		};
> +
> +		pinctrl_flexcan2: flexcan2_grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD3_DAT0__FLEXCAN2_TX    0x1b0b0
> +				MX6QDL_PAD_SD3_DAT1__FLEXCAN2_RX    0x1b0b0
> +			>;
> +		};
> +
> +		pinctrl_i2c1: i2c1_grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_D21__I2C1_SCL        0x4001b8b1
> +				MX6QDL_PAD_EIM_D28__I2C1_SDA        0x4001b8b1
> +			>;
> +		};
> +
> +		pinctrl_i2c2: i2c2_grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_KEY_COL3__I2C2_SCL       0x4001b8b1
> +				MX6QDL_PAD_KEY_ROW3__I2C2_SDA       0x4001b8b1
> +			>;
> +		};
> +
> +		pinctrl_i2c3: i2c3_grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_GPIO_3__I2C3_SCL         0x4001b8b1
> +				MX6QDL_PAD_GPIO_6__I2C3_SDA         0x4001b8b1
> +			>;
> +		};
> +
> +		pinctrl_pmic_hw300: pmic_hw300_grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_A25__GPIO5_IO02      0x1B0B0
> +			>;
> +		};
> +
> +		pinctrl_rtc_hw300: rtc_hw300_grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_GPIO_17__GPIO7_IO12      0x120B0
> +			>;
> +		};
> +
> +		pinctrl_tsc2004_hw300: tsc2004_hw300_grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_KEY_COL4__GPIO4_IO14     0x120B0
> +			>;
> +		};
> +
> +		pinctrl_uart1: uart1_grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA  0x1b0b1
> +				MX6QDL_PAD_SD3_DAT6__UART1_RX_DATA  0x1b0b1
> +				MX6QDL_PAD_EIM_D20__UART1_RTS_B     0x1b0b1
> +				MX6QDL_PAD_EIM_D19__UART1_CTS_B     0x4001b0b1
> +				MX6QDL_PAD_EIM_D23__GPIO3_IO23      0x4001b0b1
> +				MX6QDL_PAD_EIM_D24__GPIO3_IO24      0x4001b0b1
> +				MX6QDL_PAD_EIM_D25__GPIO3_IO25      0x4001b0b1
> +				MX6QDL_PAD_EIM_EB3__GPIO2_IO31      0x4001b0b1
> +			>;
> +		};
> +
> +		pinctrl_uart4: uart4_grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_CSI0_DAT12__UART4_TX_DATA 0x1b0b1
> +				MX6QDL_PAD_CSI0_DAT13__UART4_RX_DATA 0x1b0b1
> +			>;
> +		};
> +
> +		pinctrl_uart5: uart5_grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_CSI0_DAT14__UART5_TX_DATA 0x1b0b1
> +				MX6QDL_PAD_CSI0_DAT15__UART5_RX_DATA 0x1b0b1
> +				MX6QDL_PAD_CSI0_DAT18__UART5_RTS_B   0x1b0b1
> +				MX6QDL_PAD_CSI0_DAT19__UART5_CTS_B   0x4001b0b1
> +			>;
> +		};
> +
> +		pinctrl_usbh1: usbh1_grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_D31__GPIO3_IO31      0x120B0
> +			>;
> +		};
> +
> +		pinctrl_usbotg: usbotg_grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_GPIO_1__USB_OTG_ID       0x17059
> +			>;
> +		};
> +
> +		pinctrl_usdhc2: usdhc2_grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD2_CMD__SD2_CMD         0x17059
> +				MX6QDL_PAD_SD2_CLK__SD2_CLK         0x10059
> +				MX6QDL_PAD_SD2_DAT0__SD2_DATA0      0x17059
> +				MX6QDL_PAD_SD2_DAT1__SD2_DATA1      0x17059
> +				MX6QDL_PAD_SD2_DAT2__SD2_DATA2      0x17059
> +				MX6QDL_PAD_SD2_DAT3__SD2_DATA3      0x17059
> +				MX6QDL_PAD_NANDF_CS3__GPIO6_IO16    0x120B0
> +			>;
> +		};
> +
> +		pinctrl_usdhc3: usdhc3_grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD3_CMD__SD3_CMD         0x17059
> +				MX6QDL_PAD_SD3_CLK__SD3_CLK         0x10059
> +				MX6QDL_PAD_SD3_DAT0__SD3_DATA0      0x17059
> +				MX6QDL_PAD_SD3_DAT1__SD3_DATA1      0x17059
> +				MX6QDL_PAD_SD3_DAT2__SD3_DATA2      0x17059
> +				MX6QDL_PAD_SD3_DAT3__SD3_DATA3      0x17059
> +				MX6QDL_PAD_SD3_RST__GPIO7_IO08      0x120B0
> +			>;
> +		};
> +
> +		pinctrl_usdhc4: usdhc4_grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD4_CMD__SD4_CMD         0x17059
> +				MX6QDL_PAD_SD4_CLK__SD4_CLK         0x10059
> +				MX6QDL_PAD_SD4_DAT0__SD4_DATA0      0x17059
> +				MX6QDL_PAD_SD4_DAT1__SD4_DATA1      0x17059
> +				MX6QDL_PAD_SD4_DAT2__SD4_DATA2      0x17059
> +				MX6QDL_PAD_SD4_DAT3__SD4_DATA3      0x17059
> +				MX6QDL_PAD_SD4_DAT4__SD4_DATA4      0x17059
> +				MX6QDL_PAD_SD4_DAT5__SD4_DATA5      0x17059
> +				MX6QDL_PAD_SD4_DAT6__SD4_DATA6      0x17059
> +				MX6QDL_PAD_SD4_DAT7__SD4_DATA7      0x17059
> +			>;
> +		};
> +	};
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	fsl,uart-has-rtscts;

Use uart-has-rtscts instead.

> +	dtr-gpios = <&gpio3 24 GPIO_ACTIVE_LOW>;
> +	dsr-gpios = <&gpio3 25 GPIO_ACTIVE_LOW>;
> +	dcd-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
> +	rng-gpios = <&gpio2 31 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart4>;
> +	status = "okay";
> +};
> +
> +&uart5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart5>;
> +	fsl,uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&usbh1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbh1>;
> +	vbus-supply = <&reg_usb_h1_vbus>;
> +	status = "okay";

Please keep 'status' line be the last one.

Shawn

> +	dr_mode = "host";
> +};
> +
> +&usbotg {
> +	vbus-supply = <&reg_usb_otg_vbus>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbotg>;
> +	disable-over-current;
> +	status = "okay";
> +	dr_mode = "otg";
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	cd-gpios = <&gpio6 16 GPIO_ACTIVE_HIGH>;
> +	keep-power-in-suspend;
> +	status = "okay";
> +};
> +
> +&usdhc3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	cd-gpios = <&gpio7 8 GPIO_ACTIVE_LOW>;
> +	fsl,wp-controller;
> +	keep-power-in-suspend;
> +	status = "disabled";
> +};
> +
> +&usdhc4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc4>;
> +	non-removable;
> +	bus-width = <8>;
> +	no-1-8-v;
> +	keep-power-in-suspend;
> +	status = "okay";
> +};
> -- 
> 2.15.1
> 
