From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue,  4 Aug 2015 16:44:05 +0900
Subject: [RFC v2 0/4] arm64: ftrace: fix incorrect output from stack tracer
Message-ID: <1438674249-3447-1-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

See the following threads [1],[2] for the background.

With this patch series, I'm trying to fix several problems I noticed
with stack tracer on arm64. But it is rather experimental, and there still
remained are several issues. 

Patch #1 modifies ftrace framework so that we can provide arm64-specific
stack tracer later.
(Well, I know there is some room for further refactoring, but this is
just a prototype code.)
Patch #2 implements this arch_check_stack() using unwind_stackframe() to
traverse stack frames and identify a stack index for each traced function.
Patch #3 addresses an issue that stack tracer doesn't work well in
conjuction with function graph tracer.
Patch #4 addresses an issue that unwind_stackframe() misses a function
that is the one when an exception happens by setting up a stack frame
for exception handler.

See below for the result with those patches.
Issues include:
a) Size of gic_handle_irq() is 48 (#13), but should be 64.
b) We cannot identify a location of function which is being returned
   and hooked temporarily by return_to_handler() (#18)
c) A meaningless entry (#62) as well as a bogus size for the first
   function, el0_svc (#61)
d) Size doesn't contain a function's "dynamically allocated local
   variables," if any, but instead is sumed up in child's size.
   (See details in [3].)

I'm afraid that we cannot fix issue b) unless we can do *atomically*
push/pop a return adress in current->ret_stack[], increment/decrement
current->curr_ret_stack and restore lr register.

We will be able to fix issue d) once we know all the locations in
the list, including b).

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/354126.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/355920.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/358034.html


=== stack tracer with function graph tracer
# cat /sys/kernel/debug/tracing/stack_max_size /sys/kernel/debug/tracing/stack_t
race
5376
        Depth    Size   Location    (63 entries)
        -----    ----   --------
  0)     5376      64   notifier_call_chain+0x2c/0x94
  1)     5312      48   raw_notifier_call_chain+0x34/0x44
  2)     5264      64   timekeeping_update+0xe4/0x150
  3)     5200     128   update_wall_time+0x400/0x6e4
  4)     5072      80   tick_do_update_jiffies64+0xd8/0x154
  5)     4992      32   tick_sched_do_timer+0x50/0x60
  6)     4960      48   tick_sched_timer+0x34/0x90
  7)     4912     112   __hrtimer_run_queues+0xbc/0x278
  8)     4800     112   hrtimer_interrupt+0xa0/0x214
  9)     4688      32   arch_timer_handler_phys+0x38/0x48
 10)     4656      64   handle_percpu_devid_irq+0x84/0x188
 11)     4592      32   generic_handle_irq+0x38/0x54
 12)     4560      64   __handle_domain_irq+0x68/0xbc
 13)     4496      48   gic_handle_irq+0x38/0x88
 14)     4448     288   el1_irq+0x68/0xdc
 15)     4160      64   sched_clock+0x38/0x88
 16)     4096      32   trace_clock_local+0x1c/0x54
 17)     4064      96   ftrace_return_to_handler+0x64/0x120
 18)     3968      80             (null)
 19)     3888      96   xprt_complete_rqst+0xfc/0x1b0
 20)     3792      48   xs_udp_data_ready+0x168/0x170
 21)     3744      48   sock_queue_rcv_skb+0x1fc/0x270
 22)     3696      48   __udp_queue_rcv_skb+0x58/0x19c
 23)     3648      96   udp_queue_rcv_skb+0x258/0x3e4
 24)     3552      32   __udp4_lib_rcv+0x424/0x684
 25)     3520      48   udp_rcv+0x2c/0x3c
 26)     3472      64   ip_local_deliver+0xa4/0x224
 27)     3408     128   ip_rcv+0x360/0x580
 28)     3280      32   __netif_receive_skb_core+0x4d0/0x80c
 29)     3248      80   __netif_receive_skb+0x24/0x84
 30)     3168     160   process_backlog+0x9c/0x15c
 31)     3008     128   net_rx_action+0x1ec/0x32c
 32)     2880      32   __do_softirq+0x10c/0x2e8
 33)     2848      32   do_softirq+0x60/0x68
 34)     2816      96   __local_bh_enable_ip+0xb0/0xd4
 35)     2720      64   ip_finish_output2+0x1b8/0x4b8
 36)     2656      64   ip_finish_output+0x124/0x1cc
 37)     2592      32   ip_output+0xf0/0x120
 38)     2560      48   ip_local_out_sk+0x40/0x50
 39)     2512      80   ip_send_skb+0x24/0xbc
 40)     2432     272   udp_send_skb+0xfc/0x2f4
 41)     2160      48   udp_sendmsg+0x2a8/0x7a0
 42)     2112      32   inet_sendmsg+0xa0/0xd0
 43)     2080      64   sock_sendmsg+0x30/0x78
 44)     2016     176   kernel_sendmsg+0x48/0x58
 45)     1840     112   xs_send_kvec+0xdc/0xec
 46)     1728      64   xs_sendpages+0x88/0x254
 47)     1664      64   xs_udp_send_request+0x4c/0xf0
 48)     1600      48   xprt_transmit+0x54/0x264
 49)     1552     112   call_transmit+0x168/0x200
 50)     1440      48   __rpc_execute+0x68/0x37c
 51)     1392      32   rpc_execute+0x6c/0xec
 52)     1360     112   rpc_run_task+0x90/0xb4
 53)     1248      80   rpc_call_sync+0x60/0xdc
 54)     1168      48   nfs_proc_getattr+0x54/0x64
 55)     1120      96   __nfs_revalidate_inode+0xd0/0x25c
 56)     1024      80   nfs_lookup_revalidate+0x468/0x4a0
 57)      944     192   lookup_dcache+0x74/0xc8
 58)      752     272   path_openat+0x3f4/0xe8c
 59)      480     112   do_filp_open+0x70/0xec
 60)      368      64   SyS_openat+0x38/0x48
 61)      304   -7600   el0_svc_naked+0x20/0x28
 62)     7904    7904   0x471e04

AKASHI Takahiro (4):
  ftrace: allow arch-specific check_stack()
  arm64: ftrace: add arch-specific stack tracer
  arm64: ftrace: fix a stack trace result under function graph tracer
  arm64: ftrace: add a stack frame for exception handler

 arch/arm64/include/asm/ftrace.h |    2 +
 arch/arm64/kernel/entry.S       |    4 ++
 arch/arm64/kernel/ftrace.c      |   37 +++++++++++++++
 arch/arm64/kernel/stacktrace.c  |   97 ++++++++++++++++++++++++++++++++++++++-
 include/linux/stacktrace.h      |    4 ++
 kernel/trace/trace_stack.c      |   88 ++++++++++++++++++++---------------
 6 files changed, 194 insertions(+), 38 deletions(-)

-- 
1.7.9.5
