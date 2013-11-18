From: francesco.virlinzi@st.com (Francesco VIRLINZI)
Date: Mon, 18 Nov 2013 11:48:21 +0100
Subject: [PATCH 1/3] arm: delete __cpuinit/__CPUINIT usage from all ARM users
In-Reply-To: <1384771703-25741-1-git-send-email-francesco.virlinzi@st.com>
References: <1384771703-25741-1-git-send-email-francesco.virlinzi@st.com>
Message-ID: <1384771703-25741-2-git-send-email-francesco.virlinzi@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>

The __cpuinit type of throwaway sections might have made sense
some time ago when RAM was more constrained, but now the savings
do not offset the cost and complications.  For example, the fix in
commit 5e427ec2d0 ("x86: Fix bit corruption at CPU resume time")
is a good example of the nasty type of bugs that can be created
with improper use of the various __init prefixes.

After a discussion on LKML[1] it was decided that cpuinit should go
the way of devinit and be phased out.  Once all the users are gone,
we can then finally remove the macros themselves from linux/init.h.

Note that some harmless section mismatch warnings may result, since
notify_cpu_starting() and cpu_up() are arch independent (kernel/cpu.c)
and are flagged as __cpuinit  -- so if we remove the __cpuinit from
the arch specific callers, we will also get section mismatch warnings.
As an intermediate step, we intend to turn the linux/init.h cpuinit
related content into no-ops as early as possible, since that will get
rid of these warnings.  In any case, they are temporary and harmless.

This removes all the ARM uses of the __cpuinit macros from C code,
and all __CPUINIT from assembly code.  It also had two ".previous"
section statements that were paired off against __CPUINIT
(aka .section ".cpuinit.text") that also get removed here.

[1] https://lkml.org/lkml/2013/5/20/589

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Conflicts:

	arch/arm/common/mcpm_platsmp.c
	arch/arm/include/asm/arch_timer.h
	arch/arm/kernel/head-common.S
	arch/arm/kernel/head-nommu.S
	arch/arm/kernel/perf_event_cpu.c
	arch/arm/kernel/psci_smp.c
	arch/arm/kernel/smp.c
	arch/arm/lib/delay.c
	arch/arm/mach-exynos/platsmp.c
	arch/arm/mach-highbank/platsmp.c
	arch/arm/mach-imx/platsmp.c
	arch/arm/mach-keystone/platsmp.c
	arch/arm/mach-msm/platsmp.c
	arch/arm/mach-mvebu/coherency.c
	arch/arm/mach-mvebu/headsmp.S
	arch/arm/mach-mvebu/platsmp.c
	arch/arm/mach-omap2/omap-headsmp.S
	arch/arm/mach-omap2/omap-smp.c
	arch/arm/mach-prima2/headsmp.S
	arch/arm/mach-prima2/platsmp.c
	arch/arm/mach-shmobile/headsmp-scu.S
	arch/arm/mach-shmobile/headsmp.S
	arch/arm/mach-shmobile/smp-emev2.c
	arch/arm/mach-shmobile/smp-r8a7779.c
	arch/arm/mach-shmobile/smp-sh73a0.c
	arch/arm/mach-socfpga/headsmp.S
	arch/arm/mach-socfpga/platsmp.c
	arch/arm/mach-spear/generic.h
	arch/arm/mach-spear/platsmp.c
	arch/arm/mach-sti/platsmp.c
	arch/arm/mach-tegra/platsmp.c
	arch/arm/mach-tegra/pm.c
	arch/arm/mach-ux500/platsmp.c
	arch/arm/mach-zynq/common.h
	arch/arm/mach-zynq/headsmp.S
	arch/arm/mach-zynq/platsmp.c
	arch/arm/mm/proc-mohawk.S
	arch/arm/mm/proc-v7-2level.S
	arch/arm/mm/proc-v7.S
	arch/arm/plat-versatile/platsmp.c

In STLinux fixed:
 - arch/arm/mach-stm/platsmp.c
Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
---
 arch/arm/common/mcpm_platsmp.c       |   84 +++++++++
 arch/arm/include/asm/arch_timer.h    |  105 +++++++++++
 arch/arm/kernel/head-common.S        |    1 -
 arch/arm/kernel/head.S               |    1 -
 arch/arm/kernel/hw_breakpoint.c      |    4 +-
 arch/arm/kernel/perf_event_cpu.c     |  322 ++++++++++++++++++++++++++++++++++
 arch/arm/kernel/psci_smp.c           |   83 +++++++++
 arch/arm/kernel/smp.c                |   14 +-
 arch/arm/kernel/smp_twd.c            |    6 +-
 arch/arm/mach-keystone/platsmp.c     |   43 +++++
 arch/arm/mach-mvebu/coherency.c      |  156 ++++++++++++++++
 arch/arm/mach-mvebu/headsmp.S        |   47 +++++
 arch/arm/mach-mvebu/platsmp.c        |  131 ++++++++++++++
 arch/arm/mach-prima2/headsmp.S       |   38 ++++
 arch/arm/mach-prima2/platsmp.c       |  148 ++++++++++++++++
 arch/arm/mach-shmobile/headsmp-scu.S |   49 +++++
 arch/arm/mach-shmobile/smp-emev2.c   |   69 +++++++
 arch/arm/mach-socfpga/headsmp.S      |   32 ++++
 arch/arm/mach-socfpga/platsmp.c      |  102 +++++++++++
 arch/arm/mach-spear/generic.h        |   56 ++++++
 arch/arm/mach-spear/platsmp.c        |  122 +++++++++++++
 arch/arm/mach-sti/platsmp.c          |  117 ++++++++++++
 arch/arm/mach-stm/platsmp.c          |   10 +-
 arch/arm/mach-tegra/pm.c             |  248 ++++++++++++++++++++++++++
 arch/arm/mach-zynq/headsmp.S         |   22 +++
 arch/arm/mach-zynq/platsmp.c         |  136 ++++++++++++++
 arch/arm/mm/proc-v7-2level.S         |    6 +-
 arch/arm/mm/proc-v7-3level.S         |    4 -
 arch/arm/mm/proc-v7.S                |   23 +++-
 29 files changed, 2153 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm/common/mcpm_platsmp.c
 create mode 100644 arch/arm/include/asm/arch_timer.h
 create mode 100644 arch/arm/kernel/perf_event_cpu.c
 create mode 100644 arch/arm/kernel/psci_smp.c
 create mode 100644 arch/arm/mach-keystone/platsmp.c
 create mode 100644 arch/arm/mach-mvebu/coherency.c
 create mode 100644 arch/arm/mach-mvebu/headsmp.S
 create mode 100644 arch/arm/mach-mvebu/platsmp.c
 create mode 100644 arch/arm/mach-prima2/headsmp.S
 create mode 100644 arch/arm/mach-prima2/platsmp.c
 create mode 100644 arch/arm/mach-shmobile/headsmp-scu.S
 create mode 100644 arch/arm/mach-shmobile/smp-emev2.c
 create mode 100644 arch/arm/mach-socfpga/headsmp.S
 create mode 100644 arch/arm/mach-socfpga/platsmp.c
 create mode 100644 arch/arm/mach-spear/generic.h
 create mode 100644 arch/arm/mach-spear/platsmp.c
 create mode 100644 arch/arm/mach-sti/platsmp.c
 create mode 100644 arch/arm/mach-tegra/pm.c
 create mode 100644 arch/arm/mach-zynq/headsmp.S
 create mode 100644 arch/arm/mach-zynq/platsmp.c

