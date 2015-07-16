From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 16 Jul 2015 10:24:05 -0400
Subject: [RFC 2/3] arm64: refactor save_stack_trace()
In-Reply-To: <A601CC3C-4B09-4D8B-8564-558349D45815@gmail.com>
References: <1436765375-7119-1-git-send-email-takahiro.akashi@linaro.org>
 <1436765375-7119-3-git-send-email-takahiro.akashi@linaro.org>
 <DAAB1BC4-B36E-436D-8EAD-548641E58490@gmail.com>
 <20150714093154.4d73e551@gandalf.local.home>
 <55A5A75A.1060401@linaro.org>
 <20150714225105.6c1e4f15@gandalf.local.home>
 <55A646EE.6030402@linaro.org>
 <20150715105536.42949ea9@gandalf.local.home>
 <20150715121337.3b31aa84@gandalf.local.home>
 <55A6FA82.9000901@linaro.org> <55A703F3.8050203@linaro.org>
 <A601CC3C-4B09-4D8B-8564-558349D45815@gmail.com>
Message-ID: <20150716102405.2cc8c406@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Jul 2015 22:29:05 +0900
Jungseok Lee <jungseoklee85@gmail.com> wrote:


> First of all, let's look at the following data.
> 
> 1) stack_trace data
>         Depth    Size   Location    (55 entries)
>         -----    ----   --------
>   0)     4808      16   notifier_call_chain+0x2c/0x94
>   1)     4792      64   raw_notifier_call_chain+0x34/0x44
>   2)     4728      48   timekeeping_update.constprop.9+0xb8/0x114
>   3)     4680      48   update_wall_time+0x408/0x6dc
>   4)     4632     128   tick_do_update_jiffies64+0xd8/0x154
>   5)     4504      80   tick_sched_do_timer+0x50/0x60
>   6)     4424      32   tick_sched_timer+0x34/0x90
>   7)     4392      48   __run_hrtimer+0x60/0x258
>   8)     4344      64   hrtimer_interrupt+0xe8/0x260
>   9)     4280     128   arch_timer_handler_virt+0x38/0x48
>  10)     4152      32   handle_percpu_devid_irq+0x84/0x188
>  11)     4120      64   generic_handle_irq+0x38/0x54
>  12)     4056      32   __handle_domain_irq+0x68/0xbc
>  13)     4024      64   gic_handle_irq+0x38/0x88
>  14)     3960     336   el1_irq+0x64/0xd8
>  15)     3624      16   netif_rx_internal+0x14/0x198
>  16)     3608      64   netif_rx+0x20/0xa4
>  17)     3544      32   loopback_xmit+0x64/0xf4
>  18)     3512      48   dev_hard_start_xmit+0x25c/0x3f8
>  19)     3464     160   __dev_queue_xmit+0x440/0x4dc
>  20)     3304      96   dev_queue_xmit_sk+0x20/0x30
>  21)     3208      32   ip_finish_output+0x1e0/0xabc
>  22)     3176      96   ip_output+0xf0/0x120
>  23)     3080      64   ip_local_out_sk+0x44/0x54
>  24)     3016      32   ip_send_skb+0x24/0xbc
>  25)     2984      48   ip_push_pending_frames+0x40/0x60
>  26)     2936      64   icmp_push_reply+0x104/0x144
>  27)     2872      96   icmp_send+0x3c0/0x3c8
>  28)     2776     192   __udp4_lib_rcv+0x5b8/0x684
>  29)     2584      96   udp_rcv+0x2c/0x3c
>  30)     2488      32   ip_local_deliver+0xa0/0x224
>  31)     2456      48   ip_rcv+0x360/0x57c
>  32)     2408      64   __netif_receive_skb_core+0x4d0/0x80c
>  33)     2344     128   __netif_receive_skb+0x24/0x84
>  34)     2216      32   process_backlog+0x9c/0x15c
>  35)     2184      80   net_rx_action+0x1ec/0x32c
>  36)     2104     160   __do_softirq+0x114/0x2f0
>  37)     1944     128   do_softirq+0x60/0x68
>  38)     1816      32   __local_bh_enable_ip+0xb0/0xd4
>  39)     1784      32   ip_finish_output+0x1f4/0xabc
>  40)     1752      96   ip_output+0xf0/0x120
>  41)     1656      64   ip_local_out_sk+0x44/0x54
>  42)     1592      32   ip_send_skb+0x24/0xbc
>  43)     1560      48   udp_send_skb+0x1b4/0x2f4
>  44)     1512      80   udp_sendmsg+0x2a8/0x7a0
>  45)     1432     272   inet_sendmsg+0xa0/0xd0
>  46)     1160      48   sock_sendmsg+0x30/0x78
>  47)     1112      32   ___sys_sendmsg+0x15c/0x26c
>  48)     1080     400   __sys_sendmmsg+0x94/0x180
>  49)      680     320   SyS_sendmmsg+0x38/0x54
>  50)      360     360   el0_svc_naked+0x20/0x28
> 
> 2) stack_max_size data
> 4888
> 
> The data looks odd in two points.
> 1) the number of entry
> There is a mismatch between start token and real data

Yep, good catch. As soon as I read that, I realized exactly what the
issue was ;-)

> 
> 2) 80-byte gap
> stack_max_size is not aligned with "Depth" field of the first entry of stack_trace.
> 
> IMHO, two items are not considered in this series as digging them out.
> 
> 1) skipped entries
> As x variable is introduced in Steve's patch, it is needed to track down
> how many entries are recorded in both stack_dump_trace and stack_dump_index.

