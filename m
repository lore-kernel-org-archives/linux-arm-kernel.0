From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 20 Apr 2018 11:46:19 +0100
Subject: [RFC PATCH 3/3] arm64: stacktrace: Prevent looping and invalid stack
 transitions
In-Reply-To: <1524221179-19473-1-git-send-email-Dave.Martin@arm.com>
References: <1524221179-19473-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1524221179-19473-4-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the event of stack corruption, backtraces may loop indefinitely
or wander off into memory that is not a valid stack for the context
being backtraced.

This patch makes backtracing more robust against stack corruption,
by taking two things into account:

 * while staying on the same stack, the frame address must strictly
   increase from each frame to its ancestor;

 * when transitioning to another stack, the set of valid stacks for
   the context forms a strict hierarchy (e.g., a frame on the task
   stack cannot have an ancestor frame on the IRQ stack because
   task context cannot preempt IRQ handlers etc.)

on_accessible_stack() is converted to a more expressive helper
identify_stack() that also tells the caller _which_ stack the task
appears to be on.  The stack identifier is represented by an enum
sorted into the correct order for checking stack transition
validity by a simple numeric comparison.  A field stack_id is added
to struct stackframe to track the result of this for the frame.

Now that it is easy to check whether two successive frames are on
the same stack, it is easy to add a check for strictly increasing
frame address, to avoid looping around the same stack.

Now that frames can be mapped to a strict lexical order on the
stack id and frame address, forward progress should be guaranteed.

Backtracing now terminates whenever the next frame violates this
order, with kernel entry (with fp == 0 && pc == 0) as a special
case of this.

Reported-by: Ji Zhang <ji.zhang@mediatek.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

The assumption that we can place the possible stacks (task, IRQ,
overflow, SDEI) in a strict order is based on a quick review of
entry.S, but I may have this wrong... in which case the approach
proposed in this patch may need tweaking (or may not work at all).
---
 arch/arm64/include/asm/stacktrace.h | 35 +++++++++++++++++++++++++++--------
 arch/arm64/kernel/stacktrace.c      | 16 ++++++++++------
 2 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index c9bef22..fe97ff1 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -24,9 +24,26 @@
 #include <asm/ptrace.h>
 #include <asm/sdei.h>
 
+/*
+ * Set of stacks that a given task may execute on.
+ *
+ * This must be sorted so that if entry A appears before entry B, the
+ * context corresponding to A cannot preempt the context corresponding
+ * to B.  This property is used by the unwinder to verify forward
+ * progress by means of a numeric comparison on this enum.
+ */
+enum arm64_stack_id {
+	ARM64_STACK_NONE,
+	ARM64_STACK_TASK,
+	ARM64_STACK_IRQ,
+	ARM64_STACK_OVERFLOW,
+	ARM64_STACK_SDEI,
+};
+
 struct stackframe {
 	unsigned long fp;
 	unsigned long pc;
+	enum arm64_stack_id stack_id;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	int graph;
 #endif
@@ -77,21 +94,22 @@ static inline bool on_overflow_stack(unsigned long sp) { return false; }
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
+		goto bad;
 	if (on_irq_stack(sp))
-		return true;
+		return ARM64_STACK_IRQ;
 	if (on_overflow_stack(sp))
-		return true;
+		return ARM64_STACK_OVERFLOW;
 	if (on_sdei_stack(sp))
-		return true;
+		return ARM64_STACK_SDEI;
 
-	return false;
+bad:
+	return ARM64_STACK_NONE;
 }
 
 static inline void start_backtrace(struct stackframe *frame,
@@ -100,6 +118,7 @@ static inline void start_backtrace(struct stackframe *frame,
 {
 	frame->fp = fp;
 	frame->pc = pc;
+	frame->stack_id = identify_stack(tsk, fp);
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	frame.graph = tsk->curr_ret_stack;
 #endif
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index d5718a0..518ac57 100644
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
@@ -75,12 +77,14 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
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
+	if (frame->stack_id > stack_id ||
+	    (frame->stack_id == stack_id && frame->fp <= fp))
 		return -EINVAL;
 
 	return 0;
-- 
2.1.4