diff --git a/arch/arm/common/mcpm_platsmp.c b/arch/arm/common/mcpm_platsmp.c
new file mode 100644
index 0000000..1bc34c7
--- /dev/null
+++ b/arch/arm/common/mcpm_platsmp.c
@@ -0,0 +1,84 @@
+/*
+ * linux/arch/arm/mach-vexpress/mcpm_platsmp.c
+ *
+ * Created by:  Nicolas Pitre, November 2012
+ * Copyright:   (C) 2012-2013  Linaro Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Code to handle secondary CPU bringup and hotplug for the cluster power API.
+ */
+
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+
+#include <asm/mcpm.h>
+#include <asm/smp.h>
+#include <asm/smp_plat.h>
+
+static int mcpm_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	unsigned int mpidr, pcpu, pcluster, ret;
+	extern void secondary_startup(void);
+
+	mpidr = cpu_logical_map(cpu);
+	pcpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	pcluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+	pr_debug("%s: logical CPU %d is physical CPU %d cluster %d\n",
+		 __func__, cpu, pcpu, pcluster);
+
+	mcpm_set_entry_vector(pcpu, pcluster, NULL);
+	ret = mcpm_cpu_power_up(pcpu, pcluster);
+	if (ret)
+		return ret;
+	mcpm_set_entry_vector(pcpu, pcluster, secondary_startup);
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+	dsb_sev();
+	return 0;
+}
+
+static void mcpm_secondary_init(unsigned int cpu)
+{
+	mcpm_cpu_powered_up();
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+
+static int mcpm_cpu_disable(unsigned int cpu)
+{
+	/*
+	 * We assume all CPUs may be shut down.
+	 * This would be the hook to use for eventual Secure
+	 * OS migration requests as described in the PSCI spec.
+	 */
+	return 0;
+}
+
+static void mcpm_cpu_die(unsigned int cpu)
+{
+	unsigned int mpidr, pcpu, pcluster;
+	mpidr = read_cpuid_mpidr();
+	pcpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	pcluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+	mcpm_set_entry_vector(pcpu, pcluster, NULL);
+	mcpm_cpu_power_down();
+}
+
+#endif
+
+static struct smp_operations __initdata mcpm_smp_ops = {
+	.smp_boot_secondary	= mcpm_boot_secondary,
+	.smp_secondary_init	= mcpm_secondary_init,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_disable		= mcpm_cpu_disable,
+	.cpu_die		= mcpm_cpu_die,
+#endif
+};
+
+void __init mcpm_smp_set_ops(void)
+{
+	smp_set_ops(&mcpm_smp_ops);
+}
diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
new file mode 100644
index 0000000..e406d57
--- /dev/null
+++ b/arch/arm/include/asm/arch_timer.h
@@ -0,0 +1,105 @@
+#ifndef __ASMARM_ARCH_TIMER_H
+#define __ASMARM_ARCH_TIMER_H
+
+#include <asm/barrier.h>
+#include <asm/errno.h>
+#include <linux/clocksource.h>
+#include <linux/init.h>
+#include <linux/types.h>
+
+#include <clocksource/arm_arch_timer.h>
+
+#ifdef CONFIG_ARM_ARCH_TIMER
+int arch_timer_arch_init(void);
+
+/*
+ * These register accessors are marked inline so the compiler can
+ * nicely work out which register we want, and chuck away the rest of
+ * the code. At least it does so with a recent GCC (4.6.3).
+ */
+static inline void arch_timer_reg_write(const int access, const int reg, u32 val)
+{
+	if (access == ARCH_TIMER_PHYS_ACCESS) {
+		switch (reg) {
+		case ARCH_TIMER_REG_CTRL:
+			asm volatile("mcr p15, 0, %0, c14, c2, 1" : : "r" (val));
+			break;
+		case ARCH_TIMER_REG_TVAL:
+			asm volatile("mcr p15, 0, %0, c14, c2, 0" : : "r" (val));
+			break;
+		}
+	}
+
+	if (access == ARCH_TIMER_VIRT_ACCESS) {
+		switch (reg) {
+		case ARCH_TIMER_REG_CTRL:
+			asm volatile("mcr p15, 0, %0, c14, c3, 1" : : "r" (val));
+			break;
+		case ARCH_TIMER_REG_TVAL:
+			asm volatile("mcr p15, 0, %0, c14, c3, 0" : : "r" (val));
+			break;
+		}
+	}
+
+	isb();
+}
+
+static inline u32 arch_timer_reg_read(const int access, const int reg)
+{
+	u32 val = 0;
+
+	if (access == ARCH_TIMER_PHYS_ACCESS) {
+		switch (reg) {
+		case ARCH_TIMER_REG_CTRL:
+			asm volatile("mrc p15, 0, %0, c14, c2, 1" : "=r" (val));
+			break;
+		case ARCH_TIMER_REG_TVAL:
+			asm volatile("mrc p15, 0, %0, c14, c2, 0" : "=r" (val));
+			break;
+		}
+	}
+
+	if (access == ARCH_TIMER_VIRT_ACCESS) {
+		switch (reg) {
+		case ARCH_TIMER_REG_CTRL:
+			asm volatile("mrc p15, 0, %0, c14, c3, 1" : "=r" (val));
+			break;
+		case ARCH_TIMER_REG_TVAL:
+			asm volatile("mrc p15, 0, %0, c14, c3, 0" : "=r" (val));
+			break;
+		}
+	}
+
+	return val;
+}
+
+static inline u32 arch_timer_get_cntfrq(void)
+{
+	u32 val;
+	asm volatile("mrc p15, 0, %0, c14, c0, 0" : "=r" (val));
+	return val;
+}
+
+static inline u64 arch_counter_get_cntvct(void)
+{
+	u64 cval;
+
+	isb();
+	asm volatile("mrrc p15, 1, %Q0, %R0, c14" : "=r" (cval));
+	return cval;
+}
+
+static inline void arch_counter_set_user_access(void)
+{
+	u32 cntkctl;
+
+	asm volatile("mrc p15, 0, %0, c14, c1, 0" : "=r" (cntkctl));
+
+	/* disable user access to everything */
+	cntkctl &= ~((3 << 8) | (7 << 0));
+
+	asm volatile("mcr p15, 0, %0, c14, c1, 0" : : "r" (cntkctl));
+}
+#endif
+
+#endif
diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index c1d351e..3186b38 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -141,7 +141,6 @@ ENDPROC(lookup_processor_type)
  *	r5 = proc_info pointer in physical address space
  *	r9 = cpuid (preserved)
  */
-	__CPUINIT
 ENTRY(__lookup_processor_type)
 	adr	r3, __lookup_processor_type_data
 	ldmia	r3, {r4 - r6}
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 172177d..e67921a 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -337,7 +337,6 @@ __turn_mmu_on_loc:
 	.long	__turn_mmu_on_end
 
 #if defined(CONFIG_SMP)
-	__CPUINIT
 ENTRY(secondary_startup)
 	/*
 	 * Common entry point for secondary CPUs.
diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 18d39ea..7cc47c1 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -976,7 +976,7 @@ reset_regs:
 	}
 }
 
-static int __cpuinit dbg_reset_notify(struct notifier_block *self,
+static int dbg_reset_notify(struct notifier_block *self,
 				      unsigned long action, void *cpu)
 {
 	if (action == CPU_ONLINE)
@@ -985,7 +985,7 @@ static int __cpuinit dbg_reset_notify(struct notifier_block *self,
 	return NOTIFY_OK;
 }
 
-static struct notifier_block __cpuinitdata dbg_reset_nb = {
+static struct notifier_block dbg_reset_nb = {
 	.notifier_call = dbg_reset_notify,
 };
 
diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
new file mode 100644
index 0000000..aebe0e9
--- /dev/null
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -0,0 +1,322 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) 2012 ARM Limited
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ */
+#define pr_fmt(fmt) "CPU PMU: " fmt
+
+#include <linux/bitmap.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include <asm/cputype.h>
+#include <asm/irq_regs.h>
+#include <asm/pmu.h>
+
+/* Set at runtime when we know what CPU type we are. */
+static struct arm_pmu *cpu_pmu;
+
+static DEFINE_PER_CPU(struct perf_event * [ARMPMU_MAX_HWEVENTS], hw_events);
+static DEFINE_PER_CPU(unsigned long [BITS_TO_LONGS(ARMPMU_MAX_HWEVENTS)], used_mask);
+static DEFINE_PER_CPU(struct pmu_hw_events, cpu_hw_events);
+
+/*
+ * Despite the names, these two functions are CPU-specific and are used
+ * by the OProfile/perf code.
+ */
+const char *perf_pmu_name(void)
+{
+	if (!cpu_pmu)
+		return NULL;
+
+	return cpu_pmu->name;
+}
+EXPORT_SYMBOL_GPL(perf_pmu_name);
+
+int perf_num_counters(void)
+{
+	int max_events = 0;
+
+	if (cpu_pmu != NULL)
+		max_events = cpu_pmu->num_events;
+
+	return max_events;
+}
+EXPORT_SYMBOL_GPL(perf_num_counters);
+
+/* Include the PMU-specific implementations. */
+#include "perf_event_xscale.c"
+#include "perf_event_v6.c"
+#include "perf_event_v7.c"
+
+static struct pmu_hw_events *cpu_pmu_get_cpu_events(void)
+{
+	return &__get_cpu_var(cpu_hw_events);
+}
+
+static void cpu_pmu_free_irq(struct arm_pmu *cpu_pmu)
+{
+	int i, irq, irqs;
+	struct platform_device *pmu_device = cpu_pmu->plat_device;
+
+	irqs = min(pmu_device->num_resources, num_possible_cpus());
+
+	for (i = 0; i < irqs; ++i) {
+		if (!cpumask_test_and_clear_cpu(i, &cpu_pmu->active_irqs))
+			continue;
+		irq = platform_get_irq(pmu_device, i);
+		if (irq >= 0)
+			free_irq(irq, cpu_pmu);
+	}
+}
+
+static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
+{
+	int i, err, irq, irqs;
+	struct platform_device *pmu_device = cpu_pmu->plat_device;
+
+	if (!pmu_device)
+		return -ENODEV;
+
+	irqs = min(pmu_device->num_resources, num_possible_cpus());
+	if (irqs < 1) {
+		pr_err("no irqs for PMUs defined\n");
+		return -ENODEV;
+	}
+
+	for (i = 0; i < irqs; ++i) {
+		err = 0;
+		irq = platform_get_irq(pmu_device, i);
+		if (irq < 0)
+			continue;
+
+		/*
+		 * If we have a single PMU interrupt that we can't shift,
+		 * assume that we're running on a uniprocessor machine and
+		 * continue. Otherwise, continue without this interrupt.
+		 */
+		if (irq_set_affinity(irq, cpumask_of(i)) && irqs > 1) {
+			pr_warning("unable to set irq affinity (irq=%d, cpu=%u)\n",
+				    irq, i);
+			continue;
+		}
+
+		err = request_irq(irq, handler, IRQF_NOBALANCING, "arm-pmu",
+				  cpu_pmu);
+		if (err) {
+			pr_err("unable to request IRQ%d for ARM PMU counters\n",
+				irq);
+			return err;
+		}
+
+		cpumask_set_cpu(i, &cpu_pmu->active_irqs);
+	}
+
+	return 0;
+}
+
+static void cpu_pmu_init(struct arm_pmu *cpu_pmu)
+{
+	int cpu;
+	for_each_possible_cpu(cpu) {
+		struct pmu_hw_events *events = &per_cpu(cpu_hw_events, cpu);
+		events->events = per_cpu(hw_events, cpu);
+		events->used_mask = per_cpu(used_mask, cpu);
+		raw_spin_lock_init(&events->pmu_lock);
+	}
+
+	cpu_pmu->get_hw_events	= cpu_pmu_get_cpu_events;
+	cpu_pmu->request_irq	= cpu_pmu_request_irq;
+	cpu_pmu->free_irq	= cpu_pmu_free_irq;
+
+	/* Ensure the PMU has sane values out of reset. */
+	if (cpu_pmu->reset)
+		on_each_cpu(cpu_pmu->reset, cpu_pmu, 1);
+}
+
+/*
+ * PMU hardware loses all context when a CPU goes offline.
+ * When a CPU is hotplugged back in, since some hardware registers are
+ * UNKNOWN at reset, the PMU must be explicitly reset to avoid reading
+ * junk values out of them.
+ */
+static int cpu_pmu_notify(struct notifier_block *b, unsigned long action,
+			  void *hcpu)
+{
+	if ((action & ~CPU_TASKS_FROZEN) != CPU_STARTING)
+		return NOTIFY_DONE;
+
+	if (cpu_pmu && cpu_pmu->reset)
+		cpu_pmu->reset(cpu_pmu);
+	else
+		return NOTIFY_DONE;
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block cpu_pmu_hotplug_notifier = {
+	.notifier_call = cpu_pmu_notify,
+};
+
+/*
+ * PMU platform driver and devicetree bindings.
+ */
+static struct of_device_id cpu_pmu_of_device_ids[] = {
+	{.compatible = "arm,cortex-a15-pmu",	.data = armv7_a15_pmu_init},
+	{.compatible = "arm,cortex-a9-pmu",	.data = armv7_a9_pmu_init},
+	{.compatible = "arm,cortex-a8-pmu",	.data = armv7_a8_pmu_init},
+	{.compatible = "arm,cortex-a7-pmu",	.data = armv7_a7_pmu_init},
+	{.compatible = "arm,cortex-a5-pmu",	.data = armv7_a5_pmu_init},
+	{.compatible = "arm,arm11mpcore-pmu",	.data = armv6mpcore_pmu_init},
+	{.compatible = "arm,arm1176-pmu",	.data = armv6pmu_init},
+	{.compatible = "arm,arm1136-pmu",	.data = armv6pmu_init},
+	{},
+};
+
+static struct platform_device_id cpu_pmu_plat_device_ids[] = {
+	{.name = "arm-pmu"},
+	{},
+};
+
+/*
+ * CPU PMU identification and probing.
+ */
+static int probe_current_pmu(struct arm_pmu *pmu)
+{
+	int cpu = get_cpu();
+	unsigned long implementor = read_cpuid_implementor();
+	unsigned long part_number = read_cpuid_part_number();
+	int ret = -ENODEV;
+
+	pr_info("probing PMU on CPU %d\n", cpu);
+
+	/* ARM Ltd CPUs. */
+	if (implementor == ARM_CPU_IMP_ARM) {
+		switch (part_number) {
+		case ARM_CPU_PART_ARM1136:
+		case ARM_CPU_PART_ARM1156:
+		case ARM_CPU_PART_ARM1176:
+			ret = armv6pmu_init(pmu);
+			break;
+		case ARM_CPU_PART_ARM11MPCORE:
+			ret = armv6mpcore_pmu_init(pmu);
+			break;
+		case ARM_CPU_PART_CORTEX_A8:
+			ret = armv7_a8_pmu_init(pmu);
+			break;
+		case ARM_CPU_PART_CORTEX_A9:
+			ret = armv7_a9_pmu_init(pmu);
+			break;
+		case ARM_CPU_PART_CORTEX_A5:
+			ret = armv7_a5_pmu_init(pmu);
+			break;
+		case ARM_CPU_PART_CORTEX_A15:
+			ret = armv7_a15_pmu_init(pmu);
+			break;
+		case ARM_CPU_PART_CORTEX_A7:
+			ret = armv7_a7_pmu_init(pmu);
+			break;
+		}
+	/* Intel CPUs [xscale]. */
+	} else if (implementor == ARM_CPU_IMP_INTEL) {
+		switch (xscale_cpu_arch_version()) {
+		case ARM_CPU_XSCALE_ARCH_V1:
+			ret = xscale1pmu_init(pmu);
+			break;
+		case ARM_CPU_XSCALE_ARCH_V2:
+			ret = xscale2pmu_init(pmu);
+			break;
+		}
+	}
+
+	put_cpu();
+	return ret;
+}
+
+static int cpu_pmu_device_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *of_id;
+	int (*init_fn)(struct arm_pmu *);
+	struct device_node *node = pdev->dev.of_node;
+	struct arm_pmu *pmu;
+	int ret = -ENODEV;
+
+	if (cpu_pmu) {
+		pr_info("attempt to register multiple PMU devices!");
+		return -ENOSPC;
+	}
+
+	pmu = kzalloc(sizeof(struct arm_pmu), GFP_KERNEL);
+	if (!pmu) {
+		pr_info("failed to allocate PMU device!");
+		return -ENOMEM;
+	}
+
+	if (node && (of_id = of_match_node(cpu_pmu_of_device_ids, pdev->dev.of_node))) {
+		init_fn = of_id->data;
+		ret = init_fn(pmu);
+	} else {
+		ret = probe_current_pmu(pmu);
+	}
+
+	if (ret) {
+		pr_info("failed to probe PMU!");
+		goto out_free;
+	}
+
+	cpu_pmu = pmu;
+	cpu_pmu->plat_device = pdev;
+	cpu_pmu_init(cpu_pmu);
+	ret = armpmu_register(cpu_pmu, PERF_TYPE_RAW);
+
+	if (!ret)
+		return 0;
+
+out_free:
+	pr_info("failed to register PMU devices!");
+	kfree(pmu);
+	return ret;
+}
+
+static struct platform_driver cpu_pmu_driver = {
+	.driver		= {
+		.name	= "arm-pmu",
+		.pm	= &armpmu_dev_pm_ops,
+		.of_match_table = cpu_pmu_of_device_ids,
+	},
+	.probe		= cpu_pmu_device_probe,
+	.id_table	= cpu_pmu_plat_device_ids,
+};
+
+static int __init register_pmu_driver(void)
+{
+	int err;
+
+	err = register_cpu_notifier(&cpu_pmu_hotplug_notifier);
+	if (err)
+		return err;
+
+	err = platform_driver_register(&cpu_pmu_driver);
+	if (err)
+		unregister_cpu_notifier(&cpu_pmu_hotplug_notifier);
+
+	return err;
+}
+device_initcall(register_pmu_driver);
diff --git a/arch/arm/kernel/psci_smp.c b/arch/arm/kernel/psci_smp.c
new file mode 100644
index 0000000..70ded3f
--- /dev/null
+++ b/arch/arm/kernel/psci_smp.c
@@ -0,0 +1,83 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Copyright (C) 2012 ARM Limited
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ */
+
+#include <linux/init.h>
+#include <linux/irqchip/arm-gic.h>
+#include <linux/smp.h>
+#include <linux/of.h>
+
+#include <asm/psci.h>
+#include <asm/smp_plat.h>
+
+/*
+ * psci_smp assumes that the following is true about PSCI:
+ *
+ * cpu_suspend   Suspend the execution on a CPU
+ * @state        we don't currently describe affinity levels, so just pass 0.
+ * @entry_point  the first instruction to be executed on return
+ * returns 0  success, < 0 on failure
+ *
+ * cpu_off       Power down a CPU
+ * @state        we don't currently describe affinity levels, so just pass 0.
+ * no return on successful call
+ *
+ * cpu_on        Power up a CPU
+ * @cpuid        cpuid of target CPU, as from MPIDR
+ * @entry_point  the first instruction to be executed on return
+ * returns 0  success, < 0 on failure
+ *
+ * migrate       Migrate the context to a different CPU
+ * @cpuid        cpuid of target CPU, as from MPIDR
+ * returns 0  success, < 0 on failure
+ *
+ */
+
+extern void secondary_startup(void);
+
+static int psci_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	if (psci_ops.cpu_on)
+		return psci_ops.cpu_on(cpu_logical_map(cpu),
+				       __pa(secondary_startup));
+	return -ENODEV;
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+void __ref psci_cpu_die(unsigned int cpu)
+{
+       const struct psci_power_state ps = {
+               .type = PSCI_POWER_STATE_TYPE_POWER_DOWN,
+       };
+
+       if (psci_ops.cpu_off)
+               psci_ops.cpu_off(ps);
+
+       /* We should never return */
+       panic("psci: cpu %d failed to shutdown\n", cpu);
+}
+#endif
+
+bool __init psci_smp_available(void)
+{
+	/* is cpu_on available@least? */
+	return (psci_ops.cpu_on != NULL);
+}
+
+struct smp_operations __initdata psci_smp_ops = {
+	.smp_boot_secondary	= psci_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= psci_cpu_die,
+#endif
+};
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 9940f35..6506eb1 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -50,6 +50,12 @@
  */
 struct secondary_data secondary_data;
 
+/*
+ * control for which core is the next to come out of the secondary
+ * boot "holding pen"
+ */
+volatile int pen_release = -1;
+
 enum ipi_msg_type {
 	IPI_TIMER = 2,
 	IPI_RESCHEDULE,
@@ -236,7 +242,7 @@ void __ref cpu_die(void)
  * Called by both boot and secondaries to move global data into
  * per-processor storage.
  */
-static void __cpuinit smp_store_cpu_info(unsigned int cpuid)
+static void smp_store_cpu_info(unsigned int cpuid)
 {
 	struct cpuinfo_arm *cpu_info = &per_cpu(cpu_data, cpuid);
 
@@ -251,7 +257,7 @@ static void percpu_timer_setup(void);
  * This is the secondary CPU boot entry.  We're using this CPUs
  * idle thread stack, but a set of temporary page tables.
  */
-asmlinkage void __cpuinit secondary_start_kernel(void)
+asmlinkage void secondary_start_kernel(void)
 {
 	struct mm_struct *mm = &init_mm;
 	unsigned int cpu;
@@ -447,7 +453,7 @@ static void broadcast_timer_set_mode(enum clock_event_mode mode,
 {
 }
 
-static void __cpuinit broadcast_timer_setup(struct clock_event_device *evt)
+static void broadcast_timer_setup(struct clock_event_device *evt)
 {
 	evt->name	= "dummy_timer";
 	evt->features	= CLOCK_EVT_FEAT_ONESHOT |
@@ -473,7 +479,7 @@ int local_timer_register(struct local_timer_ops *ops)
 }
 #endif
 
-static void __cpuinit percpu_timer_setup(void)
+static void percpu_timer_setup(void)
 {
 	unsigned int cpu = smp_processor_id();
 	struct clock_event_device *evt = &per_cpu(percpu_clockevent, cpu);
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 146d0a0..61cc177 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -145,7 +145,7 @@ core_initcall(twd_cpufreq_init);
 
 #endif
 
-static void __cpuinit twd_calibrate_rate(void)
+static void twd_calibrate_rate(void)
 {
 	unsigned long count;
 	u64 waitjiffies;
@@ -228,7 +228,7 @@ static struct clk *twd_get_clock(void)
 /*
  * Setup the local clock events for a CPU.
  */
-static int __cpuinit twd_timer_setup(struct clock_event_device *clk)
+static int twd_timer_setup(struct clock_event_device *clk)
 {
 	struct clock_event_device **this_cpu_clk;
 
@@ -260,7 +260,7 @@ static int __cpuinit twd_timer_setup(struct clock_event_device *clk)
 	return 0;
 }
 
-static struct local_timer_ops twd_lt_ops __cpuinitdata = {
+static struct local_timer_ops twd_lt_ops = {
 	.setup	= twd_timer_setup,
 	.stop	= twd_timer_stop,
 };
diff --git a/arch/arm/mach-keystone/platsmp.c b/arch/arm/mach-keystone/platsmp.c
new file mode 100644
index 0000000..14378e3
--- /dev/null
+++ b/arch/arm/mach-keystone/platsmp.c
@@ -0,0 +1,43 @@
+/*
+ * Keystone SOC SMP platform code
+ *
+ * Copyright 2013 Texas Instruments, Inc.
+ *	Cyril Chemparathy <cyril@ti.com>
+ *	Santosh Shilimkar <santosh.shillimkar@ti.com>
+ *
+ * Based on platsmp.c, Copyright (C) 2002 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/io.h>
+
+#include <asm/smp_plat.h>
+#include <asm/prom.h>
+
+#include "keystone.h"
+
+static int keystone_smp_boot_secondary(unsigned int cpu,
+						struct task_struct *idle)
+{
+	unsigned long start = virt_to_phys(&secondary_startup);
+	int error;
+
+	pr_debug("keystone-smp: booting cpu %d, vector %08lx\n",
+		 cpu, start);
+
+	error = keystone_cpu_smc(KEYSTONE_MON_CPU_UP_IDX, cpu, start);
+	if (error)
+		pr_err("CPU %d bringup failed with %d\n", cpu, error);
+
+	return error;
+}
+
+struct smp_operations keystone_smp_ops __initdata = {
+	.smp_init_cpus		= arm_dt_init_cpu_maps,
+	.smp_boot_secondary	= keystone_smp_boot_secondary,
+};
diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
new file mode 100644
index 0000000..4c24303
--- /dev/null
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -0,0 +1,156 @@
+/*
+ * Coherency fabric (Aurora) support for Armada 370 and XP platforms.
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Yehuda Yitschak <yehuday@marvell.com>
+ * Gregory Clement <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * The Armada 370 and Armada XP SOCs have a coherency fabric which is
+ * responsible for ensuring hardware coherency between all CPUs and between
+ * CPUs and I/O masters. This file initializes the coherency fabric and
+ * supplies basic routines for configuring and controlling hardware coherency
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of_address.h>
+#include <linux/io.h>
+#include <linux/smp.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+#include <asm/smp_plat.h>
+#include <asm/cacheflush.h>
+#include "armada-370-xp.h"
+
+unsigned long coherency_phys_base;
+static void __iomem *coherency_base;
+static void __iomem *coherency_cpu_base;
+
+/* Coherency fabric registers */
+#define COHERENCY_FABRIC_CFG_OFFSET		   0x4
+
+#define IO_SYNC_BARRIER_CTL_OFFSET		   0x0
+
+static struct of_device_id of_coherency_table[] = {
+	{.compatible = "marvell,coherency-fabric"},
+	{ /* end of list */ },
+};
+
+/* Function defined in coherency_ll.S */
+int ll_set_cpu_coherent(void __iomem *base_addr, unsigned int hw_cpu_id);
+
+int set_cpu_coherent(unsigned int hw_cpu_id, int smp_group_id)
+{
+	if (!coherency_base) {
+		pr_warn("Can't make CPU %d cache coherent.\n", hw_cpu_id);
+		pr_warn("Coherency fabric is not initialized\n");
+		return 1;
+	}
+
+	return ll_set_cpu_coherent(coherency_base, hw_cpu_id);
+}
+
+static inline void mvebu_hwcc_sync_io_barrier(void)
+{
+	writel(0x1, coherency_cpu_base + IO_SYNC_BARRIER_CTL_OFFSET);
+	while (readl(coherency_cpu_base + IO_SYNC_BARRIER_CTL_OFFSET) & 0x1);
+}
+
+static dma_addr_t mvebu_hwcc_dma_map_page(struct device *dev, struct page *page,
+				  unsigned long offset, size_t size,
+				  enum dma_data_direction dir,
+				  struct dma_attrs *attrs)
+{
+	if (dir != DMA_TO_DEVICE)
+		mvebu_hwcc_sync_io_barrier();
+	return pfn_to_dma(dev, page_to_pfn(page)) + offset;
+}
+
+
+static void mvebu_hwcc_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
+			      size_t size, enum dma_data_direction dir,
+			      struct dma_attrs *attrs)
+{
+	if (dir != DMA_TO_DEVICE)
+		mvebu_hwcc_sync_io_barrier();
+}
+
+static void mvebu_hwcc_dma_sync(struct device *dev, dma_addr_t dma_handle,
+			size_t size, enum dma_data_direction dir)
+{
+	if (dir != DMA_TO_DEVICE)
+		mvebu_hwcc_sync_io_barrier();
+}
+
+static struct dma_map_ops mvebu_hwcc_dma_ops = {
+	.alloc			= arm_dma_alloc,
+	.free			= arm_dma_free,
+	.mmap			= arm_dma_mmap,
+	.map_page		= mvebu_hwcc_dma_map_page,
+	.unmap_page		= mvebu_hwcc_dma_unmap_page,
+	.get_sgtable		= arm_dma_get_sgtable,
+	.map_sg			= arm_dma_map_sg,
+	.unmap_sg		= arm_dma_unmap_sg,
+	.sync_single_for_cpu	= mvebu_hwcc_dma_sync,
+	.sync_single_for_device	= mvebu_hwcc_dma_sync,
+	.sync_sg_for_cpu	= arm_dma_sync_sg_for_cpu,
+	.sync_sg_for_device	= arm_dma_sync_sg_for_device,
+	.set_dma_mask		= arm_dma_set_mask,
+};
+
+static int mvebu_hwcc_platform_notifier(struct notifier_block *nb,
+				       unsigned long event, void *__dev)
+{
+	struct device *dev = __dev;
+
+	if (event != BUS_NOTIFY_ADD_DEVICE)
+		return NOTIFY_DONE;
+	set_dma_ops(dev, &mvebu_hwcc_dma_ops);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block mvebu_hwcc_platform_nb = {
+	.notifier_call = mvebu_hwcc_platform_notifier,
+};
+
+int __init coherency_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, of_coherency_table);
+	if (np) {
+		struct resource res;
+		pr_info("Initializing Coherency fabric\n");
+		of_address_to_resource(np, 0, &res);
+		coherency_phys_base = res.start;
+		/*
+		 * Ensure secondary CPUs will see the updated value,
+		 * which they read before they join the coherency
+		 * fabric, and therefore before they are coherent with
+		 * the boot CPU cache.
+		 */
+		sync_cache_w(&coherency_phys_base);
+		coherency_base = of_iomap(np, 0);
+		coherency_cpu_base = of_iomap(np, 1);
+		set_cpu_coherent(cpu_logical_map(smp_processor_id()), 0);
+	}
+
+	return 0;
+}
+
+static int __init coherency_late_init(void)
+{
+	if (of_find_matching_node(NULL, of_coherency_table))
+		bus_register_notifier(&platform_bus_type,
+				      &mvebu_hwcc_platform_nb);
+	return 0;
+}
+
+postcore_initcall(coherency_late_init);
diff --git a/arch/arm/mach-mvebu/headsmp.S b/arch/arm/mach-mvebu/headsmp.S
new file mode 100644
index 0000000..8a1b0c9
--- /dev/null
+++ b/arch/arm/mach-mvebu/headsmp.S
@@ -0,0 +1,47 @@
+/*
+ * SMP support: Entry point for secondary CPUs
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Yehuda Yitschak <yehuday@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * This file implements the assembly entry point for secondary CPUs in
+ * an SMP kernel. The only thing we need to do is to add the CPU to
+ * the coherency fabric by writing to 2 registers. Currently the base
+ * register addresses are hard coded due to the early initialisation
+ * problems.
+ */
+
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+/*
+ * Armada XP specific entry point for secondary CPUs.
+ * We add the CPU to the coherency fabric and then jump to secondary
+ * startup
+ */
+ENTRY(armada_xp_secondary_startup)
+	/* Get coherency fabric base physical address */
+	adr	r0, 1f
+	ldr	r1, [r0]
+	ldr	r0, [r0, r1]
+
+	/* Read CPU id */
+	mrc     p15, 0, r1, c0, c0, 5
+	and     r1, r1, #0xF
+
+	/* Add CPU to coherency fabric */
+	bl	ll_set_cpu_coherent
+	b	secondary_startup
+
+ENDPROC(armada_xp_secondary_startup)
+
+	.align 2
+1:
+	.long	coherency_phys_base - .
diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
new file mode 100644
index 0000000..ce81d30
--- /dev/null
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -0,0 +1,131 @@
+/*
+ * Symmetric Multi Processing (SMP) support for Armada XP
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Yehuda Yitschak <yehuday@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * The Armada XP SoC has 4 ARMv7 PJ4B CPUs running in full HW coherency
+ * This file implements the routines for preparing the SMP infrastructure
+ * and waking up the secondary CPUs
+ */
+
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/mbus.h>
+#include <asm/cacheflush.h>
+#include <asm/smp_plat.h>
+#include "common.h"
+#include "armada-370-xp.h"
+#include "pmsu.h"
+#include "coherency.h"
+
+void __init set_secondary_cpus_clock(void)
+{
+	int thiscpu;
+	unsigned long rate;
+	struct clk *cpu_clk = NULL;
+	struct device_node *np = NULL;
+
+	thiscpu = smp_processor_id();
+	for_each_node_by_type(np, "cpu") {
+		int err;
+		int cpu;
+
+		err = of_property_read_u32(np, "reg", &cpu);
+		if (WARN_ON(err))
+			return;
+
+		if (cpu == thiscpu) {
+			cpu_clk = of_clk_get(np, 0);
+			break;
+		}
+	}
+	if (WARN_ON(IS_ERR(cpu_clk)))
+		return;
+	clk_prepare_enable(cpu_clk);
+	rate = clk_get_rate(cpu_clk);
+
+	/* set all the other CPU clk to the same rate than the boot CPU */
+	for_each_node_by_type(np, "cpu") {
+		int err;
+		int cpu;
+
+		err = of_property_read_u32(np, "reg", &cpu);
+		if (WARN_ON(err))
+			return;
+
+		if (cpu != thiscpu) {
+			cpu_clk = of_clk_get(np, 0);
+			clk_set_rate(cpu_clk, rate);
+		}
+	}
+}
+
+static void armada_xp_secondary_init(unsigned int cpu)
+{
+	armada_xp_mpic_smp_cpu_init();
+}
+
+static int armada_xp_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	pr_info("Booting CPU %d\n", cpu);
+
+	armada_xp_boot_cpu(cpu, armada_xp_secondary_startup);
+
+	return 0;
+}
+
+static void __init armada_xp_smp_init_cpus(void)
+{
+	struct device_node *np;
+	unsigned int i, ncores;
+
+	np = of_find_node_by_name(NULL, "cpus");
+	if (!np)
+		panic("No 'cpus' node found\n");
+
+	ncores = of_get_child_count(np);
+	if (ncores == 0 || ncores > ARMADA_XP_MAX_CPUS)
+		panic("Invalid number of CPUs in DT\n");
+
+	/* Limit possible CPUs to defconfig */
+	if (ncores > nr_cpu_ids) {
+		pr_warn("SMP: %d CPUs physically present. Only %d configured.",
+			ncores, nr_cpu_ids);
+		pr_warn("Clipping CPU count to %d\n", nr_cpu_ids);
+		ncores = nr_cpu_ids;
+	}
+
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+
+	set_smp_cross_call(armada_mpic_send_doorbell);
+}
+
+void __init armada_xp_smp_prepare_cpus(unsigned int max_cpus)
+{
+	set_secondary_cpus_clock();
+	flush_cache_all();
+	set_cpu_coherent(cpu_logical_map(smp_processor_id()), 0);
+	mvebu_mbus_add_window("bootrom", 0xfff00000, SZ_1M);
+}
+
+struct smp_operations armada_xp_smp_ops __initdata = {
+	.smp_init_cpus		= armada_xp_smp_init_cpus,
+	.smp_prepare_cpus	= armada_xp_smp_prepare_cpus,
+	.smp_secondary_init	= armada_xp_secondary_init,
+	.smp_boot_secondary	= armada_xp_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= armada_xp_cpu_die,
+#endif
+};
diff --git a/arch/arm/mach-prima2/headsmp.S b/arch/arm/mach-prima2/headsmp.S
new file mode 100644
index 0000000..d86fe33
--- /dev/null
+++ b/arch/arm/mach-prima2/headsmp.S
@@ -0,0 +1,38 @@
+/*
+ * Entry of the second core for CSR Marco dual-core SMP SoCs
+ *
+ * Copyright (c) 2012 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+/*
+ * SIRFSOC specific entry point for secondary CPUs.  This provides
+ * a "holding pen" into which all secondary cores are held until we're
+ * ready for them to initialise.
+ */
+ENTRY(sirfsoc_secondary_startup)
+	bl v7_invalidate_l1
+        mrc     p15, 0, r0, c0, c0, 5
+        and     r0, r0, #15
+        adr     r4, 1f
+        ldmia   r4, {r5, r6}
+        sub     r4, r4, r5
+        add     r6, r6, r4
+pen:    ldr     r7, [r6]
+        cmp     r7, r0
+        bne     pen
+
+        /*
+         * we've been released from the holding pen: secondary_stack
+         * should now contain the SVC stack for this core
+         */
+        b       secondary_startup
+ENDPROC(sirfsoc_secondary_startup)
+
+        .align
+1:      .long   .
+        .long   pen_release
diff --git a/arch/arm/mach-prima2/platsmp.c b/arch/arm/mach-prima2/platsmp.c
new file mode 100644
index 0000000..3dbcb1a
--- /dev/null
+++ b/arch/arm/mach-prima2/platsmp.c
@@ -0,0 +1,148 @@
+/*
+ * plat smp support for CSR Marco dual-core SMP SoCs
+ *
+ * Copyright (c) 2012 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <asm/page.h>
+#include <asm/mach/map.h>
+#include <asm/smp_plat.h>
+#include <asm/smp_scu.h>
+#include <asm/cacheflush.h>
+#include <asm/cputype.h>
+
+#include "common.h"
+
+static void __iomem *scu_base;
+static void __iomem *rsc_base;
+
+static DEFINE_SPINLOCK(boot_lock);
+
+static struct map_desc scu_io_desc __initdata = {
+	.length		= SZ_4K,
+	.type		= MT_DEVICE,
+};
+
+void __init sirfsoc_map_scu(void)
+{
+	unsigned long base;
+
+	/* Get SCU base */
+	asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (base));
+
+	scu_io_desc.virtual = SIRFSOC_VA(base);
+	scu_io_desc.pfn = __phys_to_pfn(base);
+	iotable_init(&scu_io_desc, 1);
+
+	scu_base = (void __iomem *)SIRFSOC_VA(base);
+}
+
+static void sirfsoc_secondary_init(unsigned int cpu)
+{
+	/*
+	 * let the primary processor know we're out of the
+	 * pen, then head off into the C entry point
+	 */
+	pen_release = -1;
+	smp_wmb();
+
+	/*
+	 * Synchronise with the boot thread.
+	 */
+	spin_lock(&boot_lock);
+	spin_unlock(&boot_lock);
+}
+
+static struct of_device_id rsc_ids[]  = {
+	{ .compatible = "sirf,marco-rsc" },
+	{},
+};
+
+static int sirfsoc_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	unsigned long timeout;
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, rsc_ids);
+	if (!np)
+		return -ENODEV;
+
+	rsc_base = of_iomap(np, 0);
+	if (!rsc_base)
+		return -ENOMEM;
+
+	/*
+	 * write the address of secondary startup into the sram register
+	 * at offset 0x2C, then write the magic number 0x3CAF5D62 to the
+	 * RSC register at offset 0x28, which is what boot rom code is
+	 * waiting for. This would wake up the secondary core from WFE
+	 */
+#define SIRFSOC_CPU1_JUMPADDR_OFFSET 0x2C
+	__raw_writel(virt_to_phys(sirfsoc_secondary_startup),
+		rsc_base + SIRFSOC_CPU1_JUMPADDR_OFFSET);
+
+#define SIRFSOC_CPU1_WAKEMAGIC_OFFSET 0x28
+	__raw_writel(0x3CAF5D62,
+		rsc_base + SIRFSOC_CPU1_WAKEMAGIC_OFFSET);
+
+	/* make sure write buffer is drained */
+	mb();
+
+	spin_lock(&boot_lock);
+
+	/*
+	 * The secondary processor is waiting to be released from
+	 * the holding pen - release it, then wait for it to flag
+	 * that it has been released by resetting pen_release.
+	 *
+	 * Note that "pen_release" is the hardware CPU ID, whereas
+	 * "cpu" is Linux's internal ID.
+	 */
+	pen_release = cpu_logical_map(cpu);
+	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
+	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
+
+	/*
+	 * Send the secondary CPU SEV, thereby causing the boot monitor to read
+	 * the JUMPADDR and WAKEMAGIC, and branch to the address found there.
+	 */
+	dsb_sev();
+
+	timeout = jiffies + (1 * HZ);
+	while (time_before(jiffies, timeout)) {
+		smp_rmb();
+		if (pen_release == -1)
+			break;
+
+		udelay(10);
+	}
+
+	/*
+	 * now the secondary core is starting up let it run its
+	 * calibrations, then wait for it to finish
+	 */
+	spin_unlock(&boot_lock);
+
+	return pen_release != -1 ? -ENOSYS : 0;
+}
+
+static void __init sirfsoc_smp_prepare_cpus(unsigned int max_cpus)
+{
+	scu_enable(scu_base);
+}
+
+struct smp_operations sirfsoc_smp_ops __initdata = {
+        .smp_prepare_cpus       = sirfsoc_smp_prepare_cpus,
+        .smp_secondary_init     = sirfsoc_secondary_init,
+        .smp_boot_secondary     = sirfsoc_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die                = sirfsoc_cpu_die,
+#endif
+};
diff --git a/arch/arm/mach-shmobile/headsmp-scu.S b/arch/arm/mach-shmobile/headsmp-scu.S
new file mode 100644
index 0000000..bfd9200
--- /dev/null
+++ b/arch/arm/mach-shmobile/headsmp-scu.S
@@ -0,0 +1,49 @@
+/*
+ * Shared SCU setup for mach-shmobile
+ *
+ * Copyright (C) 2012 Bastian Hecht
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR /PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+
+#include <linux/linkage.h>
+#include <linux/init.h>
+#include <asm/memory.h>
+
+/*
+ * Boot code for secondary CPUs.
+ *
+ * First we turn on L1 cache coherency for our CPU. Then we jump to
+ * shmobile_invalidate_start that invalidates the cache and hands over control
+ * to the common ARM startup code.
+ */
+ENTRY(shmobile_boot_scu)
+					@ r0 = SCU base address
+	mrc     p15, 0, r1, c0, c0, 5	@ read MIPDR
+	and	r1, r1, #3		@ mask out cpu ID
+	lsl	r1, r1, #3		@ we will shift by cpu_id * 8 bits
+	ldr	r2, [r0, #8]		@ SCU Power Status Register
+	mov	r3, #3
+	bic	r2, r2, r3, lsl r1	@ Clear bits of our CPU (Run Mode)
+	str	r2, [r0, #8]		@ write back
+
+	b	shmobile_invalidate_start
+ENDPROC(shmobile_boot_scu)
+
+	.text
+	.globl	shmobile_scu_base
+shmobile_scu_base:
+	.space	4
diff --git a/arch/arm/mach-shmobile/smp-emev2.c b/arch/arm/mach-shmobile/smp-emev2.c
new file mode 100644
index 0000000..22a05a8
--- /dev/null
+++ b/arch/arm/mach-shmobile/smp-emev2.c
@@ -0,0 +1,69 @@
+/*
+ * SMP support for Emma Mobile EV2
+ *
+ * Copyright (C) 2012  Renesas Solutions Corp.
+ * Copyright (C) 2012  Magnus Damm
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <mach/common.h>
+#include <mach/emev2.h>
+#include <asm/smp_plat.h>
+#include <asm/smp_scu.h>
+
+#define EMEV2_SCU_BASE 0x1e000000
+
+static int emev2_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu_logical_map(cpu)));
+	return 0;
+}
+
+static void __init emev2_smp_prepare_cpus(unsigned int max_cpus)
+{
+	scu_enable(shmobile_scu_base);
+
+	/* Tell ROM loader about our vector (in headsmp-scu.S, headsmp.S) */
+	emev2_set_boot_vector(__pa(shmobile_boot_vector));
+	shmobile_boot_fn = virt_to_phys(shmobile_boot_scu);
+	shmobile_boot_arg = (unsigned long)shmobile_scu_base;
+
+	/* enable cache coherency on booting CPU */
+	scu_power_mode(shmobile_scu_base, SCU_PM_NORMAL);
+}
+
+static void __init emev2_smp_init_cpus(void)
+{
+	unsigned int ncores;
+
+	/* setup EMEV2 specific SCU base */
+	shmobile_scu_base = ioremap(EMEV2_SCU_BASE, PAGE_SIZE);
+	emev2_clock_init(); /* need ioremapped SMU */
+
+	ncores = shmobile_scu_base ? scu_get_core_count(shmobile_scu_base) : 1;
+
+	shmobile_smp_init_cpus(ncores);
+}
+
+struct smp_operations emev2_smp_ops __initdata = {
+	.smp_init_cpus		= emev2_smp_init_cpus,
+	.smp_prepare_cpus	= emev2_smp_prepare_cpus,
+	.smp_boot_secondary	= emev2_boot_secondary,
+};
diff --git a/arch/arm/mach-socfpga/headsmp.S b/arch/arm/mach-socfpga/headsmp.S
new file mode 100644
index 0000000..95c115d
--- /dev/null
+++ b/arch/arm/mach-socfpga/headsmp.S
@@ -0,0 +1,32 @@
+/*
+ *  Copyright (c) 2003 ARM Limited
+ *  Copyright (c) u-boot contributors
+ *  Copyright (c) 2012 Pavel Machek <pavel@denx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+	.arch	armv7-a
+
+ENTRY(secondary_trampoline)
+	movw	r2, #:lower16:cpu1start_addr
+	movt  r2, #:upper16:cpu1start_addr
+
+	/* The socfpga VT cannot handle a 0xC0000000 page offset when loading
+		the cpu1start_addr, we bit clear it. Tested on HW and VT. */
+	bic	r2, r2, #0x40000000
+
+	ldr	r0, [r2]
+	ldr	r1, [r0]
+	bx	r1
+
+ENTRY(secondary_trampoline_end)
+
+ENTRY(socfpga_secondary_startup)
+       bl      v7_invalidate_l1
+       b       secondary_startup
+ENDPROC(socfpga_secondary_startup)
diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
new file mode 100644
index 0000000..5356a72
--- /dev/null
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -0,0 +1,102 @@
+/*
+ * Copyright 2010-2011 Calxeda, Inc.
+ * Copyright 2012 Pavel Machek <pavel@denx.de>
+ * Based on platsmp.c, Copyright (C) 2002 ARM Ltd.
+ * Copyright (C) 2012 Altera Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#include <asm/cacheflush.h>
+#include <asm/smp_scu.h>
+#include <asm/smp_plat.h>
+
+#include "core.h"
+
+static int socfpga_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
+
+	if (cpu1start_addr) {
+		memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
+
+		__raw_writel(virt_to_phys(socfpga_secondary_startup),
+			(sys_manager_base_addr + (cpu1start_addr & 0x000000ff)));
+
+		flush_cache_all();
+		smp_wmb();
+		outer_clean_range(0, trampoline_size);
+
+		/* This will release CPU #1 out of reset.*/
+		__raw_writel(0, rst_manager_base_addr + 0x10);
+	}
+
+	return 0;
+}
+
+/*
+ * Initialise the CPU possible map early - this describes the CPUs
+ * which may be present or become present in the system.
+ */
+static void __init socfpga_smp_init_cpus(void)
+{
+	unsigned int i, ncores;
+
+	ncores = scu_get_core_count(socfpga_scu_base_addr);
+
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+
+	/* sanity check */
+	if (ncores > num_possible_cpus()) {
+		pr_warn("socfpga: no. of cores (%d) greater than configured"
+			"maximum of %d - clipping\n", ncores, num_possible_cpus());
+		ncores = num_possible_cpus();
+	}
+
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+}
+
+static void __init socfpga_smp_prepare_cpus(unsigned int max_cpus)
+{
+	scu_enable(socfpga_scu_base_addr);
+}
+
+/*
+ * platform-specific code to shutdown a CPU
+ *
+ * Called with IRQs disabled
+ */
+static void socfpga_cpu_die(unsigned int cpu)
+{
+	cpu_do_idle();
+
+	/* We should have never returned from idle */
+	panic("cpu %d unexpectedly exit from shutdown\n", cpu);
+}
+
+struct smp_operations socfpga_smp_ops __initdata = {
+	.smp_init_cpus		= socfpga_smp_init_cpus,
+	.smp_prepare_cpus	= socfpga_smp_prepare_cpus,
+	.smp_boot_secondary	= socfpga_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= socfpga_cpu_die,
+#endif
+};
diff --git a/arch/arm/mach-spear/generic.h b/arch/arm/mach-spear/generic.h
new file mode 100644
index 0000000..a99d90a
--- /dev/null
+++ b/arch/arm/mach-spear/generic.h
@@ -0,0 +1,56 @@
+/*
+ * spear machine family generic header file
+ *
+ * Copyright (C) 2009-2012 ST Microelectronics
+ * Rajeev Kumar <rajeev-dlh.kumar@st.com>
+ * Viresh Kumar <viresh.linux@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_GENERIC_H
+#define __MACH_GENERIC_H
+
+#include <linux/dmaengine.h>
+#include <linux/amba/pl08x.h>
+#include <linux/init.h>
+#include <linux/reboot.h>
+
+#include <asm/mach/time.h>
+
+extern void spear13xx_timer_init(void);
+extern void spear3xx_timer_init(void);
+extern struct pl022_ssp_controller pl022_plat_data;
+extern struct pl08x_platform_data pl080_plat_data;
+
+void __init spear_setup_of_timer(void);
+void __init spear3xx_clk_init(void __iomem *misc_base,
+			      void __iomem *soc_config_base);
+void __init spear3xx_map_io(void);
+void __init spear3xx_dt_init_irq(void);
+void __init spear6xx_clk_init(void __iomem *misc_base);
+void __init spear13xx_map_io(void);
+void __init spear13xx_l2x0_init(void);
+
+void spear_restart(enum reboot_mode, const char *);
+
+void spear13xx_secondary_startup(void);
+void spear13xx_cpu_die(unsigned int cpu);
+
+extern struct smp_operations spear13xx_smp_ops;
+
+#ifdef CONFIG_MACH_SPEAR1310
+void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base);
+#else
+static inline void spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base) {}
+#endif
+
+#ifdef CONFIG_MACH_SPEAR1340
+void __init spear1340_clk_init(void __iomem *misc_base);
+#else
+static inline void spear1340_clk_init(void __iomem *misc_base) {}
+#endif
+
+#endif /* __MACH_GENERIC_H */
diff --git a/arch/arm/mach-spear/platsmp.c b/arch/arm/mach-spear/platsmp.c
new file mode 100644
index 0000000..5c4a198
--- /dev/null
+++ b/arch/arm/mach-spear/platsmp.c
@@ -0,0 +1,122 @@
+/*
+ * arch/arm/mach-spear13xx/platsmp.c
+ *
+ * based upon linux/arch/arm/mach-realview/platsmp.c
+ *
+ * Copyright (C) 2012 ST Microelectronics Ltd.
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/io.h>
+#include <linux/smp.h>
+#include <asm/cacheflush.h>
+#include <asm/smp_scu.h>
+#include <mach/spear.h>
+#include "generic.h"
+
+static DEFINE_SPINLOCK(boot_lock);
+
+static void __iomem *scu_base = IOMEM(VA_SCU_BASE);
+
+static void spear13xx_secondary_init(unsigned int cpu)
+{
+	/*
+	 * let the primary processor know we're out of the
+	 * pen, then head off into the C entry point
+	 */
+	pen_release = -1;
+	smp_wmb();
+
+	/*
+	 * Synchronise with the boot thread.
+	 */
+	spin_lock(&boot_lock);
+	spin_unlock(&boot_lock);
+}
+
+static int spear13xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	unsigned long timeout;
+
+	/*
+	 * set synchronisation state between this boot processor
+	 * and the secondary one
+	 */
+	spin_lock(&boot_lock);
+
+	/*
+	 * The secondary processor is waiting to be released from
+	 * the holding pen - release it, then wait for it to flag
+	 * that it has been released by resetting pen_release.
+	 *
+	 * Note that "pen_release" is the hardware CPU ID, whereas
+	 * "cpu" is Linux's internal ID.
+	 */
+	pen_release = cpu;
+	flush_cache_all();
+	outer_flush_all();
+
+	timeout = jiffies + (1 * HZ);
+	while (time_before(jiffies, timeout)) {
+		smp_rmb();
+		if (pen_release == -1)
+			break;
+
+		udelay(10);
+	}
+
+	/*
+	 * now the secondary core is starting up let it run its
+	 * calibrations, then wait for it to finish
+	 */
+	spin_unlock(&boot_lock);
+
+	return pen_release != -1 ? -ENOSYS : 0;
+}
+
+/*
+ * Initialise the CPU possible map early - this describes the CPUs
+ * which may be present or become present in the system.
+ */
+static void __init spear13xx_smp_init_cpus(void)
+{
+	unsigned int i, ncores = scu_get_core_count(scu_base);
+
+	if (ncores > nr_cpu_ids) {
+		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
+			ncores, nr_cpu_ids);
+		ncores = nr_cpu_ids;
+	}
+
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+}
+
+static void __init spear13xx_smp_prepare_cpus(unsigned int max_cpus)
+{
+
+	scu_enable(scu_base);
+
+	/*
+	 * Write the address of secondary startup into the system-wide location
+	 * (presently it is in SRAM). The BootMonitor waits until it receives a
+	 * soft interrupt, and then the secondary CPU branches to this address.
+	 */
+	__raw_writel(virt_to_phys(spear13xx_secondary_startup), SYS_LOCATION);
+}
+
+struct smp_operations spear13xx_smp_ops __initdata = {
+       .smp_init_cpus		= spear13xx_smp_init_cpus,
+       .smp_prepare_cpus	= spear13xx_smp_prepare_cpus,
+       .smp_secondary_init	= spear13xx_secondary_init,
+       .smp_boot_secondary	= spear13xx_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+       .cpu_die			= spear13xx_cpu_die,
+#endif
+};
diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
new file mode 100644
index 0000000..dce50d9
--- /dev/null
+++ b/arch/arm/mach-sti/platsmp.c
@@ -0,0 +1,117 @@
+/*
+ *  arch/arm/mach-sti/platsmp.c
+ *
+ * Copyright (C) 2013 STMicroelectronics (R&D) Limited.
+ *		http://www.st.com
+ *
+ * Cloned from linux/arch/arm/mach-vexpress/platsmp.c
+ *
+ *  Copyright (C) 2002 ARM Ltd.
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/smp.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#include <asm/cacheflush.h>
+#include <asm/smp_plat.h>
+#include <asm/smp_scu.h>
+
+#include "smp.h"
+
+static void write_pen_release(int val)
+{
+	pen_release = val;
+	smp_wmb();
+	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
+	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
+}
+
+static DEFINE_SPINLOCK(boot_lock);
+
+void sti_secondary_init(unsigned int cpu)
+{
+	trace_hardirqs_off();
+
+	/*
+	 * let the primary processor know we're out of the
+	 * pen, then head off into the C entry point
+	 */
+	write_pen_release(-1);
+
+	/*
+	 * Synchronise with the boot thread.
+	 */
+	spin_lock(&boot_lock);
+	spin_unlock(&boot_lock);
+}
+
+int sti_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	unsigned long timeout;
+
+	/*
+	 * set synchronisation state between this boot processor
+	 * and the secondary one
+	 */
+	spin_lock(&boot_lock);
+
+	/*
+	 * The secondary processor is waiting to be released from
+	 * the holding pen - release it, then wait for it to flag
+	 * that it has been released by resetting pen_release.
+	 *
+	 * Note that "pen_release" is the hardware CPU ID, whereas
+	 * "cpu" is Linux's internal ID.
+	 */
+	write_pen_release(cpu_logical_map(cpu));
+
+	/*
+	 * Send the secondary CPU a soft interrupt, thereby causing
+	 * it to jump to the secondary entrypoint.
+	 */
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+
+	timeout = jiffies + (1 * HZ);
+	while (time_before(jiffies, timeout)) {
+		smp_rmb();
+		if (pen_release == -1)
+			break;
+
+		udelay(10);
+	}
+
+	/*
+	 * now the secondary core is starting up let it run its
+	 * calibrations, then wait for it to finish
+	 */
+	spin_unlock(&boot_lock);
+
+	return pen_release != -1 ? -ENOSYS : 0;
+}
+
+void __init sti_smp_prepare_cpus(unsigned int max_cpus)
+{
+	void __iomem *scu_base = NULL;
+	struct device_node *np = of_find_compatible_node(
+					NULL, NULL, "arm,cortex-a9-scu");
+	if (np) {
+		scu_base = of_iomap(np, 0);
+		scu_enable(scu_base);
+		of_node_put(np);
+	}
+}
+
+struct smp_operations __initdata sti_smp_ops = {
+	.smp_prepare_cpus	= sti_smp_prepare_cpus,
+	.smp_secondary_init	= sti_secondary_init,
+	.smp_boot_secondary	= sti_boot_secondary,
+};
diff --git a/arch/arm/mach-stm/platsmp.c b/arch/arm/mach-stm/platsmp.c
index 71a3174..c7f2bf5 100644
--- a/arch/arm/mach-stm/platsmp.c
+++ b/arch/arm/mach-stm/platsmp.c
@@ -36,12 +36,12 @@ extern void stm_secondary_startup(void);
  * control for which core is the next to come out of the secondary
  * boot "holding pen"
  */
