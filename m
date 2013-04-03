From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 3 Apr 2013 16:50:26 +0800
Subject: [PATCH] ARM: dts: Add initial support for Wandboard Dual-Lite
In-Reply-To: <1364964462-19143-1-git-send-email-festevam@gmail.com>
References: <1364964462-19143-1-git-send-email-festevam@gmail.com>
Message-ID: <20130403085025.GR24039@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 03, 2013 at 01:47:42AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Wandboard is a development board that has two variants: one version based
> on mx6 dual lite and another one based on mx6 solo.
> 
> For more details about Wandboard, please refer to: http://www.wandboard.org/
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/Makefile              |    1 +
>  arch/arm/boot/dts/imx6dl-wandboard.dtsp |   40 +++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx6dl.dtsip          |   11 +++++++++
>  3 files changed, 52 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6dl-wandboard.dtsp
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 5345ac1..a566619 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -100,6 +100,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
>  	imx53-smd.dtb \
>  	imx6dl-sabreauto.dtb \
>  	imx6dl-sabresd.dtb \
> +	imx6dl-wandboard.dtb \
>  	imx6q-arm2.dtb \
>  	imx6q-sabreauto.dtb \
>  	imx6q-sabrelite.dtb \
> diff --git a/arch/arm/boot/dts/imx6dl-wandboard.dtsp b/arch/arm/boot/dts/imx6dl-wandboard.dtsp
> new file mode 100644
> index 0000000..e95d2b0
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-wandboard.dtsp
> @@ -0,0 +1,40 @@
> +/*
> + * Copyright 2013 Freescale Semiconductor, Inc.
> + *
> + * Author: Fabio Estevam <fabio.estevam@freescale.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +/dts-v1/;
> +#include "imx6dl.dtsip"
> +
> +/ {
> +	model = "Wandboard i.MX6 Dual Lite Board";
> +	compatible = "wand,imx6dl-wandboard", "fsl,imx6q";

"fsl,imx6dl" please.

> +
> +	memory {
> +		reg = <0x10000000 0x40000000>;
> +	};
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet_1>;
> +	phy-mode = "rgmii";
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1_1>;
> +	status = "okay";
> +};
> +
> +&usdhc3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc3_4pin>;

Unlike mxs that pin groups are defined per function, imx simply defines
pin groups per controller.  So please just follow the pattern to use
something like pinctrl_usdhc3_2.

Shawn

> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx6dl.dtsip b/arch/arm/boot/dts/imx6dl.dtsip
> index 951ba53..2e6cff0 100644
> --- a/arch/arm/boot/dts/imx6dl.dtsip
> +++ b/arch/arm/boot/dts/imx6dl.dtsip
> @@ -136,6 +136,17 @@
>  							MX6DL_PAD_SD3_DAT7__SD3_DATA7 0x17059
>  						>;
>  					};
> +
> +					pinctrl_usdhc3_4pin: usdhc3grp-4pin {
> +						fsl,pins = <
> +							MX6DL_PAD_SD3_CMD__SD3_CMD    0x17059
> +							MX6DL_PAD_SD3_CLK__SD3_CLK    0x10059
> +							MX6DL_PAD_SD3_DAT0__SD3_DATA0 0x17059
> +							MX6DL_PAD_SD3_DAT1__SD3_DATA1 0x17059
> +							MX6DL_PAD_SD3_DAT2__SD3_DATA2 0x17059
> +							MX6DL_PAD_SD3_DAT3__SD3_DATA3 0x17059
> +						>;
> +					};
>  				};
>  
>  
> -- 
> 1.7.9.5
> 
