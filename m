From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Thu, 16 Jul 2015 22:29:05 +0900
Subject: [RFC 2/3] arm64: refactor save_stack_trace()
In-Reply-To: <55A703F3.8050203@linaro.org>
References: <1436765375-7119-1-git-send-email-takahiro.akashi@linaro.org>	<1436765375-7119-3-git-send-email-takahiro.akashi@linaro.org>	<DAAB1BC4-B36E-436D-8EAD-548641E58490@gmail.com>	<20150714093154.4d73e551@gandalf.local.home>	<55A5A75A.1060401@linaro.org>	<20150714225105.6c1e4f15@gandalf.local.home>	<55A646EE.6030402@linaro.org>	<20150715105536.42949ea9@gandalf.local.home>
 <20150715121337.3b31aa84@gandalf.local.home> <55A6FA82.9000901@linaro.org>
 <55A703F3.8050203@linaro.org>
Message-ID: <A601CC3C-4B09-4D8B-8564-558349D45815@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Jul 16, 2015, at 10:08 AM, AKASHI Takahiro wrote:

Hi, AKASHI

> On 07/16/2015 09:27 AM, AKASHI Takahiro wrote:
>> On 07/16/2015 01:13 AM, Steven Rostedt wrote:
>>> On Wed, 15 Jul 2015 10:55:36 -0400
>>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>> 
>>> 
>>>> I'll take a look at it and try to clean up the code.
>>> 
>>> Does the  following patch make sense for you?
>> 
>> Looks nice. The patch greatly simplifies changes on arm64 side.
> 
> As follows:
> 
> - Takahiro AKASHI
> 
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index c5534fa..868d6f1 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -15,6 +15,7 @@
> 
> #define MCOUNT_ADDR		((unsigned long)_mcount)
> #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
> +#define FTRACE_STACK_FRAME_OFFSET 4 /* sync it up with stacktrace.c */

How about binding it to -4 in unwind_frame function?
IMHO, it would help other developers trying to change stack trace code
be aware of this stack tracer feature.

