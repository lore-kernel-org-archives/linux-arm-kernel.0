From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 31 Mar 2015 18:08:19 +0100
Subject: [PATCH v6] arm: perf: Directly handle SMP platforms with one SPI
In-Reply-To: <1425475545-4323-1-git-send-email-daniel.thompson@linaro.org>
References: <1416581603-30557-1-git-send-email-daniel.thompson@linaro.org>
 <1425475545-4323-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20150331170817.GA14190@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

I'd very much like to see us converge on a solution for this soon. The
existing hack is getting in the way of other rework of the arm/arm64
perf code.

I think the approach this patch takes should work, but there are some
parts that can be cleaned up (hopefully mostly cosmetic). Unfortunately
I don't seem to have a relevant platform for testing on.

[...]

> diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
> index b1596bd59129..dfef7904b790 100644
> --- a/arch/arm/include/asm/pmu.h
> +++ b/arch/arm/include/asm/pmu.h
> @@ -87,6 +87,14 @@ struct pmu_hw_events {
>          * already have to allocate this struct per cpu.
>          */
>         struct arm_pmu          *percpu_pmu;
> +
> +#ifdef CONFIG_SMP
> +       /*
> +        * This is used to schedule workaround logic on platforms where all
> +        * the PMUs are attached to a single SPI.
> +        */
> +       struct irq_work work;
> +#endif
>  };
> 
>  struct arm_pmu {
> @@ -117,6 +125,10 @@ struct arm_pmu {
>         struct platform_device  *plat_device;
>         struct pmu_hw_events    __percpu *hw_events;
>         struct notifier_block   hotplug_nb;
> +#ifdef CONFIG_SMP
> +       int                     muxed_spi_workaround_irq;

There's nothing workaround specific about this IRQ; it's just the only
IRQ.

I think we should just pre-parse all the IRQs into a list at probe time,
regardless of SMP or the workaround. Then we can just grab the first
(and only) interrupt from the list in the workaround paths, and
otherwise just iterate over the list.

> +       atomic_t                remaining_irq_work;

Perhaps remaining_work_irqs? That would make it clear that this is a
counter rather than a boolean or enumeration. We could s/work/fake/ or
something to that effect.

> @@ -317,14 +315,9 @@ static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
>          * dereference.
>          */
>         armpmu = *(void **)dev;
> -       plat_device = armpmu->plat_device;
> -       plat = dev_get_platdata(&plat_device->dev);
> 
>         start_clock = sched_clock();
> -       if (plat && plat->handle_irq)
> -               ret = plat->handle_irq(irq, armpmu, armpmu->handle_irq);
> -       else
> -               ret = armpmu->handle_irq(irq, armpmu);
> +       ret = armpmu->handle_irq(irq, armpmu);
>         finish_clock = sched_clock();
> 
>         perf_sample_event_took(finish_clock - start_clock);

It's nice to see the plat stuff disappearing!

> diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
> index 61b53c46edfa..d5bbd79abd4c 100644
> --- a/arch/arm/kernel/perf_event_cpu.c
> +++ b/arch/arm/kernel/perf_event_cpu.c
> @@ -59,6 +59,116 @@ int perf_num_counters(void)
>  }
>  EXPORT_SYMBOL_GPL(perf_num_counters);
> 
> +#ifdef CONFIG_SMP
> +
> +static cpumask_t down_prepare_cpu_mask;
> +static DEFINE_SPINLOCK(down_prepare_cpu_lock);

I think the names here are a little misleading, because we care about
the whole window from CPU_DOWN_PREPARE to CPU_DEAD (or DOWN_FAILED). I
think these would be clearer with s/down_prepare_cpu/dying_cpu/ (though
admittedly that could also be confused with CPU_DYING).

> +
> +/*
> + * Workaround logic that is distributed to all cores if the PMU has only
> + * a single IRQ and the CPU receiving that IRQ cannot handle it. Its
> + * job is to try to service the interrupt on the current CPU. It will
> + * also enable the IRQ again if all the other CPUs have already tried to
> + * service it.
> + */
> +static void cpu_pmu_do_percpu_work(struct irq_work *w)

Perhaps do_muxed_irq_work?

> +{
> +       struct pmu_hw_events *hw_events =
> +           container_of(w, struct pmu_hw_events, work);
> +       struct arm_pmu *cpu_pmu = hw_events->percpu_pmu;
> +
> +       /* Ignore the return code, we can do nothing useful with it */
> +       (void) cpu_pmu->handle_irq(0, cpu_pmu);

Nit: no space after a cast please.

Do we need the void cast here? Does your toolchain complain?

> +
> +       if (atomic_dec_and_test(&cpu_pmu->remaining_irq_work))
> +               enable_irq(cpu_pmu->muxed_spi_workaround_irq);

I'm a little uneasy about calling enable_irq here, given we're in IRQ
context. While it doesn't look we'd be wired up through an irqchip with
irq_bus_lock or irq_bus_sync_unlock, I'm not sure how safe it is to rely
on that being the only thing that matters.

It would be nice to hear from someone familiar with the IRQ code on that
respect.

> +}
> +
> +/*
> + * Workaround for systems where all PMU interrupts are targeting a
> + * single SPI.
> + *
> + * The workaround will disable the interrupt and distribute irqwork to all
> + * the other processors in the system. Hopefully one of them will clear the
> + * interrupt...
> + *
> + * The workaround is only deployed when all PMU interrupts are aimed
> + * at a single core. As a result the workaround is never re-entered
> + * making it safe for us to use static data to maintain state.
> + */
> +static void cpu_pmu_deploy_muxed_spi_workaround(struct arm_pmu *cpu_pmu)

Perhaps distribute_muxed_irq?

> +{
> +       static cpumask_t irqwork_mask;
> +       int cpu;
> +
> +       disable_irq_nosync(cpu_pmu->muxed_spi_workaround_irq);
> +       spin_lock(&down_prepare_cpu_lock);
> +
> +       /*
> +        * Combining cpu_online_mask and down_prepare_cpu_mask gives
> +        * us the CPUs that are currently online and cannot die until
> +        * we release down_prepare_cpu_lock.
> +        */
> +       cpumask_andnot(&irqwork_mask, cpu_online_mask, &down_prepare_cpu_mask);
> +       cpumask_clear_cpu(smp_processor_id(), &irqwork_mask);
> +       atomic_add(cpumask_weight(&irqwork_mask), &cpu_pmu->remaining_irq_work);
> +
> +       for_each_cpu(cpu, &irqwork_mask) {
> +               struct pmu_hw_events *hw_events =
> +                   per_cpu_ptr(cpu_pmu->hw_events, cpu);
> +
> +               if (!irq_work_queue_on(&hw_events->work, cpu))
> +                       if (atomic_dec_and_test(&cpu_pmu->remaining_irq_work))
> +                               enable_irq(cpu_pmu->muxed_spi_workaround_irq);
> +       }
> +
> +       spin_unlock(&down_prepare_cpu_lock);
> +}

I think this works, given the notifier logic and hotplug_cfd flushing
any pending irq_work items.

> +
> +/*
> + * Called when the main interrupt handler cannot determine the source
> + * of interrupt. It will deploy a workaround if we are running on an SMP
> + * platform with only a single muxed SPI.
> + */
> +static irqreturn_t cpu_pmu_handle_irq_none(int irq_num, struct arm_pmu *cpu_pmu)
> +{
> +       if (irq_num != cpu_pmu->muxed_spi_workaround_irq)
> +               return IRQ_NONE;

This is somewhat opaque.

I'd rather just have a flag to determine when we need to do any special
handling for the muxed case (or better, swizzle the irq handler to a
wrapper that pings the other CPUs and calls the usual handler).

[...]

> +static int cpu_pmu_muxed_spi_workaround_init(struct arm_pmu *cpu_pmu)
> +{
> +       struct platform_device *pmu_device = cpu_pmu->plat_device;
> +
> +       atomic_set(&cpu_pmu->remaining_irq_work, 0);

Then we can move this atomic_set into the usual init path for SMP and
get rid of these init/term functions.

[...]

> diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
> index 8993770c47de..0dd914c10803 100644
> --- a/arch/arm/kernel/perf_event_v7.c
> +++ b/arch/arm/kernel/perf_event_v7.c
> @@ -792,7 +792,7 @@ static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
>          * Did an overflow occur?
>          */
>         if (!armv7_pmnc_has_overflowed(pmnc))
> -               return IRQ_NONE;
> +               return cpu_pmu_handle_irq_none(irq_num, cpu_pmu);

Won't this leave samples skewed towards the CPU the interrupt is affine
to? If you're counting something like cycles with a short enough period
(and therefore effectively always have something to handle on the local
CPU), we might never ping the other CPUs.

I think we always need to ping the other CPUs, regardless of whether
there was something to handle on this CPU.

Thanks,
Mark.
