From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 20 Jun 2014 21:20:43 +0800
Subject: [PATCH v2] ARM: dts: imx6: add aristainetos board support
In-Reply-To: <1403184957-19482-1-git-send-email-hs@denx.de>
References: <1403184957-19482-1-git-send-email-hs@denx.de>
Message-ID: <20140620132042.GL28225@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 19, 2014 at 03:35:57PM +0200, Heiko Schocher wrote:
> This patch add support for the imx6dl based aristainetos board
> with following configuration:
> 
> CPU:   Freescale i.MX6DL rev1.1 at 792 MHz
> DRAM:  1 GiB
> NAND:  512 MiB
> MMC:   FSL_SDHC: 0, FSL_SDHC: 1
> SF: Detected N25Q128 with page size 256 Bytes, erase size 64 KiB, total 16 MiB
> 
> As this board can used with 2 different display types, the
> differences between them are extracted into 2 DTS files, and
> the common settings are collected in a common file.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>

Looks good.  A couple of minor comments below.

...

> +/ {
> +	regulators {
> +		compatible = "simple-bus";



> +
> +		reg_2p5v: regulator at 0 {

You need 'reg' property for node like name at unit-address, and therefore
you need #address-cells and #size-cells for the parent.


> +			compatible = "regulator-fixed";
> +			regulator-name = "2P5V";
> +			regulator-min-microvolt = <2500000>;
> +			regulator-max-microvolt = <2500000>;
> +			regulator-always-on;
> +		};
> +
> +		reg_3p3v: regulator at 1 {
> +			compatible = "regulator-fixed";
> +			regulator-name = "3P3V";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};
> +
> +		reg_usbh1_vbus: regulator at 2 {
> +			compatible = "regulator-fixed";
> +			enable-active-high;
> +			gpio = <&gpio3 31 GPIO_ACTIVE_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_aristainetos_usbh1_vbus>;
> +			regulator-name = "usb_h1_vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +		};
> +
> +		reg_usbotg_vbus: regulator at 3 {
> +			compatible = "regulator-fixed";
> +			enable-active-high;
> +			gpio = <&gpio4 15 GPIO_ACTIVE_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_aristainetos_usbotg_vbus>;
> +			regulator-name = "usb_otg_vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +		};
> +	};
> +};

...

> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;
> +
> +	imx6qdl-aristainetos {
> +		pinctrl_aristainetos_usbh1_vbus: aristainetos-usbh1-vbus {
> +			fsl,pins = <MX6QDL_PAD_EIM_D31__GPIO3_IO31 0x130b0>;
> +		};
> +
> +		pinctrl_aristainetos_usbotg_vbus: aristainetos-usbotg-vbus {
> +			fsl,pins = <MX6QDL_PAD_KEY_ROW4__GPIO4_IO15 0x130b0>;
> +		};
> +
> +		pinctrl_audmux: audmuxgrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_CSI0_DAT7__AUD3_RXD  0x80000000
> +				MX6QDL_PAD_CSI0_DAT4__AUD3_TXC  0x80000000
> +				MX6QDL_PAD_CSI0_DAT5__AUD3_TXD  0x80000000
> +				MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS 0x80000000

Instead of using 0x80000000, please configure them explicitly.

> +			>;
> +		};
> +
> +		pinctrl_backlight: backlightgrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_GPIO_9__PWM1_OUT	0x1b0b0
> +				MX6QDL_PAD_SD4_DAT1__PWM3_OUT	0x1b0b0
> +				MX6QDL_PAD_GPIO_2__GPIO1_IO02	0x1b0b0
> +			>;
> +		};
> +
> +		pinctrl_ecspi2: ecspi2grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_OE__ECSPI2_MISO 0x100b1
> +				MX6QDL_PAD_EIM_CS0__ECSPI2_SCLK 0x100b1
> +				MX6QDL_PAD_EIM_CS1__ECSPI2_MOSI 0x100b1
> +				MX6QDL_PAD_EIM_D24__GPIO3_IO24  0x100b1
> +			>;
> +		};
> +
> +		pinctrl_ecspi4: ecspi4grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_D21__ECSPI4_SCLK 0x100b1
> +				MX6QDL_PAD_EIM_D22__ECSPI4_MISO 0x100b1
> +				MX6QDL_PAD_EIM_D28__ECSPI4_MOSI 0x100b1
> +				MX6QDL_PAD_EIM_D20__GPIO3_IO20  0x100b1
> +				MX6QDL_PAD_SD4_DAT7__GPIO2_IO15 0x1b0b0 /* WP pin */
> +			>;
> +		};
> +
> +		pinctrl_enet: enetgrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_GPIO_16__ENET_REF_CLK 0x4001b0a8
> +				MX6QDL_PAD_ENET_MDIO__ENET_MDIO  0x1b0b0
> +				MX6QDL_PAD_ENET_MDC__ENET_MDC    0x1b0b0
> +				MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0 0x1b0b0
> +				MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1 0x1b0b0
> +				MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN   0x1b0b0
> +				MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER   0x1b0b0
> +				MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0 0x1b0b0
> +				MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1 0x1b0b0
> +				MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN  0x1b0b0
> +			>;
> +		};
> +
> +		pinctrl_flexcan1: flexcan1grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x80000000
> +				MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX	0x80000000
> +			>;
> +		};
> +
> +		pinctrl_flexcan2: flexcan2grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD3_DAT0__FLEXCAN2_TX 0x80000000
> +				MX6QDL_PAD_SD3_DAT1__FLEXCAN2_RX 0x80000000

