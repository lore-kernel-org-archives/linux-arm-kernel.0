From: ivan.lam2014@gmail.com (ivan.lam2014 at gmail.com)
Date: Mon, 18 Nov 2013 22:35:00 +0800
Subject: [PATCH RESEND] arm: add save_stack_trace_regs() support
Message-ID: <528a25a0.c48e420a.3884.ffffba1e@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: ivan lam <ivan.lam2014@gmail.com>

When configure kprobe events of ftrace with stacktrace option enabled
in arm, not stacktrace was recorded after the kprobe was triggered.

Implement the save_stack_trace_regs() function in arm.

After this fix, stacktrace can be recorded, for example:

# mount -t debugfs nodev /sys/kernel/debug
# echo "p:netrx net_rx_action" >> /sys/kernel/debug/tracing/kprobe_events
# echo 1 > /sys/kernel/debug/tracing/events/kprobes/netrx/enable
# echo 1 > /sys/kernel/debug/tracing/options/stacktrace
# echo 1 > /sys/kernel/debug/tracing/tracing_on
# ping 127.0.0.1 -c 1
# echo 0 > /sys/kernel/debug/tracing/tracing_on

# cat /sys/kernel/debug/tracing/trace
# tracer: nop
#
# entries-in-buffer/entries-written: 12/12   #P:1
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
            ping-1200  [000] dNs1   667.603250: netrx: (net_rx_action+0x0/0x1f8)
            ping-1200  [000] dNs1   667.604738: <stack trace>
 => net_rx_action
 => do_softirq
 => local_bh_enable
 => ip_finish_output
 => ip_output
 => ip_local_out
 => ip_send_skb
 => ip_push_pending_frames
 => raw_sendmsg
 => inet_sendmsg
 => sock_sendmsg
 => SyS_sendto
 => ret_fast_syscall

Signed-off-by: ivan lam <ivan.lam2014@gmail.com>
---
 arch/arm/kernel/stacktrace.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index 00f79e5..2b52fac0 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -123,6 +123,25 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 
+void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
+{
+	struct stack_trace_data data;
+	struct stackframe frame;
+
+	data.trace = trace;
+	data.skip = trace->skip;
+	data.no_sched_functions = 1;
+
+	frame.fp = regs->ARM_fp;
+	frame.sp = regs->ARM_sp;
+	frame.lr = regs->ARM_lr;
+	frame.pc = regs->ARM_pc;
+
+	walk_stackframe(&frame, save_trace, &data);
+	if (trace->nr_entries < trace->max_entries)
+		trace->entries[trace->nr_entries++] = ULONG_MAX;
+}
+
 void save_stack_trace(struct stack_trace *trace)
 {
 	save_stack_trace_tsk(current, trace);
-- 
1.7.9.5
