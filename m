From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Wed, 06 Aug 2014 15:30:51 +0200
Subject: [PATCH V2 1/4] ARM: perf: Set suniden bit.
In-Reply-To: <20140806104947.GD25953@arm.com>
References: <20140805144831.25462.18149.stgit@localhost>
 <20140805144833.25462.46011.stgit@localhost> <20140806104947.GD25953@arm.com>
Message-ID: <53E22E0B.7080907@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,
thanks for the review.

On 06/08/14 12:49, Will Deacon wrote:
> +	/*
> +	 * Bits indicating any CPU or platform specific activations that have
> +	 * been done so we can undo them when stopping
> +	 */
> +	struct {
> +		unsigned int secure_regs_available : 1;
> +		unsigned int secure_debug_requested : 1;
> +		unsigned int platform_enabled : 1;
> +	} activated_flags;
> This should be a single bool secure_access; field.

The idea was to only actually modify the security settings while someone 
actually uses perf rather than just anytime the driver is loaded.
But I didn't want to disable the bit when exiting perf mode if it had 
already been enabled elsewhere (eg by the bootloader).
Hence the first two bits.

I'm not sure how important this really is but it seemed sensible and not 
too hard.

The third one is no longer necessary if the platform code handles all 
that itself as you suggest in comments on subsequent patch.
>>   
>> +#define SDER_SUNIDEN (1 << 1)
>> +
>> +static inline u32 armv2pmu_read_sder(void)
>> +{
>> +	u32 sder;
>> +
>> +	asm volatile("mrc p15, 0, %0, c1, c1, 1" : "=r" (sder));
>> +
>> +	return sder;
>> +}
>> +
>> +static inline void armv2pmu_write_sder(u32 sder)
>> +{
>> +	asm volatile("mcr p15, 0, %0, c1, c1, 1" : : "r" (sder));
>> +}
> Please stick with the naming convention of the file (armv7pmu_*). You can
> also combine these functions into armv7pmu_enable_secure_access...
Argh typo, sorry

> .
>> +	}
>> +
>>   	/* Enable all counters */
>>   	armv7_pmnc_write(armv7_pmnc_read() | ARMV7_PMNC_E);
>>   	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>> @@ -1394,6 +1429,15 @@ static void armv7pmu_stop(struct arm_pmu *cpu_pmu)
>>   	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
>>   
>>   	raw_spin_lock_irqsave(&events->pmu_lock, flags);
>> +
>> +	if (cpu_pmu->activated_flags.secure_debug_requested) {
>> +		u32 sder = armv2pmu_read_sder();
>> +
>> +		sder &= ~SDER_SUNIDEN;
>> +		armv2pmu_write_sder(sder);
>> +		cpu_pmu->activated_flags.secure_debug_requested = 0;
>> +	}
> Why do we need to disable this? Couldn't we just set this once during probe
> and be done with it?

Same as my remark above

Martin
