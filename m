From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 12 Mar 2015 13:39:21 +0000
Subject: [PATCH 4.0-rc2 v18 6/6] ARM: Add support for on-demand backtrace of
 other CPUs
In-Reply-To: <1426167561-25963-1-git-send-email-daniel.thompson@linaro.org>
References: <1422022952-31552-1-git-send-email-daniel.thompson@linaro.org>
 <1426167561-25963-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1426167561-25963-7-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replicate the x86 code to trigger a backtrace using an NMI and hook
it up to IPI on ARM.

The code differs slightly from the code on x86 because, on ARM, we do
now know at compile time whether a platform is capable of supporting FIQ.
We must avoid using an IPI to request a backtrace from the CPU on which
the backtrace was requested if interrupts are disabled and fall back to
generating it directly.

In addition the implementation of arch_trigger_all_cpu_backtrace() the
patch also includes a few small items of plumbing that must be hooked
up for the new code to work.

Credit:
  Russell King provided the initial prototype implementing this feature
  for ARM. Today the patch has been reworked and, mostly, rewriten to
  keep it aligned with x86. However this patch does still include some
  code from Russell's original prototype.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 arch/arm/Kconfig               |  1 +
 arch/arm/include/asm/hardirq.h |  2 +-
 arch/arm/include/asm/irq.h     |  5 +++
 arch/arm/include/asm/smp.h     |  3 ++
 arch/arm/kernel/smp.c          | 81 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/traps.c        |  3 ++
 6 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9f1f09a2bc9b..f3c95a44945d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -76,6 +76,7 @@ config ARM
 	select OLD_SIGACTION
 	select OLD_SIGSUSPEND3
 	select PERF_USE_VMALLOC
+	select PRINTK_NMI_BACKTRACE
 	select RTC_LIB
 	select SYS_SUPPORTS_APM_EMULATION
 	# Above selects are sorted alphabetically; please add new ones
diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index fe3ea776dc34..5df33e30ae1b 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -5,7 +5,7 @@
 #include <linux/threads.h>
 #include <asm/irq.h>
 
-#define NR_IPI	8
+#define NR_IPI	9
 
 typedef struct {
 	unsigned int __softirq_pending;
diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index 53c15dec7af6..be1d07d59ee9 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -35,6 +35,11 @@ extern void (*handle_arch_irq)(struct pt_regs *);
 extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
 #endif
 
+#ifdef CONFIG_SMP
+extern void arch_trigger_all_cpu_backtrace(bool);
+#define arch_trigger_all_cpu_backtrace(x) arch_trigger_all_cpu_backtrace(x)
+#endif
+
 #endif
 
 #endif
diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 18f5a554134f..b076584ac0fa 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -18,6 +18,8 @@
 # error "<asm/smp.h> included in non-SMP build"
 #endif
 
+#define SMP_IPI_FIQ_MASK 0x0100
+
 #define raw_smp_processor_id() (current_thread_info()->cpu)
 
 struct seq_file;
@@ -79,6 +81,7 @@ extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 extern void arch_send_wakeup_ipi_mask(const struct cpumask *mask);
 
+extern void ipi_cpu_backtrace(struct pt_regs *regs);
 extern int register_ipi_completion(struct completion *completion, int cpu);
 
 struct smp_operations {
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 86ef244c5a24..7eb6241e99d1 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -26,6 +26,7 @@
 #include <linux/completion.h>
 #include <linux/cpufreq.h>
 #include <linux/irq_work.h>
+#include <linux/seq_buf.h>
 
 #include <linux/atomic.h>
 #include <asm/smp.h>
@@ -72,6 +73,7 @@ enum ipi_msg_type {
 	IPI_CPU_STOP,
 	IPI_IRQ_WORK,
 	IPI_COMPLETION,
+	IPI_CPU_BACKTRACE,
 };
 
 static DECLARE_COMPLETION(cpu_running);
@@ -456,6 +458,7 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	S(IPI_CPU_STOP, "CPU stop interrupts"),
 	S(IPI_IRQ_WORK, "IRQ work interrupts"),
 	S(IPI_COMPLETION, "completion interrupts"),
+	S(IPI_CPU_BACKTRACE, "backtrace interrupts"),
 };
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
@@ -570,6 +573,8 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 	unsigned int cpu = smp_processor_id();
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
+	BUILD_BUG_ON(SMP_IPI_FIQ_MASK != BIT(IPI_CPU_BACKTRACE));
+
 	if ((unsigned)ipinr < NR_IPI) {
 		trace_ipi_entry(ipi_types[ipinr]);
 		__inc_irq_stat(cpu, ipi_irqs[ipinr]);
@@ -623,6 +628,12 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		irq_exit();
 		break;
 
+	case IPI_CPU_BACKTRACE:
+		irq_enter();
+		ipi_cpu_backtrace(regs);
+		irq_exit();
+		break;
+
 	default:
 		pr_crit("CPU%u: Unknown IPI message 0x%x\n",
 		        cpu, ipinr);
@@ -717,3 +728,73 @@ static int __init register_cpufreq_notifier(void)
 core_initcall(register_cpufreq_notifier);
 
 #endif
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
+
+	/*
+	 * If irqs are disabled on the current processor and
+	 * IPI_CPU_BACKTRACE is delivered using IRQ then we aren't be able to
+	 * react to IPI_CPU_BACKTRACE until we leave this function. This
+	 * would force us to get stuck and, eventually, timeout. We avoid
+	 * the timeout (and the resulting failure to print useful information)
+	 * by calling the backtrace logic directly whenever irqs are disabled.
+	 */
+	if (include_self && irqs_disabled()) {
+		ipi_cpu_backtrace(in_interrupt() ? get_irq_regs() : NULL);
+		include_self = false;
+	}
+
+	if (!include_self)
+		cpumask_clear_cpu(this_cpu, to_cpumask(backtrace_mask));
+
+	if (!cpumask_empty(to_cpumask(backtrace_mask))) {
+		pr_info("Sending FIQ to %s CPUs:\n",
+			(include_self ? "all" : "other"));
+		smp_cross_call(to_cpumask(backtrace_mask), IPI_CPU_BACKTRACE);
+	}
+
+	/* Wait for up to 10 seconds for all CPUs to do the backtrace */
+	for (i = 0; i < 10 * 1000; i++) {
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
+	if (cpumask_test_cpu(cpu, to_cpumask(backtrace_mask))) {
+		printk_nmi_backtrace_this_cpu_begin();
+		pr_warn("FIQ backtrace for cpu %d\n", cpu);
+		if (regs != NULL)
+			show_regs(regs);
+		else
+			dump_stack();
+		printk_nmi_backtrace_this_cpu_end();
+
+		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
+	}
+}
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index b35e220ae1b1..1836415b8a5c 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -483,6 +483,9 @@ asmlinkage void __exception_irq_entry handle_fiq_as_nmi(struct pt_regs *regs)
 #ifdef CONFIG_ARM_GIC
 	gic_handle_fiq_ipi();
 #endif
+#ifdef CONFIG_SMP
+	ipi_cpu_backtrace(regs);
+#endif
 
 	nmi_exit();
 
-- 
2.1.0
