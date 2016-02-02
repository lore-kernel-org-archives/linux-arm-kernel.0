From: stillcompiling@gmail.com (Joshua Clayton)
Date: Tue, 2 Feb 2016 13:21:20 -0800
Subject: [PATCH 2/2] ARM: dts: Add dts for Uniwest evi
In-Reply-To: <20160201121145.GE10671@tiger>
References: <b11bf2208fe30b96c4d82e634e8abe04343754de.1452717014.git.stillcompiling@gmail.com>
 <66c87b9536b674bdedfdbe2306def8e9bf6a585c.1452717014.git.stillcompiling@gmail.com>
 <20160201121145.GE10671@tiger>
Message-ID: <20160202132120.6c8e86b9@jclayton-pc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,
thanks for the review.
I've tried to address your concerns.
I have a new dts which I will send once I've booted it.

On Mon, 1 Feb 2016 20:11:45 +0800
Shawn Guo <shawnguo@kernel.org> wrote:

...
> > +	regulators {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		reg_usbh1_vbus: regulator at 0 {
> > +			compatible = "regulator-fixed";
> > +			reg = <0>;
> > +			regulator-name = "usbh1_vbus";
> > +			regulator-min-microvolt = <5000000>;
> > +			regulator-max-microvolt = <5000000>;
> > +			enable-active-high;
> > +			startup-delay-us = <2>;
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&pinctrl_usbh1_hubreset>;
> > +			gpio = <&gpio7 12 GPIO_ACTIVE_HIGH>;
> > +		};
> 
> Device tree maintainers do not like the fake simple-bus container for
> these fixed regulators.  We are asked to put them directly under root
> node.  In that case, we do not need the artificial 'reg' property, and
> we can name node in schema like:
> 
> 	reg_xxx: regulator-xxx {
> 		...
> 	}
>
OK. will do.  
> > +
> > +		reg_usb_otg_vbus: regulator at 1 {
> > +			compatible = "regulator-fixed";
> > +			reg = <1>;
> > +			regulator-name = "usb_otg_vbus";
> > +			regulator-min-microvolt = <5000000>;
> > +			regulator-max-microvolt = <5000000>;
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&pinctrl_usbotg_vbus>;
> > +			gpio = <&gpio4 15 GPIO_ACTIVE_HIGH>;
> > +			enable-active-high;
> > +			regulator-always-on;
> > +		};
> > +	};
> 
> Have a new line between nodes.
OK.
> 
> > +	chosen {
> > +		bootargs = "sbs-battery.force_load=1";
> > +	};
> 
> We generally put 'chosen' node at the beginning along with 'memory'
> node.  And do we really need this as the default bootargs?

It is needed because if the battery is not installed at boot time,
the device fails to probe as the dts is being parsed, and there is
no way for the kernel to be made aware later.

I guess I could put this into uboot kernel args instead...
I'll remove it for now.

