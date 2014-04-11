From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 11 Apr 2014 16:23:04 -0400 (EDT)
Subject: [PATCH 5/5] arm: exynos: Add MCPM call-back functions
In-Reply-To: <1397239311-27717-6-git-send-email-a.kesavan@samsung.com>
References: <1397239311-27717-1-git-send-email-a.kesavan@samsung.com>
 <1397239311-27717-6-git-send-email-a.kesavan@samsung.com>
Message-ID: <alpine.LFD.2.11.1404111426510.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Apr 2014, Abhilash Kesavan wrote:

> Add machine-dependent MCPM call-backs for Exynos5420. These are used
> to power up/down the secondary CPUs during boot, shutdown, s2r and
> switching.
> 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Inderpal Singh <inderpal.s@samsung.com>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>

See comments inline.

> ---
>  arch/arm/mach-exynos/Kconfig             |    9 +
>  arch/arm/mach-exynos/Makefile            |    2 +
>  arch/arm/mach-exynos/common.h            |    1 +
>  arch/arm/mach-exynos/exynos.c            |    1 +
>  arch/arm/mach-exynos/mcpm-exynos-setup.S |   35 +++
>  arch/arm/mach-exynos/mcpm-exynos.c       |  444 ++++++++++++++++++++++++++++++
>  arch/arm/mach-exynos/platsmp.c           |   19 ++
>  arch/arm/mach-exynos/regs-pmu.h          |    2 +
>  8 files changed, 513 insertions(+)
>  create mode 100644 arch/arm/mach-exynos/mcpm-exynos-setup.S
>  create mode 100644 arch/arm/mach-exynos/mcpm-exynos.c
> 
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index fc8bf18..a921a80 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -110,4 +110,13 @@ config SOC_EXYNOS5440
>  
>  endmenu
>  
> +config EXYNOS5420_MCPM
> +	bool "Exynos5420 Multi-Cluster PM support"
> +	depends on MCPM && SOC_EXYNOS5420
> +	select ARM_CCI
> +	help
> +	  Support for Dual Cluster Switching (A15/A7) on Exynos5420.
> +	  This is needed to provide CPU and cluster power management
> +	  on Exynos5420 implementing big.LITTLE.

MCPM is not about "cluster switching".  It is about cluster-wide 
power-up/power-down coordination and race avoidance.  MCPM is relied 
upon by the big.LITTLE switcher, but it is also needed by cpuidle, CPU 
hotplug, etc.  Therefore the first line of the help text is wrong and 
could be omitted entirely.

>  endif
> diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
> index a656dbe..776fcbd 100644
> --- a/arch/arm/mach-exynos/Makefile
> +++ b/arch/arm/mach-exynos/Makefile
> @@ -29,3 +29,5 @@ obj-$(CONFIG_ARCH_EXYNOS)	+= firmware.o
>  
>  plus_sec := $(call as-instr,.arch_extension sec,+sec)
>  AFLAGS_exynos-smc.o		:=-Wa,-march=armv7-a$(plus_sec)
> +
> +obj-$(CONFIG_EXYNOS5420_MCPM)	+= mcpm-exynos.o mcpm-exynos-setup.o
> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
> index 347afc2..a023ccc 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -51,6 +51,7 @@ static inline void exynos_pm_init(void) {}
>  extern void exynos_cpu_resume(void);
>  
>  extern struct smp_operations exynos_smp_ops;
> +extern bool exynos_smp_init(void);
>  
>  extern void exynos_cpu_die(unsigned int cpu);
>  
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index b1cf9d5..5b72b5e 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -412,6 +412,7 @@ DT_MACHINE_START(EXYNOS_DT, "SAMSUNG EXYNOS (Flattened Device Tree)")
>  	/* Maintainer: Thomas Abraham <thomas.abraham@linaro.org> */
>  	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
>  	.smp		= smp_ops(exynos_smp_ops),
> +	.smp_init	= smp_init_ops(exynos_smp_init),
>  	.map_io		= exynos_init_io,
>  	.init_early	= exynos_firmware_init,
>  	.init_machine	= exynos_dt_machine_init,
> diff --git a/arch/arm/mach-exynos/mcpm-exynos-setup.S b/arch/arm/mach-exynos/mcpm-exynos-setup.S
> new file mode 100644
> index 0000000..990c0d5
> --- /dev/null
> +++ b/arch/arm/mach-exynos/mcpm-exynos-setup.S
> @@ -0,0 +1,35 @@
> +/*
> + * Exynos low-level MCPM setup
> + *
> + * Copyright (C) 2013-2014 Google, Inc
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/linkage.h>
> +
> +ENTRY(exynos_power_up_setup)
> +
> +	cmp	r0, #0			@ check affinity level
> +	beq	1f
> +
> +/*
> + * Enable cluster-level coherency, in preparation for turning on the MMU.
> + * The ACTLR SMP bit does not need to be set here, because cpu_resume()
> + * already restores that.
> + */
> +	b	cci_enable_port_for_self
> +
> +1:	@ Implementation-specific local CPU setup operations should go here,
> +	@ if any.  In this case, there is nothing to do.
> +
> +	bx	lr
> +
> +ENDPROC(exynos_power_up_setup)

