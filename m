From: robh@kernel.org (Rob Herring)
Date: Tue, 8 Dec 2015 09:16:11 -0600
Subject: [PATCH 8/8] ARM: dts: imx7d: sbc-imx7: add basic board support
In-Reply-To: <1449472479-2521-9-git-send-email-ilya@compulab.co.il>
References: <1449472479-2521-1-git-send-email-ilya@compulab.co.il>
 <1449472479-2521-9-git-send-email-ilya@compulab.co.il>
Message-ID: <20151208151611.GA22609@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 09:14:39AM +0200, Ilya Ledvich wrote:
> SBC-iMX7 is a single board computer designed for industrial
> and embedded applications. It is based on the Freescale i.MX7
> system-on-chip. SBC-iMX7 is implemented with the CL-SOM-iMX7
> System-on-Module providing most of the functions, and SB-SOM-iMX7
> carrier board providing additional peripheral functions and
> connectors.
> 
> http://www.compulab.co.il/products/sbcs/sbc-imx7-freescale-i-mx-7-single-board-computer/
> 
> http://www.compulab.co.il/products/computer-on-modules/cl-som-imx7-freescale-i-mx-7-system-on-module/
> 
> Add basic board support, including SD card as a secondary boot and storage device
> 
> Signed-off-by: Ilya Ledvich <ilya@compulab.co.il>
> Acked-by: Igor Grinberg <grinberg@compulab.co.il>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/arm/fsl.txt |  4 +++
>  arch/arm/boot/dts/Makefile                    |  1 +
>  arch/arm/boot/dts/imx7d-sbc-imx7.dts          | 43 +++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx7d-sbc-imx7.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
> index 30b0ba1..15307d3 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.txt
> +++ b/Documentation/devicetree/bindings/arm/fsl.txt
> @@ -57,6 +57,10 @@ i.MX7D CL-SOM-iMX7 Board
>  Required root node properties:
>      - compatible = "compulab,cl-som-imx7", "fsl,imx7d";
>  
> +i.MX7D SBC-iMX7 Single Board Computer
> +Required root node properties:
> +    - compatible = "compulab,sbc-imx7", "compulab,cl-som-imx7", "fsl,imx7d";
> +
>  Generic i.MX boards
>  -------------------
>  
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 83ed521..72ef172 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -351,6 +351,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
>  	imx6ul-14x14-evk.dtb
>  dtb-$(CONFIG_SOC_IMX7D) += \
>  	imx7d-cl-som-imx7.dtb \
> +	imx7d-sbc-imx7.dtb \
>  	imx7d-sdb.dtb
>  dtb-$(CONFIG_SOC_LS1021A) += \
>  	ls1021a-qds.dtb \
> diff --git a/arch/arm/boot/dts/imx7d-sbc-imx7.dts b/arch/arm/boot/dts/imx7d-sbc-imx7.dts
> new file mode 100644
> index 0000000..3d5384a
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx7d-sbc-imx7.dts
> @@ -0,0 +1,43 @@
> +/*
> + * Support for CompuLab SBC-iMX7 Single Board Computer
> + *
> + * Copyright (C) 2015 CompuLab Ltd. - http://www.compulab.co.il/
> + * Author: Ilya Ledvich <ilya@compulab.co.il>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +#include "imx7d-cl-som-imx7.dts"
> +
> +/ {
> +	model = "CompuLab SBC-iMX7";
> +	compatible = "compulab,sbc-imx7", "compulab,cl-som-imx7", "fsl,imx7d";
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	cd-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
> +	wp-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
> +	enable-sdio-wakeup;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	cl-som-imx7 {
> +		pinctrl_usdhc1: usdhc1grp {
> +			fsl,pins = <
> +				MX7D_PAD_SD1_CMD__SD1_CMD		0x59
> +				MX7D_PAD_SD1_CLK__SD1_CLK		0x19
> +				MX7D_PAD_SD1_DATA0__SD1_DATA0		0x59
> +				MX7D_PAD_SD1_DATA1__SD1_DATA1		0x59
> +				MX7D_PAD_SD1_DATA2__SD1_DATA2		0x59
> +				MX7D_PAD_SD1_DATA3__SD1_DATA3		0x59
> +				MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x59 /* CD */
> +				MX7D_PAD_SD1_WP__GPIO5_IO1		0x59 /* WP */
> +			>;
> +		};
> +	};
> +};
> -- 
> 1.9.1
> 
