From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 5 Jan 2016 10:51:47 +0000
Subject: [PATCH v5 03/11] arm-cci: Group writes to counter
In-Reply-To: <20160104190353.GC17127@leverpostej>
References: <1451908490-2615-1-git-send-email-suzuki.poulose@arm.com>
 <1451908490-2615-4-git-send-email-suzuki.poulose@arm.com>
 <20160104190353.GC17127@leverpostej>
Message-ID: <568BA043.2020302@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/16 19:03, Mark Rutland wrote:
> On Mon, Jan 04, 2016 at 11:54:42AM +0000, Suzuki K. Poulose wrote:
>> Add a helper to group the writes to PMU counter, this will be
>> used to delay setting the event period to pmu::pmu_enable()
>>

>> +/* Write a value to a given set of counters */
>> +static void __pmu_write_counters(struct cci_pmu *cci_pmu, unsigned long *mask, u32 value)
>> +{
>> +	int i;
>> +
>> +	for_each_set_bit(i, mask, cci_pmu->num_cntrs)
>> +		__pmu_write_counter(cci_pmu, value, i);
>> +}
>
> I don't understand this as-is. Why do all the counters have the same
> value?

The only value we write to the counters is the period. This routine writes
a given value to a set of counters specified by the mask (not to be confused
with the PMU->hw_events->mask). This will help to group the writes to the counters,
especially since preparatory steps to write to a single counter itself is costly.
So, we do all the preparation only once for a batch of counters.

The other option is to use hw_events->prev_count (which should be set before calling
the function) for each counter specified in the mask. I am fine with either of the
two.

>
>> +static void __maybe_unused
>> +pmu_write_counters(struct cci_pmu *cci_pmu, unsigned long *mask, u32 value)
>> +{
>> +	__pmu_write_counters(cci_pmu, mask, value);
>> +}
>
> Why are these not just one function for now?

Yes, this could be just one function for now, until we introduce the hooks. This was
a written to avoid another refactoring in the later patch.

Thanks
Suzuki
