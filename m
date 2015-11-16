From: james.morse@arm.com (James Morse)
Date: Mon, 16 Nov 2015 18:22:06 +0000
Subject: [PATCH v7 2/3] arm64: Modify stack trace and dump for use with
 irq_stack
In-Reply-To: <1447698128-8490-1-git-send-email-james.morse@arm.com>
References: <1447698128-8490-1-git-send-email-james.morse@arm.com>
Message-ID: <1447698128-8490-3-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

This patch allows unwind_frame() to traverse from interrupt stack to task
stack correctly. It requires data from a dummy stack frame, created
during irq_stack_entry(), added by a later patch.

A similar approach is taken to modify dump_backtrace(), which expects to
find struct pt_regs underneath any call to functions marked __exception.
When on an irq_stack, the struct pt_regs is stored on the old task stack,
the location of which is stored in the dummy stack frame.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
[merged two patches, reworked for per_cpu irq_stacks, and no alignment
 guarantees]
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/irq.h   | 15 +++++++++++++++
 arch/arm64/kernel/stacktrace.c | 29 +++++++++++++++++++++++++++--
 arch/arm64/kernel/traps.c      | 14 +++++++++++++-
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index 00cab2e28376..bf823c5f8cbd 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -13,7 +13,22 @@ DECLARE_PER_CPU(unsigned long, irq_stack_ptr);
 #define IRQ_STACK_SIZE			THREAD_SIZE
 #define IRQ_STACK_START_SP		THREAD_START_SP
 
+/*
+ * This is the offset from irq_stack_ptr where entry.S will store the original
+ * stack pointer. Used by unwind_frame() and dump_backtrace().
+ */
+#define IRQ_STACK_TO_TASK_STACK(x)	*((unsigned long *)(x - 0x10));
+
 extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
 
 void init_irq_stack(unsigned int cpu);
+
+static inline bool on_irq_stack(unsigned long sp, int cpu)
+{
+	/* variable names the same as kernel/stacktrace.c */
+	unsigned long high = per_cpu(irq_stack_ptr, cpu);
+	unsigned long low = high - IRQ_STACK_START_SP;
+
+	return (low <= sp && sp <= high);
+}
 #endif
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index ccb6078ed9f2..a15985137328 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -20,6 +20,7 @@
 #include <linux/sched.h>
 #include <linux/stacktrace.h>
 
+#include <asm/irq.h>
 #include <asm/stacktrace.h>
 
 /*
@@ -39,17 +40,41 @@ int notrace unwind_frame(struct stackframe *frame)
 {
 	unsigned long high, low;
 	unsigned long fp = frame->fp;
+	unsigned long _irq_stack_ptr;
+
+	/*
+	 * Use raw_smp_processor_id() to avoid false-positives from
+	 * CONFIG_DEBUG_PREEMPT. get_wchan() calls unwind_frame() on sleeping
+	 * task stacks, we can be pre-empted in this case, so
+	 * {raw_,}smp_processor_id() may give us the wrong value. Sleeping
+	 * tasks can't ever be on an interrupt stack, so regardless of cpu,
+	 * the checks will always fail.
+	 */
+	_irq_stack_ptr = per_cpu(irq_stack_ptr, raw_smp_processor_id());
 
 	low  = frame->sp;
-	high = ALIGN(low, THREAD_SIZE);
+	/* irq stacks are not THREAD_SIZE aligned */
+	if (on_irq_stack(frame->sp, raw_smp_processor_id()))
+		high = _irq_stack_ptr;
+	else
+		high = ALIGN(low, THREAD_SIZE) - 0x20;
 
-	if (fp < low || fp > high - 0x18 || fp & 0xf)
+	if (fp < low || fp > high || fp & 0xf)
 		return -EINVAL;
 
 	frame->sp = fp + 0x10;
 	frame->fp = *(unsigned long *)(fp);
 	frame->pc = *(unsigned long *)(fp + 8);
 
+	/*
+	 * Check whether we are going to walk through from interrupt stack
+	 * to task stack.
+	 * If we reach the end of the stack - and its an interrupt stack,
+	 * read the original task stack pointer from the dummy frame.
+	 */
+	if (frame->sp == _irq_stack_ptr)
+		frame->sp = IRQ_STACK_TO_TASK_STACK(_irq_stack_ptr);
+
 	return 0;
 }
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index e9b9b5364393..cdfa2f9e8d59 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -146,6 +146,7 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
 static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 {
 	struct stackframe frame;
+	unsigned long _irq_stack_ptr = per_cpu(irq_stack_ptr, smp_processor_id());
 
 	pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
 
@@ -180,9 +181,20 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 		if (ret < 0)
 			break;
 		stack = frame.sp;
-		if (in_exception_text(where))
+		if (in_exception_text(where)) {
+			/*
+			 * If we switched to the irq_stack before calling this
+			 * exception handler, then the pt_regs will be on the
+			 * task stack. The easiest way to tell is if the large
+			 * pt_regs would overlap with the end of the irq_stack.
+			 */
+			if (stack < _irq_stack_ptr &&
+			    (stack + sizeof(struct pt_regs)) > _irq_stack_ptr)
+				stack = IRQ_STACK_TO_TASK_STACK(_irq_stack_ptr);
+
 			dump_mem("", "Exception stack", stack,
 				 stack + sizeof(struct pt_regs), false);
+		}
 	}
 }
 
-- 
2.1.4
