From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Aug 2013 17:20:27 +0100
Subject: [PATCHv3 4/5] arm64: add CPU_HOTPLUG infrastructure
In-Reply-To: <1376497228-20543-1-git-send-email-mark.rutland@arm.com>
References: <1376497228-20543-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1376497228-20543-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the basic infrastructure necessary to support
CPU_HOTPLUG on arm64, based on the arm implementation. Actual hotplug
support will depend on an implementation's smp_operations (e.g. PSCI).

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/Kconfig           |  7 ++++
 arch/arm64/include/asm/irq.h |  1 +
 arch/arm64/include/asm/smp.h | 14 +++++++
 arch/arm64/kernel/cputable.c |  2 +-
 arch/arm64/kernel/irq.c      | 61 ++++++++++++++++++++++++++++
 arch/arm64/kernel/process.c  |  7 ++++
 arch/arm64/kernel/smp.c      | 97 ++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 188 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9737e97..5ce4ccb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -158,6 +158,13 @@ config NR_CPUS
 	default "8" if ARCH_XGENE
 	default "4"
 
+config HOTPLUG_CPU
+	bool "Support for hot-pluggable CPUs"
+	depends on SMP
+	help
+	  Say Y here to experiment with turning CPUs off and on.  CPUs
+	  can be controlled through /sys/devices/system/cpu.
+
 source kernel/Kconfig.preempt
 
 config HZ
diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index 0332fc0..e1f7ecd 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -4,6 +4,7 @@
 #include <asm-generic/irq.h>
 
 extern void (*handle_arch_irq)(struct pt_regs *);
+extern void migrate_irqs(void);
 extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
 
 #endif
diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 831090a..d2ef02e 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -67,6 +67,11 @@ extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 
 struct device_node;
 
