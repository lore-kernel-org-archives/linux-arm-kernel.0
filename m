From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 28 Oct 2013 11:25:01 -0700
Subject: [PATCH] ARM: Support arch_irq_work_raise() via self IPIs
In-Reply-To: <526DBEAA.4030707@linaro.org>
References: <526DBEAA.4030707@linaro.org>
Message-ID: <1382984701-2371-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will allow the scheduler tick to be restarted if we're in
full NOHZ mode.

Cc: Kevin Hilman <khilman@linaro.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/include/asm/hardirq.h |  2 +-
 arch/arm/kernel/smp.c          | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index 2740c2a2..3d7351c 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -5,7 +5,7 @@
 #include <linux/threads.h>
 #include <asm/irq.h>
 
-#define NR_IPI	6
+#define NR_IPI	7
 
 typedef struct {
 	unsigned int __softirq_pending;
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 72024ea..bf9a0d6d 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -25,6 +25,7 @@
 #include <linux/clockchips.h>
 #include <linux/completion.h>
 #include <linux/cpufreq.h>
+#include <linux/irq_work.h>
 
 #include <linux/atomic.h>
 #include <asm/smp.h>
@@ -66,6 +67,7 @@ enum ipi_msg_type {
 	IPI_CALL_FUNC,
 	IPI_CALL_FUNC_SINGLE,
 	IPI_CPU_STOP,
+	IPI_IRQ_WORK,
 };
 
 static DECLARE_COMPLETION(cpu_running);
@@ -448,6 +450,13 @@ void arch_send_call_function_single_ipi(int cpu)
 	smp_cross_call(cpumask_of(cpu), IPI_CALL_FUNC_SINGLE);
 }
 
+#ifdef CONFIG_IRQ_WORK
+void arch_irq_work_raise(void)
+{
+	smp_cross_call(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
+}
+#endif
+
 static const char *ipi_types[NR_IPI] = {
 #define S(x,s)	[x] = s
 	S(IPI_WAKEUP, "CPU wakeup interrupts"),
@@ -456,6 +465,7 @@ static const char *ipi_types[NR_IPI] = {
 	S(IPI_CALL_FUNC, "Function call interrupts"),
 	S(IPI_CALL_FUNC_SINGLE, "Single function call interrupts"),
 	S(IPI_CPU_STOP, "CPU stop interrupts"),
+	S(IPI_IRQ_WORK, "IRQ work interrupts"),
 };
 
 void show_ipi_list(struct seq_file *p, int prec)
@@ -565,6 +575,14 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		irq_exit();
 		break;
 
+#ifdef CONFIG_IRQ_WORK
+	case IPI_IRQ_WORK:
+		irq_enter();
+		irq_work_run();
+		irq_exit();
+		break;
+#endif
+
 	default:
 		printk(KERN_CRIT "CPU%u: Unknown IPI message 0x%x\n",
 		       cpu, ipinr);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
