From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 5 Jan 2016 09:59:13 +0000
Subject: [PATCH v5 05/11] arm-cci PMU: Delay counter writes to pmu_enable
In-Reply-To: <20160104192401.GD17127@leverpostej>
References: <1451908490-2615-1-git-send-email-suzuki.poulose@arm.com>
 <1451908490-2615-6-git-send-email-suzuki.poulose@arm.com>
 <20160104192401.GD17127@leverpostej>
Message-ID: <568B93F1.8050202@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/16 19:24, Mark Rutland wrote:
> On Mon, Jan 04, 2016 at 11:54:44AM +0000, Suzuki K. Poulose wrote:
>> Delay setting the event periods for enabled events to pmu::pmu_enable().
>> We mark the event.hw->state PERF_HES_ARCH for the events that we know
>> have their counts recorded and have been started.
>
> Please add a comment to the code stating exactly what PERF_HES_ARCH
> means for the CCI PMU driver, so it's easy to find.
>

Sure.

>> +void cci_pmu_update_counters(struct cci_pmu *cci_pmu)
>> +{
>> +	int i;
>> +	unsigned long mask[BITS_TO_LONGS(cci_pmu->num_cntrs)];
>
> I think this can be:
>
> 	DECLARE_BITMAP(mask, cci_pmu->num_cntrs);
>
>> +
>> +	memset(mask, 0, BITS_TO_LONGS(cci_pmu->num_cntrs) * sizeof(unsigned long));
>
> Likewise:
>
> 	bitmap_zero(mask, cci_pmu->num_cntrs);

OK

>> +		if (!cci_pmu->hw_events.events[i]) {
>> +			WARN_ON(1);
>> +			continue;
>> +		}
>> +
>
> 		if (WARN_ON(!cci_pmu->hw_events.events[i]))
> 			continue;

OK
  
>> @@ -980,8 +1015,11 @@ static void cci_pmu_start(struct perf_event *event, int pmu_flags)
>>   	/* Configure the counter unless you are counting a fixed event */
>>   	if (!pmu_fixed_hw_idx(cci_pmu, idx))
>>   		pmu_set_event(cci_pmu, idx, hwc->config_base);
>> -
>> -	pmu_event_set_period(event);
>> +	/*
>> +	 * Mark this counter, so that we can program the
>> +	 * counter with the event_period. see cci_pmu_enable()
>> +	 */
>> +	hwc->state = PERF_HES_ARCH;
>
> Why couldn't we have kept pmu_event_set_period here, and have that set
> prev_count and PERF_HES_ARCH?
>
> Then we'd be able to do the same betching for overflow too.

The pmu is not disabled while we are in overflow irq handler. Hence there may
not be a pmu_enable() which would set the period for the counter which
overflowed, if defer the write in that case. Is that assumption wrong ?

Cheers
Suzuki
