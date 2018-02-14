From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Feb 2018 13:24:17 +0000
Subject: [PATCHv2 7/8] arm_pmu: note IRQs and PMUs per-cpu
In-Reply-To: <20180214131141.GF2992@arm.com>
References: <20180205164202.26502-1-mark.rutland@arm.com>
 <20180205164202.26502-8-mark.rutland@arm.com>
 <20180214131141.GF2992@arm.com>
Message-ID: <20180214132416.hragqjcsrvzes5jp@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 14, 2018 at 01:11:41PM +0000, Will Deacon wrote:
> On Mon, Feb 05, 2018 at 04:42:01PM +0000, Mark Rutland wrote:
> > diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> > index 72118e6f9122..023a8ebdace6 100644
> > --- a/drivers/perf/arm_pmu.c
> > +++ b/drivers/perf/arm_pmu.c
> > @@ -25,6 +25,9 @@
> >  
> >  #include <asm/irq_regs.h>
> >  
> > +static DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
> > +static DEFINE_PER_CPU(int, cpu_irq);
> > +
> >  static int
> >  armpmu_map_cache_event(const unsigned (*cache_map)
> >  				      [PERF_COUNT_HW_CACHE_MAX]
> > @@ -325,13 +328,9 @@ static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
> >  	int ret;
> >  	u64 start_clock, finish_clock;
> >  
> > -	/*
> > -	 * we request the IRQ with a (possibly percpu) struct arm_pmu**, but
> > -	 * the handlers expect a struct arm_pmu*. The percpu_irq framework will
> > -	 * do any necessary shifting, we just need to perform the first
> > -	 * dereference.
> > -	 */
> > -	armpmu = *(void **)dev;
> > +	armpmu = this_cpu_read(cpu_armpmu);
> > +	if (WARN_ON_ONCE(!armpmu))
> > +		return IRQ_NONE;
> >  
> >  	start_clock = sched_clock();
> >  	ret = armpmu->handle_irq(irq, armpmu);
> > @@ -517,29 +516,47 @@ int perf_num_counters(void)
> >  }
> >  EXPORT_SYMBOL_GPL(perf_num_counters);
> >  
> > -void armpmu_free_irq(struct arm_pmu *armpmu, int cpu)
> > +int armpmu_count_irq_users(const int irq)
> 
> This can be static.

sure.

> > @@ -560,16 +577,16 @@ int armpmu_request_irq(struct arm_pmu *armpmu, int cpu)
> >  
> >  		irq_set_status_flags(irq, IRQ_NOAUTOEN);
> >  		err = request_irq(irq, handler, irq_flags, "arm-pmu",
> > -				  per_cpu_ptr(&hw_events->percpu_pmu, cpu));
> > -	} else if (cpumask_empty(&armpmu->active_irqs)) {
> > +				  NULL);
> > +	} else if (armpmu_count_irq_users(irq) == 0) {
> >  		err = request_percpu_irq(irq, handler, "arm-pmu",
> > -					 &hw_events->percpu_pmu);
> > +					 cpu_armpmu);
> 
> This should be &cpu_armpmu.

I'm not sure that's the case, given the way we statically define
cpu_armpmu, but I'll try to figure that out.

> Would it be possible to pass &cpu_armpmu as the devid even in the normal
> request_irq case and have the dispatcher just pass it through to the
> underlying handler, rather than access cpu_armpmu directly?

Do you mean so that the dispatcher takes a struct arm_pmu ** in all
cases?

Otherwise, we don't have the struct pmu * early enough in the ACPI case.

Thanks,
Mark.
