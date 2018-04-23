From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 23 Apr 2018 18:07:02 +0100
Subject: [RFC PATCH v2 2/3] arm64: stacktrace: Factor out backtrace
 initialisation
In-Reply-To: <1524503223-17576-1-git-send-email-Dave.Martin@arm.com>
References: <1524503223-17576-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1524503223-17576-3-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some common code is required by each stacktrace user to initialise
struct stackframe before the first call to unwind_frame().

In preparation for adding to the common code, this patch factors it
out into a separate function start_backtrace(), and modifies the
stacktrace callers appropriately.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/stacktrace.h | 11 +++++++++++
 arch/arm64/kernel/process.c         |  6 +-----
 arch/arm64/kernel/time.c            |  6 +-----
 arch/arm64/kernel/traps.c           | 21 ++++++++-------------
 4 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index 63c0379..c9bef22 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -94,4 +94,15 @@ static inline bool on_accessible_stack(struct task_struct const *tsk,
 	return false;
 }
 
+static inline void start_backtrace(struct stackframe *frame,
+			    struct task_struct const *tsk,
+			    unsigned long fp, unsigned long pc)
+{
+	frame->fp = fp;
+	frame->pc = pc;
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	frame.graph = tsk->curr_ret_stack;
+#endif
+}
+
 #endif	/* __ASM_STACKTRACE_H */
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index f08a2ed..59b418c 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -452,11 +452,7 @@ unsigned long get_wchan(struct task_struct *p)
 	if (!stack_page)
 		return 0;
 
-	frame.fp = thread_saved_fp(p);
-	frame.pc = thread_saved_pc(p);
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	frame.graph = p->curr_ret_stack;
-#endif
+	start_backtrace(&frame, p, thread_saved_fp(p), thread_saved_pc(p));
 	do {
 		if (unwind_frame(p, &frame))
 			goto out;
diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
index f258636..83f08c7 100644
--- a/arch/arm64/kernel/time.c
+++ b/arch/arm64/kernel/time.c
@@ -49,11 +49,7 @@ unsigned long profile_pc(struct pt_regs *regs)
 	if (!in_lock_functions(regs->pc))
 		return regs->pc;
 
-	frame.fp = regs->regs[29];
-	frame.pc = regs->pc;
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	frame.graph = current->curr_ret_stack;
-#endif
+	start_backtrace(&frame, current, regs->regs[29], regs->pc);
 	do {
 		int ret = unwind_frame(NULL, &frame);
 		if (ret < 0)
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 1cb2749..40591cf 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -111,19 +111,14 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 	if (!try_get_task_stack(tsk))
 		return;
 
-	if (tsk == current) {
-		frame.fp = (unsigned long)__builtin_frame_address(0);
-		frame.pc = (unsigned long)dump_backtrace;
-	} else {
-		/*
-		 * task blocked in __switch_to
-		 */
-		frame.fp = thread_saved_fp(tsk);
-		frame.pc = thread_saved_pc(tsk);
-	}
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	frame.graph = tsk->curr_ret_stack;
-#endif
+	if (tsk == current)
+		start_backtrace(&frame, tsk,
+				(unsigned long)__builtin_frame_address(0),
+				(unsigned long)dump_backtrace);
+	else /* task blocked in __switch_to */
+		start_backtrace(&frame, tsk,
+				thread_saved_fp(tsk),
+				thread_saved_pc(tsk));
 
 	skip = !!regs;
 	printk("Call trace:\n");
-- 
2.1.4
