From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 7 Feb 2018 17:01:53 +0000
Subject: [PATCH v2 07/20] arm64: capabilities: Filter the entries based on
 a given mask
In-Reply-To: <20180207103821.GX5862@e103592.cambridge.arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-8-suzuki.poulose@arm.com>
 <20180207103821.GX5862@e103592.cambridge.arm.com>
Message-ID: <ca7b79b2-f275-7413-a8f0-01925935a692@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/18 10:38, Dave Martin wrote:
> On Wed, Jan 31, 2018 at 06:27:54PM +0000, Suzuki K Poulose wrote:
>> While processing the list of capabilities, it is useful to
>> filter out some of the entries based on the given mask for the
>> scope of the capabilities to allow better control. This can be
>> used later for handling LOCAL vs SYSTEM wide capabilities and more.
>> All capabilities should have their scope set to either LOCAL_CPU or
>> SYSTEM. No functional/flow change.
>>
>> Cc: Dave Martin <dave.martin@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   arch/arm64/include/asm/cpufeature.h |  2 ++
>>   arch/arm64/kernel/cpufeature.c      | 35 ++++++++++++++++++++++++-----------
>>   2 files changed, 26 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
>> index 69b5ce366598..cda62b70d338 100644
>> --- a/arch/arm64/include/asm/cpufeature.h
>> +++ b/arch/arm64/include/asm/cpufeature.h
>> @@ -198,6 +198,8 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
>>   /* Is it safe for a late CPU to miss this capability when system has it */
>>   #define ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU	((u16)BIT(5))
>>   
>> +#define ARM64_CPUCAP_SCOPE_ALL			 \
>> +	(ARM64_CPUCAP_SCOPE_LOCAL_CPU | ARM64_CPUCAP_SCOPE_SYSTEM)
> 
> Perhaps we could just use _MASK rather than having a separate #define,
> but it's good either way.
> 
> Is there a situation in which _ALL and _MASK would need to be
> different?

No, it just makes it easier to read the code. I have switched to:

>> -static bool __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps_list)
>> +static bool __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps_list,
>> +				    u16 scope_mask)
>>   {
>>   	bool cpu_has_cap, system_has_cap;
>>   	const struct arm64_cpu_capabilities *caps = caps_list;
>>   
>> +	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
>>   	for (; caps->matches; caps++) {
>> +
> 
> Nit: extra blank line?

Fixed.

> 
> [...]
> 
> With that fixed,
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Thanks
Suzuki
