From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 17 Jan 2013 16:14:04 +0800
Subject: [PATCH V3] Add apf51 basic support
In-Reply-To: <1358183774-4810-1-git-send-email-laurent.cans@gmail.com>
References: <1358183774-4810-1-git-send-email-laurent.cans@gmail.com>
Message-ID: <20130117081401.GA26185@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 06:16:14PM +0100, Laurent Cans wrote:
> Signed-off-by: Laurent Cans <laurent.cans@gmail.com>
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> ---
> Differences between v2 and v3
> - remove nand device
> Differences between v1 and v2
> - change board name according project convention
> - remove useless compatible properties
> - add project copyright
> - use device name instead of soc structure for description
> - add an entry for the board on documentation
> 
>  Documentation/devicetree/bindings/arm/fsl.txt |    4 ++
>  arch/arm/boot/dts/Makefile                    |    3 +-
>  arch/arm/boot/dts/imx51-apf51.dts             |   55 +++++++++++++++++++++++++
>  arch/arm/boot/dts/imx51.dtsi                  |   30 ++++++++++++++
>  4 files changed, 91 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/imx51-apf51.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
> index f798187..2549252 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.txt
> +++ b/Documentation/devicetree/bindings/arm/fsl.txt
> @@ -13,6 +13,10 @@ i.MX51 Babbage Board
>  Required root node properties:
>      - compatible = "fsl,imx51-babbage", "fsl,imx51";
>  
> +i.MX51 APF51 Board
> +Required root node properties:
> +    - compatible = "fsl,imx51-apf51", "fsl,imx51";
> +

fsl.txt is used to documented the boards that are manufactured by
Freescale.

>  i.MX53 Automotive Reference Design Board
>  Required root node properties:
>      - compatible = "fsl,imx53-ard", "fsl,imx53";
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index e44da40..1acf809 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -79,7 +79,8 @@ dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
>  	armada-370-mirabox.dtb \
>  	armada-xp-db.dtb \
>  	armada-xp-openblocks-ax3-4.dtb
> -dtb-$(CONFIG_ARCH_MXC) += imx51-babbage.dtb \
> +dtb-$(CONFIG_ARCH_MXC) += imx51-apf51.dtb \
> +	imx51-babbage.dtb \
>  	imx53-ard.dtb \
>  	imx53-evk.dtb \
>  	imx53-qsb.dtb \
> diff --git a/arch/arm/boot/dts/imx51-apf51.dts b/arch/arm/boot/dts/imx51-apf51.dts
> new file mode 100644
> index 0000000..9239e07
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx51-apf51.dts
> @@ -0,0 +1,55 @@
> +/*
> + * Copyright 2012 Armadeus Systems - <support@armadeus.com>
> + * Copyright 2012 Laurent Cans <laurent.cans@gmail.com>
> + *
> + * Based on mx51-babbage.dts
> + * Copyright 2011 Freescale Semiconductor, Inc.
> + * Copyright 2011 Linaro Ltd.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +/include/ "imx51.dtsi"
> +
> +/ {
> +	model = "Armadeus Systems APF51 module";
> +	compatible = "fsl,imx51-apf51", "fsl,imx51";

Replace fsl,imx51-apf51 with something like armadeus,imx51-apf51.

Shawn

> +
> +	memory {
> +		reg = <0x90000000 0x20000000>;
> +	};
> +
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <0>;

These two lines are not needed, since they are already in imx51.dtsi.

Shawn

> +
> +		ckih1 {
> +			clock-frequency = <0>;
> +		};
> +
> +		osc {
> +			clock-frequency = <33554432>;
> +		};
> +	};
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec_2>;
> +	phy-mode = "mii";
> +	phy-reset-gpios = <&gpio3 0 0>;
> +	phy-reset-duration = <1>;
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3_2>;
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> index 1f5d45e..8427279 100644
> --- a/arch/arm/boot/dts/imx51.dtsi
> +++ b/arch/arm/boot/dts/imx51.dtsi
> @@ -273,6 +273,29 @@
>  							260 0x80000000	/* MX51_PAD_NANDF_RDY_INT__FEC_TX_CLK */
>  						>;
>  					};
> +
> +					pinctrl_fec_2: fecgrp-2 {
> +						fsl,pins = <
> +							589 0x80000000 /* MX51_PAD_DI_GP3__FEC_TX_ER */
> +							592 0x80000000 /* MX51_PAD_DI2_PIN4__FEC_CRS */
> +							594 0x80000000 /* MX51_PAD_DI2_PIN2__FEC_MDC */
> +							596 0x80000000 /* MX51_PAD_DI2_PIN3__FEC_MDIO */
> +							598 0x80000000 /* MX51_PAD_DI2_DISP_CLK__FEC_RDATA1 */
> +							602 0x80000000 /* MX51_PAD_DI_GP4__FEC_RDATA2 */
> +							604 0x80000000 /* MX51_PAD_DISP2_DAT0__FEC_RDATA3 */
> +							609 0x80000000 /* MX51_PAD_DISP2_DAT1__FEC_RX_ER */
> +							618 0x80000000 /* MX51_PAD_DISP2_DAT6__FEC_TDATA1 */
> +							623 0x80000000 /* MX51_PAD_DISP2_DAT7__FEC_TDATA2 */
> +							628 0x80000000 /* MX51_PAD_DISP2_DAT8__FEC_TDATA3 */
> +							634 0x80000000 /* MX51_PAD_DISP2_DAT9__FEC_TX_EN */
> +							639 0x80000000 /* MX51_PAD_DISP2_DAT10__FEC_COL */
> +							644 0x80000000 /* MX51_PAD_DISP2_DAT11__FEC_RX_CLK */
> +							649 0x80000000 /* MX51_PAD_DISP2_DAT12__FEC_RX_DV */
> +							653 0x80000000 /* MX51_PAD_DISP2_DAT13__FEC_TX_CLK */
> +							657 0x80000000 /* MX51_PAD_DISP2_DAT14__FEC_RDATA0 */
> +							662 0x80000000 /* MX51_PAD_DISP2_DAT15__FEC_TDATA0 */
> +						>;
> +					};
>  				};
>  
>  				ecspi1 {
> @@ -409,6 +432,13 @@
>  							49 0x1c5	/* MX51_PAD_EIM_D24__UART3_CTS */
>  						>;
>  					};
> +
> +					pinctrl_uart3_2: uart3grp-2 {
> +						fsl,pins = <
> +							434 0x1c5	/* MX51_PAD_UART3_RXD__UART3_RXD */
> +							430 0x1c5	/* MX51_PAD_UART3_TXD__UART3_TXD */
> +						>;
> +					};
>  				};
>  			};
>  
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
