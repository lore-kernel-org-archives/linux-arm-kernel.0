From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 29 Sep 2015 10:13:16 +0100
Subject: [PATCH] arm-cci500: Workaround pmu_event_set_period
In-Reply-To: <20150928153813.GA27704@leverpostej>
References: <1443196253-22765-1-git-send-email-suzuki.poulose@arm.com>
 <20150928153813.GA27704@leverpostej>
Message-ID: <560A562C.9060508@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/09/15 16:38, Mark Rutland wrote:
> On Fri, Sep 25, 2015 at 04:50:53PM +0100, Suzuki K. Poulose wrote:
>> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
>>
>> The CCI PMU driver sets the event counter to the half of the maximum
>> value(2^31) it can count before we start the counters via
>> pmu_event_set_period(). This is done to give us the best chance to
>> handle the overflow interrupt, taking care of extreme interrupt latencies.
>>
>> However, CCI-500 comes with advanced power saving schemes, which disables
>> the clock to the event counters unless the counters are enabled to count
>> (PMCR.CEN). This prevents the driver from writing the period to the
>> counters before starting them.  Also, there is no way we can reset the
>> individual event counter to 0 (PMCR.RST resets all the counters, losing
>> their current readings). However the value of the counter is preserved and
>> could be read back, when the counters are not enabled.
>
> Does reset work while the counters are clock gated?

No. It doesn't. Both PMCR.CEN and Count Control should be turned on to
alter the value of the counter.  

>
> I take it that we can configure the counters while they are disabled,
> even if we can't alter the counter value?

We can program the events for the counter, but we can't alter the counter
value.

>
>> So we cannot reliably use the counters and compute the number of events
>> generated during the sampling period since we don't have the value of the
>> counter at start.
>>
>> Here are the possible solutions:
>>
>>   1) Disable clock gating on CCI-500 by setting Control_Override_Reg[bit3].
>>      - The Control_Override_Reg is secure (and hence not programmable from
>>        Linux), and also has an impact on power consumption.
>>
>>   2) Change the order of operations
>> 	i.e,
>> 	a) Program and enable individual counters
>> 	b) Enable counting on all the counters by setting PMCR.CEN
>> 	c) Write the period to the individual counters
>> 	d) Disable the counters
>>      - This could cause in unnecessary noise in the other counters and is
>>        costly (we should repeat this for all enabled counters).
>>
>>   3) Don't set the counter value, instead use the current count as the
>>      starting count and compute the delta at the end of sampling.
>
> This leaves us less broken than we currently are, but as far as I can
> tell, this leaves us back where we started, with the overflow issues
> seen elsewhere, cf:
>
> a737823d37666255 ("ARM: 6835/1: perf: ensure overflows aren't missed due to IRQ latency")
> 5727347180ebc6b4 ("ARM: 7354/1: perf: limit sample_period to half max_period in non-sampling mode")

Thanks for the pointers. Even now, without this change, theoretically
we could run into the overflow, isn't it ? So we should fix it for ever.

>> @@ -792,15 +803,33 @@ static void pmu_read(struct perf_event *event)
>>   void pmu_event_set_period(struct perf_event *event)
>>   {
>>   	struct hw_perf_event *hwc = &event->hw;
>> +	struct cci_pmu *cci_pmu = to_cci_pmu(event->pmu);
>> +	u64 val = 0;
>> +
>>   	/*
>> -	 * The CCI PMU counters have a period of 2^32. To account for the
>> -	 * possiblity of extreme interrupt latency we program for a period of
>> -	 * half that. Hopefully we can handle the interrupt before another 2^31
>> -	 * events occur and the counter overtakes its previous value.
>> +	 * If the PMU gates the clock to PMU event counters when the counters
>> +	 * are not enabled, any write to it is ineffective. Hence we cannot
>> +	 * set a value reliably. Also, we cannot reset an individual event
>> +	 * counter; PMCR.RST resets all the counters. However the existing
>> +	 * counter values can be read back. Hence, we use the existing counter
>> +	 * value as the period and set the prev_count accordingly. This is
>> +	 * safe, since we don't support sampling of events anyway.
>>   	 */
>> -	u64 val = 1ULL << 31;
>> +	if (pmu_ignores_cntr_write(cci_pmu)) {
>> +		val = pmu_read_counter(event);
>> +	} else {
>> +		/*
>> +		 * The CCI PMU counters have a period of 2^32. To account for
>> +		 * the possiblity of extreme interrupt latency we program for
>> +		 * a period of half that. Hopefully we can handle the interrupt
>> +		 * before another 2^31 events occur and the counter overtakes
>> +		 * its previous value.
>> +		 */
>> +		val = 1ULL << 31;
>> +		pmu_write_counter(event, val);
>> +	}
>> +
>>   	local64_set(&hwc->prev_count, val);
>> -	pmu_write_counter(event, val);
>>   }
>
> We could get rid of the flag and always do:
>
> 	pmu_write_counter(event, 1UL << 31);
> 	val = pmu_read_counter(event);
>
> That should work for CCI-400 and CCI-500, and if the CCI-500 counters
> aren't clock-gated (e.g. because of FW configuration) then we get the
> period that we actually wanted.

Yes, thats looks neater. I will change it with some comments in there.

>
> However, can't we use an event which won't count to solve the race with
> option 2?

Even if we found one, won't we have to set the 'no-op' event on all counters,
if we want to change a counter value to prevent other counters from counting?
And it gets complicated with/without event grouping.

>
> Per the TRM, events for unimplemented interfaces don't count, though I'm
> not sure if there's an event that's guaranteed to not count in all
> configurations. Perhaps we might be able to dig one up.

IIRC, there wasn't any mention about a single event which falls into that
category. I think solution 3 is much cleaner than finding and using a dummy
event.

Suzuki
