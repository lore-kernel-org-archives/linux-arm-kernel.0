From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 8 Aug 2016 16:30:05 +0800
Subject: [PATCH v2] ARM: dts: imx: add Gateworks Ventana GW553x support
In-Reply-To: <1467207146-4842-1-git-send-email-tharvey@gateworks.com>
References: <1467207146-4842-1-git-send-email-tharvey@gateworks.com>
Message-ID: <20160808083005.GD4678@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 06:32:26AM -0700, Tim Harvey wrote:
> diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
> index a3dd0c4..e5f4b6c 100644
> --- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
> @@ -86,7 +86,6 @@
>  			regulator-always-on;
>  		};
>  
> -		/* remove when pmic 1p8 regulator available */

Is this change related?

>  		reg_1p8v: regulator at 1 {
>  			compatible = "regulator-fixed";
>  			reg = <1>;
> diff --git a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
> new file mode 100644
> index 0000000..d683e08
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi

<snip>

> +	chosen {
> +		bootargs = "console=ttymxc1,115200";

A 'stdout-path' should make more sense here.

> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_leds>;
> +
> +		led0: user1 {
> +			label = "user1";
> +			gpios = <&gpio4 10 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
> +			default-state = "on";
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		led1: user2 {
> +			label = "user2";
> +			gpios = <&gpio4 11 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
> +			default-state = "off";
> +		};
> +	};
> +
> +	memory {
> +		reg = <0x10000000 0x20000000>;
> +	};
> +
> +	pps {
> +		compatible = "pps-gpio";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pps>;
> +		gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
> +		status = "okay";
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;

We had stopped doing this for a while, because DT maintainers do not
like this fake simple-bus container.  Please put the fixed regulator
nodes directly under root with following naming schema.

	reg_xxx: regulator-xxx {
		...
	};

> +
> +		reg_3p3v: regulator at 0 {
> +			compatible = "regulator-fixed";
> +			reg = <0>;
> +			regulator-name = "3P0V";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};
> +
> +		reg_5p0v: regulator at 1 {
> +			compatible = "regulator-fixed";
> +			reg = <1>;
> +			regulator-name = "5P0V";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			regulator-always-on;
> +		};
> +
> +		reg_usb_otg_vbus: regulator at 2 {
> +			compatible = "regulator-fixed";
> +			reg = <2>;
> +			regulator-name = "usb_otg_vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
> +			enable-active-high;
> +		};
> +	};
> +};
> +
> +&gpmi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gpmi_nand>;
> +	status = "okay";
> +};
> +
> +&hdmi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hdmi>;
> +	ddc-i2c-bus = <&i2c3>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	eeprom1: eeprom at 50 {
> +		compatible = "atmel,24c02";
> +		reg = <0x50>;
> +		pagesize = <16>;
> +	};
> +
> +	eeprom2: eeprom at 51 {
> +		compatible = "atmel,24c02";
> +		reg = <0x51>;
> +		pagesize = <16>;
> +	};
> +
> +	eeprom3: eeprom at 52 {
> +		compatible = "atmel,24c02";
> +		reg = <0x52>;
> +		pagesize = <16>;
> +	};
> +
> +	eeprom4: eeprom at 53 {
> +		compatible = "atmel,24c02";
> +		reg = <0x53>;
> +		pagesize = <16>;
> +	};
> +
> +	gpio: pca9555 at 23 {
> +		compatible = "nxp,pca9555";
> +		reg = <0x23>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};

We generally sort the device nodes under I2C bus in order of slave
address.  That said, this pca9555 at 23 node should go before eeprom at 50.

> +
> +	rtc: ds1672 at 68 {
> +		compatible = "dallas,ds1672";
> +		reg = <0x68>;
> +	};
> +};

<snip>

