From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Tue, 14 Jul 2015 00:01:43 +0900
Subject: [RFC 0/3] arm64: ftrace: fix incorrect output from stack tracer
In-Reply-To: <1436765375-7119-1-git-send-email-takahiro.akashi@linaro.org>
References: <1436765375-7119-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <C202FB41-C10A-44A9-9528-E55DBA942717@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Jul 13, 2015, at 2:29 PM, AKASHI Takahiro wrote:

Hi, AKASHI

> As reported in the thread below[1], the output from stack tracer using
> ftrace on arm64 seems to be incorrect due to different reasons. Each
> problem is described and fixed repsectively in the following patches.
> Please see the commit messages for the details.
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/354126.html
> 
> If the patch[1/3], which adds "#ifdef CONFIG_ARM64" to generic ftrace code,
> is not acceptable, we will have to introduce an arch-dependent function,
> ie. arch_check_stack().
> 
> Even with those patches, we see another issue that the values in 'Size'
> field are *inaccurate*. This is simply because we have no way to estimate
> the value of stack pointer at each function from the content of stack.
> Thus the function's reported stack size does not include its own local
> variables, but includes *its child's* ones.
> See more details below.
> 
> In my opinion, we cannot fix this issue unless analyzing the function's
> first instruction, ie. "stp x29, x30, [sp, #xx]!".
> 
> * How does stack tracer identify each function's stack size?
> 
> Take an example, func-0 calls func-1 and func-1 calls func-2.
> The stack layout looks like the below:
> ("p" is a temp variable in check_stack().)
> 
> sp2     +-------+ <--------- func-2's stackframe
>        |       |
>        |       |
> fp2     +-------+
>        |  fp1  |
>        +-------+ <-- p1 (*p1 == stack_dump_trace[i] == lr1)
>        |  lr1  |
>        +-------+
>        |       |
>        |  func-2's local variables
>        |       |
> sp1     +-------+ <--------- func-1(lr1)'s stackframe
>        |       |             (stack_dump_index[i] = top - p1)
>        |  func-1's dynamic local variables
>        |       |
> fp1     +-------+
>        |  fp0  |
>        +-------+ <-- p0 (*p0 == stack_dump_trace[i+1] == lr0)
>        |  lr0  |
>        +-------+
>        |       |
>        |  func-1's local variables
>        |       |
> sp0     +-------+ <--------- func-0(lr0)'s stackframe
>        |       |             (stack_dump_index[i+1] = top - p0)
>        |       |
>        *-------+ top
> 
> Stack tracer records the stack height of func-1 (== stack_dump_trace[i]):
> 	stack_dump_index[i] = <stack top> - <estimated stack pointer>
> in check_stack() by searching for func-1's return address (lr1)
> and eventually calculates func-1's stack size by:
> 	stack_dump_index[i] - stack_dump_index[i+1]
> 		=> (top - p1) - (top - p0)
> 		=> p1 - p0
> 
> On x86, this calculation is correct because x86's call instruction pushes
> the return address to the stack and jump into the child(func-2) function,
> thus the func-1's stack pointer is "p1" where *p1 is equal to
> stack_dump_trace[i]. But this is not true on arm64.
> 
> AKASHI Takahiro (3):
>  ftrace: adjust a function's pc to search for in check_stack() for
>    arm64
>  arm64: refactor save_stack_trace()
>  arm64: ftrace: mcount() should not create a stack frame

One of stack_trace examples with this patch set is as follows.
*0* size does not appear any more now.

        Depth    Size   Location    (36 entries)
        -----    ----   --------
  0)     4504      96   put_cpu_partial+0x2c/0x1d0
  1)     4408      80   get_partial_node.isra.64+0x13c/0x344
  2)     4328     256   __slab_alloc.isra.65.constprop.67+0xd8/0x37c
  3)     4072      32   kmem_cache_alloc+0x258/0x294
  4)     4040     304   __alloc_skb+0x48/0x180
  5)     3736      96   alloc_skb_with_frags+0x74/0x234
  6)     3640     112   sock_alloc_send_pskb+0x1d0/0x294
  7)     3528     160   sock_alloc_send_skb+0x44/0x54
  8)     3368      64   __ip_append_data.isra.40+0x78c/0xb48
  9)     3304     224   ip_append_data.part.42+0x98/0xe8
 10)     3080     112   ip_append_data+0x68/0x7c
 11)     2968      96   icmp_push_reply+0x7c/0x144
 12)     2872      96   icmp_send+0x3c0/0x3c8
 13)     2776     192   __udp4_lib_rcv+0x5b8/0x684
 14)     2584      96   udp_rcv+0x2c/0x3c
 15)     2488      32   ip_local_deliver+0xa0/0x224
 16)     2456      48   ip_rcv+0x360/0x57c
 17)     2408      64   __netif_receive_skb_core+0x4d0/0x80c
 18)     2344     128   __netif_receive_skb+0x24/0x84
 19)     2216      32   process_backlog+0x9c/0x15c
 20)     2184      80   net_rx_action+0x1ec/0x32c
 21)     2104     160   __do_softirq+0x114/0x2f0
 22)     1944     128   do_softirq+0x60/0x68
 23)     1816      32   __local_bh_enable_ip+0xb0/0xd4
 24)     1784      32   ip_finish_output+0x1f4/0xabc
 25)     1752      96   ip_output+0xf0/0x120
 26)     1656      64   ip_local_out_sk+0x44/0x54
 27)     1592      32   ip_send_skb+0x24/0xbc
 28)     1560      48   udp_send_skb+0x1b4/0x2f4
 29)     1512      80   udp_sendmsg+0x2a8/0x7a0
 30)     1432     272   inet_sendmsg+0xa0/0xd0
 31)     1160      48   sock_sendmsg+0x30/0x78
 32)     1112      32   ___sys_sendmsg+0x15c/0x26c
 33)     1080     400   __sys_sendmmsg+0x94/0x180
 34)      680     320   SyS_sendmmsg+0x38/0x54
 35)      360     360   el0_svc_naked+0x20/0x28

I will leave more comments after reviewing and testing them carefully.

Best Regards
Jungseok Lee