> > +
> > +	panel {
> > +		compatible = "sharp,lq101k1ly04";
> 
> Undocumented compatible string.

This is making its way through the drm list. Its a simple-panel
compatible set of timings. 

> 
> > +
> > +		port {
> > +			panel_in: endpoint {
> > +				remote-endpoint = <&lvds0_out>;
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&ecspi1 {
> > +	fsl,spi-num-chipselects = <1>;
> > +	cs-gpios = <&gpio4 10 GPIO_ACTIVE_LOW>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_ecspi1 &pinctrl_ecspi1_extra>;
> 
> You use only one GPIO in cs-gpios.  Why do you need to set up 3 in
> pinctrl_ecspi1_extra?  And why do you name the pinctrl group in the
> same way as ecspi3 and ecspi5, i.e. pinctrl_ecspi1_cs?

There is only 1 chip select for this spi node.
The extra pins are related to a not-yet-upstreamed driver.
I'll remove them and call it pinctrl_ecspi1_cs

> 
> > +	status = "okay";
> > +};
> > +
> > +&ecspi3 {
> > +	fsl,spi-num-chipselects = <3>;
> > +	cs-gpios = <&gpio4 24 GPIO_ACTIVE_LOW>,
> > +		<&gpio4 25 GPIO_ACTIVE_LOW>,
> > +		<&gpio4 26 GPIO_ACTIVE_LOW>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_ecspi3 &pinctrl_ecspi3_cs>;
> > +	status = "okay";
> > +};
> > +
> > +&ecspi5 {
> > +	fsl,spi-num-chipselects = <4>;
> > +	cs-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>,
> > +		<&gpio1 13 GPIO_ACTIVE_LOW>,
> > +		<&gpio1 12 GPIO_ACTIVE_LOW>,
> > +		<&gpio2 9 GPIO_ACTIVE_HIGH>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_ecspi5 &pinctrl_ecspi5_cs>;
> > +	status = "okay";
> 
> Have a new line between properties and sub-node.

Will do. Thanks.

> 
> > +	eeprom: m95m02 at 1 {
> > +		compatible = "st,m95m02", "atmel,at25";
> > +		size = <262144>;
> > +		pagesize = <256>;
> > +		address-width = <24>;
> > +		spi-max-frequency = <5000000>;
> > +		reg = <1>;
> > +	};
> 
> Have a new line between nodes.

OK.

> 
> > +	pb_rtc: rtc at 3 {
> > +		compatible = "nxp,rtc-pcf2123";
> > +		spi-max-frequency = <2450000>;
> > +		spi-cs-high;
> > +		reg = <3>;
> > +	};
> > +};
> > +
> > +&fec {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_enet>;
> > +	phy-mode = "rgmii";
> > +	phy-reset-gpios = <&gpio1 25 0>;
> > +	status = "okay";
> > +};
> > +
> > +&gpmi {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_gpmi_nand>;
> > +	status = "okay";
> > +};
> > +
> > +&i2c2 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_i2c2>;
> > +	clock-frequency = <100000>;
> > +	status = "okay";
> > +};
> > +
> > +&i2c3 {
> > +	pinctrl-names = "default", "gpio";
> > +	pinctrl-0 = <&pinctrl_i2c3>;
> > +	pinctrl-1 = <&pinctrl_i2c3_gpio>;
> > +	clock-frequency = <100000>;
> > +	status = "okay";
> 
> We generally put 'status' at the bottom of the property list.

Will move it.

> 
> > +	scl-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
> > +	sda-gpios = <&gpio7 11 GPIO_ACTIVE_HIGH>;
> > +
> > +	battery: sbs-battery at b {
> > +		compatible = "sbs,sbs-battery";
> > +		reg = <0x0b>;
> > +		sbs,poll-retry-count = <100>;
> > +		sbs,i2c-retry-count = <100>;
> > +	};
> > +};
> > +
> > +&ldb {
> > +	status = "okay";
> > +
> > +	lvds0: lvds-channel at 0 {
> > +		fsl,data-mapping = "jeida";
> > +		fsl,data-width = <24>;
> > +		status = "okay";
> > +
> > +		port at 4 {
> > +			reg = <4>;
> > +
> > +			lvds0_out: endpoint {
> > +				remote-endpoint = <&panel_in>;
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&ssi1 {
> > +	fsl,mode = "i2s-slave";
> 
> "i2s-slave" is deprecated for fsl,mode, and can be just dropped.

OK.

> 
> > +	status = "okay";
> > +};
> > +
> > +&uart1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_uart1>;
> > +	status = "okay";
> > +};
> > +
> > +&uart2 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_uart2>;
> > +	status = "okay";
> > +};
> > +
> > +&usbh1 {
> > +	vbus-supply = <&reg_usbh1_vbus>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_usbh1>;
> > +	dr_mode = "host";
> > +	disable-over-current;
> > +	status = "okay";
> > +};
> > +
> > +&usbotg {
> > +	vbus-supply = <&reg_usb_otg_vbus>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_usbotg>;
> > +	disable-over-current;
> > +	dr_mode = "otg";
> > +	status = "okay";
> > +};
> > +
> > +&usdhc1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_usdhc1>;
> > +	non-removable;
> > +	status = "okay";
> > +};
> > +
> > +&weim {
> > +	#address-cells = <2>;
> > +	#size-cells = <1>;
> > +	ranges = <0 0 0x08000000 0x08000000>;
> > +	fsl,weim-cs-gpr = <&gpr>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_weim_fpga &pinctrl_weim_cs>;
> > +	status = "okay";
> > +};
> > +
> > +&iomuxc {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_hog>;
> > +
> > +	imx6q-evi {
> 
> Since commit 5fcdf6a7ed95 (pinctrl: imx: Allow parsing DT without
> function nodes), this additional container node can just be saved.

So these should be directly under iomux... ok. Will do 
> 
> > +		pinctrl_hog: hoggrp {
> > +			fsl,pins = <
> > +				/* CPLD Reset */
> > +				MX6QDL_PAD_GPIO_19__GPIO4_IO05
> > 0x1b0b0
> > +				/* pwr mcu alert irq */
> > +				MX6QDL_PAD_SD4_DAT2__GPIO2_IO10
> > 0x1b0b0
> > +				/* remainder ???? */
> > +				MX6QDL_PAD_CSI0_MCLK__GPIO5_IO19
> > 0x1b0b0
> > +			>;
> > +		};
> 
> Have a new line between nodes.

OK.

> 
> > +		pinctrl_ecspi1: ecspi1grp {
> > +			fsl,pins = <
> > +				MX6QDL_PAD_KEY_COL1__ECSPI1_MISO
> > 0x100b1
> > +				MX6QDL_PAD_KEY_ROW0__ECSPI1_MOSI
> > 0x100b1
> > +				MX6QDL_PAD_KEY_COL0__ECSPI1_SCLK
> > 0x100b1
> > +			>;
> > +		};
> > +		pinctrl_ecspi1_extra: ecspi1extragrp {
> > +			fsl,pins = <
> > +				MX6QDL_PAD_KEY_COL2__GPIO4_IO10
> > 0x1b0b0
> > +				MX6QDL_PAD_KEY_ROW1__GPIO4_IO09
> > 0x1b0b0
> > +				MX6QDL_PAD_KEY_ROW2__GPIO4_IO11
> > 0x1b0b0
> > +			>;
> > +		};
> > +		pinctrl_ecspi3: ecspi3grp {
> > +			fsl,pins = <
> > +				MX6QDL_PAD_DISP0_DAT0__ECSPI3_SCLK
> > 0x10068
> > +				MX6QDL_PAD_DISP0_DAT1__ECSPI3_MOSI
> > 0x10068
> > +				MX6QDL_PAD_DISP0_DAT2__ECSPI3_MISO
> > 0x1f068
> > +			>;
> > +		};
> > +		pinctrl_ecspi3_cs: ecspi3cs {
> 
> Please name the node consistently, like xxxgrp.

OK.

> 
> > +			fsl,pins = <
> > +				MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24
> > 0x1b0b0
> > +				MX6QDL_PAD_DISP0_DAT4__GPIO4_IO25
> > 0x1b0b0
> > +				MX6QDL_PAD_DISP0_DAT5__GPIO4_IO26
> > 0x1b0b0
> > +				MX6QDL_PAD_DISP0_DAT6__GPIO4_IO27
> > 0x1b0b0
> > +			>;
> > +		};
> > +		pinctrl_ecspi5: ecspi5grp {
> > +			fsl,pins = <
> > +				MX6QDL_PAD_SD2_CLK__ECSPI5_SCLK
> > 0x100b1
> > +				MX6QDL_PAD_SD2_CMD__ECSPI5_MOSI
> > 0x100b1
> > +				MX6QDL_PAD_SD2_DAT0__ECSPI5_MISO
> > 0x100b1
> > +			>;
> > +		};
> > +		pinctrl_ecspi5_cs: ecspi5cs {
> > +			fsl,pins = <
> > +				MX6QDL_PAD_SD2_DAT1__GPIO1_IO14
> > 0x1b0b0
> > +				MX6QDL_PAD_SD2_DAT2__GPIO1_IO13
> > 0x1b0b0
> > +				MX6QDL_PAD_SD2_DAT3__GPIO1_IO12
> > 0x1b0b0
> > +				MX6QDL_PAD_SD4_DAT1__GPIO2_IO09
> > 0x1b0b0
> > +			>;
> > +		};
> > +		pinctrl_enet: enetgrp {
> > +			fsl,pins = <
> > +				MX6QDL_PAD_ENET_MDIO__ENET_MDIO
> > 0x1b0b0
> > +				MX6QDL_PAD_ENET_MDC__ENET_MDC
> > 0x1b0b0
> > +				MX6QDL_PAD_RGMII_TXC__RGMII_TXC
> > 0x1b0b0
> > +				MX6QDL_PAD_RGMII_TD0__RGMII_TD0
> > 0x1b0b0
> > +				MX6QDL_PAD_RGMII_TD1__RGMII_TD1
> > 0x1b0b0
> > +				MX6QDL_PAD_RGMII_TD2__RGMII_TD2
> > 0x1b0b0
> > +				MX6QDL_PAD_RGMII_TD3__RGMII_TD3
> > 0x1b0b0
> > +
> > MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x1b0b0
> > +
> > MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK 0x1b0b0
> > +				MX6QDL_PAD_RGMII_RXC__RGMII_RXC
> > 0x1b0b0
> > +				MX6QDL_PAD_RGMII_RD0__RGMII_RD0
> > 0x1b0b0
> > +				MX6QDL_PAD_RGMII_RD1__RGMII_RD1
> > 0x1b0b0
> > +				MX6QDL_PAD_RGMII_RD2__RGMII_RD2
> > 0x1b0b0
> > +				MX6QDL_PAD_RGMII_RD3__RGMII_RD3
> > 0x1b0b0
> > +
> > MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
> > +				MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN
> > 0x4001b0a8
> > +				MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25
> > 0x1b0b0
> > +			>;
> > +		};
> > +		pinctrl_gpmi_nand: gpminandgrp {
> > +			fsl,pins = <
> > +				MX6QDL_PAD_NANDF_CLE__NAND_CLE
> > 0xb0b1
> > +				MX6QDL_PAD_NANDF_ALE__NAND_ALE
> > 0xb0b1
> > +				MX6QDL_PAD_NANDF_WP_B__NAND_WP_B
> > 0xb0b1
> > +				MX6QDL_PAD_NANDF_RB0__NAND_READY_B
> > 0xb000
> > +				MX6QDL_PAD_NANDF_CS0__NAND_CE0_B
> > 0xb0b1
> > +				MX6QDL_PAD_NANDF_CS1__NAND_CE1_B
> > 0xb0b1
> > +				MX6QDL_PAD_SD4_CMD__NAND_RE_B
> > 0xb0b1
> > +				MX6QDL_PAD_SD4_CLK__NAND_WE_B
> > 0xb0b1
> > +				MX6QDL_PAD_NANDF_D0__NAND_DATA00
> > 0xb0b1
> > +				MX6QDL_PAD_NANDF_D1__NAND_DATA01
> > 0xb0b1
> > +				MX6QDL_PAD_NANDF_D2__NAND_DATA02
> > 0xb0b1
> > +				MX6QDL_PAD_NANDF_D3__NAND_DATA03
> > 0xb0b1
> > +				MX6QDL_PAD_NANDF_D4__NAND_DATA04
> > 0xb0b1
> > +				MX6QDL_PAD_NANDF_D5__NAND_DATA05
> > 0xb0b1
> > +				MX6QDL_PAD_NANDF_D6__NAND_DATA06
> > 0xb0b1
> > +				MX6QDL_PAD_NANDF_D7__NAND_DATA07
> > 0xb0b1
> > +				MX6QDL_PAD_SD4_DAT0__NAND_DQS
> > 0x00b1
> > +			>;
> > +		};
> > +		pinctrl_i2c2: i2c2grp {
> > +			fsl,pins = <
> > +				MX6QDL_PAD_KEY_ROW3__I2C2_SDA
> > 0x4001b8b1
> > +				MX6QDL_PAD_KEY_COL3__I2C2_SCL
> > 0x4001b8b1
> > +			>;
> > +		};
> > +		pinctrl_i2c3: i2c3grp {
> > +			fsl,pins = <
> > +				MX6QDL_PAD_GPIO_5__I2C3_SCL
> > 0x4001b8b1
> > +				MX6QDL_PAD_GPIO_16__I2C3_SDA
> > 0x4001b8b1
> > +			>;
> > +		};
> > +		pinctrl_i2c3_gpio: i2c3gpiogrp {
> > +			fsl,pins = <
> > +				MX6QDL_PAD_GPIO_5__GPIO1_IO05
> > 0x4001b8b1
> > +				MX6QDL_PAD_GPIO_16__GPIO7_IO11
> > 0x4001b8b1
> > +			>;
> > +		};
> > +		pinctrl_weim_cs: weim_csgrp {
> 
> weimcsgrp
No underscore. OK.
> 
> > +			fsl,pins = <
> > +				MX6QDL_PAD_EIM_CS0__EIM_CS0_B
> > 0xb0b1
> > +				MX6QDL_PAD_EIM_CS1__EIM_CS1_B
> > 0xb0b1
> > +			>;
> > +		};
> > +		pinctrl_weim_fpga: weim_fpgagrp {
> 
> weimfpgagrp

No underscore. OK.

...

Thanks,
