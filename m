From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 11 Jan 2016 10:58:45 +0000
Subject: [PATCH v5 07/11] arm-cci: Add routines to save/restore all
 counters
In-Reply-To: <20160111105006.GF6499@leverpostej>
References: <1451908490-2615-1-git-send-email-suzuki.poulose@arm.com>
 <1451908490-2615-8-git-send-email-suzuki.poulose@arm.com>
 <20160111105006.GF6499@leverpostej>
Message-ID: <56938AE5.9090702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/16 10:50, Mark Rutland wrote:
> On Mon, Jan 04, 2016 at 11:54:46AM +0000, Suzuki K. Poulose wrote:
>> Adds helper routines to disable the counter controls for
>> all the counters on the CCI PMU and restore it back, by
>> preserving the original state in caller provided mask.
>>
>> Cc: Punit Agrawal <punit.agrawal@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/bus/arm-cci.c |   38 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
>> index a3938ef..2f1fcf0 100644
>> --- a/drivers/bus/arm-cci.c
>> +++ b/drivers/bus/arm-cci.c
>> @@ -672,6 +672,44 @@ static void pmu_set_event(struct cci_pmu *cci_pmu, int idx, unsigned long event)
>>   }
>>
>>   /*
>> + * For all counters on the CCI-PMU, disable any 'enabled' counters,
>> + * saving the changed counters in the mask, so that we can restore
>> + * it later using pmu_restore_counters. The mask is private to the
>> + * caller. We cannot rely on the used_mask maintained by the CCI_PMU
>> + * as it only tells us if the counter is assigned to perf_event or not.
>> + * The state of the perf_event cannot be locked by the PMU layer, hence
>> + * we check the individual counter status (which can be locked by
>> + * cci_pm->hw_events->pmu_lock).
>> + *
>> + * @mask should be initialised by the caller.
>
> We should probably state "initialised to zero", or "empty".

Yep, will fix it.

>> +/*
>> + * Restore the status of the counters. Reversal of the pmu_disable_counters().
>> + * For each counter set in the mask, enable the counter back.
>> + */
>
> Shouldn't that say pmu_save_counters?

Yea, missed it in rebase.

> With that:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>

Thanks
Suzuki