-volatile int __cpuinitdata pen_release = -1;
+extern volatile int pen_release;
 
 #ifdef CONFIG_HIBERNATION_ON_MEMORY
-void __cpuinit write_pen_release(int val)
+void write_pen_release(int val)
 #else
-static void __cpuinit write_pen_release(int val)
+static void write_pen_release(int val)
 #endif
 {
 	pen_release = val;
@@ -57,7 +57,7 @@ static inline unsigned int get_core_count(void)
 
 static DEFINE_SPINLOCK(boot_lock);
 
-void __cpuinit platform_secondary_init(unsigned int cpu)
+void platform_secondary_init(unsigned int cpu)
 {
 printk("%s(%d)\n", __FUNCTION__, cpu);
 	trace_hardirqs_off();
@@ -82,7 +82,7 @@ printk("%s(%d)\n", __FUNCTION__, cpu);
 	spin_unlock(&boot_lock);
 }
 
-int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+int boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long timeout;
 
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
new file mode 100644
index 0000000..261fec1
--- /dev/null
+++ b/arch/arm/mach-tegra/pm.c
@@ -0,0 +1,248 @@
+/*
+ * CPU complex suspend & resume functions for Tegra SoCs
+ *
+ * Copyright (c) 2009-2012, NVIDIA Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/io.h>
+#include <linux/cpumask.h>
+#include <linux/delay.h>
+#include <linux/cpu_pm.h>
+#include <linux/suspend.h>
+#include <linux/err.h>
+#include <linux/clk/tegra.h>
+
+#include <asm/smp_plat.h>
+#include <asm/cacheflush.h>
+#include <asm/suspend.h>
+#include <asm/idmap.h>
+#include <asm/proc-fns.h>
+#include <asm/tlbflush.h>
+
+#include "iomap.h"
+#include "reset.h"
+#include "flowctrl.h"
+#include "fuse.h"
+#include "pmc.h"
+#include "sleep.h"
+
+#ifdef CONFIG_PM_SLEEP
+static DEFINE_SPINLOCK(tegra_lp2_lock);
+void (*tegra_tear_down_cpu)(void);
+
+static void tegra_tear_down_cpu_init(void)
+{
+	switch (tegra_chip_id) {
+	case TEGRA20:
+		if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
+			tegra_tear_down_cpu = tegra20_tear_down_cpu;
+		break;
+	case TEGRA30:
+		if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC))
+			tegra_tear_down_cpu = tegra30_tear_down_cpu;
+		break;
+	}
+}
+
+/*
+ * restore_cpu_complex
+ *
+ * restores cpu clock setting, clears flow controller
+ *
+ * Always called on CPU 0.
+ */
+static void restore_cpu_complex(void)
+{
+	int cpu = smp_processor_id();
+
+	BUG_ON(cpu != 0);
+
+#ifdef CONFIG_SMP
+	cpu = cpu_logical_map(cpu);
+#endif
+
+	/* Restore the CPU clock settings */
+	tegra_cpu_clock_resume();
+
+	flowctrl_cpu_suspend_exit(cpu);
+}
+
+/*
+ * suspend_cpu_complex
+ *
+ * saves pll state for use by restart_plls, prepares flow controller for
+ * transition to suspend state
+ *
+ * Must always be called on cpu 0.
+ */
+static void suspend_cpu_complex(void)
+{
+	int cpu = smp_processor_id();
+
+	BUG_ON(cpu != 0);
+
+#ifdef CONFIG_SMP
+	cpu = cpu_logical_map(cpu);
+#endif
+
+	/* Save the CPU clock settings */
+	tegra_cpu_clock_suspend();
+
+	flowctrl_cpu_suspend_enter(cpu);
+}
+
+void tegra_clear_cpu_in_lp2(void)
+{
+	int phy_cpu_id = cpu_logical_map(smp_processor_id());
+	u32 *cpu_in_lp2 = tegra_cpu_lp2_mask;
+
+	spin_lock(&tegra_lp2_lock);
+
+	BUG_ON(!(*cpu_in_lp2 & BIT(phy_cpu_id)));
+	*cpu_in_lp2 &= ~BIT(phy_cpu_id);
+
+	spin_unlock(&tegra_lp2_lock);
+}
+
+bool tegra_set_cpu_in_lp2(void)
+{
+	int phy_cpu_id = cpu_logical_map(smp_processor_id());
+	bool last_cpu = false;
+	cpumask_t *cpu_lp2_mask = tegra_cpu_lp2_mask;
+	u32 *cpu_in_lp2 = tegra_cpu_lp2_mask;
+
+	spin_lock(&tegra_lp2_lock);
+
+	BUG_ON((*cpu_in_lp2 & BIT(phy_cpu_id)));
+	*cpu_in_lp2 |= BIT(phy_cpu_id);
+
+	if ((phy_cpu_id == 0) && cpumask_equal(cpu_lp2_mask, cpu_online_mask))
+		last_cpu = true;
+	else if (tegra_chip_id == TEGRA20 && phy_cpu_id == 1)
+		tegra20_cpu_set_resettable_soon();
+
+	spin_unlock(&tegra_lp2_lock);
+	return last_cpu;
+}
+
+int tegra_cpu_do_idle(void)
+{
+	return cpu_do_idle();
+}
+
+static int tegra_sleep_cpu(unsigned long v2p)
+{
+	setup_mm_for_reboot();
+	tegra_sleep_cpu_finish(v2p);
+
+	/* should never here */
+	BUG();
+
+	return 0;
+}
+
+void tegra_idle_lp2_last(void)
+{
+	tegra_pmc_pm_set(TEGRA_SUSPEND_LP2);
+
+	cpu_cluster_pm_enter();
+	suspend_cpu_complex();
+
+	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
+
+	restore_cpu_complex();
+	cpu_cluster_pm_exit();
+}
+
+enum tegra_suspend_mode tegra_pm_validate_suspend_mode(
+				enum tegra_suspend_mode mode)
+{
+	/* Tegra114 didn't support any suspending mode yet. */
+	if (tegra_chip_id == TEGRA114)
+		return TEGRA_SUSPEND_NONE;
+
+	/*
+	 * The Tegra devices only support suspending to LP2 currently.
+	 */
+	if (mode > TEGRA_SUSPEND_LP2)
+		return TEGRA_SUSPEND_LP2;
+
+	return mode;
+}
+
+static const char *lp_state[TEGRA_MAX_SUSPEND_MODE] = {
+	[TEGRA_SUSPEND_NONE] = "none",
+	[TEGRA_SUSPEND_LP2] = "LP2",
+	[TEGRA_SUSPEND_LP1] = "LP1",
+	[TEGRA_SUSPEND_LP0] = "LP0",
+};
+
+static int tegra_suspend_enter(suspend_state_t state)
+{
+	enum tegra_suspend_mode mode = tegra_pmc_get_suspend_mode();
+
+	if (WARN_ON(mode < TEGRA_SUSPEND_NONE ||
+		    mode >= TEGRA_MAX_SUSPEND_MODE))
+		return -EINVAL;
+
+	pr_info("Entering suspend state %s\n", lp_state[mode]);
+
+	tegra_pmc_pm_set(mode);
+
+	local_fiq_disable();
+
+	suspend_cpu_complex();
+	switch (mode) {
+	case TEGRA_SUSPEND_LP2:
+		tegra_set_cpu_in_lp2();
+		break;
+	default:
+		break;
+	}
+
+	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
+
+	switch (mode) {
+	case TEGRA_SUSPEND_LP2:
+		tegra_clear_cpu_in_lp2();
+		break;
+	default:
+		break;
+	}
+	restore_cpu_complex();
+
+	local_fiq_enable();
+
+	return 0;
+}
+
+static const struct platform_suspend_ops tegra_suspend_ops = {
+	.valid		= suspend_valid_only_mem,
+	.enter		= tegra_suspend_enter,
+};
+
+void __init tegra_init_suspend(void)
+{
+	if (tegra_pmc_get_suspend_mode() == TEGRA_SUSPEND_NONE)
+		return;
+
+	tegra_tear_down_cpu_init();
+	tegra_pmc_suspend_init();
+
+	suspend_set_ops(&tegra_suspend_ops);
+}
+#endif
diff --git a/arch/arm/mach-zynq/headsmp.S b/arch/arm/mach-zynq/headsmp.S
new file mode 100644
index 0000000..d4cd5f3
--- /dev/null
+++ b/arch/arm/mach-zynq/headsmp.S
@@ -0,0 +1,22 @@
+/*
+ * Copyright (c) 2013 Steffen Trumtrar <s.trumtrar@pengutronix.de>
+ * Copyright (c) 2012-2013 Xilinx
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+ENTRY(zynq_secondary_trampoline)
+	ldr	r0, [pc]
+	bx	r0
+.globl zynq_secondary_trampoline_jump
+zynq_secondary_trampoline_jump:
+	/* Space for jumping address */
+	.word	/* cpu 1 */
+.globl zynq_secondary_trampoline_end
+zynq_secondary_trampoline_end:
+
+ENDPROC(zynq_secondary_trampoline)
diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
new file mode 100644
index 0000000..689fbbc
--- /dev/null
+++ b/arch/arm/mach-zynq/platsmp.c
@@ -0,0 +1,136 @@
+/*
+ * This file contains Xilinx specific SMP code, used to start up
+ * the second processor.
+ *
+ * Copyright (C) 2011-2013 Xilinx
+ *
+ * based on linux/arch/arm/mach-realview/platsmp.c
+ *
+ * Copyright (C) 2002 ARM Ltd.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/export.h>
+#include <linux/jiffies.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <asm/cacheflush.h>
+#include <asm/smp_scu.h>
+#include <linux/irqchip/arm-gic.h>
+#include "common.h"
+
+/*
+ * Store number of cores in the system
+ * Because of scu_get_core_count() must be in __init section and can't
+ * be called from zynq_cpun_start() because it is not in __init section.
+ */
+static int ncores;
+
+int zynq_cpun_start(u32 address, int cpu)
+{
+	u32 trampoline_code_size = &zynq_secondary_trampoline_end -
+						&zynq_secondary_trampoline;
+
+	if (cpu > ncores) {
+		pr_warn("CPU No. is not available in the system\n");
+		return -1;
+	}
+
+	/* MS: Expectation that SLCR are directly map and accessible */
+	/* Not possible to jump to non aligned address */
+	if (!(address & 3) && (!address || (address >= trampoline_code_size))) {
+		/* Store pointer to ioremap area which points to address 0x0 */
+		static u8 __iomem *zero;
+		u32 trampoline_size = &zynq_secondary_trampoline_jump -
+						&zynq_secondary_trampoline;
+
+		zynq_slcr_cpu_stop(cpu);
+		if (address) {
+			if (__pa(PAGE_OFFSET)) {
+				zero = ioremap(0, trampoline_code_size);
+				if (!zero) {
+					pr_warn("BOOTUP jump vectors not accessible\n");
+					return -1;
+				}
+			} else {
+				zero = (__force u8 __iomem *)PAGE_OFFSET;
+			}
+
+			/*
+			* This is elegant way how to jump to any address
+			* 0x0: Load address at 0x8 to r0
+			* 0x4: Jump by mov instruction
+			* 0x8: Jumping address
+			*/
+			memcpy((__force void *)zero, &zynq_secondary_trampoline,
+							trampoline_size);
+			writel(address, zero + trampoline_size);
+
+			flush_cache_all();
+			outer_flush_range(0, trampoline_code_size);
+			smp_wmb();
+
+			if (__pa(PAGE_OFFSET))
+				iounmap(zero);
+		}
+		zynq_slcr_cpu_start(cpu);
+
+		return 0;
+	}
+
+	pr_warn("Can't start CPU%d: Wrong starting address %x\n", cpu, address);
+
+	return -1;
+}
+EXPORT_SYMBOL(zynq_cpun_start);
+
+static int zynq_boot_secondary(unsigned int cpu,
+						struct task_struct *idle)
+{
+	return zynq_cpun_start(virt_to_phys(secondary_startup), cpu);
+}
+
+/*
+ * Initialise the CPU possible map early - this describes the CPUs
+ * which may be present or become present in the system.
+ */
+static void __init zynq_smp_init_cpus(void)
+{
+	int i;
+
+	ncores = scu_get_core_count(zynq_scu_base);
+
+	for (i = 0; i < ncores && i < CONFIG_NR_CPUS; i++)
+		set_cpu_possible(i, true);
+}
+
+static void __init zynq_smp_prepare_cpus(unsigned int max_cpus)
+{
+	int i;
+
+	/*
+	 * Initialise the present map, which describes the set of CPUs
+	 * actually populated@the present time.
+	 */
+	for (i = 0; i < max_cpus; i++)
+		set_cpu_present(i, true);
+
+	scu_enable(zynq_scu_base);
+}
+
+struct smp_operations zynq_smp_ops __initdata = {
+	.smp_init_cpus		= zynq_smp_init_cpus,
+	.smp_prepare_cpus	= zynq_smp_prepare_cpus,
+	.smp_boot_secondary	= zynq_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= zynq_platform_cpu_die,
+#endif
+};
diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
index 3a4b3e7..099c715 100644
--- a/arch/arm/mm/proc-v7-2level.S
+++ b/arch/arm/mm/proc-v7-2level.S
@@ -155,8 +155,6 @@ ENDPROC(cpu_v7_set_pte_ext)
 	mcr	p15, 0, \ttbr1, c2, c0, 1	@ load TTB1
 	.endm
 
-	__CPUINIT
-
 	/*   AT
 	 *  TFR   EV X F   I D LR    S
 	 * .EEE ..EE PUI. .T.T 4RVI ZWRS BLDP WCAM
@@ -166,6 +164,4 @@ ENDPROC(cpu_v7_set_pte_ext)
 	.align	2
 	.type	v7_crval, #object
 v7_crval:
-	crval	clear=0x0120c302, mmuset=0x10c03c7d, ucset=0x00c01c7c
-
-	.previous
+	crval	clear=0x2120c302, mmuset=0x10c03c7d, ucset=0x00c01c7c
diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
index 8de0f1d..8bcf31b 100644
--- a/arch/arm/mm/proc-v7-3level.S
+++ b/arch/arm/mm/proc-v7-3level.S
@@ -133,8 +133,6 @@ ENDPROC(cpu_v7_set_pte_ext)
 	mcrr	p15, 1, \ttbr1, \zero, c2	@ load TTBR1
 	.endm
 
-	__CPUINIT
-
 	/*
 	 *   AT
 	 *  TFR   EV X F   IHD LR    S
@@ -146,5 +144,3 @@ ENDPROC(cpu_v7_set_pte_ext)
 	.type	v7_crval, #object
 v7_crval:
 	crval	clear=0x0120c302, mmuset=0x30c23c7d, ucset=0x00c01c7c
-
-	.previous
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index c2e2b66..c7aecf3 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -140,7 +140,28 @@ ENTRY(cpu_v7_do_resume)
 ENDPROC(cpu_v7_do_resume)
 #endif
 
-	__CPUINIT
+#ifdef CONFIG_CPU_PJ4B
+	globl_equ	cpu_pj4b_switch_mm,     cpu_v7_switch_mm
+	globl_equ	cpu_pj4b_set_pte_ext,	cpu_v7_set_pte_ext
+	globl_equ	cpu_pj4b_proc_init,	cpu_v7_proc_init
+	globl_equ	cpu_pj4b_proc_fin, 	cpu_v7_proc_fin
+	globl_equ	cpu_pj4b_reset,	   	cpu_v7_reset
+#ifdef CONFIG_PJ4B_ERRATA_4742
+ENTRY(cpu_pj4b_do_idle)
+	dsb					@ WFI may enter a low-power mode
+	wfi
+	dsb					@barrier
+	mov	pc, lr
+ENDPROC(cpu_pj4b_do_idle)
+#else
+	globl_equ	cpu_pj4b_do_idle,  	cpu_v7_do_idle
+#endif
+	globl_equ	cpu_pj4b_dcache_clean_area,	cpu_v7_dcache_clean_area
+	globl_equ	cpu_pj4b_do_suspend,	cpu_v7_do_suspend
+	globl_equ	cpu_pj4b_do_resume,	cpu_v7_do_resume
+	globl_equ	cpu_pj4b_suspend_size,	cpu_v7_suspend_size
+
+#endif
 
 /*
  *	__v7_setup
-- 
1.7.7.6
