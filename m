From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 13 Jul 2015 14:29:34 +0900
Subject: [RFC 2/3] arm64: refactor save_stack_trace()
In-Reply-To: <1436765375-7119-1-git-send-email-takahiro.akashi@linaro.org>
References: <1436765375-7119-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1436765375-7119-3-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ftrace's stack tracer on arm64 returns wrong information about call stacks:

        Depth    Size   Location    (50 entries)
        -----    ----   --------
  0)     5256       0   notifier_call_chain+0x30/0x94
  1)     5256       0   ftrace_call+0x0/0x4
  2)     5256       0   notifier_call_chain+0x2c/0x94
  3)     5256       0   raw_notifier_call_chain+0x34/0x44
  4)     5256       0   timekeeping_update.constprop.9+0xb8/0x114
  5)     5256       0   update_wall_time+0x408/0x6dc

One of tracer functions, ftrace_call (or mcount), is unexpectedly listed.
The *bare* stack dump returned by save_stack_trace() is:
	save_stack_trace_tsk()
	save_stack_trace()
	stack_trace_call()
	ftrace_ops_no_ops()
	ftrace_call()
	notifier_call_chain()
	raw_notifier_call_chain()
	...

On arm64, save_stack_trace() calls save_stack_trace_tsk() and this will
result in putting additional stack frame in the returned list.
This behavior, however, conflicts with  stack stracer's assumption
that the number of functions to be skiped as part of tracer is 4, from
save_stack_trace() to mcount(), if ftrace_ops_list_func() is used.
The value is hard coded in check_patch().

This patch refactors save_stack_trace() and save_stack_trace_tsk() in order
to reduce the stack depth by making the common code inlined.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/stacktrace.c |   31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 407991b..978c923 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -97,34 +97,49 @@ static int save_trace(struct stackframe *frame, void *d)
 	return trace->nr_entries >= trace->max_entries;
 }
 
-void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
+static inline void __save_stack_trace(struct stackframe *frame,
+			struct stack_trace *trace, int no_sched)
 {
 	struct stack_trace_data data;
-	struct stackframe frame;
 
 	data.trace = trace;
 	data.skip = trace->skip;
+	data.no_sched_functions = no_sched;
+
+	walk_stackframe(frame, save_trace, &data);
+	if (trace->nr_entries < trace->max_entries)
+		trace->entries[trace->nr_entries++] = ULONG_MAX;
+}
+
+void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
+{
+	struct stackframe frame;
+	int no_sched;
 
 	if (tsk != current) {
-		data.no_sched_functions = 1;
+		no_sched = 1;
 		frame.fp = thread_saved_fp(tsk);
 		frame.sp = thread_saved_sp(tsk);
 		frame.pc = thread_saved_pc(tsk);
 	} else {
-		data.no_sched_functions = 0;
+		no_sched = 0;
 		frame.fp = (unsigned long)__builtin_frame_address(0);
 		frame.sp = current_stack_pointer;
 		frame.pc = (unsigned long)save_stack_trace_tsk;
 	}
 
-	walk_stackframe(&frame, save_trace, &data);
-	if (trace->nr_entries < trace->max_entries)
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
+	__save_stack_trace(&frame, trace, no_sched);
 }
 
 void save_stack_trace(struct stack_trace *trace)
 {
-	save_stack_trace_tsk(current, trace);
+	struct stackframe frame;
+
+	frame.fp = (unsigned long)__builtin_frame_address(0);
+	frame.sp = current_stack_pointer;
+	frame.pc = (unsigned long)save_stack_trace_tsk;
+
+	__save_stack_trace(&frame, trace, 0);
 }
 EXPORT_SYMBOL_GPL(save_stack_trace);
 #endif
-- 
1.7.9.5
