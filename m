From: andr2000@gmail.com (Oleksandr Andrushchenko)
Date: Fri, 17 Mar 2017 09:27:43 +0200
Subject: [PATCH v1] arm64: Add support for on-demand backtrace of other CPUs
In-Reply-To: <1489735663-2091-1-git-send-email-andr2000@gmail.com>
References: <1489735663-2091-1-git-send-email-andr2000@gmail.com>
Message-ID: <1489735663-2091-2-git-send-email-andr2000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Thompson <daniel.thompson@linaro.org>

Currently arm64 has no implementation of arch_trigger_cpumask_backtrace.
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
Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm64/include/asm/hardirq.h |  2 +-
 arch/arm64/include/asm/irq.h     |  6 ++++++
 arch/arm64/kernel/smp.c          | 30 +++++++++++++++++++++++++++++-
 lib/nmi_backtrace.c              |  8 ++++++--
 4 files changed, 42 insertions(+), 4 deletions(-)

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
index b77197d941fc..56e09c0e8eaf 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -56,5 +56,11 @@ static inline bool on_irq_stack(unsigned long sp, int cpu)
 	return (low <= sp && sp <= high);
 }
 
+#ifdef CONFIG_SMP
+extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
+					   bool exclude_self);
+#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
+#endif
+
 #endif /* !__ASSEMBLER__ */
 #endif
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index ef1caae02110..613c4cadd71a 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -34,6 +34,7 @@
 #include <linux/smp.h>
 #include <linux/seq_file.h>
 #include <linux/irq.h>
+#include <linux/nmi.h>
 #include <linux/percpu.h>
 #include <linux/clockchips.h>
 #include <linux/completion.h>
@@ -78,7 +79,8 @@ enum ipi_msg_type {
 	IPI_CPU_STOP,
 	IPI_TIMER,
 	IPI_IRQ_WORK,
-	IPI_WAKEUP
+	IPI_WAKEUP,
+	IPI_CPU_BACKTRACE,
 };
 
 #ifdef CONFIG_ARM64_VHE
@@ -758,6 +760,7 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	S(IPI_TIMER, "Timer broadcast interrupts"),
 	S(IPI_IRQ_WORK, "IRQ work interrupts"),
 	S(IPI_WAKEUP, "CPU wake-up interrupts"),
+	S(IPI_CPU_BACKTRACE, "backtrace interrupts"),
 };
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
@@ -883,6 +886,14 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
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
@@ -956,3 +967,20 @@ bool cpus_are_stuck_in_kernel(void)
 
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
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
+{
+	nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_nmi);
+}
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 4e8a30d1c22f..f0336e463c25 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -94,10 +94,14 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
 				cpu, instruction_pointer(regs));
 		} else {
 			pr_warn("NMI backtrace for cpu %d\n", cpu);
-			if (regs)
+			if (regs) {
 				show_regs(regs);
-			else
+#ifdef CONFIG_ARM64
+				show_stack(NULL, NULL);
+#endif
+			} else {
 				dump_stack();
+			}
 		}
 		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
 		return true;
-- 
2.7.4
