From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 24 Jul 2017 12:26:21 +0100
Subject: [PATCH 2/4] arm64: unwind: disregard frame.sp when validating frame
 pointer
In-Reply-To: <20170724112623.26109-1-ard.biesheuvel@linaro.org>
References: <20170724112623.26109-1-ard.biesheuvel@linaro.org>
Message-ID: <20170724112623.26109-3-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, when unwinding the call stack, we validate the frame pointer
of each frame against frame.sp, whose value is not clearly defined, and
which makes it more difficult to link stack frames together across
different stacks. It is far better to simply check whether the frame
pointer itself points into a valid stack.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/irq.h   | 10 +++++++-
 arch/arm64/kernel/stacktrace.c | 24 ++++++--------------
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index c01a912fbb1e..57deb5abfc24 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -7,6 +7,7 @@
 #ifndef __ASSEMBLER__
 
 #include <linux/percpu.h>
+#include <linux/sched/task_stack.h>
 
 #include <asm-generic/irq.h>
 #include <asm/thread_info.h>
@@ -49,12 +50,19 @@ static inline int nr_legacy_irqs(void)
 
 static inline bool on_irq_stack(unsigned long sp)
 {
-	/* variable names the same as kernel/stacktrace.c */
 	unsigned long low = (unsigned long)raw_cpu_ptr(irq_stack);
 	unsigned long high = low + IRQ_STACK_START_SP;
 
 	return (low <= sp && sp <= high);
 }
 
+static inline bool on_task_stack(struct task_struct *tsk, unsigned long sp)
+{
+	unsigned long low = (unsigned long)task_stack_page(tsk);
+	unsigned long high = low + THREAD_SIZE;
+
+	return (low <= sp && sp < high);
+}
+
 #endif /* !__ASSEMBLER__ */
 #endif
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 6ffb965be641..beaf51fb3088 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -42,9 +42,10 @@
  */
 int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 {
-	unsigned long high, low;
 	unsigned long fp = frame->fp;
-	unsigned long irq_stack_ptr;
+
+	if (fp & 0xf)
+		return -EINVAL;
 
 	if (!tsk)
 		tsk = current;
@@ -53,19 +54,8 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 	 * Switching between stacks is valid when tracing current and in
 	 * non-preemptible context.
 	 */
-	if (tsk == current && !preemptible())
-		irq_stack_ptr = IRQ_STACK_PTR();
-	else
-		irq_stack_ptr = 0;
-
-	low  = frame->sp;
-	/* irq stacks are not THREAD_SIZE aligned */
-	if (on_irq_stack(frame->sp))
-		high = irq_stack_ptr;
-	else
-		high = ALIGN(low, THREAD_SIZE) - 0x20;
-
-	if (fp < low || fp > high || fp & 0xf)
+	if (!(tsk == current && !preemptible() && on_irq_stack(fp)) &&
+	    !on_task_stack(tsk, fp))
 		return -EINVAL;
 
 	frame->sp = fp + 0x10;
@@ -94,9 +84,9 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 	 * Check the frame->fp we read from the bottom of the irq_stack,
 	 * and the original task stack pointer are both in current->stack.
 	 */
-	if (frame->sp == irq_stack_ptr) {
+	if (frame->sp == IRQ_STACK_PTR()) {
 		struct pt_regs *irq_args;
-		unsigned long orig_sp = IRQ_STACK_TO_TASK_STACK(irq_stack_ptr);
+		unsigned long orig_sp = IRQ_STACK_TO_TASK_STACK(frame->sp);
 
 		if (object_is_on_stack((void *)orig_sp) &&
 		   object_is_on_stack((void *)frame->fp)) {
-- 
2.9.3
