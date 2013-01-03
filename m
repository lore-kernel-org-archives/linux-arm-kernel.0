From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 3 Jan 2013 15:46:12 +0800
Subject: [PATCH 1/2] ARM: mx25pdk: Add device tree support
In-Reply-To: <1355262464-25401-1-git-send-email-festevam@gmail.com>
References: <1355262464-25401-1-git-send-email-festevam@gmail.com>
Message-ID: <20130103074610.GC2566@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 11, 2012 at 07:47:43PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Add basic device tree support for mx25pdk board.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt |    4 +++
>  arch/arm/boot/dts/Makefile                    |    3 +-
>  arch/arm/boot/dts/imx25-pdk.dts               |   44 +++++++++++++++++++++++++

Please follow how patch "ARM: dts: imx: use nodes label in board dts"
does to create board level dts.  To rebase your patch on my imx/dt
branch will be reasonable.

>  3 files changed, 50 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/imx25-pdk.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
> index f798187..b98530c 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.txt
> +++ b/Documentation/devicetree/bindings/arm/fsl.txt
> @@ -5,6 +5,10 @@ i.MX23 Evaluation Kit
>  Required root node properties:
>      - compatible = "fsl,imx23-evk", "fsl,imx23";
>  
> +i.MX25 Product Evaluation Kit
> +Required root node properties:
> +    - compatible = "fsl,imx25-pdk", "fsl,imx25";
> +
>  i.MX28 Evaluation Kit
>  Required root node properties:
>      - compatible = "fsl,imx28-evk", "fsl,imx28";
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 2beab0c..b2df1e7 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -79,7 +79,8 @@ dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
>  	armada-370-mirabox.dtb \
>  	armada-xp-db.dtb \
>  	armada-xp-openblocks-ax3-4.dtb
> -dtb-$(CONFIG_ARCH_MXC) += imx51-babbage.dtb \
> +dtb-$(CONFIG_ARCH_MXC) += imx25-pdk.dtb \
> +	imx51-babbage.dtb \
>  	imx53-ard.dtb \
>  	imx53-evk.dtb \
>  	imx53-qsb.dtb \
> diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
> new file mode 100644
> index 0000000..bcdd393
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx25-pdk.dts
> @@ -0,0 +1,44 @@
> +/*
> + * Copyright 2012 Freescale Semiconductor, Inc.
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
> +/include/ "imx25.dtsi"
> +
> +/ {
> +	model = "Freescale i.MX25 Product Development Kit";
> +	compatible = "freescale,imx25pdk", "fsl,imx25";

s/freescale,imx25pdk/fsl,imx25-pdk

> +
> +	memory {
> +		reg = <0x80000000 0x4000000>;
> +	};
> +
> +	soc {
> +		aips at 43f00000 {
> +			uart1: serial at 43f90000 {
> +				status = "okay";
> +			};
> +		};
> +
> +		spba at 50000000 {
> +			fec: ethernet at 50038000 {
> +				status = "okay";

Let "status" be the last one.

Shawn

> +				phy-mode = "rmii";
> +			};
> +		};
> +
> +		emi at 80000000 {
> +			nand at bb000000 {
> +				nand-on-flash-bbt;
> +				status = "okay";
> +			};
> +		};
> +	};
> +};
> -- 
> 1.7.9.5
> 
