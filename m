From: panand@redhat.com (Pratyush Anand)
Date: Mon, 28 Aug 2017 18:23:54 +0530
Subject: [PATCH] arm64: fix unwind_frame() for filtered out fn via
 set_graph_notrace
Message-ID: <4a92b0bf5ee602de6463057e5d98d20b4d4f2bcd.1503924827.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Testcase:
cd /sys/kernel/debug/tracing/
echo schedule > set_graph_notrace
echo 1 > options/display-graph
echo wakeup > current_tracer
ps -ef | grep -i agent

Above commands result in
PANIC: "Unable to handle kernel paging request at virtual address
ffff801bcbde7000"

vmcore analysis:
1)
crash> bt
PID: 1561   TASK: ffff8003cb7e4000  CPU: 0   COMMAND: "ps"
 #0 [ffff8003c4ff77b0] crash_kexec at ffff00000816b9b8
 #1 [ffff8003c4ff77e0] die at ffff000008088b34
 #2 [ffff8003c4ff7820] __do_kernel_fault at ffff00000809b830
 #3 [ffff8003c4ff7850] do_bad_area at ffff000008098b90
 #4 [ffff8003c4ff7880] do_translation_fault at ffff0000087c6cdc
 #5 [ffff8003c4ff78b0] do_mem_abort at ffff000008081334
 #6 [ffff8003c4ff7ab0] el1_ia at ffff000008082cc0
     PC: ffff00000808811c  [unwind_frame+300]
     LR: ffff0000080858a8  [get_wchan+212]
     SP: ffff8003c4ff7ab0  PSTATE: 60000145
    X29: ffff8003c4ff7ab0  X28: 0000000000000001  X27: 0000000000000000
    X26: 0000000000000000  X25: 0000000000000000  X24: 0000000000000000
    X23: ffff8003c1c20000  X22: ffff000008c73000  X21: ffff8003c1c1c000
    X20: 000000000000000f  X19: ffff8003c1bc7000  X18: 0000000000000010
    X17: 0000000000000000  X16: 0000000000000001  X15: ffffffffffffffed
    X14: 0000000000000010  X13: ffffffffffffffff  X12: 0000000000000004
    X11: 0000000000000000  X10: 0000000002dd14c0   X9: 1999999999999999
     X8: 000000000000003f   X7: 00008003f71b0000   X6: 0000000000000018
     X5: 0000000000000000   X4: ffff8003c1c1fd20   X3: ffff8003c1c1fd10
     X2: 00000017ffe80000   X1: ffff8003c4ff7af8   X0: ffff8003cbf67000
 #7 [ffff8003c4ff7b20] do_task_stat at ffff000008304f0c
 #8 [ffff8003c4ff7c60] proc_tgid_stat at ffff000008305b48
 #9 [ffff8003c4ff7ca0] proc_single_show at ffff0000082fdd10
 #10 [ffff8003c4ff7ce0] seq_read at ffff0000082b27bc
 #11 [ffff8003c4ff7d70] __vfs_read at ffff000008289e54
 #12 [ffff8003c4ff7e30] vfs_read at ffff00000828b14c
 #13 [ffff8003c4ff7e70] sys_read at ffff00000828c2d0
 #14 [ffff8003c4ff7ed0] __sys_trace at ffff00000808349c
     PC: 00000006  LR: 00000000  SP: ffffffffffffffed  PSTATE: 0000003f
    X12: 00000010 X11: ffffffffffffffff X10: 00000004  X9: ffff7febe8d0
     X8: 00000000  X7: 1999999999999999  X6: 0000003f  X5: 0000000c
     X4: ffff7fce9c78  X3: 0000000c  X2: 00000000  X1: 00000000
     X0: 00000400

(2) Instruction at ffff00000808811c caused IA/DA.

crash> dis -l ffff000008088108 6
/usr/src/debug/xxxxxxxxxxxx/xxxxxxxxxx/arch/arm64/kernel/stacktrace.c:
84
0xffff000008088108 <unwind_frame+280>:  ldr     w2, [x1,#24]
0xffff00000808810c <unwind_frame+284>:  sub     w6, w2, #0x1
0xffff000008088110 <unwind_frame+288>:  str     w6, [x1,#24]
0xffff000008088114 <unwind_frame+292>:  mov     w6, #0x18 // #24
0xffff000008088118 <unwind_frame+296>:  umull   x2, w2, w6
0xffff00000808811c <unwind_frame+300>:  ldr     x0, [x0,x2]

Corresponding c statement is
frame->pc = tsk->ret_stack[frame->graph--].ret;

(3) So, it caused data abort while executing
0xffff00000808811c <unwind_frame+300>:  ldr     x0, [x0,x2]

x0 + x2 = ffff8003cbf67000 + 00000017ffe80000 = ffff801bcbde7000
Access of ffff801bcbde7000 resulted in "Unable to handle kernel paging
request"

from above data: frame->graph = task->curr_ret_stack which  should be,
x2 / 0x18 = FFFF0000, which is -FTRACE_NOTRACE_DEPTH.

OK, so problem is here:
do_task_stat() calls get_wchan(). Here p->curr_ret_stack  is
-FTRACE_NOTRACE_DEPTH in the failed case. It means, when do_task_stat()
has been called for task A (ps in this case) on CPUm,task A was in mid
of execution on CPUn, and was in the mid of mcount() execution where
curr_ret_stack had been decremented in ftrace_push_return_trace() for
hitting schedule() function, but it was yet to be incremented in
ftrace_return_to_handler().

Similar problem we can have with calling of walk_stackframe() from
save_stack_trace_tsk() or dump_backtrace().

This patch fixes unwind_frame() to not to manipulate frame->pc for
function graph tracer if the function has been marked in
set_graph_notrace.

This patch fixes: 20380bb390a4 (arm64: ftrace: fix a stack tracer's
output under function graph tracer)

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64/kernel/stacktrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 09d37d66b630..e79035d673b3 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -74,7 +74,8 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	if (tsk->ret_stack &&
-			(frame->pc == (unsigned long)return_to_handler)) {
+			(frame->pc == (unsigned long)return_to_handler) &&
+			(frame->graph > -1)) {
 		/*
 		 * This is a case where function graph tracer has
 		 * modified a return address (LR) in a stack frame
-- 
2.9.4
