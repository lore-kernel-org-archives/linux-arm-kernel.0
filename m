From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 23 Apr 2018 18:07:03 +0100
Subject: [RFC PATCH v2 3/3] arm64: stacktrace: Prevent looping and invalid
 stack transitions
In-Reply-To: <1524503223-17576-1-git-send-email-Dave.Martin@arm.com>
References: <1524503223-17576-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1524503223-17576-4-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the event of stack corruption, backtraces may loop indefinitely
or wander off into memory that is not a valid stack for the context
being backtraced.

This patch makes backtracing more robust against stack corruption,
by taking two things into account:

 * while staying on the same stack, the frame address must strictly
   increase from each frame to its ancestor;

 * when transitioning to another stack, the destination stack must
   be a stack that has not been visited already.

on_accessible_stack() is converted to a more expressive helper
identify_stack() that also tells the caller _which_ stack the task
appears to be on.  A field stack_id is added to struct stackframe
to track the result of this for the frame, along with a bitmap
stacks_used that records which stacks have been visited by the
backtrace.

Now that it is easy to check whether two successive frames are on
the same stack, it becomes straightfowrard to add a check for
strictly increasing frame address, to avoid looping around the same
stack: this patch adds that too.

This patch does not attempt to catch invalid transitions such as
from the task stack to the IRQ stack.  It turns out that the way
the overflow stack is used makes this complicated.  Nonetheless,
the number of frames parsed before the backtracer terminates should
now be guaranteed to be finite.

Reported-by: Ji Zhang <ji.zhang@mediatek.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/sdei.h       | 13 +++++++------
 arch/arm64/include/asm/stackid.h    | 22 ++++++++++++++++++++++
 arch/arm64/include/asm/stacktrace.h | 29 ++++++++++++++++++-----------
 arch/arm64/kernel/sdei.c            | 12 ++++++++----
 arch/arm64/kernel/stacktrace.c      | 30 ++++++++++++++++++++++++------
 5 files changed, 79 insertions(+), 27 deletions(-)
 create mode 100644 arch/arm64/include/asm/stackid.h

diff --git a/arch/arm64/include/asm/sdei.h b/arch/arm64/include/asm/sdei.h
index e073e68..5b56cfd 100644
--- a/arch/arm64/include/asm/sdei.h
+++ b/arch/arm64/include/asm/sdei.h
@@ -15,6 +15,7 @@
 #include <linux/preempt.h>
 #include <linux/types.h>
 
+#include <asm/stackid.h>
 #include <asm/virt.h>
 
 extern unsigned long sdei_exit_mode;