> #ifndef __ASSEMBLY__
> #include <linux/compat.h>
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 1da6029..2c1bf7d 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -260,6 +260,13 @@ static inline void ftrace_kill(void) { }
> #endif /* CONFIG_FUNCTION_TRACER */
> 
> #ifdef CONFIG_STACK_TRACER
> +/*
> + * the offset value to add to return address from save_stack_trace()
> + */
> +#ifndef FTRACE_STACK_FRAME_OFFSET
> +#define FTRACE_STACK_FRAME_OFFSET 0
> +#endif
> +
> extern int stack_tracer_enabled;
> int
> stack_trace_sysctl(struct ctl_table *table, int write,
> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> index 9384647..c5b9748 100644
> --- a/kernel/trace/trace_stack.c
> +++ b/kernel/trace/trace_stack.c
> @@ -105,7 +105,7 @@ check_stack(unsigned long ip, unsigned long *stack)
> 
> 	/* Skip over the overhead of the stack tracer itself */
> 	for (i = 0; i < max_stack_trace.nr_entries; i++) {
> -		if (stack_dump_trace[i] == ip)
> +		if ((stack_dump_trace[i] + FTRACE_STACK_FRAME_OFFSET) == ip)
> 			break;
> 	}
> 
> @@ -131,7 +131,8 @@ check_stack(unsigned long ip, unsigned long *stack)
> 		p = start;
> 
> 		for (; p < top && i < max_stack_trace.nr_entries; p++) {
> -			if (*p == stack_dump_trace[i]) {
> +			if (*p == (stack_dump_trace[i]
> +					+ FTRACE_STACK_FRAME_OFFSET)) {
> 				stack_dump_trace[x] = stack_dump_trace[i++];
> 				this_size = stack_dump_index[x++] =
> 					(top - p) * sizeof(unsigned long);
> -- 

I've prepared a kernel with the following patches and reviewed them.

1) Steve's clean up patch 
2) This patch
3) [RFC 2/3]

AFAIU, [RFC 3/3] is not needed any more thanks to Steve's patch.

First of all, let's look at the following data.

1) stack_trace data
        Depth    Size   Location    (55 entries)
        -----    ----   --------
  0)     4808      16   notifier_call_chain+0x2c/0x94
  1)     4792      64   raw_notifier_call_chain+0x34/0x44
  2)     4728      48   timekeeping_update.constprop.9+0xb8/0x114
  3)     4680      48   update_wall_time+0x408/0x6dc
  4)     4632     128   tick_do_update_jiffies64+0xd8/0x154
  5)     4504      80   tick_sched_do_timer+0x50/0x60
  6)     4424      32   tick_sched_timer+0x34/0x90
  7)     4392      48   __run_hrtimer+0x60/0x258
  8)     4344      64   hrtimer_interrupt+0xe8/0x260
  9)     4280     128   arch_timer_handler_virt+0x38/0x48
 10)     4152      32   handle_percpu_devid_irq+0x84/0x188
 11)     4120      64   generic_handle_irq+0x38/0x54
 12)     4056      32   __handle_domain_irq+0x68/0xbc
 13)     4024      64   gic_handle_irq+0x38/0x88
 14)     3960     336   el1_irq+0x64/0xd8
 15)     3624      16   netif_rx_internal+0x14/0x198
 16)     3608      64   netif_rx+0x20/0xa4
 17)     3544      32   loopback_xmit+0x64/0xf4
 18)     3512      48   dev_hard_start_xmit+0x25c/0x3f8
 19)     3464     160   __dev_queue_xmit+0x440/0x4dc
 20)     3304      96   dev_queue_xmit_sk+0x20/0x30
 21)     3208      32   ip_finish_output+0x1e0/0xabc
 22)     3176      96   ip_output+0xf0/0x120
 23)     3080      64   ip_local_out_sk+0x44/0x54
 24)     3016      32   ip_send_skb+0x24/0xbc
 25)     2984      48   ip_push_pending_frames+0x40/0x60
 26)     2936      64   icmp_push_reply+0x104/0x144
 27)     2872      96   icmp_send+0x3c0/0x3c8
 28)     2776     192   __udp4_lib_rcv+0x5b8/0x684
 29)     2584      96   udp_rcv+0x2c/0x3c
 30)     2488      32   ip_local_deliver+0xa0/0x224
 31)     2456      48   ip_rcv+0x360/0x57c
 32)     2408      64   __netif_receive_skb_core+0x4d0/0x80c
 33)     2344     128   __netif_receive_skb+0x24/0x84
 34)     2216      32   process_backlog+0x9c/0x15c
 35)     2184      80   net_rx_action+0x1ec/0x32c
 36)     2104     160   __do_softirq+0x114/0x2f0
 37)     1944     128   do_softirq+0x60/0x68
 38)     1816      32   __local_bh_enable_ip+0xb0/0xd4
 39)     1784      32   ip_finish_output+0x1f4/0xabc
 40)     1752      96   ip_output+0xf0/0x120
 41)     1656      64   ip_local_out_sk+0x44/0x54
 42)     1592      32   ip_send_skb+0x24/0xbc
 43)     1560      48   udp_send_skb+0x1b4/0x2f4
 44)     1512      80   udp_sendmsg+0x2a8/0x7a0
 45)     1432     272   inet_sendmsg+0xa0/0xd0
 46)     1160      48   sock_sendmsg+0x30/0x78
 47)     1112      32   ___sys_sendmsg+0x15c/0x26c
 48)     1080     400   __sys_sendmmsg+0x94/0x180
 49)      680     320   SyS_sendmmsg+0x38/0x54
 50)      360     360   el0_svc_naked+0x20/0x28

2) stack_max_size data
4888

The data looks odd in two points.
1) the number of entry
There is a mismatch between start token and real data

2) 80-byte gap
stack_max_size is not aligned with "Depth" field of the first entry of stack_trace.

IMHO, two items are not considered in this series as digging them out.

1) skipped entries
As x variable is introduced in Steve's patch, it is needed to track down
how many entries are recorded in both stack_dump_trace and stack_dump_index.

2) max_stack_trace.skip value
max_stack_trace.skip is 0 as applying Steve's patch. The above gap could be
observed unless the value is not considered in arch code. In the above example,
80-byte gap is save_stack_trace function in arch/arm64/kernel/stacktrace.c.

As applying the following fix, stack_trace and stack_max_size are okay.
However, I'm not sure which code, arch or generic ftrace, should handle trace->skip.
The latter one is responsible for it under current implementation, not Steve's change.

Please correct me if I am wrong.

Best Regards
Jungseok Lee

----8<----

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 978c923..5f6f4df 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -137,7 +137,9 @@ void save_stack_trace(struct stack_trace *trace)
 
 	frame.fp = (unsigned long)__builtin_frame_address(0);
 	frame.sp = current_stack_pointer;
