From: panand@redhat.com (Pratyush Anand)
Date: Thu,  1 Sep 2016 19:05:16 +0530
Subject: [PATCH V2] arm64:ftrace: add save_stack_trace_regs()
Message-ID: <4f7d7a6bff7f06f814bf9a2bdc90bb0e3b833b66.1472734699.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement save_stack_trace_regs, so that stacktrace of a kprobe events can be
obtained.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
V1 to V2: Rebased to latest kernel.

I see following stack trace for kprobe at xhci_irq():

echo stacktrace > /sys/kernel/debug/tracing/trace_options
echo "p xhci_irq" > /sys/kernel/debug/tracing/kprobe_events
echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable
more /sys/kernel/debug/tracing/trace

          <idle>-0     [004] d.h.  1356.000496: p_xhci_irq_0:(xhci_irq+0x0/0x9ac)
          <idle>-0     [004] d.h.  1356.000497: <stack trace>
 => xhci_irq
 => __handle_irq_event_percpu
 => handle_irq_event_percpu
 => handle_irq_event
 => handle_fasteoi_irq
 => generic_handle_irq
 => __handle_domain_irq
 => gic_handle_irq
 => el1_irq
 => arch_cpu_idle
 => default_idle_call
 => cpu_startup_entry
 => secondary_start_kernel
 =>
 
 arch/arm64/kernel/stacktrace.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index d9751a4769e7..bd6d9d8087f0 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -152,6 +152,24 @@ static int save_trace(struct stackframe *frame, void *d)
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
+	walk_stackframe(current, &frame, save_trace, &data);
+	if (trace->nr_entries < trace->max_entries)
+		trace->entries[trace->nr_entries++] = ULONG_MAX;
+}
+
 void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 {
 	struct stack_trace_data data;
-- 
2.7.4
