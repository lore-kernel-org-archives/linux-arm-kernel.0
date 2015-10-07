From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Wed,  7 Oct 2015 15:28:12 +0000
Subject: [PATCH v4 2/2] arm64: Expand the stack trace feature to support IRQ
 stack
In-Reply-To: <1444231692-32722-1-git-send-email-jungseoklee85@gmail.com>
References: <1444231692-32722-1-git-send-email-jungseoklee85@gmail.com>
Message-ID: <1444231692-32722-3-git-send-email-jungseoklee85@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, a call trace drops a process stack walk when a separate IRQ
stack is used. It makes a call trace information much less useful when
a system gets paniked in interrupt context.

This patch addresses the issue with the following schemes:

  - Store aborted stack frame data
  - Decide whether another stack walk is needed or not via current sp
  - Loosen the frame pointer upper bound condition

Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: James Morse <james.morse@arm.com>
Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
---
 arch/arm64/include/asm/irq.h    | 12 +++++++++++
 arch/arm64/kernel/asm-offsets.c |  3 +++
 arch/arm64/kernel/entry.S       | 10 ++++++++--
 arch/arm64/kernel/stacktrace.c  | 22 ++++++++++++++++++++-
 arch/arm64/kernel/traps.c       | 13 ++++++++++++
 5 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index 6ea82e8..e5904a1 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -2,13 +2,25 @@
 #define __ASM_IRQ_H
 
 #include <linux/irqchip/arm-gic-acpi.h>
+#include <asm/stacktrace.h>
 
 #include <asm-generic/irq.h>
 
 struct irq_stack {
 	void *stack;
+	struct stackframe frame;
 };
 
+DECLARE_PER_CPU(struct irq_stack, irq_stacks);
+
+static inline bool in_irq_stack(unsigned int cpu)
+{
+	unsigned long high = (unsigned long)per_cpu(irq_stacks, cpu).stack;
+
+	return (current_stack_pointer >= round_down(high, THREAD_SIZE)) &&
+		current_stack_pointer < high;
+}
+
 struct pt_regs;
 
 extern void migrate_irqs(void);
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index b16e3cf..fbb52f2d 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -42,6 +42,9 @@ int main(void)
   DEFINE(THREAD_CPU_CONTEXT,	offsetof(struct task_struct, thread.cpu_context));
   BLANK();
   DEFINE(IRQ_STACK,		offsetof(struct irq_stack, stack));
+  DEFINE(IRQ_FRAME_FP,		offsetof(struct irq_stack, frame.fp));
+  DEFINE(IRQ_FRAME_SP,		offsetof(struct irq_stack, frame.sp));
+  DEFINE(IRQ_FRAME_PC,		offsetof(struct irq_stack, frame.pc));
   BLANK();
   DEFINE(S_X0,			offsetof(struct pt_regs, regs[0]));
   DEFINE(S_X1,			offsetof(struct pt_regs, regs[1]));
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 6d4e8c5..650cc05 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -121,7 +121,8 @@
 	 * x21 - aborted SP
 	 * x22 - aborted PC
 	 * x23 - aborted PSTATE
-	*/
+	 * x29 - aborted FP
+	 */
 	.endm
 
 	.macro	kernel_exit, el
@@ -184,7 +185,12 @@ alternative_endif
 	mov	x23, sp
 	and	x23, x23, #~(THREAD_SIZE - 1)
 	cmp	x20, x23			// check irq re-enterance
-	mov	x19, sp
+	beq	1f
+	str	x29, [x19, #IRQ_FRAME_FP]
+	str	x21, [x19, #IRQ_FRAME_SP]
+	str	x22, [x19, #IRQ_FRAME_PC]
+	mov	x29, x24
+1:	mov	x19, sp
 	csel	x23, x19, x24, eq		// x24 = top of irq stack
 	mov	sp, x23
 	.endm
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 407991b..5124649 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -43,7 +43,27 @@ int notrace unwind_frame(struct stackframe *frame)
 	low  = frame->sp;
 	high = ALIGN(low, THREAD_SIZE);
 
-	if (fp < low || fp > high - 0x18 || fp & 0xf)
+	/*
+	 * A frame pointer would reach an upper bound if a prologue of the
+	 * first function of call trace looks as follows:
+	 *
+	 *	stp     x29, x30, [sp,#-16]!
+	 *	mov     x29, sp
+	 *
+	 * Thus, the upper bound is (top of stack - 0x20) with consideration
+	 * of a 16-byte empty space in THREAD_START_SP.
+	 *
+	 * The value, 0x20, however, does not cover all cases as interrupts
+	 * are handled using a separate stack. That is, a call trace can start
+	 * from elx_irq exception vectors. The symbols could not be promoted
+	 * to candidates for a stack trace under the restriction, 0x20.
+	 *
+	 * The scenario is handled without complexity as 1) considering
+	 * (bottom of stack + THREAD_START_SP) as a dummy frame pointer, the
+	 * content of which is 0, and 2) allowing the case, which changes
+	 * the value to 0x10 from 0x20.
+	 */
+	if (fp < low || fp > high - 0x10 || fp & 0xf)
 		return -EINVAL;
 
 	frame->sp = fp + 0x10;
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index f93aae5..44b2f828 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -146,6 +146,8 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
 static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 {
 	struct stackframe frame;
+	unsigned int cpu = smp_processor_id();
+	bool in_irq = in_irq_stack(cpu);
 
 	pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
 
@@ -170,6 +172,10 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 	}
 
 	pr_emerg("Call trace:\n");
+repeat:
+	if (in_irq)
+		pr_emerg("<IRQ>\n");
+
 	while (1) {
 		unsigned long where = frame.pc;
 		int ret;
@@ -179,6 +185,13 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 			break;
 		dump_backtrace_entry(where, frame.sp);
 	}
+
+	if (in_irq) {
+		frame = per_cpu(irq_stacks, cpu).frame;
+		in_irq = false;
+		pr_emerg("<EOI>\n");
+		goto repeat;
+	}
 }
 
 void show_stack(struct task_struct *tsk, unsigned long *sp)
-- 
2.5.0
