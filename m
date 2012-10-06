From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 6 Oct 2012 21:03:46 +0800
Subject: [PATCH] ARM: dts: imx6q-sabreauto: Add basic support
In-Reply-To: <1348615018-14465-1-git-send-email-festevam@gmail.com>
References: <1348615018-14465-1-git-send-email-festevam@gmail.com>
Message-ID: <20121006130344.GE20231@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 08:16:58PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> mx6qsabreauto is a board based on mx6q SoC with the following features:
> - 2GB of DDR3
> - 2 USB ports
> - 1 HDMI output port
> - SPI NOR
> - 2 LVDS LCD ports
> - Gigabit Ethernet
> - Camera
> - eMMC and SD card slot
> - Multichannel Audio
> - CAN
> - SATA
> - NAND
> - PCIE
> - Video Input
> 
> Add very basic support for it. 
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt |    4 ++
>  arch/arm/boot/dts/imx6q-sabreauto.dts         |   65 +++++++++++++++++++++++++

Add imx6q-sabreauto.dtb into arch/arm/boot/dts/Makefile.

>  2 files changed, 69 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6q-sabreauto.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
> index ac9e751..f798187 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.txt
> +++ b/Documentation/devicetree/bindings/arm/fsl.txt
> @@ -41,6 +41,10 @@ i.MX6 Quad SABRE Smart Device Board
>  Required root node properties:
>      - compatible = "fsl,imx6q-sabresd", "fsl,imx6q";
>  
> +i.MX6 Quad SABRE Automotive Board
> +Required root node properties:
> +    - compatible = "fsl,imx6q-sabreauto", "fsl,imx6q";
> +
>  Generic i.MX boards
>  -------------------
>  
> diff --git a/arch/arm/boot/dts/imx6q-sabreauto.dts b/arch/arm/boot/dts/imx6q-sabreauto.dts
> new file mode 100644
> index 0000000..d18d25e
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-sabreauto.dts
> @@ -0,0 +1,65 @@
> +/*
> + * Copyright 2012 Freescale Semiconductor, Inc.
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
> +/include/ "imx6q.dtsi"
> +
> +/ {
> +	model = "Freescale i.MX6Q Sabre Automotive Board";

s/i.MX6Q Sabre/i.MX6 Quad SABRE, to align with imx6q-sabrelite.dts?

> +	compatible = "fsl,imx6q-sabreauto", "fsl,imx6q";
> +
> +	memory {
> +		reg = <0x10000000 0x80000000>;
> +	};
> +
> +	soc {
> +		aips-bus at 02000000 { /* AIPS1 */
> +

Drop the new line.

> +			iomuxc at 020e0000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_hog>;
> +
> +				hog {
> +					pinctrl_hog: hoggrp {
> +						fsl,pins = <
> +							1376 0x80000000	/* MX6Q_PAD_NANDF_CS2__GPIO_6_15 */
> +							13   0x80000000	/* MX6Q_PAD_SD2_DAT2__GPIO_1_13 */
> +						>;
> +					};
> +				};
> +			};
> +		};
> +
> +		aips-bus at 02100000 { /* AIPS2 */
> +			uart4: serial at 021f0000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_uart4_1>;
> +				status = "okay";
> +			};
> +
> +			ethernet at 02188000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_enet_2>;
> +				phy-mode = "rgmii";
> +				status = "okay";
> +			};
> +
> +			usdhc at 02198000 { /* uSDHC3 */
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_usdhc3_1>;
> +				cd-gpios = <&gpio6 15 0>;
> +				wp-gpios = <&gpio1 13 0>;
> +				status = "okay";
> +			};
> +		};
> +	};
> +};
> -- 
> 1.7.9.5
> 