+extern int __cpu_disable(void);
+
+extern void __cpu_die(unsigned int cpu);
+extern void cpu_die(void);
+
 /**
  * struct smp_operations - Callback operations for hotplugging CPUs.
  *
@@ -80,6 +85,11 @@ struct device_node;
  * @cpu_boot:	Boots a cpu into the kernel.
  * @cpu_postboot: Optionally, perform any post-boot cleanup or necesary
  *		synchronisation. Called from the cpu being booted.
+ * @cpu_disable: Prepares a cpu to die. May fail for some mechanism-specific
+ * 		reason, which will cause the hot unplug to be aborted. Called
+ * 		from the cpu to be killed.
+ * @cpu_die:	Makes the a leave the kernel. Must not fail. Called from the
+ *		cpu being killed.
  */
 struct smp_operations {
 	const char	*name;
@@ -87,6 +97,10 @@ struct smp_operations {
 	int		(*cpu_prepare)(unsigned int);
 	int		(*cpu_boot)(unsigned int);
 	void		(*cpu_postboot)(void);
+#ifdef CONFIG_HOTPLUG_CPU
+	int  (*cpu_disable)(unsigned int cpu);
+	void (*cpu_die)(unsigned int cpu);
+#endif
 };
 
 extern const struct smp_operations smp_spin_table_ops;
diff --git a/arch/arm64/kernel/cputable.c b/arch/arm64/kernel/cputable.c
index 63cfc4a..fd3993c 100644
--- a/arch/arm64/kernel/cputable.c
+++ b/arch/arm64/kernel/cputable.c
@@ -22,7 +22,7 @@
 
 extern unsigned long __cpu_setup(void);
 
-struct cpu_info __initdata cpu_table[] = {
+struct cpu_info cpu_table[] = {
 	{
 		.cpu_id_val	= 0x000f0000,
 		.cpu_id_mask	= 0x000f0000,
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index ecb3354..473e5db 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -81,3 +81,64 @@ void __init init_IRQ(void)
 	if (!handle_arch_irq)
 		panic("No interrupt controller found.");
 }
+
+#ifdef CONFIG_HOTPLUG_CPU
+static bool migrate_one_irq(struct irq_desc *desc)
+{
+	struct irq_data *d = irq_desc_get_irq_data(desc);
+	const struct cpumask *affinity = d->affinity;
+	struct irq_chip *c;
+	bool ret = false;
+
+	/*
+	 * If this is a per-CPU interrupt, or the affinity does not
+	 * include this CPU, then we have nothing to do.
+	 */
+	if (irqd_is_per_cpu(d) || !cpumask_test_cpu(smp_processor_id(), affinity))
+		return false;
+
+	if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids) {
+		affinity = cpu_online_mask;
+		ret = true;
+	}
+
+	c = irq_data_get_irq_chip(d);
+	if (!c->irq_set_affinity)
+		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
+	else if (c->irq_set_affinity(d, affinity, true) == IRQ_SET_MASK_OK && ret)
+		cpumask_copy(d->affinity, affinity);
+
+	return ret;
+}
+
+/*
+ * The current CPU has been marked offline.  Migrate IRQs off this CPU.
+ * If the affinity settings do not allow other CPUs, force them onto any
+ * available CPU.
+ *
+ * Note: we must iterate over all IRQs, whether they have an attached
+ * action structure or not, as we need to get chained interrupts too.
+ */
+void migrate_irqs(void)
+{
+	unsigned int i;
+	struct irq_desc *desc;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	for_each_irq_desc(i, desc) {
+		bool affinity_broken;
+
+		raw_spin_lock(&desc->lock);
+		affinity_broken = migrate_one_irq(desc);
+		raw_spin_unlock(&desc->lock);
+
+		if (affinity_broken)
+			pr_warn_ratelimited("IRQ%u no longer affine to CPU%u\n",
+					    i, smp_processor_id());
+	}
+
+	local_irq_restore(flags);
+}
+#endif /* CONFIG_HOTPLUG_CPU */
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 57fb55c..19f17ec 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -102,6 +102,13 @@ void arch_cpu_idle(void)
 	local_irq_enable();
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+void arch_cpu_idle_dead(void)
+{
+       cpu_die();
+}
+#endif
+
 void machine_shutdown(void)
 {
 #ifdef CONFIG_SMP
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index f6ce2ae..51c1acd 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -168,6 +168,103 @@ asmlinkage void secondary_start_kernel(void)
 	cpu_startup_entry(CPUHP_ONLINE);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int op_cpu_disable(unsigned int cpu)
+{
+	/*
+	 * If we don't have a cpu_die method, abort before we reach the point
+	 * of no return. CPU0 may not have an smp_ops, so test for it.
+	 */
+	if (!smp_ops[cpu] || !smp_ops[cpu]->cpu_die)
+		return -EOPNOTSUPP;
+
+	/*
+	 * We may need to abort a hot unplug for some other mechanism-specific
+	 * reason.
+	 */
+	if (smp_ops[cpu]->cpu_disable)
+		return smp_ops[cpu]->cpu_disable(cpu);
+
+	return 0;
+}
+
+/*
+ * __cpu_disable runs on the processor to be shutdown.
+ */
+int __cpu_disable(void)
+{
+	unsigned int cpu = smp_processor_id();
+	int ret;
+
+	ret = op_cpu_disable(cpu);
+	if (ret)
+		return ret;
+
+	/*
+	 * Take this CPU offline.  Once we clear this, we can't return,
+	 * and we must not schedule until we're ready to give up the cpu.
+	 */
+	set_cpu_online(cpu, false);
+
+	/*
+	 * OK - migrate IRQs away from this CPU
+	 */
+	migrate_irqs();
+
+	/*
+	 * Remove this CPU from the vm mask set of all processes.
+	 */
+	clear_tasks_mm_cpumask(cpu);
+
+	return 0;
+}
+
+static DECLARE_COMPLETION(cpu_died);
+
+/*
+ * called on the thread which is asking for a CPU to be shutdown -
+ * waits until shutdown has completed, or it is timed out.
+ */
+void __cpu_die(unsigned int cpu)
+{
+	if (!wait_for_completion_timeout(&cpu_died, msecs_to_jiffies(5000))) {
+		pr_crit("CPU%u: cpu didn't die\n", cpu);
+		return;
+	}
+	pr_notice("CPU%u: shutdown\n", cpu);
+}
+
+/*
+ * Called from the idle thread for the CPU which has been shutdown.
+ *
+ * Note that we disable IRQs here, but do not re-enable them
+ * before returning to the caller. This is also the behaviour
+ * of the other hotplug-cpu capable cores, so presumably coming
+ * out of idle fixes this.
+ */
+void __ref cpu_die(void)
+{
+	unsigned int cpu = smp_processor_id();
+
+	idle_task_exit();
+
+	local_irq_disable();
+	mb();
+
+	/* Tell __cpu_die() that this CPU is now safe to dispose of */
+	complete(&cpu_died);
+
+	/*
+	 * Actually shutdown the CPU. This must never fail. The specific hotplug
+	 * mechanism must perform all required cache maintenance to ensure that
+	 * no dirty lines are lost in the process of shutting down the CPU.
+	 */
+	smp_ops[cpu]->cpu_die(cpu);
+
+	BUG();
+}
+#endif
+
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 	unsigned long bogosum = loops_per_jiffy * num_online_cpus();
-- 
1.8.1.1
