From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 06 Jul 2015 16:56:41 +0900
Subject: Stack trace using ftrace
In-Reply-To: <5580ED65-69A0-40F9-9626-31A0D066C507@gmail.com>
References: <5580ED65-69A0-40F9-9626-31A0D066C507@gmail.com>
Message-ID: <559A34B9.2020605@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thank you for your bug report.
This issue comes from the fact that ftrace, more specifically check_stack(),
goes over immediate values in the stack with each function's (bl instruction's) PC
which is returned by save_stack_trace() while save_stack_trace(), or unwind_frame(),
decrements the saved value of PC in the stack by 4. So mismatching can happen.

We can easily fix the problem by reverting the following commit:

 > commit e306dfd06fcb44d21c80acb8e5a88d55f3d1cf63
 > Author: Olof Johansson <olof@lixom.net>
 > Date:   Fri Feb 14 19:35:15 2014 +0000
 >
 >     ARM64: unwind: Fix PC calculation

But it will also resurrect the original problem.
Another possible fix is to put arm64-specific hack in check_stack(),
but it's also undesirable.

-Takahiro AKASHI


On 07/05/2015 08:33 PM, Jungseok Lee wrote:
> Greetings,
>
> As playing with ftrace to gather kernel stack data on ARM64 kernel,
> I've found out data from /sys/kernel/debug/tracing/stack_trace looks odd.
>
> One of example using 4.1 kernel + dragonboard410c is as follows.
>
>          Depth    Size   Location    (50 entries)
>          -----    ----   --------
>    0)     5256       0   notifier_call_chain+0x30/0x94
>    1)     5256       0   ftrace_call+0x0/0x4
>    2)     5256       0   notifier_call_chain+0x2c/0x94
>    3)     5256       0   raw_notifier_call_chain+0x34/0x44
>    4)     5256       0   timekeeping_update.constprop.9+0xb8/0x114
>    5)     5256       0   update_wall_time+0x408/0x6dc
>    6)     5256       0   tick_do_update_jiffies64+0xd8/0x154
>    7)     5256       0   tick_sched_do_timer+0x50/0x60
>    8)     5256       0   tick_sched_timer+0x34/0x90
>    9)     5256       0   __run_hrtimer+0x60/0x258
>   10)     5256       0   hrtimer_interrupt+0xe8/0x260
>   11)     5256       0   arch_timer_handler_virt+0x38/0x48
>   12)     5256       0   handle_percpu_devid_irq+0x84/0x188
>   13)     5256       0   generic_handle_irq+0x38/0x54
>   14)     5256       0   __handle_domain_irq+0x68/0xbc
>   15)     5256       0   gic_handle_irq+0x38/0x88
>   16)     5256       0   el1_irq+0x64/0xd8
>   17)     5256       0   kmem_cache_alloc+0x258/0x294
>   18)     5256       0   __alloc_skb+0x48/0x180
>   19)     5256       0   alloc_skb_with_frags+0x74/0x234
>   20)     5256       0   sock_alloc_send_pskb+0x1d0/0x294
>   21)     5256       0   sock_alloc_send_skb+0x44/0x54
>   22)     5256       0   __ip_append_data.isra.40+0x78c/0xb48
>   23)     5256       0   ip_append_data.part.42+0x98/0xe8
>   24)     5256       0   ip_append_data+0x68/0x7c
>   25)     5256       0   icmp_push_reply+0x7c/0x144
>   26)     5256       0   icmp_send+0x3c0/0x3c8
>   27)     5256       0   __udp4_lib_rcv+0x5b8/0x684
>   28)     5256       0   udp_rcv+0x2c/0x3c
>   29)     5256       0   ip_local_deliver+0xa0/0x224
>   30)     5256       0   ip_rcv+0x360/0x57c
>   31)     5256       0   __netif_receive_skb_core+0x4d0/0x80c
>   32)     5256       0   __netif_receive_skb+0x24/0x84
>   33)     5256       0   process_backlog+0x9c/0x15c
>   34)     5256       0   net_rx_action+0x1ec/0x32c
>   35)     5256       0   __do_softirq+0x114/0x2f0
>   36)     5256       0   do_softirq+0x60/0x68
>   37)     5256       0   __local_bh_enable_ip+0xb0/0xd4
>   38)     5256       0   ip_finish_output+0x1f4/0xabc
>   39)     5256       0   ip_output+0xf0/0x120
>   40)     5256       0   ip_local_out_sk+0x44/0x54
>   41)     5256       0   ip_send_skb+0x24/0xbc
>   42)     5256       0   udp_send_skb+0x1b4/0x2f4
>   43)     5256       0   udp_sendmsg+0x2a8/0x7a0
>   44)     5256       0   inet_sendmsg+0xa0/0xd0
>   45)     5256       0   sock_sendmsg+0x30/0x78
>   46)     5256       0   ___sys_sendmsg+0x15c/0x26c
>   47)     5256       0   __sys_sendmmsg+0x94/0x180
>   48)     5256       0   SyS_sendmmsg+0x38/0x54
>   49)     5256    5256   el0_svc_naked+0x20/0x28
>
> I think size *0* does not make sense.
> It does not match with Documentation/trace/ftrace.txt.
>
> Am I missing something?
> I attach additional information which might be helpful.
>
> 1) Kernel configuration
> CONFIG_NOP_TRACER=y
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> CONFIG_HAVE_C_RECORDMCOUNT=y
> CONFIG_TRACE_CLOCK=y
> CONFIG_RING_BUFFER=y
> CONFIG_EVENT_TRACING=y
> CONFIG_CONTEXT_SWITCH_TRACER=y
> CONFIG_TRACING=y
> CONFIG_GENERIC_TRACER=y
> CONFIG_TRACING_SUPPORT=y
> CONFIG_FTRACE=y
> CONFIG_FUNCTION_TRACER=y
> CONFIG_FUNCTION_GRAPH_TRACER=y
> # CONFIG_IRQSOFF_TRACER is not set
> # CONFIG_PREEMPT_TRACER is not set
> # CONFIG_SCHED_TRACER is not set
> # CONFIG_FTRACE_SYSCALLS is not set
> # CONFIG_TRACER_SNAPSHOT is not set
> CONFIG_BRANCH_PROFILE_NONE=y
> # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
> # CONFIG_PROFILE_ALL_BRANCHES is not set
> CONFIG_STACK_TRACER=y
> # CONFIG_BLK_DEV_IO_TRACE is not set
> # CONFIG_PROBE_EVENTS is not set
> CONFIG_DYNAMIC_FTRACE=y
> # CONFIG_FUNCTION_PROFILER is not set
> CONFIG_FTRACE_MCOUNT_RECORD=y
> CONFIG_FTRACE_SELFTEST=y
> CONFIG_FTRACE_STARTUP_TEST=y
>
> 2) Ftrace selftest result
> [  110.791609] Testing all events: OK
> [  110.999956] Testing ftrace filter: OK
>
> Thanks for any advice or help in advance!
>
> Best Regards
> Jungseok Lee
>
