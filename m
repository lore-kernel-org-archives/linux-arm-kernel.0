From: duwe@lst.de (Torsten Duwe)
Date: Fri, 10 Aug 2018 18:03:11 +0200 (CEST)
Subject: [PATCH 3/3] arm64: reliable stacktraces
In-Reply-To: <20180810160043.9E45568C76@newverein.lst.de>
References: <20180810160043.9E45568C76@newverein.lst.de>
Message-ID: <20180810160311.C988D68CF4@newverein.lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is more an RFC in the original sense: is this basically
the correct approach? (as I had to tweak the API a bit).

In particular the code does not detect interrupts and exception
frames, and does not yet check whether the code address is valid.
The latter check would also have to be omitted for the latest frame
on other tasks' stacks. This would require some more tweaking.

unwind_frame() now reports whether we had to stop normally or due to
an error condition; walk_stackframe() will pass that info.
__save_stack_trace() is used for a start to check the validity of a
frame; maybe save_stack_trace_tsk_reliable() will need its own callback.

Any comments welcome.

Signed-off-by: Torsten Duwe <duwe@suse.de>

--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -127,8 +127,9 @@ config ARM64
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
 
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index d5718a060672..fe0dd4745ff3 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -81,23 +81,27 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
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
@@ -145,14 +149,15 @@ void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
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
@@ -171,11 +176,12 @@ static noinline void __save_stack_trace(struct task_struct *tsk,
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
 
@@ -190,4 +196,12 @@ void save_stack_trace(struct stack_trace *trace)
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
