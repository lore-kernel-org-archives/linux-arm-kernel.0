From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 1 Sep 2011 13:10:48 +0800
Subject: [PATCH] arm: gic: fix gic_set_affinity
In-Reply-To: <20110831190448.GA29729@n2100.arm.linux.org.uk>
References: <1314802086-26133-1-git-send-email-tom.leiming@gmail.com>
	<20110831190448.GA29729@n2100.arm.linux.org.uk>
Message-ID: <CACVXFVO0pAJv8WkZ6K2N1NysBcdN+9ceErE0xxQFLnYXtorsvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 1, 2011 at 3:04 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Aug 31, 2011 at 10:48:06PM +0800, tom.leiming at gmail.com wrote:
>> Current gic_set_affinity doesn't support to route irq to all cpu,
>> so fix it.
>
> That is correct - we don't support routing an IRQ to _all_ CPUs because
> that's silly - by doing so you end up with a galloping hurd problem. ?As
> soon as such an interrupt is triggered, it will be delivered to all CPUs,
> and all CPUs will be woken up. ?All CPUs will then enter the kernel, and

Yes, the irq will make 'WFI' exit from all CPUs, which will be wake up, but
the irq is only routed into one of CPUs for irq handling. Looks like WFI is
stupid designed, :-) Buf for the CPU waken up by irq handled on other
CPU, it will run wfi and sleep immediately.

> one will win the spinlock race. ?The remainder will spin on the lock while
> the winner sorts out what to do.

I have added a trace point in the entry of arch_irq_handler_default, and
observed one irq is only routed into one of CPUs, so only one CPU will
handle the irq even if gic is set to route an IRQ to _all_ CPUs.

>
> That is inefficient and needlessly causes other CPUs to wake up. ?The
> point of the current code is that we route IRQs to exactly one CPU at a
> time to avoid that problem.

Maybe the current implementation should allow user to route IRQ to all
CPUs, and no cause to just forbid it, but the default_smp_affinity can be
set as only routing to one of CPUs.

>
>> Also remove the unnecessary check for 'cpu' since cpu_online_mask
>> is already ADDed to produce correct one.
>
> Not everywhere - take a look at migrate_one_irq() in arch/arm/kernel/irq.c,
> where we want to change the current routing but without actually changing
> the user set affinity.
>


thanks,
-- 
Ming Lei
