From: duwe@lst.de (Torsten Duwe)
Date: Fri, 26 Oct 2018 16:21:57 +0200 (CEST)
Subject: [PATCH v4 3/3] arm64: reliable stacktraces
In-Reply-To: <20181026142008.D922868C94@newverein.lst.de>
References: <20181026142008.D922868C94@newverein.lst.de>
Message-ID: <20181026142157.B8FAA68C97@newverein.lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enhance the stack unwinder so that it reports whether it had to stop
normally or due to an error condition; unwind_frame() will report
continue/error/normal ending and walk_stackframe() will pass that
info. __save_stack_trace() is used to check the validity of a stack;
save_stack_trace_tsk_reliable() can now trivially be implemented.
Modify arch/arm64/kernel/time.c as the only external caller so far
to recognise the new semantics.

I had to introduce a marker symbol kthread_return_to_user to tell
the normal origin of a kernel thread.

Signed-off-by: Torsten Duwe <duwe@suse.de>

--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -128,8 +128,9 @@ config ARM64
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RCU_TABLE_FREE
+	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -33,7 +33,7 @@ struct stackframe {
 };
 
 extern int unwind_frame(struct task_struct *tsk, struct stackframe *frame);
-extern void walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
+extern int walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
 			    int (*fn)(struct stackframe *, void *), void *data);
 extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk);
 
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -40,6 +40,16 @@
  *	ldp	x29, x30, [sp]
  *	add	sp, sp, #0x10
  */
+
+/* The bottom of kernel thread stacks points there */
+extern void *kthread_return_to_user;
+
+/*
+ * unwind_frame -- unwind a single stack frame.
+ * Returns 0 when there are more frames to go.
+ * 1 means reached end of stack; negative (error)
+ * means stopped because information is not reliable.
+ */
 int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 {
 	unsigned long fp = frame->fp;
@@ -75,29 +85,39 @@ int notrace unwind_frame(struct task_str
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
 	/*
+	 * kthreads created via copy_thread() (called from kthread_create())
+	 * will have a zero BP and a return value into ret_from_fork.
+	 */
+	if (!frame->fp && frame->pc == (unsigned long)&kthread_return_to_user)
+		return 1;
+	/*
 	 * Frames created upon entry from EL0 have NULL FP and PC values, so
 	 * don't bother reporting these. Frames created by __noreturn functions
 	 * might have a valid FP even if PC is bogus, so only terminate where
 	 * both are NULL.
 	 */
 	if (!frame->fp && !frame->pc)
-		return -EINVAL;
+		return 1;
 
 	return 0;
 }
 
-void notrace walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
+int notrace walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
 		     int (*fn)(struct stackframe *, void *), void *data)
 {
 	while (1) {
 		int ret;
 
-		if (fn(frame, data))
-			break;
+		ret = fn(frame, data);
+		if (ret)
+			return ret;
 		ret = unwind_frame(tsk, frame);
 		if (ret < 0)
+			return ret;
+		if (ret > 0)
 			break;
 	}
+	return 0;
 }
 
 #ifdef CONFIG_STACKTRACE
@@ -145,14 +165,15 @@ void save_stack_trace_regs(struct pt_reg
 		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 
-static noinline void __save_stack_trace(struct task_struct *tsk,
+static noinline int __save_stack_trace(struct task_struct *tsk,
 	struct stack_trace *trace, unsigned int nosched)
 {
 	struct stack_trace_data data;
 	struct stackframe frame;
+	int ret;
 
 	if (!try_get_task_stack(tsk))
-		return;
+		return -EBUSY;
 
 	data.trace = trace;
 	data.skip = trace->skip;
@@ -171,11 +192,12 @@ static noinline void __save_stack_trace(
 	frame.graph = tsk->curr_ret_stack;
 #endif
 
-	walk_stackframe(tsk, &frame, save_trace, &data);
+	ret = walk_stackframe(tsk, &frame, save_trace, &data);
 	if (trace->nr_entries < trace->max_entries)
 		trace->entries[trace->nr_entries++] = ULONG_MAX;
 
 	put_task_stack(tsk);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
 
@@ -190,4 +212,12 @@ void save_stack_trace(struct stack_trace
 }
 
 EXPORT_SYMBOL_GPL(save_stack_trace);
+
+int save_stack_trace_tsk_reliable(struct task_struct *tsk,
+				  struct stack_trace *trace)
+{
+	return __save_stack_trace(tsk, trace, 1);
+}
+EXPORT_SYMBOL_GPL(save_stack_trace_tsk_reliable);
+
 #endif
--- a/arch/arm64/kernel/time.c
+++ b/arch/arm64/kernel/time.c
@@ -56,7 +56,7 @@ unsigned long profile_pc(struct pt_regs
 #endif
 	do {
 		int ret = unwind_frame(NULL, &frame);
-		if (ret < 0)
+		if (ret)
 			return 0;
 	} while (in_lock_functions(frame.pc));
 
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -1178,15 +1178,17 @@ ENTRY(cpu_switch_to)
 ENDPROC(cpu_switch_to)
 NOKPROBE(cpu_switch_to)
 
+	.global	kthread_return_to_user
 /*
  * This is how we return from a fork.
  */
 ENTRY(ret_from_fork)
 	bl	schedule_tail
-	cbz	x19, 1f				// not a kernel thread
+	cbz	x19, kthread_return_to_user	// not a kernel thread
 	mov	x0, x20
 	blr	x19
-1:	get_thread_info tsk
+kthread_return_to_user:
+	get_thread_info tsk
 	b	ret_to_user
 ENDPROC(ret_from_fork)
 NOKPROBE(ret_from_fork)
