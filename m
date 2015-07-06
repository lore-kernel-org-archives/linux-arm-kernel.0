From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Mon, 6 Jul 2015 21:04:26 +0900
Subject: Stack trace using ftrace
In-Reply-To: <559A34B9.2020605@linaro.org>
References: <5580ED65-69A0-40F9-9626-31A0D066C507@gmail.com>
 <559A34B9.2020605@linaro.org>
Message-ID: <42A36D72-9621-4FEF-B977-7FC6E4421618@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Jul 6, 2015, at 4:56 PM, AKASHI Takahiro wrote:
> Hi,

Hi,

> Thank you for your bug report.

Thanks for taking care about this topic.

> This issue comes from the fact that ftrace, more specifically check_stack(),
> goes over immediate values in the stack with each function's (bl instruction's) PC
> which is returned by save_stack_trace() while save_stack_trace(), or unwind_frame(),
> decrements the saved value of PC in the stack by 4. So mismatching can happen.
> 
> We can easily fix the problem by reverting the following commit:
> 
> > commit e306dfd06fcb44d21c80acb8e5a88d55f3d1cf63
> > Author: Olof Johansson <olof@lixom.net>
> > Date:   Fri Feb 14 19:35:15 2014 +0000
> >
> >     ARM64: unwind: Fix PC calculation
> 
> But it will also resurrect the original problem.

IMHO, a current problem cannot be resolved by reverting the commit.
Please refer to the following data. The result looks much better than before,
but some entries still have 0 sizes.

        Depth    Size   Location    (47 entries)
        -----    ----   --------
  0)     4664     240   jiffies_to_timeval+0x1c/0x7c
  1)     4424       0   ftrace_graph_call+0x0/0x14
  2)     4424       0   jiffies_to_timeval+0x1c/0x7c
  3)     4424       0   __acct_update_integrals+0x4c/0xbc
  4)     4424       0   acct_account_cputime+0x28/0x34
  5)     4424       0   account_system_time+0xb4/0x1e0
  6)     4424      32   account_process_tick+0x58/0xa0
  7)     4392      48   update_process_times+0x30/0x74
  8)     4344      32   tick_sched_handle.isra.15+0x3c/0x7c
  9)     4312      48   tick_sched_timer+0x4c/0x90
 10)     4264      48   __run_hrtimer+0x64/0x258
 11)     4216      64   hrtimer_interrupt+0xec/0x260
 12)     4152     128   arch_timer_handler_virt+0x3c/0x48
 13)     4024      32   handle_percpu_devid_irq+0x88/0x188
 14)     3992      64   generic_handle_irq+0x3c/0x54
 15)     3928      32   __handle_domain_irq+0x6c/0xbc
 16)     3896      64   gic_handle_irq+0x3c/0x88
 17)     3832     336   el1_irq+0x68/0xd8
 18)     3496     112   icmp_glue_bits+0x50/0x94
 19)     3384      80   __ip_append_data.isra.40+0x894/0xb48
 20)     3304     224   ip_append_data.part.42+0x9c/0xe8
 21)     3080     112   ip_append_data+0x6c/0x7c
 22)     2968      96   icmp_push_reply+0x80/0x144
 23)     2872      96   icmp_send+0x3c4/0x3c8
 24)     2776     192   __udp4_lib_rcv+0x5bc/0x684
 25)     2584      96   udp_rcv+0x30/0x3c
 26)     2488      32   ip_local_deliver+0xa4/0x224
 27)     2456      48   ip_rcv+0x364/0x57c
 28)     2408      64   __netif_receive_skb_core+0x4d4/0x80c
 29)     2344     128   __netif_receive_skb+0x28/0x84
 30)     2216      32   process_backlog+0xa0/0x15c
 31)     2184      80   net_rx_action+0x1f0/0x32c
 32)     2104     160   __do_softirq+0x118/0x2f0
 33)     1944     128   do_softirq+0x64/0x68
 34)     1816      32   __local_bh_enable_ip+0xb4/0xd4
 35)     1784      32   ip_finish_output+0x1f8/0xabc
 36)     1752      96   ip_output+0xf4/0x120
 37)     1656      64   ip_local_out_sk+0x48/0x54
 38)     1592      32   ip_send_skb+0x28/0xbc
 39)     1560      48   udp_send_skb+0x1b8/0x2f4
 40)     1512      80   udp_sendmsg+0x2ac/0x7a0
 41)     1432     272   inet_sendmsg+0xa4/0xd0
 42)     1160      48   sock_sendmsg+0x34/0x78
 43)     1112      32   ___sys_sendmsg+0x160/0x26c
 44)     1080     400   __sys_sendmmsg+0x98/0x180
 45)      680     320   SyS_sendmmsg+0x3c/0x54
 46)      360     360   el0_svc_naked+0x24/0x28

Best Regards
Jungseok Lee
