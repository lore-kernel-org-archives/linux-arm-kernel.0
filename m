From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 2 Apr 2015 17:44:14 +0100
Subject: [PATCH v6] arm: perf: Directly handle SMP platforms with one SPI
In-Reply-To: <551D5FD3.9020800@linaro.org>
References: <1416581603-30557-1-git-send-email-daniel.thompson@linaro.org>
 <1425475545-4323-1-git-send-email-daniel.thompson@linaro.org>
 <20150331170817.GA14190@leverpostej> <551D5FD3.9020800@linaro.org>
Message-ID: <20150402164414.GB6662@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>   struct arm_pmu {
> >> @@ -117,6 +125,10 @@ struct arm_pmu {
> >>          struct platform_device  *plat_device;
> >>          struct pmu_hw_events    __percpu *hw_events;
> >>          struct notifier_block   hotplug_nb;
> >> +#ifdef CONFIG_SMP
> >> +       int                     muxed_spi_workaround_irq;
> >
> > There's nothing workaround specific about this IRQ; it's just the only
> > IRQ.
> >
> > I think we should just pre-parse all the IRQs into a list at probe time,
> > regardless of SMP or the workaround. Then we can just grab the first
> > (and only) interrupt from the list in the workaround paths, and
> > otherwise just iterate over the list.
> 
> What other uses do you anticipate for such a list? I don't really
> understand why we would create a list when we only ever consume the
> first entry.

It would go parallel to the affinity property Will recently added, and
would allow us to separate the DT parsing from the request/free paths,
making those far easier to understand (and likely a little faster too).

> If there is a use for such information then why keep it as a list.
> Wouldn't the code be simpler if we add it as a field in the percpu data
> structure?
> 
> For PPIs all values would be the same, for SPIs all different, for
> broken SoCs all after [0] would be 0.

That's a nice idea. That would make the affinity info implicit, and
could be far neater.

> >> +       atomic_t                remaining_irq_work;
> >
> > Perhaps remaining_work_irqs? That would make it clear that this is a
> > counter rather than a boolean or enumeration. We could s/work/fake/ or
> > something to that effect.
> 
> I guess the thing we are actually counting is CPUs so
> remaining_cpus_with_irq_work would therefore be extremely descriptive.

It would be nice if we could come up with something that was a little
more concise. Perhaps cpus_with_work would be good enough?

> >> +}
> >> +
> >> +/*
> >> + * Workaround for systems where all PMU interrupts are targeting a
> >> + * single SPI.
> >> + *
> >> + * The workaround will disable the interrupt and distribute irqwork to all
> >> + * the other processors in the system. Hopefully one of them will clear the
> >> + * interrupt...
> >> + *
> >> + * The workaround is only deployed when all PMU interrupts are aimed
> >> + * at a single core. As a result the workaround is never re-entered
> >> + * making it safe for us to use static data to maintain state.
> >> + */
> >> +static void cpu_pmu_deploy_muxed_spi_workaround(struct arm_pmu *cpu_pmu)
> >
> > Perhaps distribute_muxed_irq?
> 
> Could do. Personally I prefer to be clear that this is deploying a
> workaround (i.e. implying it does something odd on a small number of
> SoCs) rather than this code being part of the normal case.

I'd prefer the more succinct name. We already have the comment stating
that this is a workaround.

[...]

> >> +/*
> >> + * Called when the main interrupt handler cannot determine the source
> >> + * of interrupt. It will deploy a workaround if we are running on an SMP
> >> + * platform with only a single muxed SPI.
> >> + */
> >> +static irqreturn_t cpu_pmu_handle_irq_none(int irq_num, struct arm_pmu *cpu_pmu)
> >> +{
> >> +       if (irq_num != cpu_pmu->muxed_spi_workaround_irq)
> >> +               return IRQ_NONE;
> >
> > This is somewhat opaque.
> >
> > I'd rather just have a flag to determine when we need to do any special
> > handling for the muxed case (or better, swizzle the irq handler to a
> > wrapper that pings the other CPUs and calls the usual handler).
> 
> Using a different handler for the workaround makes sense.
> 
> IIRC I avoided that previously because the way the code is currently
> split between perf_event.c and perf_event_cpu.c didn't make that very
> natural.
> 
> I'll look at this again.

The split between the two is an unfortunate legacy from when it looked
like system PMUs could reuse the code. We recently decoupled the CCI PMU
from arm_pmu so that we could fuse the two layers and get rid of a load
of indirection.

I have some patches doing that. I'll try to rework them next week given
it sounds like they could be a useful base for this.


> > [...]
> >
> >> diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
> >> index 8993770c47de..0dd914c10803 100644
> >> --- a/arch/arm/kernel/perf_event_v7.c
> >> +++ b/arch/arm/kernel/perf_event_v7.c
> >> @@ -792,7 +792,7 @@ static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
> >>           * Did an overflow occur?
> >>           */
> >>          if (!armv7_pmnc_has_overflowed(pmnc))
> >> -               return IRQ_NONE;
> >> +               return cpu_pmu_handle_irq_none(irq_num, cpu_pmu);
> >
> > Won't this leave samples skewed towards the CPU the interrupt is affine
> > to? If you're counting something like cycles with a short enough period
> > (and therefore effectively always have something to handle on the local
> > CPU), we might never ping the other CPUs.
> 
> Do we really care about fidelity of results when servicing a perf
> interrupt causes another perf interrupt to happen ;-) ? At this point
> perf has already stopped profiling anything useful.

Fair point. I'll have to consider that for a bit...

> > I think we always need to ping the other CPUs, regardless of whether
> > there was something to handle on this CPU.
> 
> Ok.
> 
> If we make this unconditional then we can, as you suggest above
> somewhere, redistribute the interrupt before trying to handle it. The
> faster we can interrupt the other CPUs the higher the fidelity of the
> profile (less time for PC to change between perf event triggering and
> CPU reacting).

Yup!

Mark.
