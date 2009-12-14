From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 14 Dec 2009 15:03:37 +0000
Subject: [PATCH 1/5] arm: provide a mechanism to reserve performance
	counters
In-Reply-To: <000e01ca7ccb$4ff2adb0$efd80910$@deacon@arm.com>
References: <1260799481-29951-1-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-2-git-send-email-jamie.iles@picochip.com>
	<000e01ca7ccb$4ff2adb0$efd80910$@deacon@arm.com>
Message-ID: <20091214150337.GG4141@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Thanks for your feedback, comments inline.

Jamie

On Mon, Dec 14, 2009 at 02:39:59PM -0000, Will Deacon wrote:
> > +#define MAX_PMU_IRQS	    8
> > +
> > +struct pmu_irqs {
> > +	int	    irqs[MAX_PMU_IRQS];
> > +	unsigned    num_irqs;
> > +};
> 
> Since we're populating this struct at compile time anyway, could we make it
> an array and use the ARRAY_SIZE macro to get the number of irqs? This would
> also mean that MAX_PMU_IRQS could be removed.
Ok, good plan.

> > diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
> > new file mode 100644
> > index 0000000..881e526
> > --- /dev/null
> > +++ b/arch/arm/kernel/pmu.c
> <snip>
> > +void
> > +release_pmu(const struct pmu_irqs *irqs)
> > +{
> > +	WARN_ON(irqs != &pmu_irqs);
> > +	up(&pmu_mutex);
> > +}
> > +EXPORT_SYMBOL_GPL(release_pmu);
> 
> I think it would be better to allow release to fail and do so if the irqs
> don't match, otherwise a malicious oprofile module could release on behalf of
> perf :).
Ok, that sounds reasonable. I'll make release_pmu() return an int, but I doubt
that it's recoverable by any of the users!
> 
> > +static void
> > +set_irq_affinity(int irq,
> > +		 unsigned int cpu)
> > +{
> > +#ifdef CONFIG_SMP
> > +	struct irq_desc *desc = irq_desc + irq;
> > +	const struct cpumask *mask = cpumask_of(cpu);
> > +	unsigned long flags;
> > +
> > +	raw_spin_lock_irqsave(&desc->lock, flags);
> > +	cpumask_copy(desc->affinity, mask);
> > +	desc->chip->set_affinity(irq, mask);
> > +	raw_spin_unlock_irqrestore(&desc->lock, flags);
> > +#endif
> > +}
> 
> Why not use irq_set_affinity(irq, cpumask_of(cpu))?
> This function isn't exported, but I don't envisage building the pmu
> as a module.
Because I moved the code from oprofile ;-) irq_set_affinity() looks like a
better option so I'll use that for the next revision.

> I think all v6 cores and above have a PMU, so you could set the bool based
> on that (and add the exceptional cases like xscale).
Ok, I wasn't sure if that was the case but if so then that's a sensible
change.
