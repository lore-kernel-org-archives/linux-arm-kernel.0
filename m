From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 17 Jun 2018 14:44:03 +0800
Subject: [PATCH v1] ARM: imx: add imx7d-m4
In-Reply-To: <20180405115134.8036-1-o.rempel@pengutronix.de>
References: <20180405115134.8036-1-o.rempel@pengutronix.de>
Message-ID: <20180617064402.GI16091@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 05, 2018 at 01:51:34PM +0200, Oleksij Rempel wrote:
> Provide basic support for Cortex-M4 located on NXP iMX7D.
> This code was tested in combination with imx-rproc driver
> which will upload with specially formatted ELF image containing
> kernel, device and CPIO rootfs.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  arch/arm/boot/dts/Makefile         |  2 +-
>  arch/arm/mach-imx/Kconfig          | 33 +++++++++++++++++++++------------
>  arch/arm/mach-imx/Makefile         |  3 ++-
>  arch/arm/mach-imx/mach-imx7d-cm4.c | 21 +++++++++++++++++++++
>  4 files changed, 45 insertions(+), 14 deletions(-)
>  create mode 100644 arch/arm/mach-imx/mach-imx7d-cm4.c
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 852452515bea..d49bb9a58aee 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -527,7 +527,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
>  	imx6ul-tx6ul-0011.dtb \
>  	imx6ul-tx6ul-mainboard.dtb \
>  	imx6ull-14x14-evk.dtb
> -dtb-$(CONFIG_SOC_IMX7D) += \
> +dtb-$(CONFIG_SOC_IMX7D_CA7) += \

I would keep this unchanged, and have future IMX7D_CM4 DTBs just
covered by CONFIG_SOC_IMX7D as well.

Shawn

>  	imx7d-cl-som-imx7.dtb \
>  	imx7d-colibri-emmc-eval-v3.dtb \
>  	imx7d-colibri-eval-v3.dtb \
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 782699e67600..101c8599d952 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -528,18 +528,6 @@ config SOC_IMX6UL
>  	help
>  	  This enables support for Freescale i.MX6 UltraLite processor.
>  
> -config SOC_IMX7D
> -	bool "i.MX7 Dual support"
> -	select PINCTRL_IMX7D
> -	select ARM_GIC
> -	select HAVE_ARM_ARCH_TIMER
> -	select HAVE_IMX_ANATOP
> -	select HAVE_IMX_MMDC
> -	select HAVE_IMX_SRC
> -	select IMX_GPCV2
> -	help
> -		This enables support for Freescale i.MX7 Dual processor.
> -
>  config SOC_LS1021A
>  	bool "Freescale LS1021A support"
>  	select ARM_GIC
> @@ -554,6 +542,27 @@ comment "Cortex-A/Cortex-M asymmetric multiprocessing platforms"
>  
>  if ARCH_MULTI_V7 || ARM_SINGLE_ARMV7M
>  
> +config SOC_IMX7D_CA7
> +	bool
> +	select ARM_GIC
> +	select HAVE_ARM_ARCH_TIMER
> +	select HAVE_IMX_ANATOP
> +	select HAVE_IMX_MMDC
> +	select HAVE_IMX_SRC
> +	select IMX_GPCV2
> +
> +config SOC_IMX7D_CM4
> +	bool
> +	select ARMV7M_SYSTICK
> +
> +config SOC_IMX7D
> +	bool "i.MX7 Dual support"
> +	select PINCTRL_IMX7D
> +	select SOC_IMX7D_CA7 if ARCH_MULTI_V7
> +	select SOC_IMX7D_CM4 if ARM_SINGLE_ARMV7M
> +	help
> +		This enables support for Freescale i.MX7 Dual processor.
> +
>  config SOC_VF610
>  	bool "Vybrid Family VF610 support"
>  	select ARM_GIC if ARCH_MULTI_V7
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index 8ff71058207d..68640f100ef3 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -80,7 +80,8 @@ obj-$(CONFIG_SOC_IMX6Q) += mach-imx6q.o
>  obj-$(CONFIG_SOC_IMX6SL) += mach-imx6sl.o
>  obj-$(CONFIG_SOC_IMX6SX) += mach-imx6sx.o
>  obj-$(CONFIG_SOC_IMX6UL) += mach-imx6ul.o
> -obj-$(CONFIG_SOC_IMX7D) += mach-imx7d.o
> +obj-$(CONFIG_SOC_IMX7D_CA7) += mach-imx7d.o
> +obj-$(CONFIG_SOC_IMX7D_CM4) += mach-imx7d-cm4.o
>  
>  ifeq ($(CONFIG_SUSPEND),y)
>  AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
> diff --git a/arch/arm/mach-imx/mach-imx7d-cm4.c b/arch/arm/mach-imx/mach-imx7d-cm4.c
> new file mode 100644
> index 000000000000..c36dea79aeb8
> --- /dev/null
> +++ b/arch/arm/mach-imx/mach-imx7d-cm4.c
> @@ -0,0 +1,21 @@
> +/*
> + * Copyright 2017 Pengutronix
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <asm/v7m.h>
> +#include <asm/mach/arch.h>
> +
> +static const char * const imx7d_cm4_dt_compat[] __initconst = {
> +	"fsl,imx7d-cm4",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(IMX7D, "Freescale i.MX7 Dual Cortex-M4 (Device Tree)")
> +	.dt_compat = imx7d_cm4_dt_compat,
> +	.restart = armv7m_restart,
> +MACHINE_END
> -- 
> 2.16.1
> 
