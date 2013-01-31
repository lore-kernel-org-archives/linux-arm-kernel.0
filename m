From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 31 Jan 2013 21:15:50 +0530
Subject: [PATCH v3 01/15] ARM: multi-cluster PM: secondary kernel entry
 code
In-Reply-To: <1359445870-18925-2-git-send-email-nicolas.pitre@linaro.org>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
 <1359445870-18925-2-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <510A91AE.6050807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 January 2013 01:20 PM, Nicolas Pitre wrote:
> CPUs in cluster based systems, such as big.LITTLE, have special needs
> when entering the kernel due to a hotplug event, or when resuming from
> a deep sleep mode.
>
> This is vectorized so multiple CPUs can enter the kernel in parallel
> without serialization.
>
> The mcpm prefix stands for "multi cluster power management", however
> this is usable on single cluster systems as well.  Only the basic
> structure is introduced here.  This will be extended with later patches.
>
> In order not to complexify things more than they currently have to,
> the planned work to make runtime adjusted MPIDR based indexing and
> dynamic memory allocation for cluster states is postponed to a later
> cycle. The MAX_NR_CLUSTERS and MAX_CPUS_PER_CLUSTER static definitions
> should be sufficient for those systems expected to be available in the
> near future.
>
'mcpm' sounds definitely better than 'bL' ;)

> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>   arch/arm/Kconfig                  |  8 ++++
>   arch/arm/common/Makefile          |  1 +
>   arch/arm/common/mcpm_entry.c      | 29 +++++++++++++
>   arch/arm/common/mcpm_head.S       | 86 +++++++++++++++++++++++++++++++++++++++
>   arch/arm/include/asm/mcpm_entry.h | 35 ++++++++++++++++
>   5 files changed, 159 insertions(+)
>   create mode 100644 arch/arm/common/mcpm_entry.c
>   create mode 100644 arch/arm/common/mcpm_head.S
>   create mode 100644 arch/arm/include/asm/mcpm_entry.h
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 67874b82a4..200f559c1c 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1584,6 +1584,14 @@ config HAVE_ARM_TWD
>   	help
>   	  This options enables support for the ARM timer and watchdog unit
>
> +config CLUSTER_PM
> +	bool "Cluster Power Management Infrastructure"
> +	depends on CPU_V7 && SMP
> +	help
> +	  This option provides the common power management infrastructure
> +	  for (multi-)cluster based systems, such as big.LITTLE based
> +	  systems.
> +
>   choice
>   	prompt "Memory split"
>   	default VMSPLIT_3G
> diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
> index e8a4e58f1b..23e85b1fae 100644
> --- a/arch/arm/common/Makefile
> +++ b/arch/arm/common/Makefile
> @@ -13,3 +13,4 @@ obj-$(CONFIG_SHARP_PARAM)	+= sharpsl_param.o
>   obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
>   obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
>   obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
> +obj-$(CONFIG_CLUSTER_PM)	+= mcpm_head.o mcpm_entry.o
> diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
> new file mode 100644
> index 0000000000..3a6d7e70fd
> --- /dev/null
> +++ b/arch/arm/common/mcpm_entry.c
> @@ -0,0 +1,29 @@
> +/*
> + * arch/arm/common/mcpm_entry.c -- entry point for multi-cluster PM
> + *
> + * Created by:  Nicolas Pitre, March 2012
> + * Copyright:   (C) 2012-2013  Linaro Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +
> +#include <asm/mcpm_entry.h>
> +#include <asm/barrier.h>
> +#include <asm/proc-fns.h>
> +#include <asm/cacheflush.h>
> +
> +extern volatile unsigned long mcpm_entry_vectors[MAX_NR_CLUSTERS][MAX_CPUS_PER_CLUSTER];
> +
> +void mcpm_set_entry_vector(unsigned cpu, unsigned cluster, void *ptr)
> +{
> +	unsigned long val = ptr ? virt_to_phys(ptr) : 0;
May be extra line would be good here.
Patch looks fine to my eyes otherwise.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
