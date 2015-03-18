From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 18 Mar 2015 14:20:28 +0000
Subject: [RFC PATCH 7/7] arm64: Add support for on-demand backtrace of other
 CPUs
In-Reply-To: <1426688428-3150-1-git-send-email-daniel.thompson@linaro.org>
References: <1426688428-3150-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1426688428-3150-8-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently arm64 has no implementation of arch_trigger_all_cpu_backtace.
The patch provides one for arm64 systems that are built with
CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS (i.e. those that have a pseudo-NMI).

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/hardirq.h |  2 +-
 arch/arm64/include/asm/irq.h     |  5 +++
 arch/arm64/include/asm/smp.h     |  4 +++
 arch/arm64/kernel/smp.c          | 70 ++++++++++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-gic-v3.c     | 28 ++++++++++++++++
 6 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 91c0babb6132..cb8d3dce73c3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -76,6 +76,7 @@ config ARM64
 	select PERF_USE_VMALLOC
 	select POWER_RESET
 	select POWER_SUPPLY
+	select PRINTK_NMI_BACKTRACE if USE_ICC_SYSREGS_FOR_IRQFLAGS
 	select RTC_LIB
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
index 6aae421f4d73..e8a3268a891c 100644
--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -20,7 +20,7 @@
 #include <linux/threads.h>
 #include <asm/irq.h>
 
-#define NR_IPI	5
+#define NR_IPI	6
 
 typedef struct {
 	unsigned int __softirq_pending;
diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index 94c53674a31d..4f974a2959bb 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -8,4 +8,9 @@ struct pt_regs;
 extern void migrate_irqs(void);
 extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
 
+#if defined CONFIG_SMP && defined CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+extern void arch_trigger_all_cpu_backtrace(bool);
+#define arch_trigger_all_cpu_backtrace(x) arch_trigger_all_cpu_backtrace(x)
+#endif
+
 #endif
diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 780f82c827b6..9b3b5663b88b 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -24,6 +24,10 @@
 # error "<asm/smp.h> included in non-SMP build"
 #endif
 
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+#define SMP_IPI_NMI_MASK (1 << 5)
+#endif
+
 #define raw_smp_processor_id() (current_thread_info()->cpu)
 
 struct seq_file;
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 328b8ce4b007..9369eee1fa9f 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -68,6 +68,7 @@ enum ipi_msg_type {
 	IPI_CPU_STOP,
 	IPI_TIMER,
 	IPI_IRQ_WORK,
+	IPI_CPU_BACKTRACE,
 };
 
 /*
@@ -485,6 +486,7 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	S(IPI_CPU_STOP, "CPU stop interrupts"),
 	S(IPI_TIMER, "Timer broadcast interrupts"),
 	S(IPI_IRQ_WORK, "IRQ work interrupts"),
+	S(IPI_CPU_BACKTRACE, "backtrace interrupts"),
 };
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
@@ -559,6 +561,66 @@ static void ipi_cpu_stop(unsigned int cpu)
 		cpu_relax();
 }
 
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+
+/* For reliability, we're prepared to waste bits here. */
+static DECLARE_BITMAP(backtrace_mask, NR_CPUS) __read_mostly;
+
+void arch_trigger_all_cpu_backtrace(bool include_self)
+{
+	int i;
+	int this_cpu = get_cpu();
+
+	if (0 != printk_nmi_backtrace_prepare()) {
+		/*
+		 * If there is already an nmi printk sequence in
+		 * progress then just give up...
+		 */
+		put_cpu();
+		return;
+	}
+
+	cpumask_copy(to_cpumask(backtrace_mask), cpu_online_mask);
+	if (!include_self)
+		cpumask_clear_cpu(this_cpu, to_cpumask(backtrace_mask));
+
+	if (!cpumask_empty(to_cpumask(backtrace_mask))) {
+		pr_info("Sending NMI to %s CPUs:\n",
+			(include_self ? "all" : "other"));
+		smp_cross_call(to_cpumask(backtrace_mask), IPI_CPU_BACKTRACE);
+	}
+
+	/* Wait for up to 10 seconds for all CPUs to do the backtrace */
+	for (i = 0; i < 3 * 1000; i++) {
+		if (cpumask_empty(to_cpumask(backtrace_mask)))
+			break;
+		mdelay(1);
+		touch_softlockup_watchdog();
+	}
+
+	printk_nmi_backtrace_complete();
+	put_cpu();
+}
+
+void ipi_cpu_backtrace(struct pt_regs *regs)
+{
+	int cpu = smp_processor_id();
+
+	BUILD_BUG_ON(SMP_IPI_NMI_MASK != BIT(IPI_CPU_BACKTRACE));
+
+	if (cpumask_test_cpu(cpu, to_cpumask(backtrace_mask))) {
+		printk_nmi_backtrace_this_cpu_begin();
+		pr_warn("NMI backtrace for cpu %d\n", cpu);
+		show_regs(regs);
+		show_stack(NULL, NULL);
+		printk_nmi_backtrace_this_cpu_end();
+
+		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
+	}
+}
+
+#endif /* CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS */
+
 /*
  * Main handler for inter-processor interrupts
  */
@@ -605,6 +667,14 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		break;
 #endif
 
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	case IPI_CPU_BACKTRACE:
+		nmi_enter();
+		ipi_cpu_backtrace(regs);
+		nmi_exit();
+		break;
+#endif
+
 	default:
 		pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
 		break;
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 3923b2a2150c..bdb134ed4519 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -34,6 +34,16 @@
 #include "irq-gic-common.h"
 #include "irqchip.h"
 
+#ifndef SMP_IPI_NMI_MASK
+#define SMP_IPI_NMI_MASK 0
+#endif
+
+/*
+ * Copied from arm-gic.h (which we cannot include here because it conflicts
+ * with arm-gic-v3.h)
+ */
+#define GIC_DIST_PRI			0x400
+
 struct redist_region {
 	void __iomem		*redist_base;
 	phys_addr_t		phys_base;
@@ -438,6 +448,7 @@ static int gic_dist_supports_lpis(void)
 static void gic_cpu_init(void)
 {
 	void __iomem *rbase;
+	unsigned long nmimask, hwirq;
 
 	/* Register ourselves with the rest of the world */
 	if (gic_populate_rdist())
@@ -455,6 +466,23 @@ static void gic_cpu_init(void)
 
 	/* initialise system registers */
 	gic_cpu_sys_reg_init();
+
+	/* Boost the priority of any IPI in the mask */
+	nmimask = SMP_IPI_NMI_MASK;
+	for_each_set_bit(hwirq, &nmimask, 16) {
+		unsigned int pri_reg = (hwirq / 4) * 4;
+		u32 pri_mask = BIT(6 + ((hwirq % 4) * 8));
+		u32 pri_val = readl_relaxed(rbase + GIC_DIST_PRI + pri_reg);
+		u32 actual;
+
+		pri_mask |= BIT(7 + ((hwirq % 4) * 8));
+		pri_val &= ~pri_mask;	/* priority boost */
+		writel_relaxed(pri_val, rbase + GIC_DIST_PRI + pri_reg);
+
+		actual = readl_relaxed(rbase + GIC_DIST_PRI + pri_reg);
+	}
+	gic_dist_wait_for_rwp();
+	gic_redist_wait_for_rwp();
 }
 
 #ifdef CONFIG_SMP
-- 
2.1.0
