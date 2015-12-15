From: james.morse@arm.com (James Morse)
Date: Tue, 15 Dec 2015 11:21:25 +0000
Subject: [PATCH v8 9/4] arm64: reduce stack use in irq_handler
In-Reply-To: <1449226948-14251-1-git-send-email-james.morse@arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
Message-ID: <1450178485-22634-1-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code for switching to irq_stack stores three pieces of information on
the stack, fp+lr, as a fake stack frame (that lets us walk back onto the
interrupted tasks stack frame), and the address of the struct pt_regs that
contains the register values from kernel entry. (which dump_backtrace()
will print in any stack trace).

To reduce this, we store fp, and the pointer to the struct pt_regs.
unwind_frame() can recognise this as the irq_stack dummy frame, (as it only
appears at the top of the irq_stack), and use the struct pt_regs values
to find the missing interrupted link-register.

Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
This patch also silently removes the other stupid mistakes I made in
IRQ_STACK_TO_TASK_STACK().

Based on for-next/core


 arch/arm64/include/asm/irq.h   | 11 ++++-------
 arch/arm64/kernel/entry.S      | 12 +++++++-----
 arch/arm64/kernel/stacktrace.c | 17 +++++++++++++++--
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index 877c7e358384..3bece4379bd9 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -25,16 +25,13 @@ DECLARE_PER_CPU(unsigned long [IRQ_STACK_SIZE/sizeof(long)], irq_stack);
  *       ------------
  *       |          |  <- irq_stack_ptr
  *   top ------------
- *       |  elr_el1 |
+ *       |   x19    | <- irq_stack_ptr - 0x08
  *       ------------
  *       |   x29    | <- irq_stack_ptr - 0x10
  *       ------------
- *       |   xzr    |
- *       ------------
- *       |   x19    | <- irq_stack_ptr - 0x20
- *       ------------
  *
- * where x19 holds a copy of the task stack pointer.
+ * where x19 holds a copy of the task stack pointer where the struct pt_regs
+ * from kernel_entry can be found.
  *
  */
 #define IRQ_STACK_PTR(cpu) ((unsigned long)per_cpu(irq_stack, cpu) + IRQ_STACK_START_SP)
@@ -43,7 +40,7 @@ DECLARE_PER_CPU(unsigned long [IRQ_STACK_SIZE/sizeof(long)], irq_stack);
  * The offset from irq_stack_ptr where entry.S will store the original
  * stack pointer. Used by unwind_frame() and dump_backtrace().
  */
-#define IRQ_STACK_TO_TASK_STACK(ptr) *((unsigned long *)(ptr - 0x20));
+#define IRQ_STACK_TO_TASK_STACK(ptr) (*((unsigned long *)((ptr) - 0x08)))
 
 extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
 
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 2284c296e3f7..0667fb7d8bb1 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -178,7 +178,7 @@ alternative_endif
 	mrs	\rd, sp_el0
 	.endm
 
-	.macro	irq_stack_entry, dummy_lr
+	.macro	irq_stack_entry
 	mov	x19, sp			// preserve the original sp
 
 	this_cpu_ptr irq_stack, x25, x26
@@ -196,10 +196,12 @@ alternative_endif
 	add	x26, x25, x26
 	mov	sp, x26
 
-	/* Add a dummy stack frame */
-	stp     x29, \dummy_lr, [sp, #-16]!           // dummy stack frame
+	/*
+	 * Add a dummy stack frame, this non-standard format is fixed up
+	 * by unwind_frame()
+	 */
+	stp     x29, x19, [sp, #-16]!
 	mov	x29, sp
-	stp     x19, xzr, [sp, #-16]!
 
 9998:
 	.endm
@@ -229,7 +231,7 @@ tsk	.req	x28		// current thread_info
 	.macro	irq_handler
 	ldr_l	x1, handle_arch_irq
 	mov	x0, sp
-	irq_stack_entry x22
+	irq_stack_entry
 	blr	x1
 	irq_stack_exit
 	.endm
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index d916d5b6aef6..82659e1df761 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -70,17 +70,30 @@ int notrace unwind_frame(struct stackframe *frame)
 	 * Check whether we are going to walk through from interrupt stack
 	 * to task stack.
 	 * If we reach the end of the stack - and its an interrupt stack,
-	 * read the original task stack pointer from the dummy frame.
+	 * unpack the dummy frame to find the original elr.
 	 *
 	 * Check the frame->fp we read from the bottom of the irq_stack,
 	 * and the original task stack pointer are both in current->stack.
 	 */
 	if (frame->sp == irq_stack_ptr) {
+		struct pt_regs *irq_args;
 		unsigned long orig_sp = IRQ_STACK_TO_TASK_STACK(irq_stack_ptr);
 
 		if(object_is_on_stack((void *)orig_sp) &&
-		   object_is_on_stack((void *)frame->fp))
+		   object_is_on_stack((void *)frame->fp)) {
 			frame->sp = orig_sp;
+
+			/* orig_sp is the saved pt_regs, find the elr */
+			irq_args = (struct pt_regs *)orig_sp;
+			frame->pc = irq_args->pc;
+		} else {
+			/*
+			 * This frame has a non-standard format, and we
+			 * didn't fix it, because the data looked wrong.
+			 * Refuse to output this frame.
+			 */
+			return -EINVAL;
+		}
 	}
 
 	return 0;
-- 
2.6.2