> +&iomuxc {
> +	imx6qdl-gw553x {

Since commit 5fcdf6a7ed95 (pinctrl: imx: Allow parsing DT without
function nodes), this function container node is no longer needed.

Shawn

> +		pinctrl_gpmi_nand: gpminandgrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_NANDF_CLE__NAND_CLE		0xb0b1
> +				MX6QDL_PAD_NANDF_ALE__NAND_ALE		0xb0b1
> +				MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0xb0b1
> +				MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0xb000
> +				MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0xb0b1
> +				MX6QDL_PAD_SD4_CMD__NAND_RE_B		0xb0b1
> +				MX6QDL_PAD_SD4_CLK__NAND_WE_B		0xb0b1
> +				MX6QDL_PAD_NANDF_D0__NAND_DATA00	0xb0b1
> +				MX6QDL_PAD_NANDF_D1__NAND_DATA01	0xb0b1
> +				MX6QDL_PAD_NANDF_D2__NAND_DATA02	0xb0b1
> +				MX6QDL_PAD_NANDF_D3__NAND_DATA03	0xb0b1
> +				MX6QDL_PAD_NANDF_D4__NAND_DATA04	0xb0b1
> +				MX6QDL_PAD_NANDF_D5__NAND_DATA05	0xb0b1
> +				MX6QDL_PAD_NANDF_D6__NAND_DATA06	0xb0b1
> +				MX6QDL_PAD_NANDF_D7__NAND_DATA07	0xb0b1
> +			>;
> +		};
> +
> +		pinctrl_hdmi: hdmigrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_A25__HDMI_TX_CEC_LINE	0x1f8b0
> +			>;
> +		};
> +
> +		pinctrl_i2c1: i2c1grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
> +				MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
> +			>;
> +		};
> +
> +		pinctrl_i2c2: i2c2grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
> +				MX6QDL_PAD_KEY_ROW3__I2C2_SDA		0x4001b8b1
> +			>;
> +		};
> +
> +		pinctrl_i2c3: i2c3grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_GPIO_3__I2C3_SCL		0x4001b8b1
> +				MX6QDL_PAD_GPIO_6__I2C3_SDA		0x4001b8b1
> +			>;
> +		};
> +
> +		pinctrl_gpio_leds: gpioledsgrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_KEY_COL2__GPIO4_IO10		0x1b0b0
> +				MX6QDL_PAD_KEY_ROW2__GPIO4_IO11		0x1b0b0
> +			>;
> +		};
> +
> +		pinctrl_pcie: pciegrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_GPIO_0__GPIO1_IO00		0x1b0b0
> +				MX6QDL_PAD_GPIO_17__GPIO7_IO12		0x4001b0b0 /* PCIESKT_WDIS# */
> +			>;
> +		};
> +
> +		pinctrl_pps: ppsgrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_ENET_RXD1__GPIO1_IO26	0x1b0b1
> +			>;
> +		};
> +
> +		pinctrl_pwm2: pwm2grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD1_DAT2__PWM2_OUT		0x1b0b1
> +			>;
> +		};
> +
> +		pinctrl_pwm3: pwm3grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD4_DAT1__PWM3_OUT		0x1b0b1
> +			>;
> +		};
> +
> +		pinctrl_pwm4: pwm4grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD1_CMD__PWM4_OUT		0x1b0b1
> +			>;
> +		};
> +
> +		pinctrl_uart2: uart2grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA	0x1b0b1
> +				MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA	0x1b0b1
> +			>;
> +		};
> +
> +		pinctrl_uart3: uart3grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b1
> +				MX6QDL_PAD_EIM_D25__UART3_RX_DATA	0x1b0b1
> +			>;
> +		};
> +
> +		pinctrl_uart4: uart4grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_KEY_COL0__UART4_TX_DATA	0x1b0b1
> +				MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA	0x1b0b1
> +			>;
> +		};
> +
> +		pinctrl_uart5: uart5grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_KEY_COL1__UART5_TX_DATA	0x1b0b1
> +				MX6QDL_PAD_KEY_ROW1__UART5_RX_DATA	0x1b0b1
> +			>;
> +		};
> +
> +		pinctrl_usbotg: usbotggrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
> +				MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x1b0b0 /* OTG_PWR_EN */
> +			>;
> +		};
> +
> +		pinctrl_usdhc3: usdhc3grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD3_CMD__SD3_CMD		0x17059
> +				MX6QDL_PAD_SD3_CLK__SD3_CLK		0x10059
> +				MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x17059
> +				MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
> +				MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
> +				MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
> +				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00		0x17059 /* CD */
> +				MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x17059
> +			>;
> +		};
> +
> +		pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170b9
> +				MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100b9
> +				MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x170b9
> +				MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x170b9
> +				MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x170b9
> +				MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x170b9
> +				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00		0x170b9 /* CD */
> +				MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x170b9
> +			>;
> +		};
> +
> +		pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170f9
> +				MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100f9
> +				MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x170f9
> +				MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x170f9
> +				MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x170f9
> +				MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x170f9
> +				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00		0x170f9 /* CD */
> +				MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x170f9
> +			>;
> +		};
> +
> +		pinctrl_wdog: wdoggrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_DISP0_DAT8__WDOG1_B		0x1b0b0
> +			>;
> +		};
> +	};
> +};
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
