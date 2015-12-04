From: james.morse@arm.com (James Morse)
Date: Fri,  4 Dec 2015 11:02:26 +0000
Subject: [PATCH v8 2/4] arm64: Modify stack trace and dump for use with
 irq_stack
In-Reply-To: <1449226948-14251-1-git-send-email-james.morse@arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
Message-ID: <1449226948-14251-3-git-send-email-james.morse@arm.com>
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
 guarantees, added irq_stack definitions]
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/irq.h   | 32 ++++++++++++++++++++++++++++++++
 arch/arm64/kernel/irq.c        |  3 +++
 arch/arm64/kernel/stacktrace.c | 29 +++++++++++++++++++++++++++--
 arch/arm64/kernel/traps.c      | 14 +++++++++++++-
 4 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index 8e8d30684392..e2f3f135a3bc 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -1,10 +1,32 @@
 #ifndef __ASM_IRQ_H
 #define __ASM_IRQ_H
 
+#define IRQ_STACK_SIZE			THREAD_SIZE
+#define IRQ_STACK_START_SP		THREAD_START_SP
+
+#ifndef __ASSEMBLER__
+
+#include <linux/percpu.h>
+
 #include <asm-generic/irq.h>
+#include <asm/thread_info.h>
 
 struct pt_regs;
 
+DECLARE_PER_CPU(unsigned long [IRQ_STACK_SIZE/sizeof(long)], irq_stack);
+
+/*
+ * The highest address on the stack, and the first to be used. Used to
+ * find the dummy-stack frame put down by el?_irq() in entry.S.
+ */
+#define IRQ_STACK_PTR(cpu) ((unsigned long)per_cpu(irq_stack, cpu) + IRQ_STACK_START_SP)
+
+/*
+ * The offset from irq_stack_ptr where entry.S will store the original
+ * stack pointer. Used by unwind_frame() and dump_backtrace().
+ */
+#define IRQ_STACK_TO_TASK_STACK(ptr) *((unsigned long *)(ptr - 0x10));
+
 extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
 
 static inline int nr_legacy_irqs(void)
@@ -12,4 +34,14 @@ static inline int nr_legacy_irqs(void)
 	return 0;
 }
 
+static inline bool on_irq_stack(unsigned long sp, int cpu)
+{
+	/* variable names the same as kernel/stacktrace.c */
+	unsigned long low = (unsigned long)per_cpu(irq_stack, cpu);
+	unsigned long high = low + IRQ_STACK_START_SP;
+
+	return (low <= sp && sp <= high);
+}
+
+#endif /* !__ASSEMBLER__ */
 #endif
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 9f17ec071ee0..1e3cef578e21 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -30,6 +30,9 @@
 
 unsigned long irq_err_count;
 
+/* irq stack only needs to be 16 byte aligned - not IRQ_STACK_SIZE aligned */
+DEFINE_PER_CPU(unsigned long [IRQ_STACK_SIZE/sizeof(long)], irq_stack) __aligned(16);
+
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
 	show_ipi_list(p, prec);
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index ccb6078ed9f2..b947eeffa5b2 100644
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
+	unsigned long irq_stack_ptr;
+
+	/*
+	 * Use raw_smp_processor_id() to avoid false-positives from
+	 * CONFIG_DEBUG_PREEMPT. get_wchan() calls unwind_frame() on sleeping
+	 * task stacks, we can be pre-empted in this case, so
+	 * {raw_,}smp_processor_id() may give us the wrong value. Sleeping
+	 * tasks can't ever be on an interrupt stack, so regardless of cpu,
+	 * the checks will always fail.
+	 */
+	irq_stack_ptr = IRQ_STACK_PTR(raw_smp_processor_id());
 
 	low  = frame->sp;
-	high = ALIGN(low, THREAD_SIZE);
+	/* irq stacks are not THREAD_SIZE aligned */
+	if (on_irq_stack(frame->sp, raw_smp_processor_id()))
+		high = irq_stack_ptr;
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
+	if (frame->sp == irq_stack_ptr)
+		frame->sp = IRQ_STACK_TO_TASK_STACK(irq_stack_ptr);
+
 	return 0;
 }
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index e9b9b5364393..8a0084541f84 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -146,6 +146,7 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
 static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 {
 	struct stackframe frame;
+	unsigned long irq_stack_ptr = IRQ_STACK_PTR(smp_processor_id());
 
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
+			if (stack < irq_stack_ptr &&
+			    (stack + sizeof(struct pt_regs)) > irq_stack_ptr)
+				stack = IRQ_STACK_TO_TASK_STACK(irq_stack_ptr);
+
 			dump_mem("", "Exception stack", stack,
 				 stack + sizeof(struct pt_regs), false);
+		}
 	}
 }
 
-- 
2.6.2