Given this is so simple, I'd suggest you simply copy the TC2 version for 
the above code and dispense with this file altogether.  See 
tc2_pm_power_up_setup() in mach-vexpress/tc2_pm.c.

> diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
> new file mode 100644
> index 0000000..46d4968
> --- /dev/null
> +++ b/arch/arm/mach-exynos/mcpm-exynos.c
> @@ -0,0 +1,444 @@
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
> + * We can't use regular spinlocks. In the switcher case, it is possible
> + * for an outbound CPU to call power_down() after its inbound counterpart
> + * is already live using the same logical CPU number which trips lockdep
> + * debugging.
> + */
> +static arch_spinlock_t bl_lock = __ARCH_SPIN_LOCK_UNLOCKED;

the bl prefix in "bl_lock" might be confusing.  I'd suggest you name 
this "exynos_mcpm_lock" or similar.

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
> +
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
> +
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
> +	pr_warn("timed out waiting for cluster %u to power %s\n", cluster,
> +		enable ? "on" : "off");

You should not have to wait for the power status to change here.  
Simply signaling the desired state and returning is all that is 
expected.  And because IRQs are turned off, it is likely that 
time_before(jiffies, timeout) will always be true anyway because jiffies 
are not updated if there is no other CPU to service the timer interrupt.

The actual power status should be polled for in the mcpm_finish() 
method only.

