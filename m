From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Mon, 18 Oct 2010 13:02:50 +0300
Subject: [PATCHv3] cpufreq for freescale mx51
In-Reply-To: <1287390105-3706-1-git-send-email-yong.shen@linaro.org>
References: <1287390105-3706-1-git-send-email-yong.shen@linaro.org>
Message-ID: <20101018100250.GB2562@matterhorn.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yong,

I get the following errors if I try to compile this with the Linaro toolchain.

In file included from
/home/amit/work/sources/linux-amit-upstream.git/arch/arm/plat-mxc/include/mach/hardware.h:63:0,
                 from
		 /home/amit/work/sources/linux-amit-upstream.git/arch/arm/plat-mxc/devices/platform-fec.c:10:
		 /home/amit/work/sources/linux-amit-upstream.git/arch/arm/plat-mxc/include/mach/mxc.h:139:2:
		 error: expected specifier-qualifier-list before ?u32?

Perhap following patch is required?

diff --git a/arch/arm/plat-mxc/include/mach/hardware.h
b/arch/arm/plat-mxc/include/mach/hardware.h
index ebadf4a..c9587fd 100644
--- a/arch/arm/plat-mxc/include/mach/hardware.h
+++ b/arch/arm/plat-mxc/include/mach/hardware.h
@@ -21,6 +21,7 @@
 #define __ASM_ARCH_MXC_HARDWARE_H__
  
   #include <asm/sizes.h>
   +#include <asm/types.h>


On 10 Oct 18, Yong Shen wrote:
> From: Yong Shen <yong.shen@linaro.org>
> 
> the operating points are tested on babbage 3.0
> 
> Signed-off-by: Yong Shen <yong.shen@linaro.org>
> ---
>  arch/arm/Kconfig                       |    6 +
>  arch/arm/mach-mx5/Kconfig              |    1 +
>  arch/arm/mach-mx5/Makefile             |    1 +
>  arch/arm/mach-mx5/board-mx51_babbage.c |   12 ++-
>  arch/arm/mach-mx5/clock-mx51.c         |   22 +++-
>  arch/arm/mach-mx5/cpu.c                |    2 +
>  arch/arm/mach-mx5/cpu_op-mx51.c        |   29 +++++
>  arch/arm/mach-mx5/cpu_op-mx51.h        |   14 +++
>  arch/arm/plat-mxc/Makefile             |    1 +
>  arch/arm/plat-mxc/cpufreq.c            |  202 ++++++++++++++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/mxc.h   |   20 +++-
>  11 files changed, 306 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm/mach-mx5/cpu_op-mx51.c
>  create mode 100644 arch/arm/mach-mx5/cpu_op-mx51.h
>  create mode 100644 arch/arm/plat-mxc/cpufreq.c
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e4ea9cb..d9ad605 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1692,6 +1692,12 @@ if ARCH_HAS_CPUFREQ
>  
>  source "drivers/cpufreq/Kconfig"

<snip>

> diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
> index a790bf2..888dddc 100644
> --- a/arch/arm/plat-mxc/include/mach/mxc.h
> +++ b/arch/arm/plat-mxc/include/mach/mxc.h
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
> + * Copyright 2004-2007, 2010 Freescale Semiconductor, Inc. All Rights Reserved.
>   * Copyright (C) 2008 Juergen Beisert (kernel at pengutronix.de)
>   *
>   * This program is free software; you can redistribute it and/or
> @@ -133,6 +133,24 @@ extern unsigned int __mxc_cpu_type;
>  # define cpu_is_mxc91231()	(0)
>  #endif
>  
> +#ifndef __ASSEMBLY__
> +
> +struct cpu_op {

struct mx51_cpu_op ?

IIUC, other I.MX SoCs use different 'variables' so this struct is
SoC-specific.

> +	u32 pll_reg;
> +	u32 pll_rate;
> +	u32 cpu_rate;
> +	u32 pdr0_reg;
> +	u32 pdf;
> +	u32 mfi;
> +	u32 mfd;
> +	u32 mfn;
> +	u32 cpu_voltage;
> +	u32 cpu_podf;
> +};
> +

Get rid of all members of struct cpu_op except cpu_rate for now. We can
re-add it later.

Also, I wonder if this struct and the external declaration should be moved
out to plat/mxc_cpufreq.h

> +extern struct cpu_op *(*get_cpu_op)(int *op);
> +#endif
> +
>  #if defined(CONFIG_ARCH_MX3) || defined(CONFIG_ARCH_MX2)
>  /* These are deprecated, use mx[23][157]_setup_weimcs instead. */
>  #define CSCR_U(n) (IO_ADDRESS(WEIM_BASE_ADDR + n * 0x10))
> -- 
> 1.6.3.3
