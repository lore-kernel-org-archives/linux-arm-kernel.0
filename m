From: olof@lixom.net (Olof Johansson)
Date: Thu, 13 Jun 2013 13:32:18 -0700
Subject: [PATCH 1/2] ARM: vexpress/TC2: basic PM support
In-Reply-To: <1370587152-4630-2-git-send-email-nicolas.pitre@linaro.org>
References: <1370587152-4630-1-git-send-email-nicolas.pitre@linaro.org>
 <1370587152-4630-2-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20130613203218.GA22310@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


Some comments below.

On Fri, Jun 07, 2013 at 02:39:11AM -0400, Nicolas Pitre wrote:
> This is the MCPM backend for the Virtual Express A15x2 A7x3 CoreTile
> aka TC2.  This provides cluster management for SMP secondary boot and
> CPU hotplug.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>  arch/arm/mach-vexpress/Kconfig  |   9 ++
>  arch/arm/mach-vexpress/Makefile |   1 +
>  arch/arm/mach-vexpress/tc2_pm.c | 243 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 253 insertions(+)
>  create mode 100644 arch/arm/mach-vexpress/tc2_pm.c
> 
> diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
> index b8bbabec63..e7a825d7df 100644
> --- a/arch/arm/mach-vexpress/Kconfig
> +++ b/arch/arm/mach-vexpress/Kconfig
> @@ -66,4 +66,13 @@ config ARCH_VEXPRESS_DCSCB
>  	  This is needed to provide CPU and cluster power management
>  	  on RTSM implementing big.LITTLE.
>  
> +config ARCH_VEXPRESS_TC2
> +	bool "Versatile Express TC2 power management"

Should there be a _PM in the config option, perhaps? Or maybe take out the
power management one-line info if it's really just base support for the
platform.

> +	depends on MCPM
> +	select VEXPRESS_SPC
> +	select ARM_CCI
> +	help
> +	  Support for CPU and cluster power management on Versatile Express
> +	  with a TC2 (A15x2 A7x3) big.LITTLE core tile.
> +
>  endmenu
> diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
> index 48ba89a814..b1cf227fa5 100644
> --- a/arch/arm/mach-vexpress/Makefile
> +++ b/arch/arm/mach-vexpress/Makefile
> @@ -7,5 +7,6 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
>  obj-y					:= v2m.o
>  obj-$(CONFIG_ARCH_VEXPRESS_CA9X4)	+= ct-ca9x4.o
>  obj-$(CONFIG_ARCH_VEXPRESS_DCSCB)	+= dcscb.o	dcscb_setup.o
> +obj-$(CONFIG_ARCH_VEXPRESS_TC2)		+= tc2_pm.o
>  obj-$(CONFIG_SMP)			+= platsmp.o
>  obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
> diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-vexpress/tc2_pm.c
> new file mode 100644
> index 0000000000..a3ea524372
> --- /dev/null
> +++ b/arch/arm/mach-vexpress/tc2_pm.c
> @@ -0,0 +1,243 @@
> +/*
> + * arch/arm/mach-vexpress/tc2_pm.c - TC2 power management support
> + *
> + * Created by:	Nicolas Pitre, October 2012
> + * Copyright:	(C) 2012-2013  Linaro Limited
> + *
> + * Some portions of this file were originally written by Achin Gupta
> + * Copyright:   (C) 2012  ARM Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/spinlock.h>
> +#include <linux/errno.h>
> +
> +#include <asm/mcpm.h>
> +#include <asm/proc-fns.h>
> +#include <asm/cacheflush.h>
> +#include <asm/cputype.h>
> +#include <asm/cp15.h>
> +
> +#include <mach/motherboard.h>
> +
> +#include <linux/vexpress.h>
> +#include <linux/arm-cci.h>
> +
> +/*
> + * We can't use regular spinlocks. In the switcher case, it is possible
> + * for an outbound CPU to call power_down() after its inbound counterpart
> + * is already live using the same logical CPU number which trips lockdep
> + * debugging.
> + */
> +static arch_spinlock_t tc2_pm_lock = __ARCH_SPIN_LOCK_UNLOCKED;
> +
> +static int tc2_pm_use_count[3][2];

