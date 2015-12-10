From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 10 Dec 2015 15:42:41 +0000
Subject: [PATCHv3 3/5] arm-cci: Add routines to enable/disable all counters
In-Reply-To: <20151210153222.GE495@leverpostej>
References: <1447783407-18027-1-git-send-email-suzuki.poulose@arm.com>
 <1447783407-18027-4-git-send-email-suzuki.poulose@arm.com>
 <20151210153222.GE495@leverpostej>
Message-ID: <56699D71.3070006@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/15 15:32, Mark Rutland wrote:
> On Tue, Nov 17, 2015 at 06:03:25PM +0000, Suzuki K. Poulose wrote:


>> +static void __maybe_unused
>> +pmu_disable_counters(struct cci_pmu *cci_pmu, unsigned long *mask)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < cci_pmu->num_cntrs; i++) {
>> +		if (pmu_counter_is_enabled(cci_pmu, i)) {
>> +			set_bit(i, mask);
>> +			pmu_disable_counter(cci_pmu, i);
>> +		} else
>> +			clear_bit(i, mask);
>
> Can we not assume a clean mask to begin with?

If we force the caller to pass a clean mask, yes we could. I am fine
with either approach.

>
>> +	}
>> +}
>> +
>> +/*
>> + * Restore the status of the counters. Reversal of the pmu_disable_counters().
>> + * For each counter set in the mask, enable the counter back.
>> + */
>> +static void __maybe_unused
>> +pmu_restore_counters(struct cci_pmu *cci_pmu, unsigned long *mask)
>
> This would probably be better with s/restore/enable/ for consistency
> with pmu_disable_counters.

I had thought as well, but then chose restore as we don't enable all the
counters. Given that we pass a mask argument, it is fine to change it to
enable and will do that in the next one.

>
> Other than that this looks fine to me.

Thanks for the review.

Cheers
Suzuki
