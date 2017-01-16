From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Jan 2017 13:30:42 +0000
Subject: [PATCH 2/3] KVM: arm64: Access CNTHCTL_EL2 bit fields correctly
 on VHE systems
In-Reply-To: <e0d1473f-0cf9-a801-585b-4385bc5b35ab@arm.com>
References: <1484307093-29153-1-git-send-email-marc.zyngier@arm.com>
 <1484307093-29153-3-git-send-email-marc.zyngier@arm.com>
 <20170113123612.GA31994@cbox> <d496020c-a097-ffd5-adb7-7edb7c1a214e@arm.com>
 <e0d1473f-0cf9-a801-585b-4385bc5b35ab@arm.com>
Message-ID: <61f7dbf1-e20d-e9e4-950c-6a224619cf31@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/01/17 14:56, Suzuki K Poulose wrote:
> On 13/01/17 13:30, Marc Zyngier wrote:
>> [+ Suzuki, who wrote the whole cpus_have_const_cap thing]
>>

[...]

>> But maybe we should have have some stronger guarantees that we'll
>> always get things inlined, and that the "const" side is enforced:
> 
> Agreed.
> 
>>
>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
>> index b4989df..4710469 100644
>> --- a/arch/arm64/include/asm/cpufeature.h
>> +++ b/arch/arm64/include/asm/cpufeature.h
>> @@ -105,10 +105,11 @@ static inline bool cpu_have_feature(unsigned int num)
>>  }
>>
>>  /* System capability check for constant caps */
>> -static inline bool cpus_have_const_cap(int num)
>> +static __always_inline bool cpus_have_const_cap(int num)
> 
> I think we should have the above change and make it inline always.
> 
>>  {
>> -	if (num >= ARM64_NCAPS)
>> -		return false;
>> +	BUILD_BUG_ON(!__builtin_constant_p(num));
> 
> This is not needed, as the compilation would fail if num is not a constant with
> static key code.
> 
>> +	BUILD_BUG_ON(num >= ARM64_NCAPS);
>> +
> 
> Also, I think it would be good to return false for caps > the ARM64_NCAPS, in sync
> with the non-const version.

But what's the semantic? It means we're accessing a capability that
doesn't exist, which looks like a major bug in my book. Is there any
valid use case for this?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
