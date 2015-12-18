From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 18 Dec 2015 09:16:12 +0000
Subject: [PATCH 1/2] ARM: Remove IPI_CALL_FUNC_SINGLE
In-Reply-To: <1450430173-26992-1-git-send-email-marc.zyngier@arm.com>
References: <1450430173-26992-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1450430173-26992-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 9a46ad6d6df3 ("smp: make smp_call_function_many() use logic
similar to smp_call_function_single()"), the core IPI handling
has been simplified, and generic_smp_call_function_interrupt is
now the same as generic_smp_call_function_single_interrupt.

This means that one of IPI_CALL_FUNC and IPI_CALL_FUNC_SINGLE has
become redundant. We can then safely drop IPI_CALL_FUNC_SINGLE,
and use only IPI_CALL_FUNC.

This has the advantage of reducing the number of SGI IDs we're using
(a fairly scarse resource).

Tested on a dual A7 board.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/hardirq.h |  2 +-
 arch/arm/kernel/smp.c          | 10 +---------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index fe3ea77..3d7351c 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -5,7 +5,7 @@
 #include <linux/threads.h>
 #include <asm/irq.h>
 
-#define NR_IPI	8
+#define NR_IPI	7
 
 typedef struct {
 	unsigned int __softirq_pending;
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index b263613..d50a77d 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -69,7 +69,6 @@ enum ipi_msg_type {
 	IPI_TIMER,
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
-	IPI_CALL_FUNC_SINGLE,
 	IPI_CPU_STOP,
 	IPI_IRQ_WORK,
 	IPI_COMPLETION,
@@ -475,7 +474,6 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	S(IPI_TIMER, "Timer broadcast interrupts"),
 	S(IPI_RESCHEDULE, "Rescheduling interrupts"),
 	S(IPI_CALL_FUNC, "Function call interrupts"),
-	S(IPI_CALL_FUNC_SINGLE, "Single function call interrupts"),
 	S(IPI_CPU_STOP, "CPU stop interrupts"),
 	S(IPI_IRQ_WORK, "IRQ work interrupts"),
 	S(IPI_COMPLETION, "completion interrupts"),
@@ -525,7 +523,7 @@ void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
 
 void arch_send_call_function_single_ipi(int cpu)
 {
-	smp_cross_call(cpumask_of(cpu), IPI_CALL_FUNC_SINGLE);
+	smp_cross_call(cpumask_of(cpu), IPI_CALL_FUNC);
 }
 
 #ifdef CONFIG_IRQ_WORK
@@ -620,12 +618,6 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		irq_exit();
 		break;
 
-	case IPI_CALL_FUNC_SINGLE:
-		irq_enter();
-		generic_smp_call_function_single_interrupt();
-		irq_exit();
-		break;
-
 	case IPI_CPU_STOP:
 		irq_enter();
 		ipi_cpu_stop(cpu);
-- 
2.1.4
