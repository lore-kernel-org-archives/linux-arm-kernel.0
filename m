From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 23 Sep 2016 13:17:29 +0100
Subject: [PATCH 1/2] armv8: aarch32: Execute 32-bit Linux for LayerScape
 platforms
In-Reply-To: <1474597146-33312-1-git-send-email-b18965@freescale.com>
References: <1474597146-33312-1-git-send-email-b18965@freescale.com>
Message-ID: <f4195baa-907d-2c00-eb62-d4452ed749c8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alison,

On 23/09/16 03:19, Alison Wang wrote:
> The ARMv8 architecture supports:
> 1. 64-bit execution state, AArch64.
> 2. 32-bit execution state, AArch32, that is compatible with previous
> versions of the ARM architecture.
> 
> LayerScape platforms are compliant with ARMv8 architecture. This patch
> is to support running 32-bit Linux kernel for LayerScape platforms.
> 
> Verified on LayerScape LS1043ARDB, LS1012ARDB, LS1046ARDB boards.
> 
> Signed-off-by: Ebony Zhu <ebony.zhu@nxp.com>
> Signed-off-by: Alison Wang <alison.wang@nxp.com>
> ---
>  arch/arm/Kconfig                    |  9 +++++++++
>  arch/arm/mach-imx/Kconfig           | 14 ++++++++++++++
>  arch/arm/mach-imx/Makefile          |  4 +++-
>  arch/arm/mach-imx/mach-layerscape.c | 23 +++++++++++++++++++++++
>  4 files changed, 49 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/mach-imx/mach-layerscape.c
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index f0c8068..e8d470e 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -294,6 +294,15 @@ config PGTABLE_LEVELS
>  	default 3 if ARM_LPAE
>  	default 2
>  
> +config ARCH_AARCH32_ES_SUPPORT
> +	def_bool n
> +	help
> +	 The ARMv8 architecture supports 64-bit execution state, AArch64
> +	 and 32-bit execution state, AArch32, that is compatible with
> +	 previous versions of the ARM architecture.
> +
> +	 Enable AArch32 execution state support for ARMv8 architecture.

What's this supposed to do, exactly? I've been running 32-bit kernels on
my Juno with very little issue (beyond a couple of DT tweaks, and some
firmware hacks with a corresponding bit of A64 assembly tacked on the
front of the zImage to switch into AArch32 state).

Robin.

> +
>  source "init/Kconfig"
>  
>  source "kernel/Kconfig.freezer"
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 0ac05a0..fda4f5f 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -549,6 +549,20 @@ config SOC_LS1021A
>  	help
>  	  This enables support for Freescale LS1021A processor.
>  
> +config ARCH_LAYERSCAPE_AARCH32
> +	bool "Freescale Layerscape SoC AArch32 ES support"
> +	select ARCH_AARCH32_ES_SUPPORT
> +	select ARM_AMBA
> +	select ARM_GIC
> +	select ARM_ARCH_TIMER
> +	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
> +	select PCI_LAYERSCAPE if PCI
> +	select PCI_DOMAINS if PCI
> +
> +	help
> +	  This enables support for Freescale Layerscape SoC family in
> +	  in AArch32 execution state.
> +
>  endif
>  
>  comment "Cortex-A/Cortex-M asymmetric multiprocessing platforms"
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index 737450f..7ded4fa 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -69,7 +69,7 @@ obj-$(CONFIG_HAVE_IMX_ANATOP) += anatop.o
>  obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
>  obj-$(CONFIG_HAVE_IMX_MMDC) += mmdc.o
>  obj-$(CONFIG_HAVE_IMX_SRC) += src.o
> -ifneq ($(CONFIG_SOC_IMX6)$(CONFIG_SOC_LS1021A),)
> +ifneq ($(CONFIG_SOC_IMX6)$(CONFIG_SOC_LS1021A)$(CONFIG_ARCH_LAYERSCAPE_AARCH32),)
>  AFLAGS_headsmp.o :=-Wa,-march=armv7-a
>  obj-$(CONFIG_SMP) += headsmp.o platsmp.o
>  obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
> @@ -96,4 +96,6 @@ obj-$(CONFIG_SOC_VF610) += mach-vf610.o
>  
>  obj-$(CONFIG_SOC_LS1021A) += mach-ls1021a.o
>  
> +obj-$(CONFIG_ARCH_LAYERSCAPE_AARCH32) += mach-layerscape.o
> +
>  obj-y += devices/
> diff --git a/arch/arm/mach-imx/mach-layerscape.c b/arch/arm/mach-imx/mach-layerscape.c
> new file mode 100644
> index 0000000..acfb2a2
> --- /dev/null
> +++ b/arch/arm/mach-imx/mach-layerscape.c
> @@ -0,0 +1,23 @@
> +/*
> + * Copyright 2015-2016 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <asm/mach/arch.h>
> +
> +#include "common.h"
> +
> +static const char * const layerscape_dt_compat[] __initconst = {
> +	"fsl,ls1012a",
> +	"fsl,ls1043a",
> +	"fsl,ls1046a",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(LAYERSCAPE_AARCH32, "Freescale LAYERSCAPE")
> +	.dt_compat	= layerscape_dt_compat,
> +MACHINE_END
> 
