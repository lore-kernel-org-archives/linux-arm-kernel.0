From: larry.bassel@linaro.org (Larry Bassel)
Date: Mon,  5 May 2014 13:48:27 -0700
Subject: [PATCH] arm64: Support arch_irq_work_raise() via self IPIs
Message-ID: <1399322907-21280-1-git-send-email-larry.bassel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support for arch_irq_work_raise() was missing from
arm64 (a prerequisite for FULL_NOHZ).

This patch is based on the arm32 patch ARM 7872/1
which ports cleanly.

commit bf18525fd793101df42a1344ecc48b49b62e48c9
Author: Stephen Boyd <sboyd@codeaurora.org>
Date:   Tue Oct 29 20:32:56 2013 +0100

    ARM: 7872/1: Support arch_irq_work_raise() via self IPIs

    By default, IRQ work is run from the tick interrupt (see
    irq_work_run() in update_process_times()). When we're in full
    NOHZ mode, restarting the tick requires the use of IRQ work and
    if the only place we run IRQ work is in the tick interrupt we
    have an unbreakable cycle. Implement arch_irq_work_raise() via
    self IPIs to break this cycle and get the tick started again.
    Note that we implement this via IPIs which are only available on
    SMP builds. This shouldn't be a problem because full NOHZ is only
    supported on SMP builds anyway.

    Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
    Reviewed-by: Kevin Hilman <khilman@linaro.org>
    Cc: Frederic Weisbecker <fweisbec@gmail.com>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Signed-off-by: Larry Bassel <larry.bassel@linaro.org>
Reviewed-by: Kevin Hilman <khilman@linaro.org>
---
 arch/arm64/include/asm/hardirq.h |  2 +-
 arch/arm64/kernel/smp.c          | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
index ae4801d..0be6782 100644
--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -20,7 +20,7 @@
 #include <linux/threads.h>
 #include <asm/irq.h>
 
-#define NR_IPI	5
+#define NR_IPI	6
 
 typedef struct {
 	unsigned int __softirq_pending;
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index f0a141d..20fd074 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -35,6 +35,7 @@
 #include <linux/clockchips.h>
 #include <linux/completion.h>
 #include <linux/of.h>
+#include <linux/irq_work.h>
 
 #include <asm/atomic.h>
 #include <asm/cacheflush.h>
@@ -62,6 +63,7 @@ enum ipi_msg_type {
 	IPI_CALL_FUNC_SINGLE,
 	IPI_CPU_STOP,
 	IPI_TIMER,
+	IPI_IRQ_WORK,
 };
 
 /*
@@ -455,6 +457,13 @@ void arch_send_call_function_single_ipi(int cpu)
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
 #define S(x,s)	[x - IPI_RESCHEDULE] = s
 	S(IPI_RESCHEDULE, "Rescheduling interrupts"),
@@ -462,6 +471,7 @@ static const char *ipi_types[NR_IPI] = {
 	S(IPI_CALL_FUNC_SINGLE, "Single function call interrupts"),
 	S(IPI_CPU_STOP, "CPU stop interrupts"),
 	S(IPI_TIMER, "Timer broadcast interrupts"),
+	S(IPI_IRQ_WORK, "IRQ work interrupts"),
 };
 
 void show_ipi_list(struct seq_file *p, int prec)
@@ -554,6 +564,14 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		break;
 #endif
 
+#ifdef CONFIG_IRQ_WORK
+	case IPI_IRQ_WORK:
+		irq_enter();
+		irq_work_run();
+		irq_exit();
+		break;
+#endif
+
 	default:
 		pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
 		break;
-- 
1.8.3.2
