From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 29 Jun 2018 15:29:12 +0100
Subject: [PATCH v3 7/7] arm64: perf: Add support for chaining event
 counters
In-Reply-To: <20180629140129.i4oh4oov3jaecnt5@lakrids.cambridge.arm.com>
References: <1529403342-17899-1-git-send-email-suzuki.poulose@arm.com>
 <1529403342-17899-8-git-send-email-suzuki.poulose@arm.com>
 <20180629140129.i4oh4oov3jaecnt5@lakrids.cambridge.arm.com>
Message-ID: <f3c293f6-226f-2d16-8e45-6a4ab08c595f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/06/18 15:01, Mark Rutland wrote:
> On Tue, Jun 19, 2018 at 11:15:42AM +0100, Suzuki K Poulose wrote:
>> Add support for 64bit event by using chained event counters
>> and 64bit cycle counters.
>>
>> PMUv3 allows chaining a pair of adjacent 32-bit counters, effectively
>> forming a 64-bit counter. The low/even counter is programmed to count
>> the event of interest, and the high/odd counter is programmed to count
>> the CHAIN event, taken when the low/even counter overflows.
>>
>> For CPU cycles, when 64bit mode is requested, the cycle counter
>> is used in 64bit mode. If the cycle counter is not available,
>> falls back to chaining.
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> Changes sinec v2:
>>   - Drop special allocation algorithm for chain indices
>>   - Since we access the counters when the PMU is stopped,
>>     get rid of the unncessary barriers.
>>   - Ensure a counter is allocated when checking for chained event
>> ---
>>   arch/arm64/kernel/perf_event.c | 184 ++++++++++++++++++++++++++++++++++++-----
>>   drivers/perf/arm_pmu.c         |  13 ++-
>>   2 files changed, 169 insertions(+), 28 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
>> index eebc635..a03def7 100644
>> --- a/arch/arm64/kernel/perf_event.c
>> +++ b/arch/arm64/kernel/perf_event.c
>> @@ -446,9 +446,16 @@ static struct attribute_group armv8_pmuv3_events_attr_group = {
>>   };
>>   
>>   PMU_FORMAT_ATTR(event, "config:0-15");
>> +PMU_FORMAT_ATTR(bits64, "config1:0");
> 
> I'm not too keen on the "bits64" name here -- it's a little unusual.
> Perhaps "long"?

I wasn't either. The other option was _64bit, but it is easier to misspell.
The only reason for not sticking to "long" is, that gives a perception that
the user always get "double" the normal counter width, which may break
if we ever get 64bit PMU counters by default without chaining.

