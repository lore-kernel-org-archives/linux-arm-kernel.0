From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Feb 2018 13:45:43 +0000
Subject: [PATCHv2 7/8] arm_pmu: note IRQs and PMUs per-cpu
In-Reply-To: <20180214132640.GG2992@arm.com>
References: <20180205164202.26502-1-mark.rutland@arm.com>
 <20180205164202.26502-8-mark.rutland@arm.com>
 <20180214131141.GF2992@arm.com>
 <20180214132416.hragqjcsrvzes5jp@lakrids.cambridge.arm.com>
 <20180214132640.GG2992@arm.com>
Message-ID: <20180214134542.qgjetawmurxn4kye@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 14, 2018 at 01:26:41PM +0000, Will Deacon wrote:
> On Wed, Feb 14, 2018 at 01:24:17PM +0000, Mark Rutland wrote:
> > On Wed, Feb 14, 2018 at 01:11:41PM +0000, Will Deacon wrote:
> > > On Mon, Feb 05, 2018 at 04:42:01PM +0000, Mark Rutland wrote:
> > > > @@ -560,16 +577,16 @@ int armpmu_request_irq(struct arm_pmu *armpmu, int cpu)
> > > >  
> > > >  		irq_set_status_flags(irq, IRQ_NOAUTOEN);
> > > >  		err = request_irq(irq, handler, irq_flags, "arm-pmu",
> > > > -				  per_cpu_ptr(&hw_events->percpu_pmu, cpu));
> > > > -	} else if (cpumask_empty(&armpmu->active_irqs)) {
> > > > +				  NULL);
> > > > +	} else if (armpmu_count_irq_users(irq) == 0) {
> > > >  		err = request_percpu_irq(irq, handler, "arm-pmu",
> > > > -					 &hw_events->percpu_pmu);
> > > > +					 cpu_armpmu);
> > > 
> > > This should be &cpu_armpmu.
> > 
> > I'm not sure that's the case, given the way we statically define
> > cpu_armpmu, but I'll try to figure that out.
> 
> Well that's what you pass to free_percpu_irq :p

Ugh. One of the two is clearly wrnog...

> > > Would it be possible to pass &cpu_armpmu as the devid even in the normal
> > > request_irq case and have the dispatcher just pass it through to the
> > > underlying handler, rather than access cpu_armpmu directly?
> > 
> > Do you mean so that the dispatcher takes a struct arm_pmu ** in all
> > cases?
> 
> Yes.

Ok. I'll try to piece that together (which should allow us to revert
some changes to the dispatcher).

Thanks,
Mark.
