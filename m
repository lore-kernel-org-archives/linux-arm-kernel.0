From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 16 Jan 2015 11:28:55 +0000
Subject: [PATCH v4] arm: perf: Directly handle SMP platforms with one SPI
In-Reply-To: <20150116105830.GG7091@arm.com>
References: <1416581603-30557-1-git-send-email-daniel.thompson@linaro.org>
 <1420820170-6127-1-git-send-email-daniel.thompson@linaro.org>
 <20150116105830.GG7091@arm.com>
Message-ID: <54B8F5F7.9040709@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/01/15 10:58, Will Deacon wrote:
> On Fri, Jan 09, 2015 at 04:16:10PM +0000, Daniel Thompson wrote:
>> Some ARM platforms mux the PMU interrupt of every core into a single
>> SPI. On such platforms if the PMU of any core except 0 raises an interrupt
>> then it cannot be serviced and eventually, if you are lucky, the spurious
>> irq detection might forcefully disable the interrupt.
>>
>> On these SoCs it is not possible to determine which core raised the
>> interrupt so workaround this issue by queuing irqwork on the other
>> cores whenever the primary interrupt handler is unable to service the
>> interrupt.
>>
>> The u8500 platform has an alternative workaround that dynamically alters
>> the affinity of the PMU interrupt. This workaround logic is no longer
>> required so the original code is removed as is the hook it relied upon.
>>
>> Tested on imx6q (which has fours cores/PMUs all muxed to a single SPI).
> 
> [...]
> 
>> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
>> index f7c65adaa428..e5c537b57f94 100644
>> --- a/arch/arm/kernel/perf_event.c
>> +++ b/arch/arm/kernel/perf_event.c
>> @@ -299,8 +299,6 @@ validate_group(struct perf_event *event)
>>  static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
>>  {
>>         struct arm_pmu *armpmu;
>> -       struct platform_device *plat_device;
>> -       struct arm_pmu_platdata *plat;
>>         int ret;
>>         u64 start_clock, finish_clock;
>>
>> @@ -311,14 +309,9 @@ static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
>>          * dereference.
>>          */
>>         armpmu = *(void **)dev;
>> -       plat_device = armpmu->plat_device;
>> -       plat = dev_get_platdata(&plat_device->dev);
>>
>>         start_clock = sched_clock();
>> -       if (plat && plat->handle_irq)
>> -               ret = plat->handle_irq(irq, armpmu, armpmu->handle_irq);
>> -       else
>> -               ret = armpmu->handle_irq(irq, armpmu);
>> +       ret = armpmu->handle_irq(irq, armpmu);
>>         finish_clock = sched_clock();
>>
>>         perf_sample_event_took(finish_clock - start_clock);
>> diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
>> index dd9acc95ebc0..76227484baa9 100644
>> --- a/arch/arm/kernel/perf_event_cpu.c
>> +++ b/arch/arm/kernel/perf_event_cpu.c
>> @@ -59,6 +59,142 @@ int perf_num_counters(void)
>>  }
>>  EXPORT_SYMBOL_GPL(perf_num_counters);
>>
>> +#ifdef CONFIG_SMP
>> +/*
>> + * Workaround logic that is distributed to all cores if the PMU has only
>> + * a single IRQ and the CPU receiving that IRQ cannot handle it. Its
>> + * job is to try to service the interrupt on the current CPU. It will
>> + * also enable the IRQ again if all the other CPUs have already tried to
>> + * service it.
>> + */
>> +static void cpu_pmu_do_percpu_work(struct irq_work *w)
>> +{
>> +       struct pmu_hw_events *hw_events =
>> +           container_of(w, struct pmu_hw_events, work);
>> +       struct arm_pmu *cpu_pmu = hw_events->percpu_pmu;
>> +
>> +       /* Ignore the return code, we can do nothing useful with it */
>> +       cpu_pmu->handle_irq(0, cpu_pmu);
>> +
>> +       if (atomic_dec_and_test(&cpu_pmu->remaining_irq_work))
>> +               enable_irq(cpu_pmu->muxed_spi_workaround_irq);
>> +}
>> +
>> +/*
>> + * Issue work to the other CPUs. Must be called whilst we own the
>> + * hotplug locks.
>> + */
>> +static void cpu_pmu_queue_percpu_work(struct arm_pmu *cpu_pmu)
>> +{
>> +       int cpu;
>> +
>> +       atomic_add(num_online_cpus() - 1, &cpu_pmu->remaining_irq_work);
>> +
>> +       for_each_online_cpu(cpu) {
>> +               struct pmu_hw_events *hw_events =
>> +                   per_cpu_ptr(cpu_pmu->hw_events, cpu);
>> +
>> +               if (cpu == smp_processor_id())
>> +                       continue;
>> +
>> +               /*
>> +                * We assume that the IPI within irq_work_queue_on()
>> +                * implies a full memory barrier making the value of
>> +                * cpu_pmu->remaining_irq_work visible to the target.
>> +                */
>> +               if (!irq_work_queue_on(&hw_events->work, cpu))
>> +                       if (atomic_dec_and_test(&cpu_pmu->remaining_irq_work))
>> +                               enable_irq(cpu_pmu->muxed_spi_workaround_irq);
>> +       }
>> +}
>> +
>> +void cpu_pmu_muxed_spi_workaround_worker(struct work_struct *work)
>> +{
>> +       struct arm_pmu *cpu_pmu =
>> +           container_of(work, struct arm_pmu, muxed_spi_workaround_work);
>> +
>> +       get_online_cpus();
>> +       cpu_pmu_queue_percpu_work(cpu_pmu);
>> +       put_online_cpus();
>> +}
>> +
>> +/*
>> + * Called when the main interrupt handler cannot determine the source
>> + * of interrupt. It will deploy a workaround if we are running on an SMP
>> + * platform with only a single muxed SPI.
>> + *
>> + * The workaround disables the interrupt and distributes irqwork to all
>> + * other processors in the system. Hopefully one of them will clear the
>> + * interrupt...
>> + */
>> +static irqreturn_t cpu_pmu_handle_irq_none(int irq_num, struct arm_pmu *cpu_pmu)
>> +{
>> +
>> +       if (irq_num != cpu_pmu->muxed_spi_workaround_irq)
>> +               return IRQ_NONE;
>> +
>> +       disable_irq_nosync(cpu_pmu->muxed_spi_workaround_irq);
>> +
>> +       if (try_get_online_cpus()) {
> 
> It's not safe to call this from interrupt context (it takes a mutex).

Ah... thanks.

I'll revisit the atomic counter approach again.


> Can you try enabling a bunch of the debug options under "Kernel Hacking"
> for things like detecting sleeping whilst atomic and then run Vince's perf
> fuzzer to see what crops up please?
> 
>   https://github.com/deater/perf_event_tests/tree/master/fuzzer

Will do.


Daniel.