@@ -40,17 +41,17 @@ asmlinkage unsigned long __sdei_handler(struct pt_regs *regs,
 unsigned long sdei_arch_get_entry_point(int conduit);
 #define sdei_arch_get_entry_point(x)	sdei_arch_get_entry_point(x)
 
-bool _on_sdei_stack(unsigned long sp);
-static inline bool on_sdei_stack(unsigned long sp)
+enum arm64_stack_id _identify_sdei_stack(unsigned long sp);
+static inline enum arm64_stack_id identify_sdei_stack(unsigned long sp)
 {
 	if (!IS_ENABLED(CONFIG_VMAP_STACK))
-		return false;
+		return ARM64_STACK_NONE;
 	if (!IS_ENABLED(CONFIG_ARM_SDE_INTERFACE))
-		return false;
+		return ARM64_STACK_NONE;
 	if (in_nmi())
-		return _on_sdei_stack(sp);
+		return _identify_sdei_stack(sp);
 
-	return false;
+	return ARM64_STACK_NONE;
 }
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm64/include/asm/stackid.h b/arch/arm64/include/asm/stackid.h
new file mode 100644
index 0000000..3c4aefc
--- /dev/null
+++ b/arch/arm64/include/asm/stackid.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * arch/arm64/include/asm/stackid.h: Stack identification
+ *
+ * Copyright 2018 Arm Limited
+ * Author: Dave Martin <Dave.Martin@arm.com>
+ */
+#ifndef __ASM_STACKID_H
+#define __ASM_STACKID_H
+
+/* Set of stacks that a given task may execute on. */
+enum arm64_stack_id {
+	ARM64_STACK_TASK = 0,
+	ARM64_STACK_IRQ,
+	ARM64_STACK_OVERFLOW,
+	ARM64_STACK_SDEI_NORMAL,
+	ARM64_STACK_SDEI_CRITICAL,
+	__NR_ARM64_STACKS,
+	ARM64_STACK_NONE = __NR_ARM64_STACKS,
+};
+
+#endif /* ! __ASM_STACKID_H */
diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index c9bef22..f06a76a 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -16,6 +16,7 @@
 #ifndef __ASM_STACKTRACE_H
 #define __ASM_STACKTRACE_H
 
+#include <linux/bitmap.h>
 #include <linux/percpu.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
@@ -23,10 +24,13 @@
 #include <asm/memory.h>
 #include <asm/ptrace.h>
 #include <asm/sdei.h>
+#include <asm/stackid.h>
 
 struct stackframe {
 	unsigned long fp;
 	unsigned long pc;
+	DECLARE_BITMAP(stacks_used, __NR_ARM64_STACKS);
+	enum arm64_stack_id stack_id;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	int graph;
 #endif
@@ -77,21 +81,18 @@ static inline bool on_overflow_stack(unsigned long sp) { return false; }
  * We can only safely access per-cpu stacks from current in a non-preemptible
  * context.
  */
-static inline bool on_accessible_stack(struct task_struct const *tsk,
-				       unsigned long sp)
+static enum arm64_stack_id identify_stack(struct task_struct const *tsk,
+					  unsigned long sp)
 {
 	if (on_task_stack(tsk, sp))
-		return true;
+		return ARM64_STACK_TASK;
 	if (tsk != current || preemptible())
-		return false;
+		return ARM64_STACK_NONE;
 	if (on_irq_stack(sp))
-		return true;
+		return ARM64_STACK_IRQ;
 	if (on_overflow_stack(sp))
-		return true;
-	if (on_sdei_stack(sp))
-		return true;
-
-	return false;
+		return ARM64_STACK_OVERFLOW;
+	return identify_sdei_stack(sp);
 }
 
 static inline void start_backtrace(struct stackframe *frame,
@@ -100,8 +101,14 @@ static inline void start_backtrace(struct stackframe *frame,
 {
 	frame->fp = fp;
 	frame->pc = pc;
+	bitmap_zero(frame->stacks_used, __NR_ARM64_STACKS);
+
+	frame->stack_id = identify_stack(tsk, fp);
+	if (frame->stack_id != ARM64_STACK_NONE)
+		set_bit(frame->stack_id, frame->stacks_used);
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	frame.graph = tsk->curr_ret_stack;
+	frame->graph = tsk->curr_ret_stack;
 #endif
 }
 
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 6b8d90d..93665b0 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -13,6 +13,7 @@
 #include <asm/mmu.h>
 #include <asm/ptrace.h>
 #include <asm/sections.h>
+#include <asm/stackid.h>
 #include <asm/sysreg.h>
 #include <asm/vmap_stack.h>
 
@@ -88,23 +89,26 @@ static int init_sdei_stacks(void)
 	return err;
 }
 
-bool _on_sdei_stack(unsigned long sp)
+enum arm64_stack_id _identify_sdei_stack(unsigned long sp)
 {
 	unsigned long low, high;
 
 	if (!IS_ENABLED(CONFIG_VMAP_STACK))
-		return false;
+		return ARM64_STACK_NONE;
 
 	low = (unsigned long)raw_cpu_read(sdei_stack_critical_ptr);
 	high = low + SDEI_STACK_SIZE;
 
 	if (low <= sp && sp < high)
-		return true;
+		return ARM64_STACK_SDEI_CRITICAL;
 
 	low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
 	high = low + SDEI_STACK_SIZE;
 
-	return (low <= sp && sp < high);
+	if (low <= sp && sp < high)
+		return ARM64_STACK_SDEI_NORMAL;
+
+	return ARM64_STACK_NONE;
 }
 
 unsigned long sdei_arch_get_entry_point(int conduit)
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index d5718a0..a5e0547 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -43,6 +43,7 @@
 int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 {
 	unsigned long fp = frame->fp;
+	enum arm64_stack_id stack_id = frame->stack_id;
 
 	if (fp & 0xf)
 		return -EINVAL;
@@ -50,11 +51,12 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 	if (!tsk)
 		tsk = current;
 
-	if (!on_accessible_stack(tsk, fp))
+	if (stack_id == ARM64_STACK_NONE)
 		return -EINVAL;
 
 	frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
 	frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 8));
+	frame->stack_id = identify_stack(tsk, frame->fp);
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	if (tsk->ret_stack &&
@@ -75,14 +77,30 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
 	/*
-	 * Frames created upon entry from EL0 have NULL FP and PC values, so
-	 * don't bother reporting these. Frames created by __noreturn functions
-	 * might have a valid FP even if PC is bogus, so only terminate where
-	 * both are NULL.
+	 * Terminate when the next frame isn't on any valid stack for
+	 * tsk.  As a special case, frames created upon entry from EL0
+	 * have NULL FP and PC values, so will terminate here also.
+	 * Frames created by __noreturn functions might have a valid FP
+	 * even if PC is bogus, so only terminate where FP is invalid.
 	 */
-	if (!frame->fp && !frame->pc)
+	if (frame->stack_id == ARM64_STACK_NONE)
 		return -EINVAL;
 
+	/*
+	 * Reject attempts to recurse back onto a stack that has been
+	 * visited already:
+	 */
+	if (test_bit(frame->stack_id, frame->stacks_used))
+		return -EINVAL;
+
+	/* Verify forward progress while on the same stack: */
+	if (frame->stack_id == stack_id) {
+		if (frame->fp <= fp)
+			return -EINVAL;
+	}
+
+	set_bit(frame->stack_id, frame->stacks_used);
+
 	return 0;
 }
 
-- 
2.1.4
