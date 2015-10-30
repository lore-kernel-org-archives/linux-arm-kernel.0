From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 30 Oct 2015 14:25:38 +0900
Subject: [PATCH v4 3/6] arm64: ftrace: fix a stack tracer's output under
 function graph tracer
In-Reply-To: <1446182741-31019-1-git-send-email-takahiro.akashi@linaro.org>
References: <1446182741-31019-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1446182741-31019-4-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Function graph tracer modifies a return address (LR) in a stack frame
to hook a function return. This will result in many useless entries
(return_to_handler) showing up in a stack tracer's output.

This patch replaces such entries with originals values preserved in
current->ret_stack[].

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/include/asm/ftrace.h |    2 ++
 arch/arm64/kernel/stacktrace.c  |   21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

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
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index bc0689a..631c49d 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -17,6 +17,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/export.h>
+#include <linux/ftrace.h>
 #include <linux/sched.h>
 #include <linux/stacktrace.h>
 
@@ -78,6 +79,9 @@ struct stack_trace_data {
 	struct stack_trace *trace;
 	unsigned int no_sched_functions;
 	unsigned int skip;
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	unsigned int ret_stack_index;
+#endif
 };
 
 static int save_trace(struct stackframe *frame, void *d)
@@ -86,6 +90,20 @@ static int save_trace(struct stackframe *frame, void *d)
 	struct stack_trace *trace = data->trace;
 	unsigned long addr = frame->pc;
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	if (addr == (unsigned long)return_to_handler - AARCH64_INSN_SIZE) {
+		/*
+		 * This is a case where function graph tracer has
+		 * modified a return address (LR) in a stack frame
+		 * to hook a function return.
+		 * So replace it to an original value.
+		 */
+		frame->pc = addr =
+			current->ret_stack[data->ret_stack_index--].ret
+							- AARCH64_INSN_SIZE;
+	}
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+
 	if (data->no_sched_functions && in_sched_functions(addr))
 		return 0;
 	if (data->skip) {
@@ -105,6 +123,9 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 
 	data.trace = trace;
 	data.skip = trace->skip;
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	data.ret_stack_index = current->curr_ret_stack;
+#endif
 
 	if (tsk != current) {
 		data.no_sched_functions = 1;
-- 
1.7.9.5
