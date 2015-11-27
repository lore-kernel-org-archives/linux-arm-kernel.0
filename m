From: stefan@agner.ch (Stefan Agner)
Date: Fri, 27 Nov 2015 11:38:44 -0800
Subject: [PATCH 1/2] ARM: dts: imx6: Add support for Toradex Apalis SoM
In-Reply-To: <1447942325.3144.86.camel@pengutronix.de>
References: <1447935900-13635-1-git-send-email-ynezz@true.cz>
 <1447935900-13635-2-git-send-email-ynezz@true.cz>
 <1447942325.3144.86.camel@pengutronix.de>
Message-ID: <ecfde8366160cb17f7b1e571f81488de@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Petr,

Thanks for pushing this! It is on my todo list, but never came around...
[I do work for Toradex]

And thanks Lucas for reviewing it!


On 2015-11-19 06:12, Lucas Stach wrote:
> Hi Petr,
> 
> Am Donnerstag, den 19.11.2015, 13:24 +0100 schrieb Petr ?tetiar:
>> Signed-off-by: Petr ?tetiar <ynezz@true.cz>
>> ---
>>  arch/arm/boot/dts/imx6qdl-apalis.dtsi |  951 +++++++++++++++++++++++++++++++++
>>  1 file changed, 951 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/imx6qdl-apalis.dtsi
>>
>> diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
>> new file mode 100644
>> index 0000000..610d844
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
>> @@ -0,0 +1,951 @@
>> +/*
>> + * Copyright 2014-2015 Toradex AG
>> + * Copyright 2012 Freescale Semiconductor, Inc.
>> + * Copyright 2011 Linaro Ltd.
>> + *
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
>> + *
>> + * http://www.opensource.org/licenses/gpl-license.html
>> + * http://www.gnu.org/copyleft/gpl.html

New device trees typically come with a dual license, X11/GPL. It makes
sense that we use that too, Toradex agrees...

>> + */
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +/ {
>> +	model = "Toradex Apalis iMX6Q Module";
>> +	compatible = "toradex,apalis_imx6q", "fsl,imx6q";
>> +
>> +	backlight: backlight {
>> +		compatible = "pwm-backlight";
>> +		pwms = <&pwm4 0 5000000>;
>> +		status = "disabled";
>> +	};
>> +
>> +	clocks {
>> +		clk24m: clk24m {
>> +			compatible = "fixed-clock";
>> +			#clock-cells = <0>;
>> +			clock-frequency = <24000000>;
>> +		};
>> +	};


There is a 24Mhz osc defined in imx6qdl.dtsi, but I think that is the
internal osc? I am not entierly familar with the i.MX6 clocks...

However, this seems not to be used anywhere and other boards also do not
define that clock, hence I would drop it.

>> +
>> +	i2cddc: i2c at 0 {
>> +		compatible = "i2c-gpio";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_i2c_ddc>;
>> +		gpios = <&gpio3 16 GPIO_ACTIVE_HIGH /* sda */
>> +			 &gpio2 30 GPIO_ACTIVE_HIGH /* scl */
>> +			>;
>> +		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
> 
> You are most likely not going to attach devices to this bus, so the
> above 2 properties are not needed.
> 
>> +		status = "okay";
>> +	};
>> +
>> +	memory {
>> +		reg = <0x10000000 0x80000000>;
>> +	};
> 
> The memory node is typically located at the top of the DT, but that's
> just nitpicking.
> 
>> +
>> +	regulators {
>> +		compatible = "simple-bus";
>> +
> Get rid of this simple bus. It's not there in hardware and regulators
> are board level components just like the nodes above and below.
> 
>> +		reg_1p8v: 1p8v {
>> +			compatible = "regulator-fixed";
>> +			regulator-name = "1P8V";
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-always-on;
>> +		};
>> +
>> +		reg_2p5v: 2p5v {
>> +			compatible = "regulator-fixed";
>> +			regulator-name = "2P5V";
>> +			regulator-min-microvolt = <2500000>;
>> +			regulator-max-microvolt = <2500000>;
>> +			regulator-always-on;
>> +		};
>> +
>> +		reg_3p3v: 3p3v {
>> +			compatible = "regulator-fixed";
>> +			regulator-name = "3P3V";
>> +			regulator-min-microvolt = <3300000>;
>> +			regulator-max-microvolt = <3300000>;
>> +			regulator-always-on;
>> +		};
>> +
>> +		reg_usb_otg_vbus: usb_otg_vbus {
>> +			compatible = "regulator-fixed";
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&pinctrl_regulator_usbotg_pwr>;
>> +			regulator-name = "usb_otg_vbus";
>> +			regulator-min-microvolt = <5000000>;
>> +			regulator-max-microvolt = <5000000>;
>> +			gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
>> +			enable-active-high;
>> +			status = "disabled";
>> +		};
>> +
>> +		/* on module usb hub */
>> +		reg_usb_host_vbus_hub: usb_host_vbus_hub {
>> +			compatible = "regulator-fixed";
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&pinctrl_regulator_usbhub_pwr>;
>> +			regulator-name = "usb_host_vbus_hub";
>> +			regulator-min-microvolt = <5000000>;
>> +			regulator-max-microvolt = <5000000>;
>> +			gpio = <&gpio3 28 GPIO_ACTIVE_HIGH>;
>> +			startup-delay-us = <2000>;
>> +			enable-active-high;
>> +			status = "okay";
>> +		};
>> +
>> +		reg_usb_host_vbus: usb_host_vbus {
>> +			compatible = "regulator-fixed";
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&pinctrl_regulator_usbh_pwr>;
>> +			regulator-name = "usb_host_vbus";
>> +			regulator-min-microvolt = <5000000>;
>> +			regulator-max-microvolt = <5000000>;
>> +			gpio =  <&gpio1 0 GPIO_ACTIVE_HIGH>;
>> +			enable-active-high;
>> +			vin-supply = <&reg_usb_host_vbus_hub>;
>> +			status = "disabled";
>> +		};
>> +	};
>> +};
>> +
>> +&audmux {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_audmux &pinctrl_audmux_mclk>;
>> +	status = "okay";
>> +};
>> +
>> +/* Apalis SPI1 */
>> +&ecspi1 {
>> +	fsl,spi-num-chipselects = <1>;
>> +	cs-gpios = <&gpio5 25 GPIO_ACTIVE_HIGH>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_ecspi1 &pinctrl_spi_cs1>;
>> +	status = "disabled";
>> +};
>> +
>> +/* Apalis SPI2 */
>> +&ecspi2 {
>> +	fsl,spi-num-chipselects = <1>;
>> +	cs-gpios = <&gpio2 26 GPIO_ACTIVE_HIGH>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_ecspi2 &pinctrl_spi_cs2>;
>> +	status = "disabled";
>> +};
>> +
>> +&fec {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_enet &pinctrl_enet_ctrl>;
>> +	phy-mode = "rgmii";
>> +	status = "okay";
>> +
>> +	#address-cells = <0>;
>> +	#size-cells = <1>;
>> +	phy_int {
>> +		reg = <0x6>;
>> +		interrupt-parent = <&gpio1>;
>> +		interrupts = <30 IRQ_TYPE_LEVEL_LOW>;
>> +	};
> I don't think that's the right way to describe a PHY with the mainline
> kernel bindings.
> 
>> +};
>> +
>> +&can1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_flexcan1>;
>> +	status = "disabled";
>> +};
>> +
>> +&can2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_flexcan2>;
>> +	status = "disabled";
>> +};
>> +
>> +/*
>> + * GEN1_I2C: I2C1_SDA/SCL on MXM3 209/211 (e.g. RTC on carrier
>> + * board)
>> + */
> 
> This comment doesn't add any value. Remove.
> 
>> +&i2c1 {
>> +	clock-frequency = <100000>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_i2c1>;
>> +	status = "disabled";
>> +};
>> +
>> +&i2c2 {
>> +	clock-frequency = <100000>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_i2c2>;
>> +	status = "okay";
>> +
>> +	pmic: pfuze100 at 08 {
>> +		compatible = "fsl,pfuze100";
>> +		reg = <0x08>;
>> +
>> +		regulators {
>> +			sw1a_reg: sw1ab {
>> +				regulator-min-microvolt = <300000>;
>> +				regulator-max-microvolt = <1875000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +				regulator-ramp-delay = <6250>;
>> +			};
>> +
>> +			sw1c_reg: sw1c {
>> +				regulator-min-microvolt = <300000>;
>> +				regulator-max-microvolt = <1875000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +				regulator-ramp-delay = <6250>;
>> +			};
>> +
>> +			sw3a_reg: sw3a {
>> +				regulator-min-microvolt = <400000>;
>> +				regulator-max-microvolt = <1975000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			swbst_reg: swbst {
>> +				regulator-min-microvolt = <5000000>;
>> +				regulator-max-microvolt = <5150000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			snvs_reg: vsnvs {
>> +				regulator-min-microvolt = <1000000>;
>> +				regulator-max-microvolt = <3000000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			vref_reg: vrefddr {
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			vgen1_reg: vgen1 {
>> +				regulator-min-microvolt = <800000>;
>> +				regulator-max-microvolt = <1550000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			vgen2_reg: vgen2 {
>> +				regulator-min-microvolt = <800000>;
>> +				regulator-max-microvolt = <1550000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			vgen3_reg: vgen3 {
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			vgen4_reg: vgen4 {
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			vgen5_reg: vgen5 {
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			vgen6_reg: vgen6 {
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +/*
>> + * GEN2_I2C, CAM: I2C3_SDA/SCL on MXM3 201/203 (unused)
>> + */
> 
> Remove.
> 
>> +&i2c3 {
>> +	clock-frequency = <100000>;
>> +	pinctrl-names = "default", "recovery";
>> +	pinctrl-0 = <&pinctrl_i2c3>;
>> +	pinctrl-1 = <&pinctrl_i2c3_recovery>;
>> +	gpios = <&gpio3 18 GPIO_ACTIVE_HIGH /* sda */
>> +		 &gpio3 17 GPIO_ACTIVE_HIGH /* scl */
>> +		 >;
> 
> The mainline binding states that those need to be named as "scl-gpios"
> and "sda-gpios". See Documentation/devicetree/bindings/i2c/i2c-imx.txt
> 
>> +	status = "disabled";
>> +};
>> +
>> +/* PAD Ctrl values for common settings */
>> +/* (PAD_CTL_HYS | PAD_CTL_PUS_100K_UP | PAD_CTL_PUE | PAD_CTL_PKE | PAD_CTL_SPEED_MED | PAD_CTL_DSE_40ohm) */
>> +#define PAD_CTRL_HYS_PU 0x1b0b0
>> +
>> +/* (PAD_CTL_HYS | PAD_CTL_PUE | PAD_CTL_PKE | PAD_CTL_SPEED_MED | PAD_CTL_DSE_40ohm) */
>> +#define PAD_CTRL_HYS_PD 0x130b0
>> +
>> +/* (PAD_CTL_PUS_22K_UP | PAD_CTL_PUE | PAD_CTL_PKE | PAD_CTL_SPEED_LOW | PAD_CTL_DSE_80ohm) */
>> +#define PAD_CTRL_PU_22k 0x0f058
>> +
> I don't particularly like those defines. Maybe just replace by the hex
> values?
> 
>> +#define PAD_CTRL_NO 0x80000000
>> +
> No pad control isn't okay for new DTs. Even if the pin should stay at
> the hardware reset default, it must be explicitly set in the DT. Please
> look up the defaults in the reference manual and replace any occurrence
> of 0x80000000 with the real value.
> 
>> +&iomuxc {
>> +	ecspi {
>> +		pinctrl_ecspi1: ecspi1grp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_CSI0_DAT6__ECSPI1_MISO 0x100b1
>> +				MX6QDL_PAD_CSI0_DAT5__ECSPI1_MOSI 0x100b1
>> +				MX6QDL_PAD_CSI0_DAT4__ECSPI1_SCLK 0x100b1
>> +			>;
>> +		};
>> +		pinctrl_ecspi2: ecspi2grp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_EIM_OE__ECSPI2_MISO 0x100b1
>> +				MX6QDL_PAD_EIM_CS1__ECSPI2_MOSI 0x100b1
>> +				MX6QDL_PAD_EIM_CS0__ECSPI2_SCLK 0x100b1
>> +			>;
>> +		};
>> +		pinctrl_spi_cs1: spi_cs1 {
>> +			fsl,pins = <
>> +				/* SPI1 cs */
>> +				MX6QDL_PAD_CSI0_DAT7__GPIO5_IO25 PAD_CTRL_NO
>> +				>;
>> +		};
>> +		pinctrl_spi_cs2: spi_cs2 {
>> +			fsl,pins = <
>> +				/* SPI2 cs */
>> +				MX6QDL_PAD_EIM_RW__GPIO2_IO26 PAD_CTRL_NO
>> +				>;
>> +		};
>> +	};
>> +
>> +	flexcan {
>> +		pinctrl_flexcan1: flexcan1grp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_GPIO_7__FLEXCAN1_TX   0x80000000
>> +				MX6QDL_PAD_GPIO_8__FLEXCAN1_RX   0x80000000
>> +			>;
>> +		};
>> +		pinctrl_flexcan2: flexcan2grp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX 0x80000000
>> +				MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX 0x80000000
>> +			>;
>> +		};
>> +	};
>> +
>> +	gpio {
>> +		pinctrl_apalis_gpio1: apalis_gpio1 {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_NANDF_D4__GPIO2_IO04 PAD_CTRL_HYS_PD
>> +			>;
>> +		};
>> +		pinctrl_apalis_gpio2: apalis_gpio2 {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_NANDF_D5__GPIO2_IO05 PAD_CTRL_HYS_PD
>> +			>;
>> +		};
>> +		pinctrl_apalis_gpio3: apalis_gpio3 {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_NANDF_D6__GPIO2_IO06 PAD_CTRL_HYS_PD
>> +			>;
>> +		};
>> +		pinctrl_apalis_gpio4: apalis_gpio4 {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_NANDF_D7__GPIO2_IO07 PAD_CTRL_HYS_PD
>> +			>;
>> +		};
>> +		pinctrl_apalis_gpio5: apalis_gpio5 {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_NANDF_RB0__GPIO6_IO10 PAD_CTRL_HYS_PD
>> +			>;
>> +		};
>> +		pinctrl_apalis_gpio6: apalis_gpio6 {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_NANDF_WP_B__GPIO6_IO09 PAD_CTRL_HYS_PD
>> +			>;
>> +		};
>> +		pinctrl_apalis_gpio7: apalis_gpio7 {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_GPIO_2__GPIO1_IO02 PAD_CTRL_HYS_PD
>> +			>;
>> +		};
>> +		pinctrl_apalis_gpio8: apalis_gpio8 {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_GPIO_6__GPIO1_IO06 PAD_CTRL_HYS_PD
>> +			>;
>> +		};
>> +		pinctrl_gpio_keys: gpio_keys {
>> +			fsl,pins = <
>> +				/* Power Button */
>> +				MX6QDL_PAD_GPIO_4__GPIO1_IO04 PAD_CTRL_HYS_PU
>> +				>;
>> +		};
>> +	};
>> +
>> +	hdmi {
>> +		pinctrl_hdmi_cec: hdmicecgrp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_KEY_ROW2__HDMI_TX_CEC_LINE 0x1f8b0
>> +			>;
>> +		};
>> +	};
>> +
>> +	i2c {
>> +		pinctrl_i2c_ddc: i2c_ddc {
>> +			fsl,pins = <
>> +				/* DDC bitbang */
>> +				MX6QDL_PAD_EIM_EB2__GPIO2_IO30 PAD_CTRL_HYS_PU
>> +				MX6QDL_PAD_EIM_D16__GPIO3_IO16 PAD_CTRL_HYS_PU
>> +				>;
>> +		};
>> +		pinctrl_i2c1: i2c1grp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_CSI0_DAT8__I2C1_SDA 0x4001b8b1
>> +				MX6QDL_PAD_CSI0_DAT9__I2C1_SCL 0x4001b8b1
>> +			>;
>> +		};
>> +		pinctrl_i2c3: i2c3grp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_EIM_D17__I2C3_SCL 0x4001b8b1
>> +				MX6QDL_PAD_EIM_D18__I2C3_SDA 0x4001b8b1
>> +			>;
>> +		};
>> +		pinctrl_i2c3_recovery: i2c3-recoverygrp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_EIM_D17__GPIO3_IO17 0x4001b8b1
>> +				MX6QDL_PAD_EIM_D18__GPIO3_IO18 0x4001b8b1
>> +			>;
>> +		};
>> +	};
>> +
>> +	/* pins used on module */
>> +	imx6q-apalis {
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_reset_moci &pinctrl_emmc_reset>;
>> +		pinctrl_audmux: audmuxgrp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_DISP0_DAT20__AUD4_TXC  0x130b0
>> +				MX6QDL_PAD_DISP0_DAT21__AUD4_TXD  0x130b0
>> +				MX6QDL_PAD_DISP0_DAT22__AUD4_TXFS 0x130b0
>> +				MX6QDL_PAD_DISP0_DAT23__AUD4_RXD  0x130b0
>> +			>;
>> +		};
>> +		pinctrl_audmux_mclk: audmux_mclk {
>> +			fsl,pins = <
>> +				/* SGTL5000 sys_mclk */
>> +				MX6QDL_PAD_GPIO_5__CCM_CLKO1 0x000b0
>> +			>;
>> +		};
>> +		pinctrl_emmc_reset: emmc_reset {
>> +			fsl,pins = <
>> +				/* eMMC reset, leave it alone */
>> +				MX6QDL_PAD_SD3_RST__GPIO7_IO08 PAD_CTRL_PU_22k
>> +			>;
>> +		};
>> +		pinctrl_enet: enetgrp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_ENET_MDIO__ENET_MDIO       0x1b0b0
>> +				MX6QDL_PAD_ENET_MDC__ENET_MDC         0x1b0b0
>> +				MX6QDL_PAD_RGMII_TXC__RGMII_TXC       0x1b0b0
>> +				MX6QDL_PAD_RGMII_TD0__RGMII_TD0       0x1b0b0
>> +				MX6QDL_PAD_RGMII_TD1__RGMII_TD1       0x1b0b0
>> +				MX6QDL_PAD_RGMII_TD2__RGMII_TD2       0x1b0b0
>> +				MX6QDL_PAD_RGMII_TD3__RGMII_TD3       0x1b0b0
>> +				MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x1b0b0
>> +				MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0b0
>> +				MX6QDL_PAD_RGMII_RXC__RGMII_RXC       0x1b0b0
>> +				MX6QDL_PAD_RGMII_RD0__RGMII_RD0       0x1b0b0
>> +				MX6QDL_PAD_RGMII_RD1__RGMII_RD1       0x1b0b0
>> +				MX6QDL_PAD_RGMII_RD2__RGMII_RD2       0x1b0b0
>> +				MX6QDL_PAD_RGMII_RD3__RGMII_RD3       0x1b0b0
>> +				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
>> +			>;
>> +		};
>> +		pinctrl_enet_ctrl: enet_ctrlgrp {
>> +			fsl,pins = <
>> +				/* ENET phy reset */
>> +				MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25 PAD_CTRL_NO
>> +				/* ENET phy interrupt */
>> +				MX6QDL_PAD_ENET_TXD0__GPIO1_IO30 PAD_CTRL_HYS_PU
>> +			>;
>> +		};
>> +		pinctrl_i2c2: i2c2grp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b8b1
>> +				MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b8b1
>> +			>;
>> +		};
>> +		pinctrl_ipu2_vdac: ipu2vdacgrp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_DI0_DISP_CLK__IPU2_DI0_DISP_CLK 0xD1
>> +				MX6QDL_PAD_DI0_PIN15__IPU2_DI0_PIN15       0xD1
>> +				MX6QDL_PAD_DI0_PIN2__IPU2_DI0_PIN02        0xD1
>> +				MX6QDL_PAD_DI0_PIN3__IPU2_DI0_PIN03        0xD1
>> +				MX6QDL_PAD_DISP0_DAT0__IPU2_DISP0_DATA00   0xF9
>> +				MX6QDL_PAD_DISP0_DAT1__IPU2_DISP0_DATA01   0xF9
>> +				MX6QDL_PAD_DISP0_DAT2__IPU2_DISP0_DATA02   0xF9
>> +				MX6QDL_PAD_DISP0_DAT3__IPU2_DISP0_DATA03   0xF9
>> +				MX6QDL_PAD_DISP0_DAT4__IPU2_DISP0_DATA04   0xF9
>> +				MX6QDL_PAD_DISP0_DAT5__IPU2_DISP0_DATA05   0xF9
>> +				MX6QDL_PAD_DISP0_DAT6__IPU2_DISP0_DATA06   0xF9
>> +				MX6QDL_PAD_DISP0_DAT7__IPU2_DISP0_DATA07   0xF9
>> +				MX6QDL_PAD_DISP0_DAT8__IPU2_DISP0_DATA08   0xF9
>> +				MX6QDL_PAD_DISP0_DAT9__IPU2_DISP0_DATA09   0xF9
>> +				MX6QDL_PAD_DISP0_DAT10__IPU2_DISP0_DATA10  0xF9
>> +				MX6QDL_PAD_DISP0_DAT11__IPU2_DISP0_DATA11  0xF9
>> +				MX6QDL_PAD_DISP0_DAT12__IPU2_DISP0_DATA12  0xF9
>> +				MX6QDL_PAD_DISP0_DAT13__IPU2_DISP0_DATA13  0xF9
>> +				MX6QDL_PAD_DISP0_DAT14__IPU2_DISP0_DATA14  0xF9
>> +				MX6QDL_PAD_DISP0_DAT15__IPU2_DISP0_DATA15  0xF9
> 
> Lowercase for hex values, please.
> 
>> +			>;
>> +		};
>> +		pinctrl_regulator_usbhub_pwr: gpio_regulator_usbhub_pwr {
>> +			fsl,pins = <
>> +				/* USBH_HUB_EN */
>> +				MX6QDL_PAD_EIM_D28__GPIO3_IO28 PAD_CTRL_PU_22k
>> +				>;
>> +		};
>> +		pinctrl_reset_moci: gpio_reset_moci {
>> +			fsl,pins = <
>> +				/* RESET_MOCI control */
>> +				MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28 PAD_CTRL_PU_22k
>> +				>;
>> +		};
>> +		pinctrl_touch_int: touch_intgrp {
>> +			fsl,pins = <
>> +				/* STMPE811 interrupt */
>> +				MX6QDL_PAD_KEY_COL2__GPIO4_IO10 PAD_CTRL_HYS_PU
>> +			>;
>> +		};
>> +		pinctrl_usdhc3: usdhc3grp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_SD3_CMD__SD3_CMD    0x17059
>> +				MX6QDL_PAD_SD3_CLK__SD3_CLK    0x10059
>> +				MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x17059
>> +				MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x17059
>> +				MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x17059
>> +				MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x17059
>> +				MX6QDL_PAD_SD3_DAT4__SD3_DATA4 0x17059
>> +				MX6QDL_PAD_SD3_DAT5__SD3_DATA5 0x17059
>> +				MX6QDL_PAD_SD3_DAT6__SD3_DATA6 0x17059
>> +				MX6QDL_PAD_SD3_DAT7__SD3_DATA7 0x17059
>> +			>;
>> +		};
>> +		pinctrl_usdhc3_100mhz: usdhc3grp-100mhz { /* 100Mhz */
>> +			fsl,pins = <
>> +				MX6QDL_PAD_SD3_CMD__SD3_CMD 0x170B9
>> +				MX6QDL_PAD_SD3_CLK__SD3_CLK 0x100B9
>> +				MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x170B9
>> +				MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x170B9
>> +				MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x170B9
>> +				MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x170B9
>> +				MX6QDL_PAD_SD3_DAT4__SD3_DATA4 0x170B9
>> +				MX6QDL_PAD_SD3_DAT5__SD3_DATA5 0x170B9
>> +				MX6QDL_PAD_SD3_DAT6__SD3_DATA6 0x170B9
>> +				MX6QDL_PAD_SD3_DAT7__SD3_DATA7 0x170B9
>> +			>;
>> +		};
>> +		pinctrl_usdhc3_200mhz: usdhc3grp-200mhz { /* 200Mhz */
>> +			fsl,pins = <
>> +				MX6QDL_PAD_SD3_CMD__SD3_CMD 0x170F9
>> +				MX6QDL_PAD_SD3_CLK__SD3_CLK 0x100F9
>> +				MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x170F9
>> +				MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x170F9
>> +				MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x170F9
>> +				MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x170F9
>> +				MX6QDL_PAD_SD3_DAT4__SD3_DATA4 0x170F9
>> +				MX6QDL_PAD_SD3_DAT5__SD3_DATA5 0x170F9
>> +				MX6QDL_PAD_SD3_DAT6__SD3_DATA6 0x170F9
>> +				MX6QDL_PAD_SD3_DAT7__SD3_DATA7 0x170F9
>> +			>;
>> +		};
>> +	};
>> +
>> +	ipu1 {
>> +		pinctrl_ipu1_lcdif: ipu1lcdifgrp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_EIM_A16__IPU1_DI1_DISP_CLK	0x61
>> +				MX6QDL_PAD_EIM_DA10__IPU1_DI1_PIN15	0x61 /* DE */
>> +				MX6QDL_PAD_EIM_DA11__IPU1_DI1_PIN02	0x61 /* HSync */
>> +				MX6QDL_PAD_EIM_DA12__IPU1_DI1_PIN03	0x61 /* VSync */
>> +				MX6QDL_PAD_EIM_DA9__IPU1_DISP1_DATA00	0x61
>> +				MX6QDL_PAD_EIM_DA8__IPU1_DISP1_DATA01	0x61
>> +				MX6QDL_PAD_EIM_DA7__IPU1_DISP1_DATA02	0x61
>> +				MX6QDL_PAD_EIM_DA6__IPU1_DISP1_DATA03	0x61
>> +				MX6QDL_PAD_EIM_DA5__IPU1_DISP1_DATA04	0x61
>> +				MX6QDL_PAD_EIM_DA4__IPU1_DISP1_DATA05	0x61
>> +				MX6QDL_PAD_EIM_DA3__IPU1_DISP1_DATA06	0x61
>> +				MX6QDL_PAD_EIM_DA2__IPU1_DISP1_DATA07	0x61
>> +				MX6QDL_PAD_EIM_DA1__IPU1_DISP1_DATA08	0x61
>> +				MX6QDL_PAD_EIM_DA0__IPU1_DISP1_DATA09	0x61
>> +				MX6QDL_PAD_EIM_EB1__IPU1_DISP1_DATA10	0x61
>> +				MX6QDL_PAD_EIM_EB0__IPU1_DISP1_DATA11	0x61
>> +				MX6QDL_PAD_EIM_A17__IPU1_DISP1_DATA12	0x61
>> +				MX6QDL_PAD_EIM_A18__IPU1_DISP1_DATA13	0x61
>> +				MX6QDL_PAD_EIM_A19__IPU1_DISP1_DATA14	0x61
>> +				MX6QDL_PAD_EIM_A20__IPU1_DISP1_DATA15	0x61
>> +				MX6QDL_PAD_EIM_A21__IPU1_DISP1_DATA16	0x61
>> +				MX6QDL_PAD_EIM_A22__IPU1_DISP1_DATA17	0x61
>> +				MX6QDL_PAD_EIM_A23__IPU1_DISP1_DATA18	0x61
>> +				MX6QDL_PAD_EIM_A24__IPU1_DISP1_DATA19	0x61
>> +				MX6QDL_PAD_EIM_D31__IPU1_DISP1_DATA20	0x61
>> +				MX6QDL_PAD_EIM_D30__IPU1_DISP1_DATA21	0x61
>> +				MX6QDL_PAD_EIM_D26__IPU1_DISP1_DATA22	0x61
>> +				MX6QDL_PAD_EIM_D27__IPU1_DISP1_DATA23	0x61
>> +			>;
>> +		};
>> +		pinctrl_cam_mclk: cam_mclk {
>> +			fsl,pins = <
>> +				/* CAM sys_mclk */
>> +				MX6QDL_PAD_NANDF_CS2__CCM_CLKO2 0x00b0
>> +			>;
>> +		};
>> +		pinctrl_ipu1_csi0: ipu1csi0grp { /* parallel camera */
>> +			fsl,pins = <
>> +				MX6QDL_PAD_CSI0_DAT12__IPU1_CSI0_DATA12  0xb0b1
>> +				MX6QDL_PAD_CSI0_DAT13__IPU1_CSI0_DATA13  0xb0b1
>> +				MX6QDL_PAD_CSI0_DAT14__IPU1_CSI0_DATA14  0xb0b1
>> +				MX6QDL_PAD_CSI0_DAT15__IPU1_CSI0_DATA15  0xb0b1
>> +				MX6QDL_PAD_CSI0_DAT16__IPU1_CSI0_DATA16  0xb0b1
>> +				MX6QDL_PAD_CSI0_DAT17__IPU1_CSI0_DATA17  0xb0b1
>> +				MX6QDL_PAD_CSI0_DAT18__IPU1_CSI0_DATA18  0xb0b1
>> +				MX6QDL_PAD_CSI0_DAT19__IPU1_CSI0_DATA19  0xb0b1
>> +				MX6QDL_PAD_CSI0_PIXCLK__IPU1_CSI0_PIXCLK 0xb0b1
>> +				MX6QDL_PAD_CSI0_MCLK__IPU1_CSI0_HSYNC    0xb0b1
>> +				MX6QDL_PAD_CSI0_VSYNC__IPU1_CSI0_VSYNC   0xb0b1
>> +			>;
>> +		};
>> +	};
>> +
>> +	pwm {
>> +		pinctrl_pwm1: pwm1grp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_GPIO_9__PWM1_OUT 0x1b0b1
>> +			>;
>> +		};
>> +		pinctrl_pwm2: pwm2grp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_GPIO_1__PWM2_OUT 0x1b0b1
>> +			>;
>> +		};
>> +		pinctrl_pwm3: pwm3grp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_SD4_DAT1__PWM3_OUT 0x1b0b1
>> +			>;
>> +		};
>> +		pinctrl_pwm4: pwm4grp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_SD4_DAT2__PWM4_OUT 0x1b0b1
>> +			>;
>> +		};
>> +	};
>> +
>> +	spdif {
>> +		pinctrl_spdif: spdifgrp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_GPIO_16__SPDIF_IN  0x1b0b0
>> +				MX6QDL_PAD_GPIO_17__SPDIF_OUT 0x1b0b0
>> +			>;
>> +		};
>> +	};
>> +
>> +	uart1 {
>> +		pinctrl_uart1_dce: uart1-dcegrp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA 0x1b0b1
>> +				MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA 0x1b0b1
>> +			>;
>> +		};
>> +
>> +		/* DTE mode */
>> +		pinctrl_uart1_dte: uart1-dtegrp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_CSI0_DAT10__UART1_RX_DATA 0x1b0b1
>> +				MX6QDL_PAD_CSI0_DAT11__UART1_TX_DATA 0x1b0b1
>> +				MX6QDL_PAD_EIM_D19__UART1_RTS_B 0x1b0b1
>> +				MX6QDL_PAD_EIM_D20__UART1_CTS_B 0x1b0b1
>> +			>;
>> +		};
>> +
>> +		/* Additional DTR, DSR, DCD */
>> +		pinctrl_uart1_ctrl: uart1-ctrlgrp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_EIM_D23__UART1_DCD_B 0x1b0b0
>> +				MX6QDL_PAD_EIM_D24__UART1_DTR_B 0x1b0b0
>> +				MX6QDL_PAD_EIM_D25__UART1_DSR_B 0x1b0b0
>> +			>;
>> +		};
>> +	};
>> +
>> +	uart2 {
>> +		pinctrl_uart2_dce: uart2-dcegrp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA   0x1b0b1
>> +				MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA   0x1b0b1
>> +			>;
>> +		};
>> +
>> +		/* DTE mode */
>> +		pinctrl_uart2_dte: uart2grp-dte {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_SD4_DAT4__UART2_TX_DATA   0x1b0b1
>> +				MX6QDL_PAD_SD4_DAT7__UART2_RX_DATA   0x1b0b1
>> +				MX6QDL_PAD_SD4_DAT6__UART2_RTS_B 0x1b0b1
>> +				MX6QDL_PAD_SD4_DAT5__UART2_CTS_B 0x1b0b1
>> +			>;
>> +		};
>> +	};
>> +
>> +	uart4 {
>> +		pinctrl_uart4_dce: uart4-dcegrp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_KEY_COL0__UART4_TX_DATA 0x1b0b1
>> +				MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA 0x1b0b1
>> +			>;
>> +		};
>> +
>> +		/* DTE mode */
>> +		pinctrl_uart4_dte: uart4-dtegrp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_KEY_COL0__UART4_RX_DATA 0x1b0b1
>> +				MX6QDL_PAD_KEY_ROW0__UART4_TX_DATA 0x1b0b1
>> +			>;
>> +		};
>> +	};
>> +
>> +	uart5 {
>> +		pinctrl_uart5_dce: uart5-dcegrp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_KEY_COL1__UART5_TX_DATA 0x1b0b1
>> +				MX6QDL_PAD_KEY_ROW1__UART5_RX_DATA 0x1b0b1
>> +			>;
>> +		};
>> +
>> +		/* DTE mode */
>> +		pinctrl_uart5_dte: uart5-dtegrp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_KEY_COL1__UART5_RX_DATA 0x1b0b1
>> +				MX6QDL_PAD_KEY_ROW1__UART5_TX_DATA 0x1b0b1
>> +			>;
>> +		};
>> +	};
>> +
>> +	usbh {
>> +		pinctrl_regulator_usbh_pwr: gpio_regulator_usbh_pwr {
>> +			fsl,pins = <
>> +				/* USBH_EN */
>> +				MX6QDL_PAD_GPIO_0__GPIO1_IO00 PAD_CTRL_PU_22k
>> +				>;
>> +		};
>> +	};
>> +
>> +	usbotg {
>> +		pinctrl_usbotg: usbotggrp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID 0x17059
>> +			>;
>> +		};
>> +		pinctrl_regulator_usbotg_pwr: gpio_regulator_usbotg_pwr {
>> +			fsl,pins = <
>> +				/* USBO power en */
>> +				MX6QDL_PAD_EIM_D22__GPIO3_IO22 PAD_CTRL_PU_22k
>> +				>;
>> +		};
>> +	};
>> +
>> +	usdhc {
>> +		pinctrl_mmc_cd: gpio_mmc_cd {
>> +			fsl,pins = <
>> +				 /* MMC1 CD */
>> +				MX6QDL_PAD_DI0_PIN4__GPIO4_IO20 PAD_CTRL_NO
>> +				>;
>> +		};
>> +		pinctrl_sd_cd: gpio_sd_cd {
>> +			fsl,pins = <
>> +				/* SD1 CD */
>> +				MX6QDL_PAD_NANDF_CS1__GPIO6_IO14 PAD_CTRL_NO
>> +				>;
>> +		};
>> +		pinctrl_usdhc1: usdhc1grp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17071
>> +				MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10071
>> +				MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17071
>> +				MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17071
>> +				MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17071
>> +				MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17071
>> +				MX6QDL_PAD_NANDF_D0__SD1_DATA4 0x17071
>> +				MX6QDL_PAD_NANDF_D1__SD1_DATA5 0x17071
>> +				MX6QDL_PAD_NANDF_D2__SD1_DATA6 0x17071
>> +				MX6QDL_PAD_NANDF_D3__SD1_DATA7 0x17071
>> +			>;
>> +		};
>> +		pinctrl_usdhc2: usdhc2grp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_SD2_CMD__SD2_CMD    0x17059
>> +				MX6QDL_PAD_SD2_CLK__SD2_CLK    0x10059
>> +				MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x17059
>> +				MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x17059
>> +				MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x17059
>> +				MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x17059
>> +			>;
>> +		};
>> +	};
>> +};
>> +
>> +&ldb {
>> +	ipu_id = <1>;
>> +	disp_id = <1>;
>> +	ext_ref = <1>;
>> +	mode = "spl1";
>> +	sec_ipu_id = <1>;
>> +	sec_disp_id = <0>;
> 
> Those properties are not part of the mainline binding. Remove.
> 
>> +	status = "okay";
>> +};
>> +
>> +&pwm1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_pwm1>;
>> +	status = "disabled";
>> +};
>> +
>> +&pwm2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_pwm2>;
>> +	status = "disabled";
>> +};
>> +
>> +&pwm3 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_pwm3>;
>> +	status = "disabled";
>> +};
>> +
>> +&pwm4 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_pwm4>;
>> +	status = "disabled";
>> +};
>> +
>> +&spdif {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_spdif>;
>> +	status = "disabled";
>> +};
>> +
>> +&ssi1 {
>> +	fsl,mode = "i2s-slave";
>> +	status = "okay";
>> +};
>> +
>> +&uart1 {
>> +	pinctrl-names = "default";
>> +#ifndef USE_UART_IN_DCE_MODE
>> +	pinctrl-0 = <&pinctrl_uart1_dte &pinctrl_uart1_ctrl>;
>> +	fsl,dte-mode;
>> +	fsl,uart-has-rtscts;
>> +#else
>> +	pinctrl-0 = <&pinctrl_uart1_dce>;
>> +#endif
>> +	status = "disabled";
>> +};
>> +
>> +&uart2 {
>> +	pinctrl-names = "default";
>> +#ifndef USE_UART_IN_DCE_MODE
>> +	pinctrl-0 = <&pinctrl_uart2_dte>;
>> +	fsl,dte-mode;
>> +	fsl,uart-has-rtscts;
>> +#else
>> +	pinctrl-0 = <&pinctrl_uart2_dce>;
>> +#endif
>> +	status = "disabled";
>> +};
>> +
>> +&uart4 {
>> +	pinctrl-names = "default";
>> +#ifndef USE_UART_IN_DCE_MODE
>> +	pinctrl-0 = <&pinctrl_uart4_dte>;
>> +	fsl,dte-mode;
>> +#else
>> +	pinctrl-0 = <&pinctrl_uart4_dce>;
>> +#endif
>> +	status = "disabled";
>> +};
>> +
>> +&uart5 {
>> +	pinctrl-names = "default";
>> +#ifndef USE_UART_IN_DCE_MODE
>> +	pinctrl-0 = <&pinctrl_uart5_dte>;
>> +	fsl,dte-mode;
>> +#else
>> +	pinctrl-0 = <&pinctrl_uart5_dce>;
>> +#endif
>> +	status = "disabled";
>> +};
> 
> Urgh, those ifdefs are really ugly, but probably nothing you can do
> about that. Maybe you can just override the pinctrl from the top level
> DT...
> 
> Were v1.0 modules sold to customers? If not the value of having those
> supported by mainline is really limited.

