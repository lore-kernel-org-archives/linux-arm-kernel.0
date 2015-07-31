From: panand@redhat.com (Pratyush Anand)
Date: Fri, 31 Jul 2015 14:51:02 +0530
Subject: [PATCH] arm64:ftrace: add save_stack_trace_regs()
Message-ID: <1e8882680fd875de22db27c897727d0466a7e2e0.1438333085.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement save_stack_trace_regs, so that stacktrace of a kprobe events can be
obtained.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
Function will be useful only after having ARM64 kprobes upstreamed.
However, since there is no dependency in applying the patch, so it may be
upstreamed independently (if there is no other review comment).

I see following stack trace for kfree with this patch in one of the case.

echo stacktrace > /sys/kernel/debug/tracing/trace_options
echo "p kfree" >> /sys/kernel/debug/tracing/kprobe_events
echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable
more /sys/kernel/debug/tracing/trace
            bash-3868  [001] d...  2863.068271: p_kfree_0: (kfree+0x0/0x194)
            bash-3868  [001] d...  2863.068276: <stack trace>
 => kfree
 => syscall_trace_exit
 => __sys_trace_return_skipped

 arch/arm64/kernel/stacktrace.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 407991bf79f5..c7fa0431ef3e 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -97,6 +97,24 @@ static int save_trace(struct stackframe *frame, void *d)
 	return trace->nr_entries >= trace->max_entries;
 }
 
+void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
+{
+	struct stack_trace_data data;
+	struct stackframe frame;
+
+	data.trace = trace;
+	data.skip = trace->skip;
+	data.no_sched_functions = 0;
+
+	frame.fp = regs->regs[29];
+	frame.sp = regs->sp;
+	frame.pc = regs->pc;
+
+	walk_stackframe(&frame, save_trace, &data);
+	if (trace->nr_entries < trace->max_entries)
+		trace->entries[trace->nr_entries++] = ULONG_MAX;
+}
+
 void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 {
 	struct stack_trace_data data;
-- 
2.4.3