> 
>> +
>> +static inline bool armv8pmu_event_is_64bit(struct perf_event *event)
>> +{
>> +	return event->attr.config1 & 0x1;
>> +}
>>   
>>   static struct attribute *armv8_pmuv3_format_attrs[] = {
>>   	&format_attr_event.attr,
>> +	&format_attr_bits64.attr,
>>   	NULL,
>>   };
>>   
>> @@ -466,6 +473,20 @@ static struct attribute_group armv8_pmuv3_format_attr_group = {
>>   	(ARMV8_IDX_CYCLE_COUNTER + cpu_pmu->num_events - 1)
>>   
>>   /*
>> + * Use chained counter for a 64bit event, if we could not allocate
>> + * the 64bit cycle counter. This must be called after a counter
>> + * was allocated.
>> + */
>> +static inline bool armv8pmu_event_is_chained(struct perf_event *event)
>> +{
>> +	int idx = event->hw.idx;
>> +
>> +	return !WARN_ON(idx < 0) &&
>> +	       armv8pmu_event_is_64bit(event) &&
>> +	       (event->hw.idx != ARMV8_IDX_CYCLE_COUNTER);
>> +}
> 
> It took me a moment to parse this. Perhaps:

Yes, it does look a bit weird.

> 
> 	/*
> 	 * The dedicated cycle counter doesn't requrie chaining, but
> 	 * when this is already in use, we must chain two programmable
> 	 * counters to form a 64-bit cycle counter.
> 	 */

That sounds like, we check only for cycle events, which is not true, how
about :

	/*
	 * We must chain two programmable counters for 64 bit events,
	 * except when we have allocated the 64bit cycle counter (for CPU
	 *cycles event).
	 */


> 
>> +
>> +/*
>>    * ARMv8 low level PMU access
>>    */
>>   
>> @@ -516,12 +537,28 @@ static inline u32 armv8pmu_read_evcntr(int idx)
>>   	return read_sysreg(pmxevcntr_el0);
>>   }
>>   
>> +static inline u64 armv8pmu_read_hw_counter(struct perf_event *event)
>> +{
>> +	int idx = event->hw.idx;
>> +	u64 val = 0;
>> +
>> +	val = armv8pmu_read_evcntr(idx);
>> +	/*
>> +	 * We always read the counter with the PMU turned off.
>> +	 * So we don't need special care for reading chained
>> +	 * counters.
>> +	 */
> 
> I think this comment can go.

OK

>> +	if (armv8pmu_event_is_chained(event))
>> +		val = (val << 32) | armv8pmu_read_evcntr(idx - 1);
>> +	return val;
>> +}
>> +
>>   static inline u64 armv8pmu_read_counter(struct perf_event *event)
>>   {
>>   	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
>>   	struct hw_perf_event *hwc = &event->hw;
>>   	int idx = hwc->idx;
>> -	u32 value = 0;
>> +	u64 value = 0;
>>   
>>   	if (!armv8pmu_counter_valid(cpu_pmu, idx))
>>   		pr_err("CPU%u reading wrong counter %d\n",
>> @@ -529,7 +566,7 @@ static inline u64 armv8pmu_read_counter(struct perf_event *event)
>>   	else if (idx == ARMV8_IDX_CYCLE_COUNTER)
>>   		value = read_sysreg(pmccntr_el0);
>>   	else
>> -		value = armv8pmu_read_evcntr(idx);
>> +		value = armv8pmu_read_hw_counter(event);
>>   
>>   	return value;
>>   }
>> @@ -540,6 +577,19 @@ static inline void armv8pmu_write_evcntr(int idx, u32 value)
>>   	write_sysreg(value, pmxevcntr_el0);
>>   }
>>   
>> +static inline void armv8pmu_write_hw_counter(struct perf_event *event,
>> +					     u64 value)
>> +{
>> +	int idx = event->hw.idx;
>> +
>> +	if (armv8pmu_event_is_chained(event)) {
>> +		armv8pmu_write_evcntr(idx, upper_32_bits(value));
>> +		armv8pmu_write_evcntr(idx - 1, lower_32_bits(value));
>> +	} else {
>> +		armv8pmu_write_evcntr(idx, value);
>> +	}
>> +}
>> +
>>   static inline void armv8pmu_write_counter(struct perf_event *event, u64 value)
>>   {
>>   	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
>> @@ -551,14 +601,15 @@ static inline void armv8pmu_write_counter(struct perf_event *event, u64 value)
>>   			smp_processor_id(), idx);
>>   	else if (idx == ARMV8_IDX_CYCLE_COUNTER) {
>>   		/*
>> -		 * Set the upper 32bits as this is a 64bit counter but we only
>> +		 * Set the upper 32bits as this is a 64bit counter, if we only
>>   		 * count using the lower 32bits and we want an interrupt when
>>   		 * it overflows.
>>   		 */
> 
> Let's reword this as:
> 
> 		/*
> 		 * The cycles counter is really a 64-bit counter.
> 		 * When treating it as a 32-bit counter, we only count
> 		 * the lower 32 bits, and set the upper 32-bits so that
> 		 * we get an interrupt upon 32-bit overflow.
> 		 */
> 

OK

...

>> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
>> index 6e10e8c..a4675e4 100644
>> --- a/drivers/perf/arm_pmu.c
>> +++ b/drivers/perf/arm_pmu.c
>> @@ -674,14 +674,13 @@ static void cpu_pm_pmu_setup(struct arm_pmu *armpmu, unsigned long cmd)
>>   	int idx;
>>   
>>   	for (idx = 0; idx < armpmu->num_events; idx++) {
>> -		/*
>> -		 * If the counter is not used skip it, there is no
>> -		 * need of stopping/restarting it.
>> -		 */
>> -		if (!test_bit(idx, hw_events->used_mask))
>> -			continue;
>> -
>>   		event = hw_events->events[idx];
>> +		/*
>> +		 * If there is no event at this idx (e.g, an idx used
>> +		 * by a chained event in Arm v8 PMUv3), skip it.
>> +		 */
>> +		if (!event)
>> +			continue;
>>   
>>   		switch (cmd) {
>>   		case CPU_PM_ENTER:
> 
> Please make this change an individual patch earlier in the series. It's

I can do that. But I don't think the krait needs this, as explained in the
other patch.

> a bug fix needed for krait, too.

Thanks for the review.

Suzuki