Some have been made it to customers as early samples, however not that
many.

I am inclined to say lets not support them. They anyway lead to
headaches since you need to use a different U-Boot binary too...

Petr, do you happen to have one of them?

Otherwise I like the approach by overriding the pinctrl property in a 
arch/arm/boot/dts/imx6qdl-apalis_v1_0.dtsi...

Can we set fsl,dte-mode to false?

> 
>> +
>> +&usbh1 {
>> +	vbus-supply = <&reg_usb_host_vbus>;
>> +	status = "disabled";
>> +};
>> +
>> +&usbotg {
>> +	vbus-supply = <&reg_usb_otg_vbus>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_usbotg>;
>> +	disable-over-current;
>> +	status = "disabled";
>> +};
>> +
>> +/* MMC1 */
>> +&usdhc1 {
>> +	label = "MMC1";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_mmc_cd>;
>> +	cd-gpios = <&gpio4 20 GPIO_ACTIVE_HIGH>;
> 
> Probably active low.
> 

Yes...

>> +	vmmc-supply = <&reg_3p3v>;
>> +	bus-width = <8>;
>> +	no-1-8-v;
>> +	status = "disabled";
>> +};
>> +
>> +/* SD1 */
>> +&usdhc2 {
>> +	label = "SD1";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_usdhc2 &pinctrl_sd_cd>;
>> +	cd-gpios = <&gpio6 14 GPIO_ACTIVE_HIGH>;
> 
> Same as above.
> 

Yes...

>> +	vmmc-supply = <&reg_3p3v>;
>> +	bus-width = <4>;
>> +	no-1-8-v;
>> +	status = "disabled";
>> +};
>> +
>> +/* eMMC */
>> +&usdhc3 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_usdhc3>;
>> +	vmmc-supply = <&reg_3p3v>;
>> +	bus-width = <8>;
>> +	no-1-8-v;
>> +	non-removable;
>> +	status = "okay";
>> +};
>> +
>> +&weim {
>> +	status = "disabled"; /* weim signals not accessible on i.MX6 */
>> +};


--
Stefan
