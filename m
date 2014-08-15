From: zhangwm@marvell.com (Neil Zhang)
Date: Fri, 15 Aug 2014 02:45:09 -0700
Subject: [PATCH] arm: irq: fix the affinity when migrate a irq
In-Reply-To: <53EDC89F.4020300@arm.com>
References: <1408087917-22603-1-git-send-email-zhangwm@marvell.com>
 <53EDC89F.4020300@arm.com>
Message-ID: <9034CBD80F070943B59700D7F8149ED9020D8CC38A@SC-VEXCH4.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla at arm.com]
> Sent: 2014?8?15? 16:45
> To: Neil Zhang; linux at arm.linux.org.uk
> Cc: Sudeep Holla; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] arm: irq: fix the affinity when migrate a irq
> 
> Hi Neil,
> 
> On 15/08/14 08:31, Neil Zhang wrote:
> > Commit ffde1de64012 ("irqchip: Gic: Support forced affinity setting")
> > has enable the forcing cpu affinity of interrupts for gic.
> >
> > The current code of migrate_one_irq will pass the current affinity
> > mask to irq_set_affinity with force is true, it may select the cpu
> > being offlined as the target CPU again, then the interrupt won't be
> > migrated correctly.
> >
> 
> I had posted similar patch [1] a while ago and the discussion[2] did not
> conclude. We need feedback from Thomas Gleixner.
> 
> Regards,
> Sudeep
> 
> [1]
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/254838.html
> [2]
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/265191.html

I see, thanks.

> 
> > Signed-off-by: Neil Zhang <zhangwm@marvell.com>
> > ---
> >   arch/arm/kernel/irq.c |    5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c index
> > 2c42576..6f5a878 100644
> > --- a/arch/arm/kernel/irq.c
> > +++ b/arch/arm/kernel/irq.c
> > @@ -167,11 +167,10 @@ static bool migrate_one_irq(struct irq_desc *desc)
> >   	if (irqd_is_per_cpu(d) || !cpumask_test_cpu(smp_processor_id(), affinity))
> >   		return false;
> >
> > -	if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids) {
> > -		affinity = cpu_online_mask;
> > +	if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids)
> >   		ret = true;
> > -	}
> >
> > +	affinity = cpu_online_mask;
> >   	c = irq_data_get_irq_chip(d);
> >   	if (!c->irq_set_affinity)
> >   		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
> >

Best Regards,
Neil Zhang
