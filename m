From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 26 Jul 2017 19:18:29 +0100
Subject: [PATCHv2 6/7] arm64: unwind: reference pt_regs via embedded stack
 frame
In-Reply-To: <1501093110-3844-1-git-send-email-mark.rutland@arm.com>
References: <1501093110-3844-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1501093110-3844-7-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

As it turns out, the unwind code is slightly broken, and probably has
been for a while. The problem is in the dumping of the exception stack,
which is intended to dump the contents of the pt_regs struct at each
level in the call stack where an exception was taken and routed to a
routine marked as __exception (which means its stack frame is right
below the pt_regs struct on the stack).

'Right below the pt_regs struct' is ill defined, though: the unwind
code assigns 'frame pointer + 0x10' to the .sp member of the stackframe
struct at each level, and dump_backtrace() happily dereferences that as
the pt_regs pointer when encountering an __exception routine. However,
the actual size of the stack frame created by this routine (which could
be one of many __exception routines we have in the kernel) is not known,
and so frame.sp is pretty useless to figure out where struct pt_regs
really is.

So it seems the only way to ensure that we can find our struct pt_regs
when walking the stack frames is to put it at a known fixed offset of
the stack frame pointer that is passed to such __exception routines.
The simplest way to do that is to put it inside pt_regs itself, which is
the main change implemented by this patch. As a bonus, doing this allows
us to get rid of a fair amount of cruft related to walking from one stack
to the other, which is especially nice since we intend to introduce yet
another stack for overflow handling once we add support for vmapped
stacks. It also fixes an inconsistency where we only add a stack frame
pointing to ELR_EL1 if we are executing from the IRQ stack but not when
we are executing from the task stack.

To consistly identify exceptions regs even in the presence of exceptions
taken from entry code, we must check whether the next frame was created
by entry text, rather than whether the current frame was crated by
exception text.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
[Mark: compare current frame against .entry.text]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/irq.h    | 25 -------------------------
 arch/arm64/include/asm/ptrace.h |  1 +
 arch/arm64/include/asm/traps.h  |  5 +++++
 arch/arm64/kernel/asm-offsets.c |  1 +
 arch/arm64/kernel/entry.S       | 16 ++++++++--------
 arch/arm64/kernel/stacktrace.c  | 30 ------------------------------
 arch/arm64/kernel/traps.c       | 32 +++++++-------------------------
 7 files changed, 22 insertions(+), 88 deletions(-)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index 8155e48..8ba89c4 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -16,31 +16,6 @@
 
 DECLARE_PER_CPU(unsigned long [IRQ_STACK_SIZE/sizeof(long)], irq_stack);
 
-/*
- * The highest address on the stack, and the first to be used. Used to
- * find the dummy-stack frame put down by el?_irq() in entry.S, which
- * is structured as follows:
- *
- *       ------------
- *       |          |  <- irq_stack_ptr
- *   top ------------
- *       |   x19    | <- irq_stack_ptr - 0x08
- *       ------------
- *       |   x29    | <- irq_stack_ptr - 0x10
- *       ------------
- *
- * where x19 holds a copy of the task stack pointer where the struct pt_regs
- * from kernel_entry can be found.
- *
- */
-#define IRQ_STACK_PTR() ((unsigned long)raw_cpu_ptr(irq_stack) + IRQ_STACK_START_SP)
-
-/*
- * The offset from irq_stack_ptr where entry.S will store the original
- * stack pointer. Used by unwind_frame() and dump_backtrace().
- */
-#define IRQ_STACK_TO_TASK_STACK(ptr) (*((unsigned long *)((ptr) - 0x08)))
-
 extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
 
 static inline int nr_legacy_irqs(void)
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 11403fd..ee72aa9 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -119,6 +119,7 @@ struct pt_regs {
 	u64 syscallno;
 	u64 orig_addr_limit;
 	u64 unused;	// maintain 16 byte alignment
+	u64 stackframe[2];
 };
 
 #define MAX_REG_OFFSET offsetof(struct pt_regs, pstate)
diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index 02e9035..4136168 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -60,4 +60,9 @@ static inline int in_exception_text(unsigned long ptr)
 	return in ? : __in_irqentry_text(ptr);
 }
 
+static inline int in_entry_text(unsigned long ptr)
+{
+	return ptr >= (unsigned long)&__entry_text_start &&
+	       ptr < (unsigned long)&__entry_text_end;
+}
 #endif
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index b3bb7ef..71bf088 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -75,6 +75,7 @@ int main(void)
   DEFINE(S_ORIG_X0,		offsetof(struct pt_regs, orig_x0));
   DEFINE(S_SYSCALLNO,		offsetof(struct pt_regs, syscallno));
   DEFINE(S_ORIG_ADDR_LIMIT,	offsetof(struct pt_regs, orig_addr_limit));
