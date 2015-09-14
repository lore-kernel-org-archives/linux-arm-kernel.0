From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 14 Sep 2015 14:26:16 +0100
Subject: [RFC PATCH v2 2/7] arm64: Add support for on-demand backtrace of
 other CPUs
In-Reply-To: <1442237181-17064-1-git-send-email-daniel.thompson@linaro.org>
References: <1442237181-17064-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1442237181-17064-3-git-send-email-daniel.thompson@linaro.org>
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
 arch/arm64/kernel/smp.c          | 26 ++++++++++++++++++++++++++
 lib/nmi_backtrace.c              |  8 ++++++--
 4 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
index 2bb7009bdac7..0af4cdb4b5a9 100644
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
index bbb251b14746..6b2724b2a803 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -21,4 +21,7 @@ static inline void acpi_irq_init(void)
 }
 #define acpi_irq_init acpi_irq_init
 
+extern void arch_trigger_all_cpu_backtrace(bool);
+#define arch_trigger_all_cpu_backtrace(x) arch_trigger_all_cpu_backtrace(x)
+
 #endif
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index dbdaacddd9a5..0f37a33499e2 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -37,6 +37,7 @@
 #include <linux/completion.h>
 #include <linux/of.h>
 #include <linux/irq_work.h>
+#include <linux/nmi.h>
 
 #include <asm/alternative.h>
 #include <asm/atomic.h>
@@ -70,6 +71,7 @@ enum ipi_msg_type {
 	IPI_CPU_STOP,
 	IPI_TIMER,
 	IPI_IRQ_WORK,
+	IPI_CPU_BACKTRACE,
 };
 
 /*
@@ -623,6 +625,7 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	S(IPI_CPU_STOP, "CPU stop interrupts"),
 	S(IPI_TIMER, "Timer broadcast interrupts"),
 	S(IPI_IRQ_WORK, "IRQ work interrupts"),
+	S(IPI_CPU_BACKTRACE, "backtrace interrupts"),
 };
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
@@ -743,6 +746,12 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		break;
 #endif
 
+	case IPI_CPU_BACKTRACE:
+		irq_enter();
+		nmi_cpu_backtrace(regs);
+		irq_exit();
+		break;
+
 	default:
 		pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
 		break;
@@ -794,3 +803,20 @@ int setup_profiling_timer(unsigned int multiplier)
 {
 	return -EINVAL;
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
index be0466a80d0b..29f7c4585f7f 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -149,10 +149,14 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
 		/* Replace printk to write into the NMI seq */
 		this_cpu_write(printk_func, nmi_vprintk);
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
 		this_cpu_write(printk_func, printk_func_save);
 
 		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
-- 
2.4.3
