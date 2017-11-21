From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Nov 2017 13:20:01 +0000
Subject: do page fault in atomic bug on arm
In-Reply-To: <d83cdbf1-0d27-fb82-14c8-3d37101c3c06@linaro.org>
References: <d83cdbf1-0d27-fb82-14c8-3d37101c3c06@linaro.org>
Message-ID: <20171121132001.GH31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 21, 2017 at 09:06:27PM +0800, Alex Shi wrote:
> Hi All,
> 
> LKFT occasionally found a kernel bug in x15 platform, which is a armv7 board. 
> The bug caught on kernel commit f82786d v4.9.55, but panic could happens in 
> upstream, since there is no much change on the function call chain.
> 
> The function call chain is vector___pabt_svc -> do_PrefetchAbort -> 
> 	do_page_fault -> might_sleep()
> 
> The trick thing is LKFT team can not reproduce the bug. But from the kernel
> panic info, we know the irq_disabled() is 128, that would be the only reason,
> we got the panic -- the code can not return since irqs_disabled() = 128.
> The preempt_offset and preempt_count are both 0 here.
> 
> line 7726 in kernel/sched/core.c: in function ___might_sleep():
>        if ((preempt_count_equals(preempt_offset) && !irqs_disabled() &&
>              !is_idle_task(current)) ||
>             system_state != SYSTEM_RUNNING || oops_in_progress)
>                 return;
> 
> I have no more idea on this issue. Any hints are appreciated!
> 
> Regards
> Alex
> 
>  BUG: sleeping function called from invalid context at /srv/oe/build/tmp-rpb-glibc/work-shared/am57xx-evm/kernel-source/arch/arm/mm/fault.c:303
> [   53.264908] in_atomic(): 0, irqs_disabled(): 128, pid: 1691, name: ftracetest
> [   53.272074] 1 lock held by ftracetest/1691:
> [   53.276273]  #0:  (&mm->mmap_sem){++++++}, at: [<c0d60cfc>] do_page_fault+0x90/0x428
> [   53.284095] irq event stamp: 12924
> [   53.287514] hardirqs last  enabled at (12923): [<c0307f10>] no_work_pending+0x4/0x30
> [   53.295289] hardirqs last disabled at (12924): [<c0d605a0>] __pabt_svc+0x60/0xa0

Unfortunately, this doesn't help, because on entry to __pabt_svc, we
tell the IRQ context tracker that IRQs are now disabled, wiping out
the previous recording of where IRQs were disabled...

> [   53.302718] softirqs last  enabled at (11474): [<c034c5d0>] __do_softirq+0x280/0x5ac
> [   53.310494] softirqs last disabled at (11433): [<c034cc98>] irq_exit+0xf4/0x158
> [   53.317837] CPU: 0 PID: 1691 Comm: ftracetest Not tainted 4.9.55-dirty #1
> [   53.324652] Hardware name: Generic DRA74X (Flattened Device Tree)
> [   53.330857] [<c03114d8>] (unwind_backtrace) from [<c030cb18>] (show_stack+0x10/0x14)
> [   53.338644] [<c030cb18>] (show_stack) from [<c067e604>] (dump_stack+0xa4/0xd0)
> [   53.345908] [<c067e604>] (dump_stack) from [<c0373808>] (___might_sleep+0x1ac/0x2a0)
> [   53.353694] [<c0373808>] (___might_sleep) from [<c0d60ec8>] (do_page_fault+0x25c/0x428)
> [   53.361739] [<c0d60ec8>] (do_page_fault) from [<c03013e8>] (do_PrefetchAbort+0x38/0x9c)
> [   53.369780] [<c03013e8>] (do_PrefetchAbort) from [<c0d605a8>] (__pabt_svc+0x68/0xa0)
> [   53.377557] Exception stack(0xec6fbfa8 to 0xec6fbff0)
> [   53.382629] bfa0:                   00000001 00000001 ffffffff 00000000 0010ac68 00000007
> [   53.390845] bfc0: 00000001 0000003f 00000009 0000000c fffffffa be9d27a4 000e31fc ec6fbff8
> [   53.399055] bfe0: b6e6d49c b6e6d49c 40070093 ffffffff
> [   53.404137] [<c0d605a8>] (__pabt_svc) from [<b6e6d49c>] (0xb6e6d49c)

It also doesn't help that the backtrace stops at this point, and it looks
very strange:

1. the value of PC looks like it's outside of the module space.
2. the CPSR indicates that the CPU was in SVC mode in the parent context
   with IRQs disabled.
3. We're right at the top of the kernel stack, which suggests no further
   stack frames above this.

We should never be in SVC mode without further stack frames on the kernel
stack.

We don't seem to have overflowed the kernel stack, as the thread info
seems correct - and it would also be unlikely that the saved SP value
would end in ff8 in the exception stack frame.

I suspect something nasty is going on in the ftrace code, causing some
stacked state corruption, which then leads to us returning from a
kernel exception with state that leaves the CPU in SVC mode with
IRQs disabled, and with a LR & PC value of 0xb6e6d49c - a page that
doesn't exist.  That the leads to a prefetch abort, and this error.

In other words, the real problem is that something has gone wrong in
the ftrace code... what that is, I've no idea.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
