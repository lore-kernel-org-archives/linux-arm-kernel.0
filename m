From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 22 Apr 2014 15:18:23 -0400 (EDT)
Subject: [PATCH v2 2/3] arm: exynos: Add MCPM call-back functions
In-Reply-To: <1398147435-3122-1-git-send-email-a.kesavan@samsung.com>
References: <1397239311-27717-6-git-send-email-a.kesavan@samsung.com>
 <1398147435-3122-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <alpine.LFD.2.11.1404221428070.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Apr 2014, Abhilash Kesavan wrote:

> Add machine-dependent MCPM call-backs for Exynos5420. These are used
> to power up/down the secondary CPUs during boot, shutdown, s2r and
> switching.
> 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Inderpal Singh <inderpal.s@samsung.com>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>

Getting there!  See comments below.

[...]
> diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
> new file mode 100644
> index 0000000..49b9031
> --- /dev/null
> +++ b/arch/arm/mach-exynos/mcpm-exynos.c
> @@ -0,0 +1,345 @@
> +/*
> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * arch/arm/mach-exynos/mcpm-exynos.c
> + *
> + * Based on arch/arm/mach-vexpress/dcscb.c
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +#include <linux/spinlock.h>
> +#include <linux/uaccess.h>
> +#include <linux/miscdevice.h>
> +#include <linux/fs.h>
> +#include <linux/delay.h>
> +#include <linux/arm-cci.h>
> +
> +#include <asm/mcpm.h>
> +#include <asm/cputype.h>
> +#include <asm/cp15.h>
> +
> +#include <plat/cpu.h>
> +#include "regs-pmu.h"
> +
> +#define EXYNOS5420_CPUS_PER_CLUSTER	4
> +#define EXYNOS5420_NR_CLUSTERS		2
> +
> +/* Secondary CPU entry point */
> +#define REG_ENTRY_ADDR		(S5P_VA_SYSRAM_NS + 0x1C)
> +
> +#define EXYNOS_CORE_LOCAL_PWR_EN		0x3
> +#define EXYNOS_CORE_LOCAL_PWR_DIS		0x0
> +
> +#define EXYNOS_ARM_COMMON_CONFIGURATION		S5P_PMUREG(0x2500)
> +#define EXYNOS_ARM_L2_CONFIGURATION		S5P_PMUREG(0x2600)
> +
> +#define EXYNOS_ARM_CORE_CONFIGURATION(_nr)	\
> +			(S5P_ARM_CORE0_CONFIGURATION + ((_nr) * 0x80))
> +#define EXYNOS_ARM_CORE_STATUS(_nr)		\
> +			(S5P_ARM_CORE0_STATUS + ((_nr) * 0x80))
> +
> +#define EXYNOS_COMMON_CONFIGURATION(_nr)	\
> +			(EXYNOS_ARM_COMMON_CONFIGURATION + ((_nr) * 0x80))
> +#define EXYNOS_COMMON_STATUS(_nr)		\
> +			(EXYNOS_COMMON_CONFIGURATION(_nr) + 0x4)
> +
> +#define EXYNOS_L2_CONFIGURATION(_nr)		\
> +			(EXYNOS_ARM_L2_CONFIGURATION + ((_nr) * 0x80))
> +#define EXYNOS_L2_STATUS(_nr)			\
> +			(EXYNOS_L2_CONFIGURATION(_nr) + 0x4)
> +
> +/*
> + * The common v7_exit_coherency_flush API could not be used because of the
> + * Erratum 799270 workaround. This macro is the same as the common one (in
> + * arch/arm/include/asm/cacheflush.h) except for the erratum handling.
> + */
> +#define exynos_v7_exit_coherency_flush(level) \
> +	asm volatile( \
> +	"stmfd	sp!, {fp, ip}\n\t"\
> +	"mrc	p15, 0, r0, c1, c0, 0	@ get SCTLR\n\t" \
> +	"bic	r0, r0, #"__stringify(CR_C)"\n\t" \
> +	"mcr	p15, 0, r0, c1, c0, 0	@ set SCTLR\n\t" \
> +	"isb\n\t"\
> +	"bl	v7_flush_dcache_"__stringify(level)"\n\t" \
> +	"clrex\n\t"\
> +	"mrc	p15, 0, r0, c1, c0, 1	@ get ACTLR\n\t" \
> +	"bic	r0, r0, #(1 << 6)	@ disable local coherency\n\t" \
> +	/* Dummy Load of a device register to avoid Erratum 799270 */ \
> +	"ldr	r4, [%0]\n\t" \
> +	"and	r4, r4, #0\n\t" \
> +	"orr	r0, r0, r4\n\t" \
> +	"mcr	p15, 0, r0, c1, c0, 1	@ set ACTLR\n\t" \
> +	"isb\n\t" \
> +	"dsb\n\t" \
> +	"ldmfd	sp!, {fp, ip}" \
> +	: \
> +	: "Ir" (S5P_INFORM0) \
> +	: "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", \
> +	  "r9", "r10", "lr", "memory")
> +
> +/*
> + * We can't use regular spinlocks. In the switcher case, it is possible
> + * for an outbound CPU to call power_down() after its inbound counterpart
> + * is already live using the same logical CPU number which trips lockdep
> + * debugging.
> + */
> +static arch_spinlock_t exynos_mcpm_lock = __ARCH_SPIN_LOCK_UNLOCKED;
> +static int
> +cpu_use_count[EXYNOS5420_CPUS_PER_CLUSTER][EXYNOS5420_NR_CLUSTERS];
> +
> +static bool exynos_core_power_state(unsigned int cpu, unsigned int cluster)
> +{
> +	unsigned int val;
> +	unsigned int cpunr = cpu + (cluster * EXYNOS5420_CPUS_PER_CLUSTER);
> +
> +	val = __raw_readl(EXYNOS_ARM_CORE_STATUS(cpunr)) &
> +				EXYNOS_CORE_LOCAL_PWR_EN;
> +	return !!val;
> +}
> +
> +static void exynos_core_power_control(unsigned int cpu, unsigned int cluster,
> +						int enable)
> +{
> +	unsigned int val = EXYNOS_CORE_LOCAL_PWR_DIS;
> +	unsigned int cpunr = cpu + (cluster * EXYNOS5420_CPUS_PER_CLUSTER);
> +
> +	if (exynos_core_power_state(cpu, cluster) == enable)
> +		return;

I think this isn't right.

Normally, the power _status_ and the power _control_ are not always in 
sync.  It is possible for the power control to be set to OFF but the
status won't reflect that until the CPU has executed WFI for example.

Here we don't care about the actual status.  What matters is the 
control.  In the exynos_power_up case, if the control bit says "power 
off" but the status bit says "it isn't off yet" then the code won't turn 
the control bit back on.

For example, it should be possible for CPU1 to call exynos_power_up() 
while CPU0 is still executing code in exynos_power_down() right after 
releasing exynos_mcpm_lock but before WFI is executed.  There is a cache 
flush during that window which might take some time to execute, making 
this scenario more likely that you might think.

What we want here is simply to set the power control bit back on.  No 
need to test its previous status as the value of cpu_use_count already 
reflects it.  And if the affected CPU didn't reach WFI yet, then the 
execution of WFI will simply return and the CPU will be soft rebooted.

And in the exynos_power_down() case the CPU turning the control bit off 
is always doing so for itself, therefore its status bit must obviously 
show that it is running.  Testing it is therefore redundant.

Therefore you should be able to simplify this greatly.

> +	if (enable)
> +		val = EXYNOS_CORE_LOCAL_PWR_EN;
> +	__raw_writel(val, EXYNOS_ARM_CORE_CONFIGURATION(cpunr));
> +}
> +
> +static void exynos_cluster_power_control(unsigned int cluster, int enable)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(20);
> +	unsigned int status, val = EXYNOS_CORE_LOCAL_PWR_DIS;
> +
> +	if (enable)
> +		val = EXYNOS_CORE_LOCAL_PWR_EN;
> +
> +	status = __raw_readl(EXYNOS_COMMON_STATUS(cluster));
> +	if ((status & EXYNOS_CORE_LOCAL_PWR_EN) == val)
> +		return;