-	frame.pc = (unsigned long)save_stack_trace_tsk;
+	frame.pc = (unsigned long)save_stack_trace;
+
+	trace->skip += 4;
 
 	__save_stack_trace(&frame, trace, 0);
 }
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index c5b9748..5635683 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -158,6 +158,9 @@ check_stack(unsigned long ip, unsigned long *stack)
 			i++;
 	}
 
+	/* We do not want to include skipped entries */
+	max_stack_trace.nr_entries -= (i - x);
+
 	for (; x < max_stack_trace.nr_entries; x++)
 		stack_dump_trace[x] = ULONG_MAX;
 
@@ -330,7 +333,7 @@ static int t_show(struct seq_file *m, void *v)
 		seq_printf(m, "        Depth    Size   Location"
 			   "    (%d entries)\n"
 			   "        -----    ----   --------\n",
-			   max_stack_trace.nr_entries - 1);
+			   max_stack_trace.nr_entries);
 
 		if (!stack_tracer_enabled && !max_stack_size)
 			print_disabled(m);

----8<----

1) stack_trace data
        Depth    Size   Location    (47 entries)
        -----    ----   --------
  0)     4648      16   notifier_call_chain+0x2c/0x94
  1)     4632      64   raw_notifier_call_chain+0x34/0x44
  2)     4568      48   timekeeping_update.constprop.9+0xb8/0x114
  3)     4520      48   update_wall_time+0x408/0x6dc
  4)     4472     128   tick_do_update_jiffies64+0xd8/0x154
  5)     4344      80   tick_sched_do_timer+0x50/0x60
  6)     4264      32   tick_sched_timer+0x34/0x90
  7)     4232      48   __run_hrtimer+0x60/0x258
  8)     4184      64   hrtimer_interrupt+0xe8/0x260
  9)     4120     128   arch_timer_handler_virt+0x38/0x48
 10)     3992      32   handle_percpu_devid_irq+0x84/0x188
 11)     3960      64   generic_handle_irq+0x38/0x54
 12)     3896      32   __handle_domain_irq+0x68/0xbc
 13)     3864      64   gic_handle_irq+0x38/0x88
 14)     3800     336   el1_irq+0x64/0xd8
 15)     3464      48   __kmalloc_track_caller+0x40/0x2f8
 16)     3416      16   __kmalloc_reserve.isra.46+0x44/0x9c
 17)     3400     144   __alloc_skb+0x70/0x180
 18)     3256      96   alloc_skb_with_frags+0x74/0x234
 19)     3160     112   sock_alloc_send_pskb+0x1d0/0x294
 20)     3048     160   sock_alloc_send_skb+0x44/0x54
 21)     2888      64   __ip_append_data.isra.40+0x78c/0xb48
 22)     2824     224   ip_append_data.part.42+0x98/0xe8
 23)     2600     112   ip_append_data+0x68/0x7c
 24)     2488      96   icmp_push_reply+0x7c/0x144
 25)     2392      96   icmp_send+0x3c0/0x3c8
 26)     2296     192   __udp4_lib_rcv+0x5b8/0x684
 27)     2104      96   udp_rcv+0x2c/0x3c
 28)     2008      32   ip_local_deliver+0xa0/0x224
 29)     1976      48   ip_rcv+0x360/0x57c
 30)     1928      64   __netif_receive_skb_core+0x4d0/0x80c
 31)     1864     128   __netif_receive_skb+0x24/0x84
 32)     1736      32   process_backlog+0x9c/0x15c
 33)     1704      80   net_rx_action+0x1ec/0x32c
 34)     1624     160   __do_softirq+0x114/0x2f0
 35)     1464     128   do_softirq+0x60/0x68
 36)     1336      32   __local_bh_enable_ip+0xb0/0xd4
 37)     1304      32   ip_finish_output+0x1f4/0xabc
 38)     1272      96   ip_output+0xf0/0x120
 39)     1176      64   ip_local_out_sk+0x44/0x54
 40)     1112      32   ip_send_skb+0x24/0xbc
 41)     1080      48   udp_send_skb+0x1b4/0x2f4
 42)     1032      80   udp_sendmsg+0x2a8/0x7a0
 43)      952     272   inet_sendmsg+0xa0/0xd0
 44)      680      48   sock_sendmsg+0x30/0x78
 45)      632      32   SyS_sendto+0xc4/0x108
 46)      600     600   el0_svc_naked+0x20/0x28

2) stack_max_size data
4648
