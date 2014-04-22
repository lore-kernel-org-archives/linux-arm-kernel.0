From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 22 Apr 2014 00:08:37 -0400 (EDT)
Subject: [PATCH v3 07/13] ARM: hisi: add hip04 SoC support
In-Reply-To: <1397801156-25682-8-git-send-email-haojian.zhuang@linaro.org>
References: <1397801156-25682-1-git-send-email-haojian.zhuang@linaro.org>
 <1397801156-25682-8-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <alpine.LFD.2.11.1404212323440.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Apr 2014, Haojian Zhuang wrote:

> Hisilicon Hi3xxx is based on Cortex A9 Core. Now HiP04 SoC is based on
> Cortex A15 Core. Since multiple clusters is used in HiP04 SoC, it could
> be based on MCPM.
> 
> And HiP04 supports LPAE to support large memory.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

I'm providing review comments on the MCPM parts only.

> ---
>  arch/arm/Kconfig               |   2 +-
>  arch/arm/mach-hisi/Kconfig     |   9 +-
>  arch/arm/mach-hisi/Makefile    |   1 +
>  arch/arm/mach-hisi/core.h      |   2 +
>  arch/arm/mach-hisi/hisilicon.c |  12 ++
>  arch/arm/mach-hisi/platmcpm.c  | 334 +++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 358 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-hisi/platmcpm.c
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index f2a25be..2961627 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1113,7 +1113,7 @@ source arch/arm/mm/Kconfig
>  
>  config ARM_NR_BANKS
>  	int
> -	default 16 if ARCH_EP93XX
> +	default 16 if ARCH_EP93XX || ARCH_HIP04
>  	default 8
>  
>  config IWMMXT
> diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
> index da16efd..0bfd739 100644
> --- a/arch/arm/mach-hisi/Kconfig
> +++ b/arch/arm/mach-hisi/Kconfig
> @@ -17,7 +17,14 @@ config ARCH_HI3xxx
>  	select PINCTRL
>  	select PINCTRL_SINGLE
>  	help
> -	  Support for Hisilicon Hi36xx/Hi37xx processor family
> +	  Support for Hisilicon Hi36xx/Hi37xx SoC family
> +
> +config ARCH_HIP04
> +	bool "Hisilicon HiP04 Cortex A15 family" if ARCH_MULTI_V7_LPAE
> +	select HAVE_ARM_ARCH_TIMER
> +	select MCPM if SMP

This is where you should select MCPM_QUAD_CLUSTER as well.

