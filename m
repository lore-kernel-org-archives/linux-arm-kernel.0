From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 15 Oct 2015 11:45:27 +0100
Subject: [PATCH v3 09/24] arm64: Keep track of CPU feature registers
In-Reply-To: <20151015103611.GK4239@e104818-lin.cambridge.arm.com>
References: <1444756952-31145-1-git-send-email-suzuki.poulose@arm.com>
 <1444756952-31145-10-git-send-email-suzuki.poulose@arm.com>
 <20151015103611.GK4239@e104818-lin.cambridge.arm.com>
Message-ID: <561F83C7.9090500@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/10/15 11:36, Catalin Marinas wrote:
> Hi Suzuki,
>
> Some minor comments below.

>> The feature bits are classified as one of SCALAR_MIN, SCALAR_MAX and DISCRETE
>> depending on the implication of the possible values. This information
>> is used to decide the safe value for a feature.
>>
>
> The "SCALAR..." etc. in the comment needs updating.

Sorry about that. Will fix it.

>
>> +#define FTR_STRICT	true
>> +#define FTR_NONSTRICT	false
>
> Please add a comment on what STRICT/NONSTRICT mean.
>

Sure

>> +static inline u64 ftr_mask(struct arm64_ftr_bits *ftrp)
>> +{
>> +	return (u64)GENMASK(ftrp->shift + ftrp->width - 1, ftrp->shift);
>> +}
>> +
>> +static inline s64 arm64_ftr_value(struct arm64_ftr_bits *ftrp, u64 val)
>> +{
>> +	return cpuid_feature_extract_field_width(val, ftrp->shift, ftrp->width);
>> +}
>
> Slightly inconsistent naming: since you are prefixing everything with
> arm64_, do the same for ftr_mask.

OK, will add it.

>
>> +static struct arm64_ftr_reg arm64_ftr_regs[] = {
>> +
>> +	/* This array should be always kept in the ascending order of id  */
>
> Do we have a sanity check somewhere? You could also call sort() on this
> array and we wouldn't have to worry.

No we don't have a sanity check. I will take a look.

>
>> +/*
>> + * get_arm64_sys_reg - Lookup a feature register entry using its
>> + * sys_reg() encoding. With the array arm64_ftr_regs sorted in the
>> + * ascending order, we use binary search to find a matching entry.
>> + *
>> + * returns - Upon success,  matching ftr_reg entry for id.
>> + *         - NULL on failure. It is upto the caller to decide
>> + *	     the impact of a failure.
>> + */
>> +static struct arm64_ftr_reg* get_arm64_sys_reg(u32 sys_id)
>
> Nitpick: the * near the function name.
>
> Also rename it to get_arm64_ftr_reg() to match the actual return type.
>

Sure, will fix all of these. Thanks for the detailed look