> +}
> +
> +static int exynos_power_up(unsigned int cpu, unsigned int cluster)
> +{
> +	unsigned long mpidr;
> +
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
> +	arch_spin_lock(&bl_lock);
> +
> +	cpu_use_count[cpu][cluster]++;
> +	if (cpu_use_count[cpu][cluster] == 1) {
> +		bool was_cluster_down =
> +			__mcpm_cluster_state(cluster) == CLUSTER_DOWN;
> +
> +		if (was_cluster_down)
> +			exynos_cluster_power_control(cluster, 1);
> +		exynos_core_power_control(cpu, cluster, 1);
> +
> +		if (was_cluster_down) {
> +			mpidr = read_cpuid_mpidr();
> +			udelay(10);
> +			cci_control_port_by_cpu(mpidr, true);
> +		}

This is completely wrong.  Is this why you created the patch to 
introduce cci_control_port_by_cpu()?  If so I'm NAKing that other patch 
as well.

This is going to be completely ineffective with concurrent usage by 
cpuidle where CPUs in the other cluster are awaken by an interrupt and 
not by calling the cpu_up method.  The current cluster will therefore 
not be aware of the other cluster coming online and system memory 
corruption will occur.

I see below that you do turn off the CCI port for the current cluster 
and the other cluster together, hence the need to enable back the CCI 
for the current cluster here.  Please don't do that.  That's not the 
proper way to achieve that and there are many race conditions to take 
care of before this can be done.  And if we were to go that route, I 
want to be convinced it is worth the needed complexity first i.e. I want 
to see evidence this actually does save power or improve performance by 
a non negligible margin.

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
> +	arch_spin_unlock(&bl_lock);
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
> +	arch_spin_lock(&bl_lock);
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
> +		arch_spin_unlock(&bl_lock);
> +
> +		/*
> +		 * Flush all cache levels for this cluster.
> +		 *
> +		 * To do so we do:
> +		 * - Clear the SCTLR.C bit to prevent further cache allocations
> +		 * - Flush the whole cache
> +		 * - Clear the ACTLR "SMP" bit to disable local coherency
> +		 *
> +		 * Let's do it in the safest possible way i.e. with
> +		 * no memory access within the following sequence
> +		 * including to the stack.
> +		 *
> +		 * Note: fp is preserved to the stack explicitly prior doing
> +		 * this since adding it to the clobber list is incompatible
> +		 * with having CONFIG_FRAME_POINTER=y.
> +		 *
> +		 * The common v7_exit_coherency_flush API that could not be
> +		 * used because of the Erratum 799270 workaround.
> +		 */

Bummer.  Could you at least create a macro locally, similar to 
v7_exit_coherency_flush, so not to duplicate this code twice please?

> +		asm volatile(
> +		"stmfd	sp!, {fp, ip}\n\t"
> +		"mrc	p15, 0, r0, c1, c0, 0	@ get SCTLR\n\t"
> +		"bic	r0, r0, #"__stringify(CR_C)"\n\t"
> +		"mcr	p15, 0, r0, c1, c0, 0	@ set SCTLR\n\t"
> +		"isb\n\t"
> +		"bl	v7_flush_dcache_all\n\t"
> +		"clrex\n\t"
> +		"mrc	p15, 0, r0, c1, c0, 1	@ get ACTLR\n\t"
> +		"bic	r0, r0, #(1 << 6)	@ disable local coherency\n\t"
> +		/* Dummy Load of a device register to avoid Erratum 799270 */
> +		"ldr	r4, [%0]\n\t"
> +		"and	r4, r4, #0\n\t"
> +		"orr	r0, r0, r4\n\t"
> +		"mcr	p15, 0, r0, c1, c0, 1	@ set ACTLR\n\t"
> +		"isb\n\t"
> +		"dsb\n\t"
> +		"ldmfd	sp!, {fp, ip}"
> +		:
> +		: "Ir" (S5P_INFORM0)
> +		: "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
> +		      "r9", "r10", "lr", "memory");
> +
> +		/*
> +		 * This is a harmless no-op.  On platforms with a real
> +		 * outer cache this might either be needed or not,
> +		 * depending on where the outer cache sits.
> +		 */
> +		outer_flush_all();

If you have no actual outer cache, please remove this call.  In most 
cases with existing outer cache controllers this call is wrong anyway.  
I've already sent a patch removing it from dcscb.c to RMK.

> +		/*
> +		 * Disable cluster-level coherency by masking
> +		 * incoming snoops and DVM messages:
> +		 */
> +		cci_control_port_by_cpu(mpidr, false);
> +		cci_control_port_by_cpu(mpidr ^ (1 << 8), false);

See my comment above for not disabling the remote cluster.

> +
> +		__mcpm_outbound_leave_critical(cluster, CLUSTER_DOWN);
> +	} else {
> +		arch_spin_unlock(&bl_lock);
> +
> +		/*
> +		 * Flush the local CPU cache.
> +		 * Let's do it in the safest possible way as above.
> +		 */
> +		asm volatile(
> +		"stmfd	sp!, {fp, ip}\n\t"
> +		"mrc	p15, 0, r0, c1, c0, 0	@ get SCTLR\n\t"
> +		"bic	r0, r0, #"__stringify(CR_C)"\n\t"
> +		"mcr	p15, 0, r0, c1, c0, 0	@ set SCTLR\n\t"
> +		"isb\n\t"
> +		"bl	v7_flush_dcache_louis\n\t"
> +		"clrex\n\t"
> +		"mrc	p15, 0, r0, c1, c0, 1	@ get ACTLR\n\t"
> +		"bic	r0, r0, #(1 << 6)	@ disable local coherency\n\t"
> +		/* Dummy Load of a device register to avoid Erratum 799270 */
> +		"ldr	r4, [%0]\n\t"
> +		"and	r4, r4, #0\n\t"
> +		"orr	r0, r0, r4\n\t"
> +		"mcr	p15, 0, r0, c1, c0, 1	@ set ACTLR\n\t"
> +		"isb\n\t"
> +		"dsb\n\t"
> +		"ldmfd	sp!, {fp, ip}"
> +		:
> +		: "Ir" (S5P_INFORM0)
> +		: "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
> +		      "r9", "r10", "lr", "memory");

See my note above for not duplicating this code.

> +	}
> +
> +	__mcpm_cpu_down(cpu, cluster);
> +
> +	/* Now we are prepared for power-down, do it: */
> +	dsb();

This dsb is redundant.  The cache maintenance implied by 
__mcpm_cpu_down() already contains a dsb.

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

Unlike above, here is the proper location to implement a timeout.

> +
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
> +	unsigned int mpidr, cpu, cluster, i;
> +
> +	mpidr = read_cpuid_mpidr();
> +	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +
> +	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
> +	BUG_ON(cpu >= EXYNOS5420_CPUS_PER_CLUSTER  ||
> +			cluster >= EXYNOS5420_NR_CLUSTERS);
> +
> +	for (i = 0; i < EXYNOS5420_CPUS_PER_CLUSTER; i++) {
> +		cpu_use_count[i][0] = 0;
> +		cpu_use_count[i][1] = 0;
> +	}

Global non-initialized variables are already initialized to zero by 
default.  You therefore don't need to do it here.

> +	cpu_use_count[cpu][cluster] = 1;
> +}
> +
> +static size_t bL_check_status(char *info)
> +{
> +	size_t len = 0;
> +	int i;
> +
> +	len += sprintf(&info[len], "\t0 1 2 3 L2\n");
> +	len += sprintf(&info[len], "[A15]   ");
> +	for (i = 0; i < 4; i++) {
> +		len += sprintf(&info[len], "%d ",
> +			(readl(EXYNOS_ARM_CORE_STATUS(i)) & 0x3) == 3 ? 1 : 0);
> +	}
> +	len += sprintf(&info[len], "%d\n",
> +			(readl(EXYNOS_COMMON_STATUS(0)) & 0x3) == 3 ? 1 : 0);
> +
> +	len += sprintf(&info[len], "[A7]    ");
> +	for (i = 4; i < 8; i++)
> +		len += sprintf(&info[len], "%d ",
> +			(readl(EXYNOS_ARM_CORE_STATUS(i)) & 0x3) == 3 ? 1 : 0);
> +	len += sprintf(&info[len], "%d\n\n",
> +			(readl(EXYNOS_COMMON_STATUS(1)) & 0x3) == 3 ? 1 : 0);
> +
> +	return len;
> +}
> +
> +static ssize_t bL_status_read(struct file *file, char __user *buf,
> +			size_t len, loff_t *pos)
> +{
> +	size_t count = 0;
> +	char info[100];
> +
> +	count = bL_check_status(info);
> +	if (count < 0)
> +		return -EINVAL;
> +
> +	return simple_read_from_buffer(buf, len, pos, info, count);
> +}
> +
> +static const struct file_operations bL_status_fops = {
> +	.read		= bL_status_read,
> +};
> +
> +static struct miscdevice bL_status_device = {
> +	MISC_DYNAMIC_MINOR,
> +	"bL_status",
> +	&bL_status_fops
> +};

