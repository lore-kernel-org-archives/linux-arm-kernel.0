From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 11 Jan 2016 12:14:56 +0000
Subject: [PATCH v5 08/11] arm-cci: Provide hook for writing to PMU counters
In-Reply-To: <20160111105454.GG6499@leverpostej>
References: <1451908490-2615-1-git-send-email-suzuki.poulose@arm.com>
 <1451908490-2615-9-git-send-email-suzuki.poulose@arm.com>
 <20160111105454.GG6499@leverpostej>
Message-ID: <56939CC0.1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/16 10:54, Mark Rutland wrote:
> On Mon, Jan 04, 2016 at 11:54:47AM +0000, Suzuki K. Poulose wrote:

>>   static struct cci_pmu_model cci_pmu_models[];
>> @@ -846,7 +847,15 @@ static void pmu_write_counter(struct perf_event *event, u32 value)
>>   		dev_err(&cci_pmu->plat_device->dev, "Invalid CCI PMU counter %d\n", idx);
>>   		return;
>>   	}
>> -	__pmu_write_counter(cci_pmu, value, idx);
>> +
>> +	if (cci_pmu->model->write_counters) {
>> +		unsigned long mask[BITS_TO_LONGS(cci_pmu->num_cntrs)];
>> +
>> +		memset(mask, 0, BITS_TO_LONGS(cci_pmu->num_cntrs) * sizeof(unsigned long));
>> +		set_bit(idx, mask);
>> +		cci_pmu->model->write_counters(cci_pmu, mask, value);
>> +	} else
>> +		__pmu_write_counter(cci_pmu, value, idx);
>>   }
>
> It would be much simpler to always log writes here, and only do the real
> wirtes in batches when we re-enable the PMU (with appropriate
> disable/enable calls in the IRQ handler).
>
> We'd still need special hooks for CCIs which require a special dance to
> program them, but all the logic to handle the writes would be in one
> place.

This one is only there for the writes from the irq handler. Now that
we have decided to disable pmu there, we could batch this one too.

Cheers
Suzuki
