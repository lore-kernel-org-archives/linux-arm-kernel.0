From: will.deacon@arm.com (Will Deacon)
Date: Tue, 31 Mar 2015 17:20:41 +0100
Subject: [PATCH v6] arm: perf: Directly handle SMP platforms with one SPI
In-Reply-To: <1425475545-4323-1-git-send-email-daniel.thompson@linaro.org>
References: <1416581603-30557-1-git-send-email-daniel.thompson@linaro.org>
 <1425475545-4323-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20150331162040.GE24583@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Wed, Mar 04, 2015 at 01:25:45PM +0000, Daniel Thompson wrote:
> Some ARM platforms mux the PMU interrupt of every core into a single
> SPI. On such platforms if the PMU of any core except 0 raises an interrupt
> then it cannot be serviced and eventually, if you are lucky, the spurious
> irq detection might forcefully disable the interrupt.
> 
> On these SoCs it is not possible to determine which core raised the
> interrupt so workaround this issue by queuing irqwork on the other
> cores whenever the primary interrupt handler is unable to service the
> interrupt.
> 
> The u8500 platform has an alternative workaround that dynamically alters
> the affinity of the PMU interrupt. This workaround logic is no longer
> required so the original code is removed as is the hook it relied upon.
> 
> Tested on imx6q (which has fours cores/PMUs all muxed to a single SPI)
> using a simple soak, combined perf and CPU hotplug soak and using
> perf fuzzer's fast_repro.sh.

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
> +       atomic_t                remaining_irq_work;
> +#endif
>  };
> 
>  #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> index 557e128e4df0..e3fc1a0ce969 100644
> --- a/arch/arm/kernel/perf_event.c
> +++ b/arch/arm/kernel/perf_event.c
> @@ -305,8 +305,6 @@ validate_group(struct perf_event *event)
>  static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
>  {
>         struct arm_pmu *armpmu;
> -       struct platform_device *plat_device;
> -       struct arm_pmu_platdata *plat;
>         int ret;
>         u64 start_clock, finish_clock;
> 
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
> +
> +/*
> + * Workaround logic that is distributed to all cores if the PMU has only
> + * a single IRQ and the CPU receiving that IRQ cannot handle it. Its
> + * job is to try to service the interrupt on the current CPU. It will
> + * also enable the IRQ again if all the other CPUs have already tried to
> + * service it.
> + */
> +static void cpu_pmu_do_percpu_work(struct irq_work *w)
> +{
> +       struct pmu_hw_events *hw_events =
> +           container_of(w, struct pmu_hw_events, work);
> +       struct arm_pmu *cpu_pmu = hw_events->percpu_pmu;
> +
> +       /* Ignore the return code, we can do nothing useful with it */
> +       (void) cpu_pmu->handle_irq(0, cpu_pmu);
> +
> +       if (atomic_dec_and_test(&cpu_pmu->remaining_irq_work))
> +               enable_irq(cpu_pmu->muxed_spi_workaround_irq);
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

AFAICT, this is a hack to avoid get_online_cpus (which can sleep) from irq
context? Is there no way we can do try_get_online_cpus, and just return
IRQ_NONE if that fails? At some point, the hotplug operation will complete
and we'll be able to service the pending interrupt. I think that would allow
us to kill the down_prepare_cpu_lock.

Will
