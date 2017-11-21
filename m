From: alex.shi@linaro.org (Alex Shi)
Date: Tue, 21 Nov 2017 21:06:27 +0800
Subject: do page fault in atomic bug on arm
Message-ID: <d83cdbf1-0d27-fb82-14c8-3d37101c3c06@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

LKFT occasionally found a kernel bug in x15 platform, which is a armv7 board. 
The bug caught on kernel commit f82786d v4.9.55, but panic could happens in 
upstream, since there is no much change on the function call chain.

The function call chain is vector___pabt_svc -> do_PrefetchAbort -> 
	do_page_fault -> might_sleep()

The trick thing is LKFT team can not reproduce the bug. But from the kernel
panic info, we know the irq_disabled() is 128, that would be the only reason,
we got the panic -- the code can not return since irqs_disabled() = 128.
The preempt_offset and preempt_count are both 0 here.

line 7726 in kernel/sched/core.c: in function ___might_sleep():
       if ((preempt_count_equals(preempt_offset) && !irqs_disabled() &&
             !is_idle_task(current)) ||
            system_state != SYSTEM_RUNNING || oops_in_progress)
                return;

I have no more idea on this issue. Any hints are appreciated!

Regards
Alex

 BUG: sleeping function called from invalid context at /srv/oe/build/tmp-rpb-glibc/work-shared/am57xx-evm/kernel-source/arch/arm/mm/fault.c:303
[   53.264908] in_atomic(): 0, irqs_disabled(): 128, pid: 1691, name: ftracetest
[   53.272074] 1 lock held by ftracetest/1691:
[   53.276273]  #0:  (&mm->mmap_sem){++++++}, at: [<c0d60cfc>] do_page_fault+0x90/0x428
[   53.284095] irq event stamp: 12924
[   53.287514] hardirqs last  enabled at (12923): [<c0307f10>] no_work_pending+0x4/0x30
[   53.295289] hardirqs last disabled at (12924): [<c0d605a0>] __pabt_svc+0x60/0xa0
[   53.302718] softirqs last  enabled at (11474): [<c034c5d0>] __do_softirq+0x280/0x5ac
[   53.310494] softirqs last disabled at (11433): [<c034cc98>] irq_exit+0xf4/0x158
[   53.317837] CPU: 0 PID: 1691 Comm: ftracetest Not tainted 4.9.55-dirty #1
[   53.324652] Hardware name: Generic DRA74X (Flattened Device Tree)
[   53.330857] [<c03114d8>] (unwind_backtrace) from [<c030cb18>] (show_stack+0x10/0x14)
[   53.338644] [<c030cb18>] (show_stack) from [<c067e604>] (dump_stack+0xa4/0xd0)
[   53.345908] [<c067e604>] (dump_stack) from [<c0373808>] (___might_sleep+0x1ac/0x2a0)
[   53.353694] [<c0373808>] (___might_sleep) from [<c0d60ec8>] (do_page_fault+0x25c/0x428)
[   53.361739] [<c0d60ec8>] (do_page_fault) from [<c03013e8>] (do_PrefetchAbort+0x38/0x9c)
[   53.369780] [<c03013e8>] (do_PrefetchAbort) from [<c0d605a8>] (__pabt_svc+0x68/0xa0)
[   53.377557] Exception stack(0xec6fbfa8 to 0xec6fbff0)
[   53.382629] bfa0:                   00000001 00000001 ffffffff 00000000 0010ac68 00000007
[   53.390845] bfc0: 00000001 0000003f 00000009 0000000c fffffffa be9d27a4 000e31fc ec6fbff8
[   53.399055] bfe0: b6e6d49c b6e6d49c 40070093 ffffffff
[   53.404137] [<c0d605a8>] (__pabt_svc) from [<b6e6d49c>] (0xb6e6d49c)
