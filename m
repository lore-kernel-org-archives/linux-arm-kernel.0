From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 9 Jun 2013 23:53:12 -0400 (EDT)
Subject: [PATCH 1/2] ARM: vexpress/TC2: basic PM support
In-Reply-To: <20130607142645.GD3111@e102568-lin.cambridge.arm.com>
References: <1370587152-4630-1-git-send-email-nicolas.pitre@linaro.org>
 <1370587152-4630-2-git-send-email-nicolas.pitre@linaro.org>
 <20130607142645.GD3111@e102568-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.03.1306080118440.18597@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Jun 2013, Lorenzo Pieralisi wrote:

> On Fri, Jun 07, 2013 at 07:39:11AM +0100, Nicolas Pitre wrote:
> > +#include <mach/motherboard.h>
> 
> Is the include above needed ?

Apparently not.

> > +static int tc2_pm_power_up(unsigned int cpu, unsigned int cluster)
> > +{
> > +	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
> > +	if (cluster >= 2 || cpu >= vexpress_spc_get_nb_cpus(cluster))
> > +		return -EINVAL;
> 
> We could stash (vexpress_spc_get_nb_cpus()), it never changes.

Well... sure.  However, given cpu_up is not a very hot path and because 
the cpu argument is externally provided in this case, I'm inclined to 
leave this instance as is.  I'll hardcode a constant in the other cases 
where the cpu number is obtained from the MPIDR and validated with 
BUG_ON() where this is done only to prevent overflowing the 
tc2_pm_use_count array if something very wrong happens.

Oh and I'll use defines for those constants as well.

> > +	if (last_man && __mcpm_outbound_enter_critical(cpu, cluster)) {
> > +		arch_spin_unlock(&tc2_pm_lock);
> > +
> > +		set_cr(get_cr() & ~CR_C);
> 
> We must disable L2 prefetching on A15 before cleaning L2.

OK.

> > +		flush_cache_all();
> > +		asm volatile ("clrex");
> > +		set_auxcr(get_auxcr() & ~(1 << 6));
> 
> I think we should add comments here to avoid copy'n'paste mayhem. The
> code above is safe on cpus like A15/A7 (I know this back-end can just
> be run on those processors) that hit in the cache with C-bit in SCTLR
> cleared, it would explode on processors (eg A9) that do not hit in the
> cache with C-bit cleared. I am wondering if it is better to write inline
> asm and jump to v7 cache functions that do not need stack push/pop
> straight away.

Well... yeah.  This is unfortunate because we moved this part from 
assembly to C over time to clean it up.  But better use something safer 
in case it gets copied as you say.

> 
> > +		cci_disable_port_by_cpu(mpidr);
> > +
> > +		/*
> > +		 * Ensure that both C & I bits are disabled in the SCTLR
> > +		 * before disabling ACE snoops. This ensures that no
> > +		 * coherency traffic will originate from this cpu after
> > +		 * ACE snoops are turned off.
> > +		 */
> > +		cpu_proc_fin();
> 
> Mmm, C bit is already cleared, why clear the I bit (and the A bit) ?
> I do not think cpu_proc_fin() is needed and I am really keen on getting
> the power down procedure right to avoid copy'n'paste induced error from
> the start.

I trusted the above and its accompanying comment from Achin's initial 
cluster shutdown code.  But I suppose icache lookups don't create snoop 
requests?

> > +		__mcpm_outbound_leave_critical(cluster, CLUSTER_DOWN);
> > +	} else {
> > +		/*
> > +		 * If last man then undo any setup done previously.
> > +		 */
> > +		if (last_man) {
> > +			vexpress_spc_powerdown_enable(cluster, 0);
> > +			vexpress_spc_set_global_wakeup_intr(0);
> > +		}
> > +
> > +		arch_spin_unlock(&tc2_pm_lock);
> > +
> > +		set_cr(get_cr() & ~CR_C);
> > +		flush_cache_louis();
> > +		asm volatile ("clrex");
> > +		set_auxcr(get_auxcr() & ~(1 << 6));
> > +	}
> > +
> > +	__mcpm_cpu_down(cpu, cluster);
> > +
> > +	/* Now we are prepared for power-down, do it: */
> > +	if (!skip_wfi)
> > +		wfi();
> > +
> > +	/* Not dead at this point?  Let our caller cope. */
> 
> This function should disable the GIC CPU IF, but I guess you will add
> the code when CPUidle is merged.

The GIC code does not provide a hook for doing that at the moment.  That 
needs to be sorted out there before that can be added here.

[...]

OK, here's another version:

From: Nicolas Pitre <nicolas.pitre@linaro.org>
Date: Fri, 19 Oct 2012 20:48:50 -0400
Subject: [PATCH] ARM: vexpress/TC2: basic PM support

This is the MCPM backend for the Virtual Express A15x2 A7x3 CoreTile
aka TC2.  This provides cluster management for SMP secondary boot and
CPU hotplug.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index b8bbabec63..e7a825d7df 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -66,4 +66,13 @@ config ARCH_VEXPRESS_DCSCB
 	  This is needed to provide CPU and cluster power management
 	  on RTSM implementing big.LITTLE.
 
+config ARCH_VEXPRESS_TC2
+	bool "Versatile Express TC2 power management"
+	depends on MCPM
+	select VEXPRESS_SPC
+	select ARM_CCI
+	help
+	  Support for CPU and cluster power management on Versatile Express
+	  with a TC2 (A15x2 A7x3) big.LITTLE core tile.
+
 endmenu
diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
index 48ba89a814..b1cf227fa5 100644
--- a/arch/arm/mach-vexpress/Makefile
+++ b/arch/arm/mach-vexpress/Makefile
@@ -7,5 +7,6 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 obj-y					:= v2m.o
 obj-$(CONFIG_ARCH_VEXPRESS_CA9X4)	+= ct-ca9x4.o
 obj-$(CONFIG_ARCH_VEXPRESS_DCSCB)	+= dcscb.o	dcscb_setup.o
+obj-$(CONFIG_ARCH_VEXPRESS_TC2)		+= tc2_pm.o
 obj-$(CONFIG_SMP)			+= platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-vexpress/tc2_pm.c
new file mode 100644
index 0000000000..f0673b4814
--- /dev/null
+++ b/arch/arm/mach-vexpress/tc2_pm.c
@@ -0,0 +1,275 @@
+/*
+ * arch/arm/mach-vexpress/tc2_pm.c - TC2 power management support
+ *
+ * Created by:	Nicolas Pitre, October 2012
+ * Copyright:	(C) 2012-2013  Linaro Limited
+ *
+ * Some portions of this file were originally written by Achin Gupta
+ * Copyright:   (C) 2012  ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/errno.h>
+
+#include <asm/mcpm.h>
+#include <asm/proc-fns.h>
+#include <asm/cacheflush.h>
+#include <asm/cputype.h>
+#include <asm/cp15.h>
+
+#include <linux/vexpress.h>
+#include <linux/arm-cci.h>
+
+/*
+ * We can't use regular spinlocks. In the switcher case, it is possible
+ * for an outbound CPU to call power_down() after its inbound counterpart
+ * is already live using the same logical CPU number which trips lockdep
+ * debugging.
+ */
+static arch_spinlock_t tc2_pm_lock = __ARCH_SPIN_LOCK_UNLOCKED;
+
+#define TC2_CLUSTERS			2
+#define TC2_MAX_CPUS_PER_CLUSTER	3
+static int tc2_pm_use_count[TC2_MAX_CPUS_PER_CLUSTER][TC2_CLUSTERS];
+
+static int tc2_pm_power_up(unsigned int cpu, unsigned int cluster)
+{
+	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
+	if (cluster >= TC2_CLUSTERS || cpu >= vexpress_spc_get_nb_cpus(cluster))
+		return -EINVAL;
+
+	/*
+	 * Since this is called with IRQs enabled, and no arch_spin_lock_irq
+	 * variant exists, we need to disable IRQs manually here.
+	 */
+	local_irq_disable();
+	arch_spin_lock(&tc2_pm_lock);
+
+	if (!tc2_pm_use_count[0][cluster] &&
+	    !tc2_pm_use_count[1][cluster] &&
+	    !tc2_pm_use_count[2][cluster])
+		vexpress_spc_powerdown_enable(cluster, 0);
+
+	tc2_pm_use_count[cpu][cluster]++;
+	if (tc2_pm_use_count[cpu][cluster] == 1) {
+		vexpress_spc_write_resume_reg(cluster, cpu,
+					      virt_to_phys(mcpm_entry_point));
+		vexpress_spc_set_cpu_wakeup_irq(cpu, cluster, 1);
+	} else if (tc2_pm_use_count[cpu][cluster] != 2) {
+		/*
+		 * The only possible values are:
+		 * 0 = CPU down
+		 * 1 = CPU (still) up
+		 * 2 = CPU requested to be up before it had a chance
+		 *     to actually make itself down.
+		 * Any other value is a bug.
+		 */
+		BUG();
+	}
+
+	arch_spin_unlock(&tc2_pm_lock);
+	local_irq_enable();
+
+	return 0;
+}
+
+static void tc2_pm_power_down(void)
+{
+	unsigned int mpidr, cpu, cluster;
+	bool last_man = false, skip_wfi = false;
+
+	mpidr = read_cpuid_mpidr();
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+
+	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
+	BUG_ON(cluster >= TC2_CLUSTERS || cpu >= TC2_MAX_CPUS_PER_CLUSTER);
+
+	__mcpm_cpu_going_down(cpu, cluster);
+
+	arch_spin_lock(&tc2_pm_lock);
+	BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
+	tc2_pm_use_count[cpu][cluster]--;
+	if (tc2_pm_use_count[cpu][cluster] == 0) {
+		vexpress_spc_set_cpu_wakeup_irq(cpu, cluster, 1);
+		if (!tc2_pm_use_count[0][cluster] &&
+		    !tc2_pm_use_count[1][cluster] &&
+		    !tc2_pm_use_count[2][cluster]) {
+			vexpress_spc_powerdown_enable(cluster, 1);
+			vexpress_spc_set_global_wakeup_intr(1);
+			last_man = true;
+		}
+	} else if (tc2_pm_use_count[cpu][cluster] == 1) {
+		/*
+		 * A power_up request went ahead of us.
+		 * Even if we do not want to shut this CPU down,
+		 * the caller expects a certain state as if the WFI
+		 * was aborted.  So let's continue with cache cleaning.
+		 */
+		skip_wfi = true;
+	} else
+		BUG();
+
+	if (last_man && __mcpm_outbound_enter_critical(cpu, cluster)) {
+		arch_spin_unlock(&tc2_pm_lock);
+
+		if ((read_cpuid_id() & 0xf0) == 0xf0) {
+			/*
+			 * On the Cortex-A15 we need to disable
+			 * L2 prefetching before flushing the cache.
+			 */
+			asm volatile(
+			"mcr	p15, 1, %0, c15, c0, 3 \n\t"
+			"isb	\n\t"
+			"dsb	"
+			: : "r" (0x400) );
+		}
+
+		/*
+		 * We need to disable and flush the whole (L1 and L2) cache.
+		 * Let's do it in the safest possible way i.e. with
+		 * no memory access within the following sequence,
+		 * including the stack.
+		 */
+		asm volatile(
+		"mrc	p15, 0, r0, c1, c0, 0	@ get CR \n\t"
+		"bic	r0, r0, #"__stringify(CR_C)" \n\t"
+		"mcr	p15, 0, r0, c1, c0, 0	@ set CR \n\t"
+		"isb	\n\t"
+		"bl	v7_flush_dcache_all \n\t"
+		"clrex	\n\t"
+		"mrc	p15, 0, r0, c1, c0, 1	@ get AUXCR \n\t"
+		"bic	r0, r0, #(1 << 6)	@ disable local coherency \n\t"
+		"mcr	p15, 0, r0, c1, c0, 1	@ set AUXCR \n\t"
+		"isb	"
+		: : : "r0","r1","r2","r3","r4","r5","r6","r7",
+		      "r9","r10","r11","lr","memory");
+
+		cci_disable_port_by_cpu(mpidr);
+
+		__mcpm_outbound_leave_critical(cluster, CLUSTER_DOWN);
+	} else {
+		/*
+		 * If last man then undo any setup done previously.
+		 */
+		if (last_man) {
+			vexpress_spc_powerdown_enable(cluster, 0);
+			vexpress_spc_set_global_wakeup_intr(0);
+		}
+
+		arch_spin_unlock(&tc2_pm_lock);
+
+		/*
+		 * We need to disable and flush only the L1 cache.
+		 * Let's do it in the safest possible way as above.
+		 */
+		asm volatile(
+		"mrc	p15, 0, r0, c1, c0, 0	@ get CR \n\t"
+		"bic	r0, r0, #"__stringify(CR_C)" \n\t"
+		"mcr	p15, 0, r0, c1, c0, 0	@ set CR \n\t"
+		"isb	\n\t"
+		"bl	v7_flush_dcache_louis \n\t"
+		"clrex	\n\t"
+		"mrc	p15, 0, r0, c1, c0, 1	@ get AUXCR \n\t"
+		"bic	r0, r0, #(1 << 6)	@ disable local coherency \n\t"
+		"mcr	p15, 0, r0, c1, c0, 1	@ set AUXCR \n\t"
+		"isb	"
+		: : : "r0","r1","r2","r3","r4","r5","r6","r7",
+		      "r9","r10","r11","lr","memory");
+	}
+
+	__mcpm_cpu_down(cpu, cluster);
+
+	/* Now we are prepared for power-down, do it: */
+	if (!skip_wfi)
+		wfi();
+
+	/* Not dead@this point?  Let our caller cope. */
+}
+
+static void tc2_pm_powered_up(void)
+{
+	unsigned int mpidr, cpu, cluster;
+	unsigned long flags;
+
+	mpidr = read_cpuid_mpidr();
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+
+	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
+	BUG_ON(cluster >= TC2_CLUSTERS || cpu >= TC2_MAX_CPUS_PER_CLUSTER);
+
+	local_irq_save(flags);
+	arch_spin_lock(&tc2_pm_lock);
+
+	if (!tc2_pm_use_count[0][cluster] &&
+	    !tc2_pm_use_count[1][cluster] &&
+	    !tc2_pm_use_count[2][cluster]) {
+		vexpress_spc_powerdown_enable(cluster, 0);
+		vexpress_spc_set_global_wakeup_intr(0);
+	}
+
+	if (!tc2_pm_use_count[cpu][cluster])
+		tc2_pm_use_count[cpu][cluster] = 1;
+
+	vexpress_spc_set_cpu_wakeup_irq(cpu, cluster, 0);
+	vexpress_spc_write_resume_reg(cluster, cpu, 0);
+
+	arch_spin_unlock(&tc2_pm_lock);
+	local_irq_restore(flags);
+}
+
+static const struct mcpm_platform_ops tc2_pm_power_ops = {
+	.power_up	= tc2_pm_power_up,
+	.power_down	= tc2_pm_power_down,
+	.powered_up	= tc2_pm_powered_up,
+};
+
+static void __init tc2_pm_usage_count_init(void)
+{
+	unsigned int mpidr, cpu, cluster;
+
+	mpidr = read_cpuid_mpidr();
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+
+	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
+	BUG_ON(cluster >= TC2_CLUSTERS || cpu >= TC2_MAX_CPUS_PER_CLUSTER);
+	tc2_pm_use_count[cpu][cluster] = 1;
+}
+
+/*
+ * Enable cluster-level coherency, in preparation for turning on the MMU.
+ */
+static void __naked tc2_pm_power_up_setup(unsigned int affinity_level)
+{
+	asm volatile (" \n"
+"	cmp	r0, #1 \n"
+"	bxne	lr \n"
+"	b	cci_enable_port_for_self ");
+}
+
+static int __init tc2_pm_init(void)
+{
+	int ret;
+
+	if (!vexpress_spc_check_loaded())
+		return -ENODEV;
+
+	tc2_pm_usage_count_init();
+
+	ret = mcpm_platform_register(&tc2_pm_power_ops);
+	if (!ret)
+		ret = mcpm_sync_init(tc2_pm_power_up_setup);
+	if (!ret)
+		pr_info("TC2 power management initialized\n");
+	return ret;
+}
+
+early_initcall(tc2_pm_init);
