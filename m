From: julien.thierry@arm.com (Julien Thierry)
Date: Mon, 16 Oct 2017 09:19:16 +0100
Subject: [RESEND PATCH 2/2] arm/arm64: pmu: Distinguish percpu irq and
 percpu_devid irq
In-Reply-To: <20171013164715.GB5919@leverpostej>
References: <1507894005-53778-1-git-send-email-julien.thierry@arm.com>
 <1507894005-53778-3-git-send-email-julien.thierry@arm.com>
 <20171013164715.GB5919@leverpostej>
Message-ID: <7e099dfa-fafa-f946-d8db-8e0c5c2f18cb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13/10/17 17:47, Mark Rutland wrote:
> On Fri, Oct 13, 2017 at 12:26:45PM +0100, Julien Thierry wrote:
>> arm_pmu interrupts are maked as PERCPU even when these are not local
>> physical interrupts to a single CPU. When using non-local interrupts,
>> interrupts marked as PERCPU will not get freed not disabled properly
>> by the PMU driver.
>>
>> Check if interrupts are local to a single CPU with PERCPU_DEVID since
>> this is what the PMU driver really needs to know.
>>
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Will Deacon <will.deacon@arm.com>
>> Mark Rutland <mark.rutland@arm.com>
>
> I guess these should have been with prefixed 'Cc: '.

Oops, yes they should've.

>
> The patch itself looks good to me:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> I suspect we'll need to take both patches via the usual arm pmu tree, so
> it'd be good if we could get an ack on patch 1.
>

Thanks!

> Thanks,
> Mark.
>
>> ---
>>   drivers/perf/arm_pmu.c          | 10 +++++-----
>>   drivers/perf/arm_pmu_platform.c |  4 ++--
>>   2 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
>> index d14fc2e..7bc5eee 100644
>> --- a/drivers/perf/arm_pmu.c
>> +++ b/drivers/perf/arm_pmu.c
>> @@ -539,7 +539,7 @@ void armpmu_free_irq(struct arm_pmu *armpmu, int cpu)
>>      if (!cpumask_test_and_clear_cpu(cpu, &armpmu->active_irqs))
>>              return;
>>
>> -    if (irq_is_percpu(irq)) {
>> +    if (irq_is_percpu_devid(irq)) {
>>              free_percpu_irq(irq, &hw_events->percpu_pmu);
>>              cpumask_clear(&armpmu->active_irqs);
>>              return;
>> @@ -565,10 +565,10 @@ int armpmu_request_irq(struct arm_pmu *armpmu, int cpu)
>>      if (!irq)
>>              return 0;
>>
>> -    if (irq_is_percpu(irq) && cpumask_empty(&armpmu->active_irqs)) {
>> +    if (irq_is_percpu_devid(irq) && cpumask_empty(&armpmu->active_irqs)) {
>>              err = request_percpu_irq(irq, handler, "arm-pmu",
>>                                       &hw_events->percpu_pmu);
>> -    } else if (irq_is_percpu(irq)) {
>> +    } else if (irq_is_percpu_devid(irq)) {
>>              int other_cpu = cpumask_first(&armpmu->active_irqs);
>>              int other_irq = per_cpu(hw_events->irq, other_cpu);
>>
>> @@ -649,7 +649,7 @@ static int arm_perf_starting_cpu(unsigned int cpu, struct hlist_node *node)
>>
>>      irq = armpmu_get_cpu_irq(pmu, cpu);
>>      if (irq) {
>> -            if (irq_is_percpu(irq)) {
>> +            if (irq_is_percpu_devid(irq)) {
>>                      enable_percpu_irq(irq, IRQ_TYPE_NONE);
>>                      return 0;
>>              }
>> @@ -667,7 +667,7 @@ static int arm_perf_teardown_cpu(unsigned int cpu, struct hlist_node *node)
>>              return 0;
>>
>>      irq = armpmu_get_cpu_irq(pmu, cpu);
>> -    if (irq && irq_is_percpu(irq))
>> +    if (irq && irq_is_percpu_devid(irq))
>>              disable_percpu_irq(irq);
>>
>>      return 0;
>> diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
>> index 4eafa7a..bbc64ee 100644
>> --- a/drivers/perf/arm_pmu_platform.c
>> +++ b/drivers/perf/arm_pmu_platform.c
>> @@ -126,7 +126,7 @@ static int pmu_parse_irqs(struct arm_pmu *pmu)
>>
>>      if (num_irqs == 1) {
>>              int irq = platform_get_irq(pdev, 0);
>> -            if (irq && irq_is_percpu(irq))
>> +            if (irq && irq_is_percpu_devid(irq))
>>                      return pmu_parse_percpu_irq(pmu, irq);
>>      }
>>
>> @@ -149,7 +149,7 @@ static int pmu_parse_irqs(struct arm_pmu *pmu)
>>              if (WARN_ON(irq <= 0))
>>                      continue;
>>
>> -            if (irq_is_percpu(irq)) {
>> +            if (irq_is_percpu_devid(irq)) {
>>                      pr_warn("multiple PPIs or mismatched SPI/PPI detected\n");
>>                      return -EINVAL;
>>              }
>> --
>> 1.9.1

--
Julien Thierry
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
