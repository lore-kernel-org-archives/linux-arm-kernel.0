From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 5 Nov 2015 10:14:25 +0000
Subject: [PATCHv2 3/4] arm-cci: Add routines to enable/disable all counters
In-Reply-To: <20151104182854.GH23860@leverpostej>
References: <1445346326-30820-1-git-send-email-suzuki.poulose@arm.com>
 <1445346326-30820-4-git-send-email-suzuki.poulose@arm.com>
 <20151104182854.GH23860@leverpostej>
Message-ID: <563B2C01.80701@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/15 18:28, Mark Rutland wrote:
> On Tue, Oct 20, 2015 at 02:05:25PM +0100, Suzuki K. Poulose wrote:
>> Adds helper routines to manipulate the counter controls for
>> all the counters on the CCI PMU.
>>
>> pmu_disable_counters_ctrl: Iterates over the counters,
>> checking the status of each counter and disabling any enabled
>> counters. For each such changed counter, the mask is updated so that
>> one can restore the state later using pmu_enable_counters_ctrl.
>>

>>   /*
>> + * Restore the status of the counters.
>> + * For each counter set in the mask, enable the counter back.
>> + */
>> +static void pmu_restore_counters_ctrl(struct cci_pmu *cci_pmu, unsigned long *mask)
>> +{
>> +	int i;
>> +
>> +	for_each_set_bit(i, mask, cci_pmu->num_cntrs)
>> +		pmu_enable_counter(cci_pmu, i);
>> +}
>> +
>> +/*
>> + * For all counters on the CCI-PMU, disable any 'enabled' counters,
>> + * saving the changed counters in the mask, so that we can restore
>> + * it later using pmu_restore_counters_ctrl.
>> + */
>> +static void pmu_disable_counters_ctrl(struct cci_pmu *cci_pmu, unsigned long *mask)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < cci_pmu->num_cntrs; i++) {
>> +		clear_bit(i, mask);
>> +		if (pmu_get_counter_ctrl(cci_pmu, i)) {
>> +			set_bit(i, mask);
>> +			pmu_disable_counter(cci_pmu, i);
>> +		}
>> +	}
>> +}
>
> I don't understand what's going on with the mask here. Why do we clear
> ieach bit when the only user (introduced in the next patch) explicitly
> clears the mask anyway?

To be more precise, it should have been :

	if (pmu_get_counter_ctrl(cci_pmu, i)) {
		set_bit(i, mask);
		pmu_disable_counter(cci_pmu, i);
	} else
		clear_bit(i, mask);

>
> Can we not get rid of the mask entirely? The combination of used_mask
> and each event's hwc->state tells us which counters are actually in use.

The problem is that neither hwc->state nor the cci_pmu->hw_events->events is
protected by pmu_lock, while enable/disable counter is. So we cannot really
rely on ((struct perf_event *)(cci_pmu->hw_events->events[counter]))->hw->state.

What we do above is, create a mask of the counters which are enabled at the
moment and disable all of them. We then program the counter and then re-enable
those which were enabled (as marked in the mask).

Suzuki


>
> Thanks,
> Mark.
>
