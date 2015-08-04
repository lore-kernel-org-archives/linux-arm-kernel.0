From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue,  4 Aug 2015 16:44:07 +0900
Subject: [RFC v2 2/4] arm64: ftrace: add arch-specific stack tracer
In-Reply-To: <1438674249-3447-1-git-send-email-takahiro.akashi@linaro.org>
References: <1438674249-3447-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1438674249-3447-3-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses walk_stackframe(), instead of slurping stack contents
as orignal check_stack() does, to identify each stack frame.
return_to_handler() is handled in a special way because it is not
a function, but invoked via function graph tracer by faking a saved lr
register on stack.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/include/asm/ftrace.h |    2 ++
 arch/arm64/kernel/ftrace.c      |   37 +++++++++++++++++++++++++
 arch/arm64/kernel/stacktrace.c  |   58 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 2b43e20..b7d597c 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -29,6 +29,8 @@ struct dyn_arch_ftrace {
 
 extern unsigned long ftrace_graph_call;
 
+extern void return_to_handler(void);
+
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
 	/*
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index c851be7..d812870 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -176,3 +176,40 @@ int ftrace_disable_ftrace_graph_caller(void)
 }
 #endif /* CONFIG_DYNAMIC_FTRACE */
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+
+#ifdef CONFIG_STACK_TRACER
+#define stack_top(fp) (((fp) & ~(THREAD_SIZE-1)) + THREAD_SIZE)
+#define stack_index(fp) (stack_top((fp)) - (fp))
+
+extern struct stack_trace max_stack_trace;
+extern void save_stack_trace_index(struct stack_trace *trace);
+
+void arch_check_stack(unsigned long ip, unsigned long *stack,
+		      unsigned long *max_size, int *tracer_size)
+{
+	int i, j;
+
+	max_stack_trace.skip = 0;
+	save_stack_trace_index(&max_stack_trace);
+	max_stack_trace.nr_entries--; /* for '-1' entry */
+
+	/* Skip over the overhead of the stack tracer itself */
+	for (i = 0; i < max_stack_trace.nr_entries; i++) {
+		if ((max_stack_trace.entries[i] + FTRACE_STACK_FRAME_OFFSET)
+				== ip)
+			break;
+	}
+
+	if (unlikely(!*tracer_size)) {
+		*tracer_size = stack_index((unsigned long)stack)
+			- max_stack_trace.index[i];
+		*max_size -= *tracer_size;
+	}
+
+	max_stack_trace.nr_entries -= i;
+	for (j = 0; j < max_stack_trace.nr_entries; j++) {
+		max_stack_trace.index[j] = max_stack_trace.index[j + i];
+		max_stack_trace.entries[j] = max_stack_trace.entries[j + i];
+	}
+}
+#endif /* CONFIG_STACK_TRACER */
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index bc0689a..496ab0f 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -17,12 +17,15 @@
  */
 #include <linux/kernel.h>
 #include <linux/export.h>
+#include <linux/ftrace.h>
 #include <linux/sched.h>
 #include <linux/stacktrace.h>
 
 #include <asm/insn.h>
 #include <asm/stacktrace.h>
 
+#define S_FRAME_SIZE sizeof(struct pt_regs) /* asm-offsets.h */
+
 /*
  * AArch64 PCS assigns the frame pointer to x29.
  *
@@ -78,9 +81,29 @@ struct stack_trace_data {
 	struct stack_trace *trace;
 	unsigned int no_sched_functions;
 	unsigned int skip;
+#ifdef CONFIG_STACK_TRACER
+	int ftracer;
+	int ret_stack_index;
+#endif
 };
 
-static int save_trace(struct stackframe *frame, void *d)
+#ifdef CONFIG_STACK_TRACER
+static void notrace arm64_stack_index(struct stackframe *frame,
+		struct stack_trace_data *data)
+{
+	struct stack_trace *trace = data->trace;
+	unsigned long top;
+	unsigned int x = trace->nr_entries;
+
+	top = (frame->fp & ~(THREAD_SIZE-1)) + THREAD_SIZE;
+	trace->index[x] = top - frame->fp;
+	/* should not go beyond this frame */
+	if (trace->index[x] == THREAD_SIZE)
+		trace->index[x] = 0;
+}
+#endif /* CONFIG_STACK_TRACER */
+
+static int notrace save_trace(struct stackframe *frame, void *d)
 {
 	struct stack_trace_data *data = d;
 	struct stack_trace *trace = data->trace;
@@ -93,7 +116,13 @@ static int save_trace(struct stackframe *frame, void *d)
 		return 0;
 	}
 
-	trace->entries[trace->nr_entries++] = addr;
+	trace->entries[trace->nr_entries] = addr;
+#ifdef CONFIG_STACK_TRACER
+	if (data->ftracer) {
+		arm64_stack_index(frame, data);
+	}
+#endif
+	trace->nr_entries++;
 
 	return trace->nr_entries >= trace->max_entries;
 }
@@ -105,6 +134,9 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 
 	data.trace = trace;
 	data.skip = trace->skip;
+#ifdef CONFIG_STACK_TRACER
+	data.ftracer = 0;
+#endif
 
 	if (tsk != current) {
 		data.no_sched_functions = 1;
@@ -128,4 +160,26 @@ void save_stack_trace(struct stack_trace *trace)
 	save_stack_trace_tsk(current, trace);
 }
 EXPORT_SYMBOL_GPL(save_stack_trace);
+
+#ifdef CONFIG_STACK_TRACER
+void notrace save_stack_trace_index(struct stack_trace *trace)
+{
+	struct stack_trace_data data;
+	struct stackframe frame;
+
+	data.trace = trace;
+	data.skip = trace->skip;
+	data.ftracer = 1;
+	data.ret_stack_index = current->curr_ret_stack;
+
+	data.no_sched_functions = 0;
+	frame.fp = (unsigned long)__builtin_frame_address(0);
+	frame.sp = current_stack_pointer;
+	frame.pc = (unsigned long)save_stack_trace_index;
+
+	walk_stackframe(&frame, save_trace, &data);
+	if (trace->nr_entries < trace->max_entries)
+		trace->entries[trace->nr_entries++] = ULONG_MAX;
+}
+#endif /* CONFIG_STACK_TRACER */
 #endif
-- 
1.7.9.5
