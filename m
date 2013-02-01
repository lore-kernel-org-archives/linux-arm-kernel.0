From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 1 Feb 2013 11:08:41 +0530
Subject: [PATCH v3 06/15] ARM: mcpm: generic SMP secondary bringup and
 hotplug support
In-Reply-To: <1359445870-18925-7-git-send-email-nicolas.pitre@linaro.org>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
 <1359445870-18925-7-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <510B54E1.1080707@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 January 2013 01:21 PM, Nicolas Pitre wrote:
> Now that the cluster power API is in place, we can use it for SMP secondary
> bringup and CPU hotplug in a generic fashion.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>   arch/arm/common/Makefile       |  2 +-
>   arch/arm/common/mcpm_platsmp.c | 85 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 86 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/common/mcpm_platsmp.c
>
> diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
> index c901a38c59..e1c9db45de 100644
> --- a/arch/arm/common/Makefile
> +++ b/arch/arm/common/Makefile
> @@ -13,4 +13,4 @@ obj-$(CONFIG_SHARP_PARAM)	+= sharpsl_param.o
>   obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
>   obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
>   obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
> -obj-$(CONFIG_CLUSTER_PM)	+= mcpm_head.o mcpm_entry.o vlock.o
> +obj-$(CONFIG_CLUSTER_PM)	+= mcpm_head.o mcpm_entry.o mcpm_platsmp.o vlock.o
> diff --git a/arch/arm/common/mcpm_platsmp.c b/arch/arm/common/mcpm_platsmp.c
> new file mode 100644
> index 0000000000..401298f5ee
> --- /dev/null
> +++ b/arch/arm/common/mcpm_platsmp.c
> @@ -0,0 +1,85 @@
> +/*
> + * linux/arch/arm/mach-vexpress/mcpm_platsmp.c
> + *
> + * Created by:  Nicolas Pitre, November 2012
> + * Copyright:   (C) 2012-2013  Linaro Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Code to handle secondary CPU bringup and hotplug for the cluster power API.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/smp.h>
> +
> +#include <asm/mcpm_entry.h>
> +#include <asm/smp_plat.h>
> +#include <asm/hardware/gic.h>
> +
> +static void __init simple_smp_init_cpus(void)
> +{
> +	set_smp_cross_call(gic_raise_softirq);
> +}
> +
> +static int __cpuinit mcpm_boot_secondary(unsigned int cpu, struct task_struct *idle)
> +{
> +	unsigned int mpidr, pcpu, pcluster, ret;
> +	extern void secondary_startup(void);
> +
> +	mpidr = cpu_logical_map(cpu);
> +	pcpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +	pcluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +	pr_debug("%s: logical CPU %d is physical CPU %d cluster %d\n",
> +		 __func__, cpu, pcpu, pcluster);
> +
> +	mcpm_set_entry_vector(pcpu, pcluster, NULL);
> +	ret = mcpm_cpu_power_up(pcpu, pcluster);
> +	if (ret)
> +		return ret;
> +	mcpm_set_entry_vector(pcpu, pcluster, secondary_startup);
> +	gic_raise_softirq(cpumask_of(cpu), 0);
> +	dsb_sev();
> +	return 0;
> +}
> +
> +static void __cpuinit mcpm_secondary_init(unsigned int cpu)
> +{
> +	mcpm_cpu_powered_up();
> +	gic_secondary_init(0);
This gic init should not be needed with Catalin's notifier
series. Some thing to be removed based on when that series
gets in.

Reviewed-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
