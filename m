From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 11 Dec 2017 18:15:31 +0000
Subject: [PATCH 4/5] arm_pmu: note IRQs/PMUs per-cpu
In-Reply-To: <20171211173657.GB3275@arm.com>
References: <20171101141239.45340-1-mark.rutland@arm.com>
 <20171101141239.45340-5-mark.rutland@arm.com>
 <20171211173657.GB3275@arm.com>
Message-ID: <20171211181531.ynpbhdhqzn3okbyv@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 05:36:58PM +0000, Will Deacon wrote:
> On Wed, Nov 01, 2017 at 02:12:38PM +0000, Mark Rutland wrote:
> > @@ -531,40 +530,56 @@ int perf_num_counters(void)
> >  }
> >  EXPORT_SYMBOL_GPL(perf_num_counters);
> >  
> > -void armpmu_free_irq(struct arm_pmu *armpmu, int cpu)
> > +int armpmu_count_irq_users(const int irq)
> >  {
> > -	struct pmu_hw_events __percpu *hw_events = armpmu->hw_events;
> > -	int irq = per_cpu(hw_events->irq, cpu);
> > +	int cpu, count = 0;
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		if (per_cpu(cpu_irq, cpu) == irq)
> > +			count++;
> > +	}
> > +
> > +	return count;
> > +}
> >  
> > -	if (!cpumask_test_and_clear_cpu(cpu, &armpmu->active_irqs))
> > +void __armpmu_free_irq(int irq, int cpu)
> > +{
> > +	if (per_cpu(cpu_irq, cpu) == 0)
> > +		return;
> > +	if (WARN_ON(irq != per_cpu(cpu_irq, cpu)))
> >  		return;
> >  
> >  	if (irq_is_percpu_devid(irq)) {
> > -		free_percpu_irq(irq, &hw_events->percpu_pmu);
> > -		cpumask_clear(&armpmu->active_irqs);
> > -		return;
> > +		if (armpmu_count_irq_users(irq) == 1)
> > +			free_percpu_irq(irq, &cpu_armpmu);
> 
> Do you actually need the count, or could you just free the irq the first
> time this is called and set all of the cpu_irqs to 0?

It might be safe to blat all the matching cpu_irq entries. I'll take a
look.

Thanks,
Mark.