A comment describing the purpose of this array would be much beneficial for
someone reading the driver.

> +
> +static int tc2_pm_power_up(unsigned int cpu, unsigned int cluster)
> +{
> +	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
> +	if (cluster >= 2 || cpu >= vexpress_spc_get_nb_cpus(cluster))
> +		return -EINVAL;
> +
> +	/*
> +	 * Since this is called with IRQs enabled, and no arch_spin_lock_irq
> +	 * variant exists, we need to disable IRQs manually here.
> +	 */
> +	local_irq_disable();
> +	arch_spin_lock(&tc2_pm_lock);
> +
> +	if (!tc2_pm_use_count[0][cluster] &&
> +	    !tc2_pm_use_count[1][cluster] &&
> +	    !tc2_pm_use_count[2][cluster])

I see this construct used three times open-coded like this in the file. Adding
a smaller helper with a descriptive name would be a good idea.

Same goes for other direct accesses to the array -- maybe a tiny helper to
set/get state? It might end up overabstracted that way though.

> +		vexpress_spc_powerdown_enable(cluster, 0);
> +
> +	tc2_pm_use_count[cpu][cluster]++;
> +	if (tc2_pm_use_count[cpu][cluster] == 1) {
> +		vexpress_spc_write_resume_reg(cluster, cpu,
> +					      virt_to_phys(mcpm_entry_point));
> +		vexpress_spc_set_cpu_wakeup_irq(cpu, cluster, 1);
> +	} else if (tc2_pm_use_count[cpu][cluster] != 2) {
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
> +	arch_spin_unlock(&tc2_pm_lock);
> +	local_irq_enable();
> +
> +	return 0;
> +}
> +
> +static void tc2_pm_power_down(void)
> +{
> +	unsigned int mpidr, cpu, cluster;
> +	bool last_man = false, skip_wfi = false;
> +
> +	mpidr = read_cpuid_mpidr();
> +	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +
> +	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
> +	BUG_ON(cluster >= 2 || cpu >= vexpress_spc_get_nb_cpus(cluster));
> +
> +	__mcpm_cpu_going_down(cpu, cluster);
> +
> +	arch_spin_lock(&tc2_pm_lock);
> +	BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
> +	tc2_pm_use_count[cpu][cluster]--;
> +	if (tc2_pm_use_count[cpu][cluster] == 0) {
> +		vexpress_spc_set_cpu_wakeup_irq(cpu, cluster, 1);
> +		if (!tc2_pm_use_count[0][cluster] &&
> +		    !tc2_pm_use_count[1][cluster] &&
> +		    !tc2_pm_use_count[2][cluster]) {
> +			vexpress_spc_powerdown_enable(cluster, 1);
> +			vexpress_spc_set_global_wakeup_intr(1);
> +			last_man = true;
> +		}
> +	} else if (tc2_pm_use_count[cpu][cluster] == 1) {
> +		/*
> +		 * A power_up request went ahead of us.
> +		 * Even if we do not want to shut this CPU down,
> +		 * the caller expects a certain state as if the WFI
> +		 * was aborted.  So let's continue with cache cleaning.
> +		 */
> +		skip_wfi = true;
> +	} else
> +		BUG();
> +
> +	if (last_man && __mcpm_outbound_enter_critical(cpu, cluster)) {
> +		arch_spin_unlock(&tc2_pm_lock);
> +
> +		set_cr(get_cr() & ~CR_C);
> +		flush_cache_all();
> +		asm volatile ("clrex");
> +		set_auxcr(get_auxcr() & ~(1 << 6));
> +
> +		cci_disable_port_by_cpu(mpidr);
> +
> +		/*
> +		 * Ensure that both C & I bits are disabled in the SCTLR
> +		 * before disabling ACE snoops. This ensures that no
> +		 * coherency traffic will originate from this cpu after
> +		 * ACE snoops are turned off.
> +		 */
> +		cpu_proc_fin();
> +
> +		__mcpm_outbound_leave_critical(cluster, CLUSTER_DOWN);
> +	} else {
> +		/*
> +		 * If last man then undo any setup done previously.
> +		 */
> +		if (last_man) {
> +			vexpress_spc_powerdown_enable(cluster, 0);
> +			vexpress_spc_set_global_wakeup_intr(0);
> +		}
> +
> +		arch_spin_unlock(&tc2_pm_lock);
> +
> +		set_cr(get_cr() & ~CR_C);
> +		flush_cache_louis();
> +		asm volatile ("clrex");
> +		set_auxcr(get_auxcr() & ~(1 << 6));
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
> +static void tc2_pm_powered_up(void)
> +{
> +	unsigned int mpidr, cpu, cluster;
> +	unsigned long flags;
> +
> +	mpidr = read_cpuid_mpidr();
> +	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +
> +	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
> +	BUG_ON(cluster >= 2 || cpu >= vexpress_spc_get_nb_cpus(cluster));
> +
> +	local_irq_save(flags);
> +	arch_spin_lock(&tc2_pm_lock);
> +
> +	if (!tc2_pm_use_count[0][cluster] &&
> +	    !tc2_pm_use_count[1][cluster] &&
> +	    !tc2_pm_use_count[2][cluster]) {
> +		vexpress_spc_powerdown_enable(cluster, 0);
> +		vexpress_spc_set_global_wakeup_intr(0);
> +	}
> +
> +	if (!tc2_pm_use_count[cpu][cluster])
> +		tc2_pm_use_count[cpu][cluster] = 1;
> +
> +	vexpress_spc_set_cpu_wakeup_irq(cpu, cluster, 0);
> +	vexpress_spc_write_resume_reg(cluster, cpu, 0);
> +
> +	arch_spin_unlock(&tc2_pm_lock);
> +	local_irq_restore(flags);
> +}
> +
> +static const struct mcpm_platform_ops tc2_pm_power_ops = {
> +	.power_up	= tc2_pm_power_up,
> +	.power_down	= tc2_pm_power_down,
> +	.powered_up	= tc2_pm_powered_up,
> +};
> +
> +static void __init tc2_pm_usage_count_init(void)
> +{
> +	unsigned int mpidr, cpu, cluster;
> +
> +	mpidr = read_cpuid_mpidr();
> +	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +
> +	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
> +	BUG_ON(cpu >= 3 || cluster >= 2);

A warning saying that this hardware configuration is not supported would maybe
be more informal for an user trying to boot some mythical future hardware with
a too-old kernel.

> +	tc2_pm_use_count[cpu][cluster] = 1;
> +}
> +
> +/*
> + * Enable cluster-level coherency, in preparation for turning on the MMU.
> + */
> +static void __naked tc2_pm_power_up_setup(unsigned int affinity_level)
> +{
> +	asm volatile (" \n"
> +"	cmp	r0, #1 \n"
> +"	beq	cci_enable_port_for_self \n"
> +"	bx	lr ");
> +}
> +
> +static int __init tc2_pm_init(void)
> +{
> +	int ret;
> +
> +	if (!vexpress_spc_check_loaded())
> +		return -ENODEV;
> +
> +	tc2_pm_usage_count_init();
> +
> +	ret = mcpm_platform_register(&tc2_pm_power_ops);
> +	if (!ret)
> +		ret = mcpm_sync_init(tc2_pm_power_up_setup);
> +	if (!ret)
> +		pr_info("TC2 power management initialized\n");
> +	return ret;
> +}
> +
> +early_initcall(tc2_pm_init);
> -- 
> 1.8.1.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