Please split this debug code out to a separate patch so it can be 
evaluated on its own.

> +extern void exynos_power_up_setup(unsigned int affinity_level);
> +
> +static int __init exynos_mcpm_init(void)
> +{
> +	int ret = 0;
> +
> +	if (!cci_probed())
> +		return -ENODEV;
> +
> +	if (!soc_is_exynos5420())
> +		return 0;

You should return -ENODEV here as well.  Also this would be better to 
test this before calling cci_probed().

> +	 * To increase the stability of KFC reset we need to program
> +	 * the PMU SPARE3 register
> +	 */
> +	__raw_writel(EXYNOS5420_SWRESET_KFC_SEL, S5P_PMU_SPARE3);
> +
> +	exynos_mcpm_usage_count_init();
> +
> +	ret = mcpm_platform_register(&exynos_power_ops);
> +	if (!ret)
> +		ret = mcpm_sync_init(exynos_power_up_setup);
> +
> +	pr_info("Exynos MCPM support installed\n");
> +
> +	/*
> +	 * Future entries into the kernel can now go
> +	 * through the cluster entry vectors.
> +	 */
> +	__raw_writel(virt_to_phys(mcpm_entry_point),
> +		REG_ENTRY_ADDR);

You should probably do the positive pr_info() and change the vector 
entry point only when ret is equal to 0.


> +
> +	return ret;
> +}
> +
> +early_initcall(exynos_mcpm_init);
> +
> +static int __init exynos_bl_status_init(void)
> +{
> +	int ret;
> +
> +	if (!soc_is_exynos5420())
> +		return 0;
> +
> +	ret = misc_register(&bL_status_device);
> +	if (ret)
> +		pr_info("bl_status not available\n");
> +	return 0;
> +}
> +
> +late_initcall(exynos_bl_status_init);
> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
> index 03e5e9f..4f14457 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -25,6 +25,7 @@
>  #include <asm/smp_plat.h>
>  #include <asm/smp_scu.h>
>  #include <asm/firmware.h>
> +#include <asm/mcpm.h>
>  
>  #include <plat/cpu.h>
>  
> @@ -226,6 +227,24 @@ static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
>  	}
>  }
>  
> +bool __init exynos_smp_init(void)
> +{
> +#ifdef CONFIG_MCPM
> +	/*
> +	 * The best way to detect a multi-cluster configuration at the moment
> +	 * is to look for the presence of a CCI in the system.
> +	 * Override the default exynos_smp_ops if so.
> +	 */
> +	struct device_node *node;
> +	node = of_find_compatible_node(NULL, NULL, "arm,cci-400");
> +	if (node && of_device_is_available(node)) {
> +		mcpm_smp_set_ops();
> +		return true;
> +	}
> +#endif
> +	return false;
> +}

Unlike on the Versatile Express, it is likely that you can simply call 
mcpm_smp_set_ops() from exynos_mcpm_init() directly (after a successful 
MCPM install of course) and dispense with this.

> +
>  struct smp_operations exynos_smp_ops __initdata = {
>  	.smp_init_cpus		= exynos_smp_init_cpus,
>  	.smp_prepare_cpus	= exynos_smp_prepare_cpus,
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