> +	help
> +	  Support for Hisilicon HiP04 SoC family
>  
>  endmenu
>  
[...]
> diff --git a/arch/arm/mach-hisi/platmcpm.c b/arch/arm/mach-hisi/platmcpm.c
> new file mode 100644
> index 0000000..4ac8d4b
> --- /dev/null
> +++ b/arch/arm/mach-hisi/platmcpm.c
> @@ -0,0 +1,334 @@
> +/*
> + * Copyright (c) 2013-2014 Linaro Ltd.
> + * Copyright (c) 2013-2014 Hisilicon Limited.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + */
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/memblock.h>
> +#include <linux/of_address.h>
> +
> +#include <asm/cputype.h>
> +#include <asm/cp15.h>
> +#include <asm/mcpm.h>
> +
> +#include "core.h"
> +
> +/* bits definition in SC_CPU_RESET_REQ[x]/SC_CPU_RESET_DREQ[x]
> + * 1 -- unreset; 0 -- reset
> + */
> +#define CORE_RESET_BIT(x)		(1 << x)
> +#define NEON_RESET_BIT(x)		(1 << (x + 4))
> +#define CORE_DEBUG_RESET_BIT(x)		(1 << (x + 9))
> +#define CLUSTER_L2_RESET_BIT		(1 << 8)
> +#define CLUSTER_DEBUG_RESET_BIT		(1 << 13)
> +
> +/*
> + * bits definition in SC_CPU_RESET_STATUS[x]
> + * 1 -- reset status; 0 -- unreset status
> + */
> +#define CORE_RESET_STATUS(x)		(1 << x)
> +#define NEON_RESET_STATUS(x)		(1 << (x + 4))
> +#define CORE_DEBUG_RESET_STATUS(x)	(1 << (x + 9))
> +#define CLUSTER_L2_RESET_STATUS		(1 << 8)
> +#define CLUSTER_DEBUG_RESET_STATUS	(1 << 13)
> +#define CORE_WFI_STATUS(x)		(1 << (x + 16))
> +#define CORE_WFE_STATUS(x)		(1 << (x + 20))
> +#define CORE_DEBUG_ACK(x)		(1 << (x + 24))
> +
> +#define SC_CPU_RESET_REQ(x)		(0x520 + (x << 3))	/* reset */
> +#define SC_CPU_RESET_DREQ(x)		(0x524 + (x << 3))	/* unreset */
> +#define SC_CPU_RESET_STATUS(x)		(0x1520 + (x << 3))
> +
> +#define FAB_SF_MODE			0x0c
> +#define FAB_SF_INVLD			0x10
> +
> +/* bits definition in FB_SF_INVLD */
> +#define FB_SF_INVLD_START		(1 << 8)
> +
> +#define HIP04_MAX_CLUSTERS		4
> +#define HIP04_MAX_CPUS_PER_CLUSTER	4
> +
> +#define POLL_MSEC	10
> +#define TIMEOUT_MSEC	1000
> +
> +struct hip04_secondary_cpu_data {
> +	u32	bootwrapper_phys;
> +	u32	bootwrapper_size;
> +	u32	bootwrapper_magic;
> +	u32	relocation_entry;
> +	u32	relocation_size;
> +};
> +
> +static void __iomem *relocation, *sysctrl, *fabric;
> +static int hip04_cpu_table[HIP04_MAX_CLUSTERS][HIP04_MAX_CPUS_PER_CLUSTER];
> +static DEFINE_SPINLOCK(boot_lock);
> +static struct hip04_secondary_cpu_data hip04_boot;
> +
> +static bool hip04_cluster_down(unsigned int cluster)
> +{
> +	int i;
> +
> +	for (i = 0; i < HIP04_MAX_CPUS_PER_CLUSTER; i++)
> +		if (hip04_cpu_table[cluster][i])
> +			return false;
> +	return true;
> +}
> +
> +static void hip04_set_snoop_filter(unsigned int cluster, unsigned int on)
> +{
> +	unsigned long data;
> +
> +	if (!fabric)
> +		return;
> +	data = readl_relaxed(fabric + FAB_SF_MODE);
> +	if (on)
> +		data |= 1 << cluster;
> +	else
> +		data &= ~(1 << cluster);
> +	writel_relaxed(data, fabric + FAB_SF_MODE);
> +	while (1) {
> +		if (data == readl_relaxed(fabric + FAB_SF_MODE))
> +			break;
> +	}
> +}
> +
> +static int hip04_mcpm_power_up(unsigned int cpu, unsigned int cluster)
> +{
> +	unsigned long data, mask;
> +
> +	if (!relocation || !sysctrl)
> +		return -ENODEV;
> +	if (cluster >= HIP04_MAX_CLUSTERS || cpu >= HIP04_MAX_CPUS_PER_CLUSTER)
> +		return -EINVAL;
> +
> +	spin_lock(&boot_lock);

This is called in interruptible context.  Surely you want 
spin_lock_irq() here.

> +	writel_relaxed(hip04_boot.bootwrapper_phys, relocation);
> +	writel_relaxed(hip04_boot.bootwrapper_magic, relocation + 4);
> +	writel_relaxed(virt_to_phys(mcpm_entry_point), relocation + 8);
> +	writel_relaxed(0, relocation + 12);
> +
> +	if (hip04_cluster_down(cluster)) {
> +		data = CLUSTER_L2_RESET_BIT | CLUSTER_DEBUG_RESET_BIT;
> +		writel_relaxed(data, sysctrl + SC_CPU_RESET_DREQ(cluster));
> +		do {
> +			mask = CLUSTER_L2_RESET_STATUS | \
> +			       CLUSTER_DEBUG_RESET_STATUS;
> +			data = readl_relaxed(sysctrl + \
> +					     SC_CPU_RESET_STATUS(cluster));
> +		} while (data & mask);
> +		hip04_set_snoop_filter(cluster, 1);
> +	}
> +
> +	hip04_cpu_table[cluster][cpu]++;
> +
> +	data = CORE_RESET_BIT(cpu) | NEON_RESET_BIT(cpu) | \
> +	       CORE_DEBUG_RESET_BIT(cpu);
> +	writel_relaxed(data, sysctrl + SC_CPU_RESET_DREQ(cluster));

It might be a good idea to reset and initialize things only if 
hip04_cpu_table[cluster][cpu] was zero initially.  Please see the 
comment in mcpm_cpu_power_down() discussing concurrent up/down 
operations, and the way races are handled using dcscb_use_count in 
dcscb_power_up() / dcscb_power_down() for example.

> +	spin_unlock(&boot_lock);
> +	msleep(POLL_MSEC);

You don't have to wait here.  The MCPM up method should set things for 
the CPU to come up eventually and that CPU to signal itself when it is 
finally online.

> +	return 0;
> +}
> +
> +static void hip04_mcpm_power_down(void)
> +{
> +	unsigned int mpidr, cpu, cluster;
> +	unsigned int v;
> +
> +	mpidr = read_cpuid_mpidr();
> +	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +
> +	spin_lock(&boot_lock);
> +	BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
> +	__mcpm_cpu_going_down(cpu, cluster);
> +
> +	hip04_cpu_table[cluster][cpu]--;
> +	if (hip04_cpu_table[cluster][cpu]) {
> +		pr_err("Cluster %d CPU%d is still running\n", cluster, cpu);
> +		goto out;
> +	}

This is wrong.  Please see dcscb_power_down() or tc2_pm_down() for 
examples of how to deal with this situation.

> +	__mcpm_cpu_down(cpu, cluster);

That call should happen last i.e. after coherency has been disabled and 
the CPU is about to call WFI.  Again, see the TC2 implementation for 
example.  You may also read 
Documentation/arm/cluster-pm-race-avoidance.txt for more details about 
those calls and the algorithm behind them.

> +	spin_unlock(&boot_lock);
> +
> +	asm volatile(
> +	"	mrc	p15, 0, %0, c1, c0, 0\n"
> +	"	bic	%0, %0, %1\n"
> +	"	mcr	p15, 0, %0, c1, c0, 0\n"
> +	  : "=&r" (v)
> +	  : "Ir" (CR_C)
> +	  :);
> +
> +	flush_cache_louis();
> +
> +	asm volatile(
> +	/* Turn off coherency, disable SMP bit in ACTLR */
> +	"	mrc	p15, 0, %0, c1, c0, 1\n"
> +	"	bic	%0, %0, %1\n"
> +	"	mcr	p15, 0, %0, c1, c0, 1\n"
> +	: "=&r" (v)
> +	: "Ir" (0x40)
> +	:);

The above code is not safe.

You should use v7_exit_coherency_flush() instead.

> +	isb();
> +	dsb();
> +
> +	while (true)
> +		wfi();

This is wrong.  By the time execution gets here, it is well possible 
that another CPU decided that this CPU should not be down anymore, in 
which case wfi() will return.  See what's expected in this case by 
looking at mcpm_cpu_power_down() and what other backend implementations 
do.

> +	return;
> +out:
> +	spin_unlock(&boot_lock);
> +}
> +
> +static int hip04_mcpm_wait_for_powerdown(unsigned int cpu, unsigned int cluster)
> +{
> +	unsigned int data, tries;
> +
> +	BUG_ON(cluster >= HIP04_MAX_CLUSTERS ||
> +	       cpu >= HIP04_MAX_CPUS_PER_CLUSTER);
> +
> +	for (tries = 0; tries < TIMEOUT_MSEC / POLL_MSEC; tries++) {
> +		data = readl_relaxed(sysctrl + SC_CPU_RESET_STATUS(cluster));
> +		if (!(data & CORE_WFI_STATUS(cpu))) {
> +			msleep(POLL_MSEC);
> +			continue;
> +		}
> +		data = CORE_RESET_BIT(cpu) | NEON_RESET_BIT(cpu) | \
> +		       CORE_DEBUG_RESET_BIT(cpu);
> +		writel_relaxed(data, sysctrl + SC_CPU_RESET_REQ(cluster));

Why are you resetting those here?

> +		return 0;
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static void hip04_mcpm_powered_up(void)
> +{
> +	if (!relocation)
> +		return;
> +	spin_lock(&boot_lock);
> +	writel_relaxed(0, relocation);
> +	writel_relaxed(0, relocation + 4);
> +	writel_relaxed(0, relocation + 8);
> +	writel_relaxed(0, relocation + 12);
> +	spin_unlock(&boot_lock);
> +}
> +
> +static const struct mcpm_platform_ops hip04_mcpm_ops = {
> +	.power_up		= hip04_mcpm_power_up,
> +	.power_down		= hip04_mcpm_power_down,
> +	.wait_for_powerdown	= hip04_mcpm_wait_for_powerdown,
> +	.powered_up		= hip04_mcpm_powered_up,
> +};
> +
> +static bool __init hip04_cpu_table_init(void)
> +{
> +	unsigned int mpidr, cpu, cluster;
> +
> +	mpidr = read_cpuid_mpidr();
> +	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +
> +	if (cluster >= HIP04_MAX_CLUSTERS ||
> +	    cpu >= HIP04_MAX_CPUS_PER_CLUSTER) {
> +		pr_err("%s: boot CPU is out of bound!\n", __func__);
> +		return false;
> +	}
> +	hip04_set_snoop_filter(cluster, 1);
> +	hip04_cpu_table[cluster][cpu] = 1;
> +	return true;
> +}
> +
> +static int __init hip04_mcpm_init(void)
> +{
> +	struct device_node *np, *np_fab;
> +	int ret = -ENODEV;
> +
> +	np = of_find_compatible_node(NULL, NULL, "hisilicon,sysctrl");
> +	if (!np)
> +		goto err;
> +	np_fab = of_find_compatible_node(NULL, NULL, "hisilicon,hip04-fabric");
> +	if (!np_fab)
> +		goto err;
> +
> +	if (of_property_read_u32(np, "bootwrapper-phys",
> +				 &hip04_boot.bootwrapper_phys)) {
> +		pr_err("failed to get bootwrapper-phys\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +	if (of_property_read_u32(np, "bootwrapper-size",
> +				 &hip04_boot.bootwrapper_size)) {
> +		pr_err("failed to get bootwrapper-size\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +	if (of_property_read_u32(np, "bootwrapper-magic",
> +				 &hip04_boot.bootwrapper_magic)) {
> +		pr_err("failed to get bootwrapper-magic\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +	if (of_property_read_u32(np, "relocation-entry",
> +				 &hip04_boot.relocation_entry)) {
> +		pr_err("failed to get relocation-entry\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +	if (of_property_read_u32(np, "relocation-size",
> +				 &hip04_boot.relocation_size)) {
> +		pr_err("failed to get relocation-size\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	relocation = ioremap(hip04_boot.relocation_entry,
> +			     hip04_boot.relocation_size);
> +	if (!relocation) {
> +		pr_err("failed to map relocation space\n");
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +	sysctrl = of_iomap(np, 0);
> +	if (!sysctrl) {
> +		pr_err("failed to get sysctrl base\n");
> +		ret = -ENOMEM;
> +		goto err_sysctrl;
> +	}
> +	fabric = of_iomap(np_fab, 0);
> +	if (!fabric) {
> +		pr_err("failed to get fabric base\n");
> +		ret = -ENOMEM;
> +		goto err_fabric;
> +	}
> +
> +	memblock_reserve(hip04_boot.bootwrapper_phys,
> +			 hip04_boot.bootwrapper_size);
> +
> +	if (!hip04_cpu_table_init())
> +		return -EINVAL;
> +	ret = mcpm_platform_register(&hip04_mcpm_ops);
> +	if (!ret) {
> +		mcpm_sync_init(NULL);
> +		pr_info("HiP04 MCPM initialized\n");
> +	}
> +	return ret;
> +err_fabric:
> +	iounmap(sysctrl);
> +err_sysctrl:
> +	iounmap(relocation);
> +err:
> +	return ret;
> +}
> +early_initcall(hip04_mcpm_init);
> +
> +bool __init hip04_smp_init_ops(void)
> +{
> +	mcpm_smp_set_ops();
> +	return true;
> +}
> -- 
> 1.8.3.2
> 
