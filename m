From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri, 8 Jun 2018 15:46:57 +0100
Subject: [PATCH v2 5/5] arm64: perf: Add support for chaining event
 counters
In-Reply-To: <20180606180119.4ofhges6codarbmk@lakrids.cambridge.arm.com>
References: <1527591356-10934-1-git-send-email-suzuki.poulose@arm.com>
 <1527591356-10934-6-git-send-email-suzuki.poulose@arm.com>
 <20180606180119.4ofhges6codarbmk@lakrids.cambridge.arm.com>
Message-ID: <4a5b5e7f-fc0b-84e3-fc65-b9f860029207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 06/06/2018 07:01 PM, Mark Rutland wrote:
> On Tue, May 29, 2018 at 11:55:56AM +0100, Suzuki K Poulose wrote:
>> Add support for 64bit event by using chained event counters
>> and 64bit cycle counters.
>>
>> Arm v8 PMUv3 allows chaining a pair of adjacent PMU counters
>> (with the lower counter number being always "even"). The low
>> counter is programmed to count the event of interest and the
>> high counter(odd numbered) is programmed with a special event
>> code (0x1e - Chain).
> 
> I found this a little difficult to read. How about:
> 
> PMUv3 allows chaining a pair of adjacent 32-bit counters, effectively
> forming a 64-bit counter. The low/even counter is programmed to count
> the event of interest, and the high/odd counter is programmed to count
> the CHAIN event, taken when the low/even counter overflows.
> 

Sure, that looks better.

>> Thus we need special allocation schemes
>> to make the full use of available counters. So, we allocate the
>> counters from either ends. i.e, chained counters are allocated
>> from the lower end in pairs of two and the normal counters are
>> allocated from the higher number. Also makes necessary changes to
>> handle the chained events as a single event with 2 counters.
> 
> Why do we need to allocate in this way?
> 
> I can see this might make allocating a pair of counters more likely in
> some cases, but there are still others where it wouldn't be possible
> (and we'd rely on the rotation logic to repack the counters for us).

It makes the efficient use of the counters in all cases and allows
counting maximum number of events with any given set, keeping the 
precedence on the order of their "inserts".
e.g, if the number of counters happened to be "odd" (not sure if it is 
even possible).

> 
> [...]
> 
>> +static inline u32 armv8pmu_read_evcntr(int idx)
>> +{
>> +	return (armv8pmu_select_counter(idx) == idx) ?
>> +	       read_sysreg(pmxevcntr_el0) : 0;
>> +}
> 
> Given armv8pmu_select_counter() always returns the idx passed to it, I
> don't think we need to check anything here. We can clean that up to be
> void, and remove the existing checks.
> 
> [...]

OK.

> 
>> +static inline u64 armv8pmu_read_chain_counter(int idx)
>> +{
>> +	u64 prev_hi, hi, lo;
>> +
>> +	hi = armv8pmu_read_evcntr(idx);
>> +	do {
>> +		prev_hi = hi;
>> +		isb();
>> +		lo = armv8pmu_read_evcntr(idx - 1);
>> +		isb();
>> +		hi = armv8pmu_read_evcntr(idx);
>> +	} while (prev_hi != hi);
>> +
>> +	return (hi << 32) | lo;
>> +}
> 
>> +static inline void armv8pmu_write_chain_counter(int idx, u64 value)
>> +{
>> +	armv8pmu_write_evcntr(idx, value >> 32);
>> +	isb();
>> +	armv8pmu_write_evcntr(idx - 1, value);
>> +}
> 
> Can we use upper_32_bits() and lower_32_bits() here?
> 
> As a more general thing, I think we need to clean up the way we
> read/write counters, because I don't think that it's right that we poke
> them while they're running -- that means you get some arbitrary skew on
> counter groups.
> 
> It looks like the only case we do that is the IRQ handler, so we should
> be able to stop/start the PMU there.

Since we don't stop the "counting" of events usually when an IRQ is
triggered, the skew will be finally balanced when the events are stopped
in a the group. So, I think, stopping the PMU may not be really a good
thing after all. Just my thought.

> 
> With that, we can get rid of the ISB here, and likewise in
> read_chain_counter, which wouldn't need to be a loop.
> 
>> +
>> +static inline void armv8pmu_write_hw_counter(struct perf_event *event,
>> +					     u64 value)
>> +{
>> +	int idx = event->hw.idx;
>> +
>> +	if (armv8pmu_event_is_chained(event))
>> +		armv8pmu_write_chain_counter(idx, value);
>> +	else
>> +		armv8pmu_write_evcntr(idx, value);
>> +}
>> +
>>   static inline void armv8pmu_write_counter(struct perf_event *event, u64 value)
>>   {
>>   	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
>> @@ -541,14 +612,14 @@ static inline void armv8pmu_write_counter(struct perf_event *event, u64 value)
>>   			smp_processor_id(), idx);
>>   	else if (idx == ARMV8_IDX_CYCLE_COUNTER) {
>>   		/*
>> -		 * Set the upper 32bits as this is a 64bit counter but we only
>> -		 * count using the lower 32bits and we want an interrupt when
>> -		 * it overflows.
>> +		 * Set the upper 32bits if we are counting this in
>> +		 * 32bit mode, as this is a 64bit counter.
>>   		 */
> 
> It would be good to keep the explaination as to why.
> 

Sure

>> -		value |= 0xffffffff00000000ULL;
>> +		if (!armv8pmu_event_is_64bit(event))
>> +			value |= 0xffffffff00000000ULL;
>>   		write_sysreg(value, pmccntr_el0);
>> -	} else if (armv8pmu_select_counter(idx) == idx)
>> -		write_sysreg(value, pmxevcntr_el0);
>> +	} else
>> +		armv8pmu_write_hw_counter(event, value);
>>   }
> 
>> +static inline void armv8pmu_write_event_type(struct perf_event *event)
>> +{
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	int idx = hwc->idx;
>> +
>> +	/*
>> +	 * For chained events, write the the low counter event type
>> +	 * followed by the high counter. The high counter is programmed
>> +	 * with CHAIN event code with filters set to count at all ELs.
>> +	 */
>> +	if (armv8pmu_event_is_chained(event)) {
>> +		u32 chain_evt = ARMV8_PMUV3_PERFCTR_CHAIN |
>> +				ARMV8_PMU_INCLUDE_EL2;
>> +
>> +		armv8pmu_write_evtype(idx - 1, hwc->config_base);
>> +		isb();
>> +		armv8pmu_write_evtype(idx, chain_evt);
> 
> The ISB isn't necessary here, AFAICT. We only do this while the PMU is
> disabled; no?

You're right. I was just following the ARM ARM.

> 
>> +	} else
>> +		armv8pmu_write_evtype(idx, hwc->config_base);
>> +}
> 
> [...]
> 
>> @@ -679,6 +679,12 @@ static void cpu_pm_pmu_setup(struct arm_pmu *armpmu, unsigned long cmd)
>>   			continue;
>>   
>>   		event = hw_events->events[idx];
>> +		/*
>> +		 * If there is no event at this idx (e.g, an idx used
>> +		 * by a chained event in Arm v8 PMUv3), skip it.
>> +		 */
>> +		if (!event)
>> +			continue;
> 
> We may as well lose the used_mask test if we're looking at the event
> regardless.

Ok

Suzuki