Ditto.

Shawn

> +				>;
> +		};
> +
> +		pinctrl_gpmi_nand: gpminandgrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_NANDF_CLE__NAND_CLE     0xb0b1
> +				MX6QDL_PAD_NANDF_ALE__NAND_ALE     0xb0b1
> +				MX6QDL_PAD_NANDF_WP_B__NAND_WP_B   0xb0b1
> +				MX6QDL_PAD_NANDF_RB0__NAND_READY_B 0xb000
> +				MX6QDL_PAD_NANDF_CS0__NAND_CE0_B   0xb0b1
> +				MX6QDL_PAD_NANDF_CS1__NAND_CE1_B   0xb0b1
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
> +				MX6QDL_PAD_SD4_DAT0__NAND_DQS      0x00b1
> +			>;
> +		};
> +
> +		pinctrl_hog: hoggrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_D29__GPIO3_IO29   0x10
> +			>;
> +		};
> +
> +		pinctrl_i2c1: i2c1grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_CSI0_DAT8__I2C1_SDA 0x4001b8b1
> +				MX6QDL_PAD_CSI0_DAT9__I2C1_SCL 0x4001b8b1
> +			>;
> +		};
> +
> +		pinctrl_i2c2: i2c2grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b8b1
> +				MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b8b1
> +			>;
> +		};
> +
> +		pinctrl_i2c3: i2c3grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_D17__I2C3_SCL 0x4001b8b1
> +				MX6QDL_PAD_EIM_D18__I2C3_SDA 0x4001b8b1
> +			>;
> +		};
> +
> +		pinctrl_ipu_disp: ipudisp1grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK	0x10
> +				MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15		0x10
> +				MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02		0x10
> +				MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03		0x10
> +				MX6QDL_PAD_DI0_PIN4__GPIO4_IO20			0x20000
> +				MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00	0x10
> +				MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01	0x10
> +				MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02	0x10
> +				MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03	0x10
> +				MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04	0x10
> +				MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05	0x10
> +				MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06	0x10
> +				MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07	0x10
> +				MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08	0x10
> +				MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09	0x10
> +				MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10	0x10
> +				MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11	0x10
> +				MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12	0x10
> +				MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13	0x10
> +				MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14	0x10
> +				MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15	0x10
> +				MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16	0x10
> +				MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17	0x10
> +				MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18	0x10
> +				MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19	0x10
> +				MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20	0x10
> +				MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21	0x10
> +				MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22	0x10
> +				MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23	0x10
> +				>;
> +		};
> +
> +		pinctrl_uart2: uart2grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_D26__UART2_TX_DATA 0x1b0b1
> +				MX6QDL_PAD_EIM_D27__UART2_RX_DATA 0x1b0b1
> +			>;
> +		};
> +
> +		pinctrl_uart4: uart4grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_CSI0_DAT12__UART4_TX_DATA 0x1b0b1
> +				MX6QDL_PAD_CSI0_DAT13__UART4_RX_DATA 0x1b0b1
> +				MX6QDL_PAD_CSI0_DAT16__UART4_RTS_B 0x1b0b1
> +				MX6QDL_PAD_CSI0_DAT17__UART4_CTS_B 0x1b0b1
> +			>;
> +		};
> +
> +		pinctrl_uart5: uart5grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_CSI0_DAT14__UART5_TX_DATA 0x1b0b1
> +				MX6QDL_PAD_CSI0_DAT15__UART5_RX_DATA 0x1b0b1
> +			>;
> +		};
> +
> +		pinctrl_usbotg: usbotggrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x17059
> +			>;
> +		};
> +
> +		pinctrl_usdhc1: usdhc1grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17059
> +				MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10059
> +				MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17059
> +				MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17059
> +				MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17059
> +				MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17059
> +				MX6QDL_PAD_KEY_ROW0__GPIO4_IO07 0x1b0b0
> +			>;
> +		};
> +
> +		pinctrl_usdhc2: usdhc2grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_SD2_CMD__SD2_CMD    0x17059
> +				MX6QDL_PAD_SD2_CLK__SD2_CLK    0x10059
> +				MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x17059
> +				MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x17059
> +				MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x17059
> +				MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x17059
> +				MX6QDL_PAD_KEY_COL1__GPIO4_IO08 0x1b0b0
> +			>;
> +		};
> +	};
> +};
> -- 
> 1.8.3.1
> 
