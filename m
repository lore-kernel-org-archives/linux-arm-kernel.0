From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 9 Aug 2016 20:58:32 +0800
Subject: [PATCH v2 2/2] ARM: dts: TS-4900: add basic device tree
In-Reply-To: <1470060293-28517-3-git-send-email-lucile.quirion@savoirfairelinux.com>
References: <1470060293-28517-1-git-send-email-lucile.quirion@savoirfairelinux.com>
 <1470060293-28517-3-git-send-email-lucile.quirion@savoirfairelinux.com>
Message-ID: <20160809125832.GT4678@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 01, 2016 at 10:04:53AM -0400, Lucile Quirion wrote:
> diff --git a/arch/arm/boot/dts/imx6dl-ts4900.dts b/arch/arm/boot/dts/imx6dl-ts4900.dts
> new file mode 100644
> index 0000000..909fd5c
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-ts4900.dts

<snip>

> +/dts-v1/;
> +#include "imx6dl.dtsi"
> +#include "imx6qdl-ts4900.dtsi"
> +#include <dt-bindings/interrupt-controller/irq.h>

Is this header really needed here?

> +
> +/ {
> +	model = "Technologic Systems i.MX6 Solo/DualLite TS-4900 (Default Device Tree)";
> +	compatible = "technologic,imx6dl-ts4900", "fsl,imx6dl";
> +};
> diff --git a/arch/arm/boot/dts/imx6q-ts4900.dts b/arch/arm/boot/dts/imx6q-ts4900.dts
> new file mode 100644
> index 0000000..0d482bf
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-ts4900.dts

<snip>

> +/dts-v1/;
> +#include "imx6q.dtsi"
> +#include "imx6qdl-ts4900.dtsi"
> +#include <dt-bindings/interrupt-controller/irq.h>

Ditto

