From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 5 Feb 2018 17:13:53 +0000
Subject: [PATCHv2 7/8] arm_pmu: note IRQs and PMUs per-cpu
In-Reply-To: <768a893a-121e-3768-ce71-36ace311c498@arm.com>
References: <20180205164202.26502-1-mark.rutland@arm.com>
 <20180205164202.26502-8-mark.rutland@arm.com>
 <768a893a-121e-3768-ce71-36ace311c498@arm.com>
Message-ID: <20180205171353.dk44k257w26fp5gb@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 05, 2018 at 05:07:23PM +0000, Robin Murphy wrote:
> Hi Mark,
> 
> Just a couple of nits spotted in passing...
> 
> On 05/02/18 16:42, Mark Rutland wrote:

> > +void armpmu_free_cpu_irq(int irq, int cpu)
> > +{
> > +	if (per_cpu(cpu_irq, cpu) == 0)
> > +		return;
> > +	if (WARN_ON(irq != per_cpu(cpu_irq, cpu)))
> >   		return;
> >   	if (irq_is_percpu_devid(irq)) {
> > -		free_percpu_irq(irq, &hw_events->percpu_pmu);
> > -		cpumask_clear(&armpmu->active_irqs);
> > -		return;
> > +		if (armpmu_count_irq_users(irq) == 1)
> > +			free_percpu_irq(irq, &cpu_armpmu);
> > +	} else {
> > +		free_irq(irq, NULL);
> >   	}
> 
> Following the same pattern as the request would make this marginally simpler
> (and nicely symmetric), i.e.
> 
> 	if (!irq_is_percpu_devid(irq))
> 		free_irq(irq, NULL);
> 	else if (armpmu_count_irq_users(irq) == 1)
> 		free_percpu_irq(irq, &cpu_armpmu);

Sure; done.

> > +int armpmu_request_irq(struct arm_pmu *armpmu, int cpu)
> > +{
> > +	struct pmu_hw_events __percpu *hw_events = armpmu->hw_events;
> > +	int irq = per_cpu(hw_events->irq, cpu);
> > +	if (!irq)
> > +		return 0;
> > +
> > +
> 
> Double blank line here.

... and gone.

Thanks,
Mark.
