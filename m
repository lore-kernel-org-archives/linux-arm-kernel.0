From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 20 Jun 2012 14:44:50 +0100
Subject: [PATCH 15/15] ARM: perf: handle muxed CPU IRQ lines
In-Reply-To: <20120620132823.GG32666@mudshark.cambridge.arm.com>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
 <1340197011-5435-16-git-send-email-lee.jones@linaro.org>
 <20120620132823.GG32666@mudshark.cambridge.arm.com>
Message-ID: <4FE1D3D2.3050209@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

> On Wed, Jun 20, 2012 at 01:56:51PM +0100, Lee Jones wrote:
>> When registering a PMU device, a platform can either use the generic
>> IRQ handler, or supplement it with one of its own. One of the reasons
>> a platform might choose to do this is to handle the case of muxed IRQ
>> lines. If this is the case and the IRQ is handled on the wrong CPU,
>> this patch sets affinity with the next successive online CPU.
>>
>> Cc: Will Deacon<will.deacon@arm.com>
>> Signed-off-by: Lee Jones<lee.jones@linaro.org>
>> ---
>>   arch/arm/kernel/perf_event_v7.c |   12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
>> index d3c5360..04a8867 100644
>> --- a/arch/arm/kernel/perf_event_v7.c
>> +++ b/arch/arm/kernel/perf_event_v7.c
>> @@ -1069,8 +1069,18 @@ static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
>>   	/*
>>   	 * Did an overflow occur?
>>   	 */
>> -	if (!armv7_pmnc_has_overflowed(pmnc))
>> +	if (armv7_pmnc_has_overflowed(pmnc)) {
>
> Did you mean to change this predicate?

No sorry, that's a mistake.

>> +		unsigned int next_cpu;
>> +
>> +		next_cpu = cpumask_next(smp_processor_id(), cpu_online_mask);
>> +
>> +		if (next_cpu>= nr_cpumask_bits)
>> +			next_cpu = cpumask_first(cpu_online_mask);
>> +
>> +		irq_set_affinity(irq_num, cpumask_of(next_cpu));
>> +
>
> Shouldn't this be in the platform IRQ handler, rather than the core v7 perf
> code?

Well that's where it currently resides, but in the process of DT:ing the 
platform, we have no real way to set the call-back. Normally, if it's 
absolutely necessary, we do this with AUXDATA. However in the PMU case 
we fall-down as a device address is required for DT look-up, which the 
PMU does not have.

I spoke with Arnd about sensible solutions and he suggested placing the 
logic inside the generic instead, thus supporting muxed IRQ lines 
without the requirement of providing a platform specific handler in 
every instance this occurs (although, I think the ux500 are the only 
platform to do this currently).

I'd be happy to take any other suggestions, but this seemed fairly neat 
and unobtrusive (not withstanding the predicate cock-up).

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
