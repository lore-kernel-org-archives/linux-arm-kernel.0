From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 19 Aug 2016 17:13:10 +0100
Subject: [RFC PATCH v3 2/7] arm64: Add support for on-demand backtrace of
 other CPUs
In-Reply-To: <1471623195-7829-1-git-send-email-daniel.thompson@linaro.org>
References: <1471623195-7829-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1471623195-7829-3-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently arm64 has no implementation of arch_trigger_all_cpu_backtace.
The patch provides one using library code recently added by Russell King
for for the majority of the implementation. Currently this is realized
using regular irqs but could, in the future, be implemented using
NMI-like mechanisms.

Note: There is a small (and nasty) change to the generic code to ensure
      good stack traces. The generic code currently assumes that
      show_regs() will include a stack trace but arch/arm64 does not do
      this so we must add extra code here. Ideas on a better approach
      here would be very welcome (is there any appetite to change arm64
      show_regs() or should we just tease out the dump code into a
      callback?).

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm64/include/asm/hardirq.h |  2 +-
 arch/arm64/include/asm/irq.h     |  3 +++
 arch/arm64/kernel/smp.c          | 30 +++++++++++++++++++++++++++++-
 lib/nmi_backtrace.c              |  9 +++++++--
 4 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
index 8740297dac77..1473fc2f7ab7 100644
--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -20,7 +20,7 @@
 #include <linux/threads.h>
 #include <asm/irq.h>
 
-#define NR_IPI	6
+#define NR_IPI	7
 
 typedef struct {
 	unsigned int __softirq_pending;
diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index b77197d941fc..67dc130ae517 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -56,5 +56,8 @@ static inline bool on_irq_stack(unsigned long sp, int cpu)
 	return (low <= sp && sp <= high);
 }
 
+extern void arch_trigger_all_cpu_backtrace(bool);
+#define arch_trigger_all_cpu_backtrace(x) arch_trigger_all_cpu_backtrace(x)
+
 #endif /* !__ASSEMBLER__ */
 #endif
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index d93d43352504..99f607f0fa97 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -37,6 +37,7 @@
 #include <linux/completion.h>
 #include <linux/of.h>
 #include <linux/irq_work.h>
+#include <linux/nmi.h>
 
 #include <asm/alternative.h>
 #include <asm/atomic.h>
@@ -73,7 +74,8 @@ enum ipi_msg_type {
 	IPI_CPU_STOP,
 	IPI_TIMER,
 	IPI_IRQ_WORK,
-	IPI_WAKEUP
+	IPI_WAKEUP,
+	IPI_CPU_BACKTRACE,
 };
 
 #ifdef CONFIG_ARM64_VHE
@@ -737,6 +739,7 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	S(IPI_TIMER, "Timer broadcast interrupts"),
 	S(IPI_IRQ_WORK, "IRQ work interrupts"),
 	S(IPI_WAKEUP, "CPU wake-up interrupts"),
+	S(IPI_CPU_BACKTRACE, "backtrace interrupts"),
 };
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
@@ -862,6 +865,14 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		break;
 #endif
 
+	case IPI_CPU_BACKTRACE:
+		printk_nmi_enter();
+		irq_enter();
+		nmi_cpu_backtrace(regs);
+		irq_exit();
+		printk_nmi_exit();
+		break;
+
 	default:
 		pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
 		break;
@@ -935,3 +946,20 @@ bool cpus_are_stuck_in_kernel(void)
 
 	return !!cpus_stuck_in_kernel || smp_spin_tables;
 }
+
+static void raise_nmi(cpumask_t *mask)
+{
+	/*
+	 * Generate the backtrace directly if we are running in a
+	 * calling context that is not preemptible by the backtrace IPI.
+	 */
+	if (cpumask_test_cpu(smp_processor_id(), mask) && irqs_disabled())
+		nmi_cpu_backtrace(NULL);
+
+	smp_cross_call(mask, IPI_CPU_BACKTRACE);
+}
+
+void arch_trigger_all_cpu_backtrace(bool include_self)
+{
+	nmi_trigger_all_cpu_backtrace(include_self, raise_nmi);
+}
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 26caf51cc238..3dada8487477 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -78,10 +78,15 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
 
 	if (cpumask_test_cpu(cpu, to_cpumask(backtrace_mask))) {
 		pr_warn("NMI backtrace for cpu %d\n", cpu);
-		if (regs)
+		if (regs) {
 			show_regs(regs);
-		else
+#ifdef CONFIG_ARM64
+			show_stack(NULL, NULL);
+#endif
+		} else {
 			dump_stack();
+		}
+
 		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
 		return true;
 	}
-- 
2.7.4
