From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 7 May 2015 06:25:08 +0200
Subject: [PATCH] arm, imx6, dts: add DT for aristainetos2 board
In-Reply-To: <1430899581-16252-1-git-send-email-hs@denx.de>
References: <1430899581-16252-1-git-send-email-hs@denx.de>
Message-ID: <20150507042508.GI6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 10:06:21AM +0200, Heiko Schocher wrote:
> This patch add support for the imx6dl based aristainetos2 board
> with following configuration:
> 
> CPU:   Freescale i.MX6DL rev1.1 at 792 MHz
> MReset cause: POR
> MBoard: aristaitenos2
> DRAM:  1 GiB
> NAND:  1024 MiB
> MMC:   FSL_SDHC: 0, FSL_SDHC: 1
> SF: Detected N25Q128A with page size 256 Bytes, erase size 64 KiB, total 16 MiB
> Display: lb07wv8 (800x480)
> 
> As this board can used with 2 different display types, the
> differences between them are extracted into 2 DTS files, and
> the common settings are collected in a common file.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> 
>  arch/arm/boot/dts/imx6dl-aristainetos2_4.dts | 124 ++++++
>  arch/arm/boot/dts/imx6dl-aristainetos2_7.dts |  63 +++
>  arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi | 631 +++++++++++++++++++++++++++
>  3 files changed, 818 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
>  create mode 100644 arch/arm/boot/dts/imx6dl-aristainetos2_7.dts
>  create mode 100644 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
> 

[...]

> +
> +&i2c1 {
> +	clock-frequency = <100000>;

I wonder why I see so many I2C nodes with this in this and other board
dts files. Are all these buses so slow? Why not 400000? Also 100000 is
the default anyway.

> +
> +	gpio {
> +		pinctrl_gpio: gpiogrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25	0x1b0b0 /* led enable */
> +				MX6QDL_PAD_EIM_BCLK__GPIO6_IO31		0x1b0b0 /* backlight enable */
> +				MX6QDL_PAD_NANDF_CS2__GPIO6_IO15	0x1b0b0 /* LCD power enable */
> +				MX6QDL_PAD_NANDF_CS3__GPIO6_IO16	0x1b0b0 /* led yellow */
> +				MX6QDL_PAD_EIM_EB0__GPIO2_IO28		0x1b0b0 /* led red */
> +				MX6QDL_PAD_EIM_A24__GPIO5_IO04		0x1b0b0 /* led green */
> +				MX6QDL_PAD_EIM_EB1__GPIO2_IO29		0x1b0b0 /* led blue */
> +				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00		0x1b0b0 /* Profibus IRQ */
> +				MX6QDL_PAD_SD3_DAT6__GPIO6_IO18		0x1b0b0 /* FPGA IRQ */
> +				MX6QDL_PAD_EIM_A23__GPIO6_IO06		0x1b0b0 /* spi bus #2 SS driver enable */
> +				MX6QDL_PAD_GPIO_18__GPIO7_IO13		0x1b0b0 /* RST_LOC# PHY reset input (has pull-down!)*/
> +				MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID	0x1b0b0 /* USB_OTG_ID = GPIO1_24*/
> +				MX6QDL_PAD_SD3_RST__GPIO7_IO08		0x1b0b0 /* SD2 level shifter output enable */
> +				MX6QDL_PAD_ENET_RXD0__GPIO1_IO27	0x1b0b0 /* SD1 card detect input */
> +				MX6QDL_PAD_DI0_PIN4__GPIO4_IO20		0x1b0b0 /* SD1 write protect input */
> +				MX6QDL_PAD_GPIO_19__GPIO4_IO05		0x1b0b0 /* SD2 card detect input */
> +				MX6QDL_PAD_SD4_DAT2__GPIO2_IO10		0x1b0b0 /* SD2 write protect input */

Shouldn't the SD specific pins in the usdhc nodes below? Also backlight
enable, LEDs could also be moved to the corresponding device nodes.

> +				MX6QDL_PAD_SD4_DAT1__GPIO2_IO09		0x1b0b0 /* Touchscreen IRQ */
> +				MX6QDL_PAD_EIM_A22__GPIO2_IO16		0x1b0b0 /* PCIe reset */
> +			>;
> +		};
> +	};
> +
> +	gpmi-nand {
> +		pinctrl_gpmi_nand: gpmi-nand {
> +			fsl,pins = <
> +				MX6QDL_PAD_NANDF_CLE__NAND_CLE     0xb0b1
> +				MX6QDL_PAD_NANDF_ALE__NAND_ALE     0xb0b1
> +				MX6QDL_PAD_NANDF_WP_B__NAND_WP_B   0xb0b1
> +				MX6QDL_PAD_NANDF_RB0__NAND_READY_B 0xb000
> +				MX6QDL_PAD_NANDF_CS0__NAND_CE0_B   0xb0b1
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
> +			>;
> +		};
> +	};
> +
> +	i2c1 {
> +		pinctrl_i2c1: i2c1grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_CSI0_DAT8__I2C1_SDA 0x4001b8b1
> +				MX6QDL_PAD_CSI0_DAT9__I2C1_SCL 0x4001b8b1
> +			>;
> +		};
> +	};
> +
> +	i2c2 {
> +		pinctrl_i2c2: i2c2grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b8b1
> +				MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b8b1
> +			>;
> +		};
> +	};
> +
> +	i2c3 {
> +		pinctrl_i2c3: i2c3grp {
> +			fsl,pins = <
> +			MX6QDL_PAD_GPIO_5__I2C3_SCL 0x4001b8b1
> +			MX6QDL_PAD_GPIO_6__I2C3_SDA 0x4001b8b1
> +			>;

Please check the indentation here and in some other pinctrl nodes.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