> +
> +/ {
> +	model = "Technologic Systems i.MX6 Quad TS-4900 (Default Device Tree)";
> +	compatible = "technologic,imx6q-ts4900", "fsl,imx6q";
> +};
> +
> +&sata {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx6qdl-ts4900.dtsi b/arch/arm/boot/dts/imx6qdl-ts4900.dtsi
> new file mode 100644
> index 0000000..0026214
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6qdl-ts4900.dtsi

<snip>

> +&ecspi1 {
> +	fsl,spi-num-chipselects = <1>;
> +	cs-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi1>;
> +	status = "okay";
> +
> +	flash: n25q064 at 0 {
> +		compatible = "micron,n25q064", "jedec,spi-nor";
> +		spi-max-frequency = <20000000>;
> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		partition at 0000000 {
> +			label = "U-Boot";
> +			reg = <0x0000000 0x0100000>;
> +		};
> +		partition at 0100000 {
> +			label = "env";
> +			reg = <0x0100000 0x0020000>;
> +		};
> +		partition at 0400000 {
> +			label = "user-data";
> +			reg = <0x0400000 0x0400000>;
> +		};

Do not put partition table into mainline DTS file.

> +	};
> +};
> +
> +&ecspi2 {
> +	fsl,spi-num-chipselects = <1>;
> +	cs-gpios = <&gpio6 2 GPIO_ACTIVE_HIGH>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi2>;
> +	status = "okay";
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet>;
> +	phy-mode = "rgmii";
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	pinctrl-1 = <&pinctrl_i2c1_gpio>;
> +	scl-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
> +	sda-gpios = <&gpio3 28 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +
> +	rtc: isl12022 at 6f {

	isl12022: rtc at 6f

> +		compatible = "isil,isl12022";
> +		reg = <0x6f>;
> +	};
> +};
> +
> +&i2c2 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	pinctrl-1 = <&pinctrl_i2c2_gpio>;
> +	scl-gpios = <&gpio4 12 GPIO_ACTIVE_HIGH>;
> +	sda-gpios = <&gpio4 13 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;
> +
> +	pinctrl_ecspi1: ecspi1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_D17__ECSPI1_MISO		0x100b1
> +			MX6QDL_PAD_EIM_D18__ECSPI1_MOSI		0x100b1
> +			MX6QDL_PAD_EIM_D16__ECSPI1_SCLK		0x100b1
> +			MX6QDL_PAD_EIM_D19__GPIO3_IO19		0x100b1 /* Onboard flash CS1# */
> +		>;
> +	};
> +
> +	pinctrl_ecspi2: ecspi2 {
> +		fsl,pins = <
> +			MX6QDL_PAD_CSI0_DAT8__ECSPI2_SCLK	0x100b1
> +			MX6QDL_PAD_CSI0_DAT9__ECSPI2_MOSI	0x100b1
> +			MX6QDL_PAD_CSI0_DAT10__ECSPI2_MISO	0x100b1
> +			MX6QDL_PAD_CSI0_DAT11__GPIO5_IO29	0x100b1 /* Offboard CS0# */
> +			MX6QDL_PAD_CSI0_DAT16__GPIO6_IO02	0x100b1 /* FPGA CS1# */
> +			MX6QDL_PAD_CSI0_VSYNC__GPIO5_IO21	0x1b0b1 /* FPGA_RESET# */
> +			MX6QDL_PAD_CSI0_DATA_EN__GPIO5_IO20	0x1b0b1 /* FPGA_DONE */
> +			MX6QDL_PAD_GPIO_3__XTALOSC_REF_CLK_24M	0x10    /* FPGA 24MHZ */
> +			MX6QDL_PAD_GPIO_4__GPIO1_IO04		0x1b0b1 /* FPGA_IRQ */
> +		>;
> +	};
> +
> +	pinctrl_enet: enet {
> +		fsl,pins = <
> +			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
> +			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
> +			MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x1b0b0

There are no SPEED field for RGMII pads.  See Uwe's patch below for
details.

http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/442465.html

> +			MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b0b0
> +			MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b0b0
> +			MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b0b0
> +			MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b0b0
> +			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b0b0
> +			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b0
> +			MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b0b0
> +			MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x1b0b0
> +			MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x1b0b0
> +			MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b0b0
> +			MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b0b0
> +			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b0b0
> +			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x4001b0a8
> +			MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28	0x1b0b1
> +			MX6QDL_PAD_DI0_PIN4__GPIO4_IO20		0x1b0b1 /* ETH_PHY_RESET */
> +		>;
> +	};

<snip>

> +	pinctrl_uart1: uart1-grp {

uart1grp

> +		fsl,pins = <
> +			MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
> +			MX6QDL_PAD_SD3_DAT6__UART1_RX_DATA	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2-grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_7__UART2_TX_DATA	0x1b0b1
> +			MX6QDL_PAD_GPIO_8__UART2_RX_DATA	0x1b0b1
> +			MX6QDL_PAD_SD4_DAT6__UART2_CTS_B	0x1b0b1
> +			MX6QDL_PAD_SD4_DAT5__UART2_RTS_B	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_uart3: uart3-grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b1
> +			MX6QDL_PAD_EIM_D25__UART3_RX_DATA	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_uart4: uart4-grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_KEY_COL0__UART4_TX_DATA	0x1b0b1
> +			MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_uart5: uart5-grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_KEY_COL1__UART5_TX_DATA	0x1b0b1
> +			MX6QDL_PAD_KEY_ROW1__UART5_RX_DATA	0x1b0b1
> +		>;
> +	};

<snip>

> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	fsl,uart-has-rtscts;

This vendor specific property is deprecated.  Please use
uart-has-rtscts instead.

> +	status = "okay";
> +};

<snip>

> +/* SD */
> +&usdhc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	vmmc-supply = <&reg_3p3v>;
> +	bus-width = <4>;
> +	fsl,wp-controller;
> +	status = "okay";
> +};
> +
> +/* eMMC */
> +&usdhc3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	vmmc-supply = <&reg_3p3v>;
> +	bus-width = <4>;
> +	fsl,wp-controller;

WP for an eMMC?

Shawn

> +	non-removable;
> +	status = "okay";
> +};
> -- 
> 2.5.5
