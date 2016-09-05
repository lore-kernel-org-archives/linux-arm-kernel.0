From: panand@redhat.com (Pratyush Anand)
Date: Mon,  5 Sep 2016 08:03:16 +0530
Subject: [PATCH V3] arm64:ftrace: add save_stack_trace_regs()
Message-ID: <12a4a8e304fb26dbe533be0ea68e448df462a7c5.1473038514.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, enabling stacktrace of a kprobe events generates warning:

echo stacktrace > /sys/kernel/debug/tracing/trace_options
echo "p xhci_irq" > /sys/kernel/debug/tracing/kprobe_events
echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable

save_stack_trace_regs() not implemented yet.
------------[ cut here ]------------
WARNING: CPU: 1 PID: 0 at ../kernel/stacktrace.c:74 save_stack_trace_regs+0x3c/0x48
Modules linked in:

CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.8.0-rc4-dirty #5128
Hardware name: ARM Juno development board (r1) (DT)
task: ffff800975dd1900 task.stack: ffff800975ddc000
PC is at save_stack_trace_regs+0x3c/0x48
LR is at save_stack_trace_regs+0x3c/0x48
pc : [<ffff000008126c64>] lr : [<ffff000008126c64>] pstate: 600003c5
sp : ffff80097ef52c00

Call trace:
[<ffff000008126c64>] save_stack_trace_regs+0x3c/0x48
[<ffff00000817a0b0>] __ftrace_trace_stack+0x168/0x208
[<ffff00000817ad40>] trace_buffer_unlock_commit_regs+0x5c/0x7c
[<ffff00000818d57c>] kprobe_trace_func+0x308/0x3d8
[<ffff00000818defc>] kprobe_dispatcher+0x58/0x60
[<ffff0000088d8cfc>] kprobe_breakpoint_handler+0xbc/0x18c
[<ffff0000080851b8>] brk_handler+0x50/0x90
[<ffff000008081300>] do_debug_exception+0x50/0xbc

This patch implements save_stack_trace_regs(), so that stacktrace of a
kprobe events can be obtained.

After this patch, there is no warning and we can see the stacktrace for
kprobe events in trace buffer.

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

Tested-by: David A. Long <dave.long@linaro.org>
Reviewed-by: James Morse <james.morse@arm.com>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
v1 to v2: Rebased with 4.8.0-rc4
v2 to v3: CONFIG_FUNCTION_GRAPH_TRACER fixup and improved commit log

 arch/arm64/kernel/stacktrace.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index d9751a4769e7..ca01addf8c4c 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -152,6 +152,27 @@ static int save_trace(struct stackframe *frame, void *d)
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
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	frame.graph = current->curr_ret_stack;
+#endif
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