Same comment as above.  You shouldn't need to check current status 
before adjusting the wanted control.  If you get here that's because the 
control is never what you want it to be.

> +	__raw_writel(val, EXYNOS_COMMON_CONFIGURATION(cluster));
> +	/* Wait until cluster power control is applied */
> +	while (time_before(jiffies, timeout)) {
> +		status = __raw_readl(EXYNOS_COMMON_STATUS(cluster));
> +
> +		if ((status & EXYNOS_CORE_LOCAL_PWR_EN) == val)
> +			return;
> +
> +		cpu_relax();
> +	}

As mentioned in a previous email, it is possible for the CPU executing 
this code to be the only CPU currently alive.  And in this code path 
IRQs are disabled.  That means nothing will ever increase jiffies in 
that case and the timeout will never expire.

If in practice there is only a few loops to perform here, I'd suggest 
simply looping, say, 100 times and bail out if that fails.

Oh and if the poll loop fails then you must turn the power control back 
off and return an error via exynos_power_up().

> +	pr_warn("timed out waiting for cluster %u to power %s\n", cluster,
> +		enable ? "on" : "off");
> +}
> +
> +static int exynos_power_up(unsigned int cpu, unsigned int cluster)
> +{
> +	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
> +	if (cpu >= EXYNOS5420_CPUS_PER_CLUSTER ||
> +		cluster >= EXYNOS5420_NR_CLUSTERS)
> +		return -EINVAL;
> +
> +	/*
> +	 * Since this is called with IRQs enabled, and no arch_spin_lock_irq
> +	 * variant exists, we need to disable IRQs manually here.
> +	 */
> +	local_irq_disable();
> +	arch_spin_lock(&exynos_mcpm_lock);
> +
> +	cpu_use_count[cpu][cluster]++;
> +	if (cpu_use_count[cpu][cluster] == 1) {
> +		bool was_cluster_down =
> +			__mcpm_cluster_state(cluster) == CLUSTER_DOWN;
> +
> +		/*
> +		 * Turn on the cluster (L2/COMMON) and then power on the cores.
> +		 * TODO: Turn off the clusters when all cores in the cluster
> +		 * are down to achieve significant power savings.
> +		 */
> +		if (was_cluster_down)
> +			exynos_cluster_power_control(cluster, 1);
> +		exynos_core_power_control(cpu, cluster, 1);
> +
> +		/* CPU should be powered up there */
> +		/* Also setup Cluster Power Sequence here */
> +	} else if (cpu_use_count[cpu][cluster] != 2) {
> +		/*
> +		 * The only possible values are:
> +		 * 0 = CPU down
> +		 * 1 = CPU (still) up
> +		 * 2 = CPU requested to be up before it had a chance
> +		 *     to actually make itself down.
> +		 * Any other value is a bug.
> +		 */
> +		BUG();
> +	}
> +
> +	arch_spin_unlock(&exynos_mcpm_lock);
> +	local_irq_enable();
> +
> +	return 0;
> +}
> +
> +static void exynos_power_down(void)
> +{
> +	unsigned int mpidr, cpu, cluster, cpumask;
> +	bool last_man = false, skip_wfi = false;
> +
> +	mpidr = read_cpuid_mpidr();
> +	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +	cpumask = (1 << cpu);
> +
> +	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
> +	BUG_ON(cpu >= EXYNOS5420_CPUS_PER_CLUSTER ||
> +			cluster >= EXYNOS5420_NR_CLUSTERS);
> +
> +	__mcpm_cpu_going_down(cpu, cluster);
> +
> +	arch_spin_lock(&exynos_mcpm_lock);
> +	BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
> +	cpu_use_count[cpu][cluster]--;
> +	if (cpu_use_count[cpu][cluster] == 0) {
> +		int cnt = 0, i;
> +
> +		exynos_core_power_control(cpu, cluster, 0);
> +		for (i = 0; i < EXYNOS5420_CPUS_PER_CLUSTER; i++)
> +			cnt += cpu_use_count[i][cluster];
> +		if (cnt == 0)
> +			last_man = true;
> +	} else if (cpu_use_count[cpu][cluster] == 1) {
> +		/*
> +		 * A power_up request went ahead of us.
> +		 * Even if we do not want to shut this CPU down,
> +		 * the caller expects a certain state as if the WFI
> +		 * was aborted.  So let's continue with cache cleaning.
> +		 */
> +		skip_wfi = true;
> +	} else {
> +		BUG();
> +	}
> +
> +	if (last_man && __mcpm_outbound_enter_critical(cpu, cluster)) {
> +		arch_spin_unlock(&exynos_mcpm_lock);
> +
> +		/* Flush all cache levels for this cluster. */
> +		exynos_v7_exit_coherency_flush(all);
> +
> +		/*
> +		 * Disable cluster-level coherency by masking
> +		 * incoming snoops and DVM messages:
> +		 */
> +		cci_disable_port_by_cpu(mpidr);
> +
> +		__mcpm_outbound_leave_critical(cluster, CLUSTER_DOWN);
> +	} else {
> +		arch_spin_unlock(&exynos_mcpm_lock);
> +
> +		/* Disable and flush the local CPU cache. */
> +		exynos_v7_exit_coherency_flush(louis);
> +	}
> +
> +	__mcpm_cpu_down(cpu, cluster);
> +
> +	/* Now we are prepared for power-down, do it: */
> +	if (!skip_wfi)
> +		wfi();
> +
> +	/* Not dead at this point?  Let our caller cope. */
> +}
> +
> +static int exynos_power_down_finish(unsigned int cpu, unsigned int cluster)
> +{
> +	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
> +	BUG_ON(cpu >= EXYNOS5420_CPUS_PER_CLUSTER ||
> +			cluster >= EXYNOS5420_NR_CLUSTERS);
> +
> +	/* Wait for the core state to be OFF */
> +	while (exynos_core_power_state(cpu, cluster) != 0x0)
> +		;
> +

*Here* is the place to actually establish a timeout.  Please see 
tc2_pm_power_down_finish() for example.

Also beware that this method is going to be renamed once RMK applies the 
following patch:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8029/1





> +	return 0; /* success: the CPU is halted */
> +}
> +
> +static const struct mcpm_platform_ops exynos_power_ops = {
> +	.power_up		= exynos_power_up,
> +	.power_down		= exynos_power_down,
> +	.power_down_finish	= exynos_power_down_finish,
> +};
> +
> +static void __init exynos_mcpm_usage_count_init(void)
> +{
> +	unsigned int mpidr, cpu, cluster;
> +
> +	mpidr = read_cpuid_mpidr();
> +	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +
> +	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
> +	BUG_ON(cpu >= EXYNOS5420_CPUS_PER_CLUSTER  ||
> +			cluster >= EXYNOS5420_NR_CLUSTERS);
> +
> +	cpu_use_count[cpu][cluster] = 1;
> +}
> +
> +/*
> + * Enable cluster-level coherency, in preparation for turning on the MMU.
> + */
> +static void __naked exynos_pm_power_up_setup(unsigned int affinity_level)
> +{
> +	asm volatile ("\n"
> +	"cmp	r0, #1\n"
> +	"bxne	lr\n"
> +	"b	cci_enable_port_for_self");
> +}
> +
> +static int __init exynos_mcpm_init(void)
> +{
> +	int ret = 0;
> +
> +	if (!soc_is_exynos5420())
> +		return -ENODEV;
> +
> +	if (!cci_probed())
> +		return -ENODEV;
> +
> +	/*
> +	 * To increase the stability of KFC reset we need to program
> +	 * the PMU SPARE3 register
> +	 */
> +	__raw_writel(EXYNOS5420_SWRESET_KFC_SEL, S5P_PMU_SPARE3);
> +
> +	exynos_mcpm_usage_count_init();
> +
> +	ret = mcpm_platform_register(&exynos_power_ops);
> +	if (!ret)
> +		ret = mcpm_sync_init(exynos_pm_power_up_setup);
> +	if (ret)
> +		return ret;
> +
> +	mcpm_smp_set_ops();
> +
> +	pr_info("Exynos MCPM support installed\n");
> +
> +	/*
> +	 * Future entries into the kernel can now go
> +	 * through the cluster entry vectors.
> +	 */
> +	__raw_writel(virt_to_phys(mcpm_entry_point),
> +		REG_ENTRY_ADDR);
> +
> +	return ret;
> +}
> +
> +early_initcall(exynos_mcpm_init);
> diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
> index cfbfc575..43fe7a0 100644
> --- a/arch/arm/mach-exynos/regs-pmu.h
> +++ b/arch/arm/mach-exynos/regs-pmu.h
> @@ -38,6 +38,7 @@
>  #define S5P_INFORM5				S5P_PMUREG(0x0814)
>  #define S5P_INFORM6				S5P_PMUREG(0x0818)
>  #define S5P_INFORM7				S5P_PMUREG(0x081C)
> +#define S5P_PMU_SPARE3				S5P_PMUREG(0x090C)
>  
>  #define EXYNOS_IROM_DATA2			S5P_PMUREG(0x0988)
>  
> @@ -540,5 +541,6 @@
>  #define EXYNOS5420_KFC_USE_STANDBY_WFE3				(1 << 23)
>  
>  #define DUR_WAIT_RESET				0xF
> +#define EXYNOS5420_SWRESET_KFC_SEL		0x3
>  
>  #endif /* __ASM_ARCH_REGS_PMU_H */
> -- 
> 1.7.9.5
> 