+  DEFINE(S_STACKFRAME,		offsetof(struct pt_regs, stackframe));
   DEFINE(S_FRAME_SIZE,		sizeof(struct pt_regs));
   BLANK();
   DEFINE(MM_CONTEXT_ID,		offsetof(struct mm_struct, context.id.counter));
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 9e126d3..4ddb8d7 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -111,6 +111,14 @@
 	mrs	x23, spsr_el1
 	stp	lr, x21, [sp, #S_LR]
 
+	/*
+	 * In order to be able to dump the contents of struct pt_regs@the
+	 * time the exception was taken (in case we attempt to walk the call
+	 * stack later), chain it together with the stack frames.
+	 */
+	stp	x29, x22, [sp, #S_STACKFRAME]
+	add	x29, sp, #S_STACKFRAME
+
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
 	/*
 	 * Set the TTBR0 PAN bit in SPSR. When the exception is taken from
@@ -265,14 +273,6 @@ alternative_else_nop_endif
 
 	/* switch to the irq stack */
 	mov	sp, x26
-
-	/*
-	 * Add a dummy stack frame, this non-standard format is fixed up
-	 * by unwind_frame()
-	 */
-	stp     x29, x19, [sp, #-16]!
-	mov	x29, sp
-
 9998:
 	.endm
 
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index beaf51f..b079af1 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -75,36 +75,6 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 	}
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
-	/*
-	 * Check whether we are going to walk through from interrupt stack
-	 * to task stack.
-	 * If we reach the end of the stack - and its an interrupt stack,
-	 * unpack the dummy frame to find the original elr.
-	 *
-	 * Check the frame->fp we read from the bottom of the irq_stack,
-	 * and the original task stack pointer are both in current->stack.
-	 */
-	if (frame->sp == IRQ_STACK_PTR()) {
-		struct pt_regs *irq_args;
-		unsigned long orig_sp = IRQ_STACK_TO_TASK_STACK(frame->sp);
-
-		if (object_is_on_stack((void *)orig_sp) &&
-		   object_is_on_stack((void *)frame->fp)) {
-			frame->sp = orig_sp;
-
-			/* orig_sp is the saved pt_regs, find the elr */
-			irq_args = (struct pt_regs *)orig_sp;
-			frame->pc = irq_args->pc;
-		} else {
-			/*
-			 * This frame has a non-standard format, and we
-			 * didn't fix it, because the data looked wrong.
-			 * Refuse to output this frame.
-			 */
-			return -EINVAL;
-		}
-	}
-
 	return 0;
 }
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 7ba80f2..caf2f79 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -143,7 +143,6 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
 void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 {
 	struct stackframe frame;
-	unsigned long irq_stack_ptr;
 	int skip;
 
 	pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
@@ -154,15 +153,6 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 	if (!try_get_task_stack(tsk))
 		return;
 
-	/*
-	 * Switching between stacks is valid when tracing current and in
-	 * non-preemptible context.
-	 */
-	if (tsk == current && !preemptible())
-		irq_stack_ptr = IRQ_STACK_PTR();
-	else
-		irq_stack_ptr = 0;
-
 	if (tsk == current) {
 		frame.fp = (unsigned long)__builtin_frame_address(0);
 		frame.sp = current_stack_pointer;
@@ -182,13 +172,12 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 	skip = !!regs;
 	printk("Call trace:\n");
 	while (1) {
-		unsigned long where = frame.pc;
 		unsigned long stack;
 		int ret;
 
 		/* skip until specified stack frame */
 		if (!skip) {
-			dump_backtrace_entry(where);
+			dump_backtrace_entry(frame.pc);
 		} else if (frame.fp == regs->regs[29]) {
 			skip = 0;
 			/*
@@ -203,20 +192,13 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 		ret = unwind_frame(tsk, &frame);
 		if (ret < 0)
 			break;
-		stack = frame.sp;
-		if (in_exception_text(where)) {
-			/*
-			 * If we switched to the irq_stack before calling this
-			 * exception handler, then the pt_regs will be on the
-			 * task stack. The easiest way to tell is if the large
-			 * pt_regs would overlap with the end of the irq_stack.
-			 */
-			if (stack < irq_stack_ptr &&
-			    (stack + sizeof(struct pt_regs)) > irq_stack_ptr)
-				stack = IRQ_STACK_TO_TASK_STACK(irq_stack_ptr);
+		if (in_entry_text(frame.pc)) {
+			stack = frame.fp - offsetof(struct pt_regs, stackframe);
 
-			dump_mem("", "Exception stack", stack,
-				 stack + sizeof(struct pt_regs));
+			if (on_task_stack(tsk, stack) ||
+			    (tsk == current && !preemptible() && on_irq_stack(stack)))
+				dump_mem("", "Exception stack", stack,
+					 stack + sizeof(struct pt_regs));
 		}
 	}
 
-- 
1.9.1
