From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 18 Nov 2015 15:43:06 +0900
Subject: [PATCH v6 3/6] arm64: ftrace: fix a stack tracer's output under
 function graph tracer
In-Reply-To: <1447828989-4980-1-git-send-email-takahiro.akashi@linaro.org>
References: <1447828989-4980-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1447828989-4980-4-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Function graph tracer modifies a return address (LR) in a stack frame
to hook a function return. This will result in many useless entries
(return_to_handler) showing up in
 a) a stack tracer's output
 b) perf call graph (with perf record -g)
 c) dump_backtrace (at panic et al.)

For example, in case of a),
  $ echo function_graph > /sys/kernel/debug/tracing/current_tracer
  $ echo 1 > /proc/sys/kernel/stack_trace_enabled
  $ cat /sys/kernel/debug/tracing/stack_trace
        Depth    Size   Location    (54 entries)
        -----    ----   --------
  0)     4504      16   gic_raise_softirq+0x28/0x150
  1)     4488      80   smp_cross_call+0x38/0xb8
  2)     4408      48   return_to_handler+0x0/0x40
  3)     4360      32   return_to_handler+0x0/0x40
  ...

In case of b),
  $ echo function_graph > /sys/kernel/debug/tracing/current_tracer
  $ perf record -e mem:XXX:x -ag -- sleep 10
  $ perf report
                  ...
                  |          |          |--0.22%-- 0x550f8
                  |          |          |          0x10888
                  |          |          |          el0_svc_naked
                  |          |          |          sys_openat
                  |          |          |          return_to_handler
                  |          |          |          return_to_handler
                  ...

In case of c),
  $ echo function_graph > /sys/kernel/debug/tracing/current_tracer
  $ echo c > /proc/sysrq-trigger
  ...
  Call trace:
  [<ffffffc00044d3ac>] sysrq_handle_crash+0x24/0x30
  [<ffffffc000092250>] return_to_handler+0x0/0x40
  [<ffffffc000092250>] return_to_handler+0x0/0x40
  ...

This patch replaces such entries with real addresses preserved in
current->ret_stack[] at unwind_frame(). This way, we can cover all
the cases.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/include/asm/ftrace.h     |    2 ++
 arch/arm64/include/asm/stacktrace.h |    3 +++
 arch/arm64/kernel/perf_callchain.c  |    3 +++
 arch/arm64/kernel/process.c         |    3 +++
 arch/arm64/kernel/return_address.c  |    3 +++
 arch/arm64/kernel/stacktrace.c      |   17 +++++++++++++++++
 arch/arm64/kernel/time.c            |    3 +++
 arch/arm64/kernel/traps.c           |    3 +++
 8 files changed, 37 insertions(+)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index c5534fa..3c60f37 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -28,6 +28,8 @@ struct dyn_arch_ftrace {
 
 extern unsigned long ftrace_graph_call;
 
+extern void return_to_handler(void);
+
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
 	/*
diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index 6fb61c5..801a16db 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -22,6 +22,9 @@ struct stackframe {
 	unsigned long fp;
 	unsigned long sp;
 	unsigned long pc;
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	unsigned int graph;
+#endif
 };
 
 extern int unwind_frame(struct task_struct *tsk, struct stackframe *frame);
diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
index 797220d..ff46654 100644
--- a/arch/arm64/kernel/perf_callchain.c
+++ b/arch/arm64/kernel/perf_callchain.c
@@ -164,6 +164,9 @@ void perf_callchain_kernel(struct perf_callchain_entry *entry,
 	frame.fp = regs->regs[29];
 	frame.sp = regs->sp;
 	frame.pc = regs->pc;
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	frame.graph = current->curr_ret_stack;
+#endif
 
 	walk_stackframe(current, &frame, callchain_trace, entry);
 }
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 98bf546..88d742b 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -344,6 +344,9 @@ unsigned long get_wchan(struct task_struct *p)
 	frame.fp = thread_saved_fp(p);
 	frame.sp = thread_saved_sp(p);
 	frame.pc = thread_saved_pc(p);
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	frame.graph = p->curr_ret_stack;
+#endif
 	stack_page = (unsigned long)task_stack_page(p);
 	do {
 		if (frame.sp < stack_page ||
diff --git a/arch/arm64/kernel/return_address.c b/arch/arm64/kernel/return_address.c
index 07b37ac..1718706 100644
--- a/arch/arm64/kernel/return_address.c
+++ b/arch/arm64/kernel/return_address.c
@@ -43,6 +43,9 @@ void *return_address(unsigned int level)
 	frame.fp = (unsigned long)__builtin_frame_address(0);
 	frame.sp = current_stack_pointer;
 	frame.pc = (unsigned long)return_address; /* dummy */
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	frame.graph = current->curr_ret_stack;
+#endif
 
 	walk_stackframe(current, &frame, save_return_addr, &data);
 
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 9c7acf8..0a39049 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -17,6 +17,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/export.h>
+#include <linux/ftrace.h>
 #include <linux/sched.h>
 #include <linux/stacktrace.h>
 
@@ -66,6 +67,19 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 	frame->fp = *(unsigned long *)(fp);
 	frame->pc = *(unsigned long *)(fp + 8);
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	if (tsk && tsk->ret_stack &&
+			(frame->pc == (unsigned long)return_to_handler)) {
+		/*
+		 * This is a case where function graph tracer has
+		 * modified a return address (LR) in a stack frame
+		 * to hook a function return.
+		 * So replace it to an original value.
+		 */
+		frame->pc = tsk->ret_stack[frame->graph--].ret;
+	}
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+
 	/*
 	 * Check whether we are going to walk through from interrupt stack
 	 * to task stack.
@@ -137,6 +151,9 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 		frame.sp = current_stack_pointer;
 		frame.pc = (unsigned long)save_stack_trace_tsk;
 	}
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	frame.graph = tsk->curr_ret_stack;
+#endif
 
 	walk_stackframe(tsk, &frame, save_trace, &data);
 	if (trace->nr_entries < trace->max_entries)
diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
index 6e5c521..5977969 100644
--- a/arch/arm64/kernel/time.c
+++ b/arch/arm64/kernel/time.c
@@ -52,6 +52,9 @@ unsigned long profile_pc(struct pt_regs *regs)
 	frame.fp = regs->regs[29];
 	frame.sp = regs->sp;
 	frame.pc = regs->pc;
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	frame.graph = -1; /* no task info */
+#endif
 	do {
 		int ret = unwind_frame(NULL, &frame);
 		if (ret < 0)
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index da45224..46053c2 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -169,6 +169,9 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 		frame.sp = thread_saved_sp(tsk);
 		frame.pc = thread_saved_pc(tsk);
 	}
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	frame.graph = tsk->curr_ret_stack;
+#endif
 
 	pr_emerg("Call trace:\n");
 	while (1) {
-- 
1.7.9.5