Yep.

> 
> 2) max_stack_trace.skip value
> max_stack_trace.skip is 0 as applying Steve's patch. The above gap could be
> observed unless the value is not considered in arch code. In the above example,
> 80-byte gap is save_stack_trace function in arch/arm64/kernel/stacktrace.c.
> 
> As applying the following fix, stack_trace and stack_max_size are okay.
> However, I'm not sure which code, arch or generic ftrace, should handle trace->skip.
> The latter one is responsible for it under current implementation, not Steve's change.
> 
> Please correct me if I am wrong.

No, it's a bug in my patch. I'll make an update.

Does this new patch fix it for you?

-- Steve

---
 kernel/trace/trace_stack.c |   58 +++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 41 deletions(-)

Index: linux-trace.git/kernel/trace/trace_stack.c
===================================================================
--- linux-trace.git.orig/kernel/trace/trace_stack.c	2015-07-15 12:49:59.290063597 -0400
+++ linux-trace.git/kernel/trace/trace_stack.c	2015-07-16 09:55:37.936188197 -0400
@@ -18,12 +18,6 @@
 
 #define STACK_TRACE_ENTRIES 500
 
-#ifdef CC_USING_FENTRY
-# define fentry		1
-#else
-# define fentry		0
-#endif
-
 static unsigned long stack_dump_trace[STACK_TRACE_ENTRIES+1] =
 	 { [0 ... (STACK_TRACE_ENTRIES)] = ULONG_MAX };
 static unsigned stack_dump_index[STACK_TRACE_ENTRIES];
@@ -35,7 +29,7 @@ static unsigned stack_dump_index[STACK_T
  */
 static struct stack_trace max_stack_trace = {
 	.max_entries		= STACK_TRACE_ENTRIES - 1,
-	.entries		= &stack_dump_trace[1],
+	.entries		= &stack_dump_trace[0],
 };
 
 static unsigned long max_stack_size;
@@ -77,7 +71,7 @@ check_stack(unsigned long ip, unsigned l
 	unsigned long this_size, flags; unsigned long *p, *top, *start;
 	static int tracer_frame;
 	int frame_size = ACCESS_ONCE(tracer_frame);
-	int i;
+	int i, x;
 
 	this_size = ((unsigned long)stack) & (THREAD_SIZE-1);
 	this_size = THREAD_SIZE - this_size;
@@ -105,26 +99,20 @@ check_stack(unsigned long ip, unsigned l
 	max_stack_size = this_size;
 
 	max_stack_trace.nr_entries = 0;
-
-	if (using_ftrace_ops_list_func())
-		max_stack_trace.skip = 4;
-	else
-		max_stack_trace.skip = 3;
+	max_stack_trace.skip = 3;
 
 	save_stack_trace(&max_stack_trace);
 
-	/*
-	 * Add the passed in ip from the function tracer.
-	 * Searching for this on the stack will skip over
-	 * most of the overhead from the stack tracer itself.
-	 */
-	stack_dump_trace[0] = ip;
-	max_stack_trace.nr_entries++;
+	/* Skip over the overhead of the stack tracer itself */
+	for (i = 0; i < max_stack_trace.nr_entries; i++) {
+		if (stack_dump_trace[i] == ip)
+			break;
+	}
 
 	/*
 	 * Now find where in the stack these are.
 	 */
-	i = 0;
+	x = 0;
 	start = stack;
 	top = (unsigned long *)
 		(((unsigned long)start & ~(THREAD_SIZE-1)) + THREAD_SIZE);
@@ -139,12 +127,13 @@ check_stack(unsigned long ip, unsigned l
 	while (i < max_stack_trace.nr_entries) {
 		int found = 0;
 
-		stack_dump_index[i] = this_size;
+		stack_dump_index[x] = this_size;
 		p = start;
 
 		for (; p < top && i < max_stack_trace.nr_entries; p++) {
 			if (*p == stack_dump_trace[i]) {
-				this_size = stack_dump_index[i++] =
+				stack_dump_trace[x] = stack_dump_trace[i++];
+				this_size = stack_dump_index[x++] =
 					(top - p) * sizeof(unsigned long);
 				found = 1;
 				/* Start the search from here */
@@ -168,6 +157,10 @@ check_stack(unsigned long ip, unsigned l
 			i++;
 	}
 
+	max_stack_trace.nr_entries = x;
+	for (; x < i; x++)
+		stack_dump_trace[x] = ULONG_MAX;
+
 	if (task_stack_end_corrupted(current)) {
 		print_max_stack();
 		BUG();
@@ -192,24 +185,7 @@ stack_trace_call(unsigned long ip, unsig
 	if (per_cpu(trace_active, cpu)++ != 0)
 		goto out;
 
-	/*
-	 * When fentry is used, the traced function does not get
-	 * its stack frame set up, and we lose the parent.
-	 * The ip is pretty useless because the function tracer
-	 * was called before that function set up its stack frame.
-	 * In this case, we use the parent ip.
-	 *
-	 * By adding the return address of either the parent ip
-	 * or the current ip we can disregard most of the stack usage
-	 * caused by the stack tracer itself.
-	 *
-	 * The function tracer always reports the address of where the
-	 * mcount call was, but the stack will hold the return address.
-	 */
-	if (fentry)
-		ip = parent_ip;
-	else
-		ip += MCOUNT_INSN_SIZE;
+	ip += MCOUNT_INSN_SIZE;
 
 	check_stack(ip, &stack);
 
