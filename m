From: james.morse@arm.com (James Morse)
Date: Fri, 18 Sep 2015 14:44:56 +0100
Subject: [PATCH v2] arm64: Introduce IRQ stack
In-Reply-To: <6A6F7BF2-D75E-4D8D-B0F7-45294C4C4426@gmail.com>
References: <1442155337-7020-1-git-send-email-jungseoklee85@gmail.com>
 <20150917111735.GN25444@e104818-lin.cambridge.arm.com>
 <3C2C78B3-4669-4DBA-98DC-362EB762FD9C@gmail.com>
 <CFF333D1-E771-4C50-902A-444DAE76C163@gmail.com>
 <20150917162110.GO25444@e104818-lin.cambridge.arm.com>
 <6A6F7BF2-D75E-4D8D-B0F7-45294C4C4426@gmail.com>
Message-ID: <55FC1558.7030303@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/09/15 13:57, Jungseok Lee wrote:
> On Sep 18, 2015, at 1:21 AM, Catalin Marinas wrote:
>> in more detail. BTW, I don't think we need the any count for the irq
>> stack as we don't re-enter the same IRQ stack.
> 
> Another interrupt could come in since IRQ is enabled when handling softirq
> according to the following information which are self-evident.
> 
> (Am I missing something?)
> 
> 1) kernel/softirq.c
> 
> asmlinkage __visible void __do_softirq(void)
> {
>         unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
>         unsigned long old_flags = current->flags;
>         int max_restart = MAX_SOFTIRQ_RESTART;
>         struct softirq_action *h;
>         bool in_hardirq;
>         __u32 pending;
>         int softirq_bit;
> 
>         /*  
>          * Mask out PF_MEMALLOC s current task context is borrowed for the
>          * softirq. A softirq handled such as network RX might set PF_MEMALLOC
>          * again if the socket is related to swap
>          */
>         current->flags &= ~PF_MEMALLOC;
> 
>         pending = local_softirq_pending();
>         account_irq_enter_time(current);
> 
>         __local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
>         in_hardirq = lockdep_softirq_start();
> 
> restart:
>         /* Reset the pending bitmask before enabling irqs */
>         set_softirq_pending(0);
> 
>         local_irq_enable();

This call into __do_softirq() should be prevented by
kernel/softirq.c:irq_exit():
> preempt_count_sub(HARDIRQ_OFFSET);
> if (!in_interrupt() && local_softirq_pending())
>      invoke_softirq();

in_interrupt(), pulls preempt_count out of thread_info, and masks it with
(SOFTIRQ_MASK | HARDIRQ_MASK | NMI_MASK). This value is zero due to the
preempt_count_sub() immediately before.

preempt_count_add(HARDIRQ_OFFSET) is called in __irq_enter(), so its not
unreasonable that it decrements it here - but it is falling to zero,
causing softirqs to be handled during interrupt handling.


Despite the '!in_interrupt()', it looks like this is entirely intentional,
from invoke_softirq():
/*
 * We can safely execute softirq on the current stack if
 * it is the irq stack, because it should be near empty
 * at this stage.
 */


x86 has an additional preempt_count_{add,sub}(HARDIRQ_OFFSET) in
ist_{enter,exit}(), which would prevent this. They call this for
double_faults and debug-exceptions.

It looks like we need to 'preempt_count_add(HARDIRQ_OFFSET)' in el1_irq()
to prevent the fall-to-zero, to prevent recursive use of the irq stack -
alternatively I have a smaller set of asm for irq_stack_entry() which keeps
the status quo.



James
