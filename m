From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 8 Oct 2015 10:55:11 +0100
Subject: [PATCH v2 07/22] arm64: Keep track of CPU feature registers
In-Reply-To: <20151007171621.GD17192@e104818-lin.cambridge.arm.com>
References: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
 <1444064531-25607-8-git-send-email-suzuki.poulose@arm.com>
 <20151007171621.GD17192@e104818-lin.cambridge.arm.com>
Message-ID: <56163D7F.4000003@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/15 18:16, Catalin Marinas wrote:
> On Mon, Oct 05, 2015 at 06:01:56PM +0100, Suzuki K. Poulose wrote:
>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
>> index b5f313d..7ed92f2 100644
>> --- a/arch/arm64/include/asm/cpufeature.h
>> +++ b/arch/arm64/include/asm/cpufeature.h
>> @@ -35,6 +35,38 @@
>>
>>   #include <linux/kernel.h>
>>
>> +/* CPU feature register tracking */
>> +enum ftr_type {
>> +	FTR_DISCRETE,	/* Use a predefined safe value */
>> +	FTR_SCALAR_MIN,	/* Smaller value is safer */
>> +	FTR_SCALAR_MAX,	/* Bigger value is safer */
>> +};
>
> I think s/safer/safe/ sounds better, otherwise it looks like we are not
> entirely sure.

>
> BTW, I don't fully understand the name choosing here (e.g. discrete vs.
> scalar; a scalar type is also a discrete type). "MIN" looks to me like
> any higher value should be safe but instead the comment states "smaller
> value is safe". Maybe something like:
>
> 	FTR_EXACT
> 	FTR_LOWER_SAFE
> 	FTR_HIGHER_SAFE

OK, I will change them.


>
>> +
>> +#define FTR_STRICT	true
>> +#define FTR_NONSTRICT	false
>> +
>> +struct arm64_ftr_bits {
>> +	bool		strict;		/* CPU Sanity check
>> +					 *  strict matching required ? */
>
> I don't care about 80 characters line, especially around comments. So
> please place the comment on a single line.
>

OK

>> +struct arm64_ftr_reg {
>> +	u32			sys_id;
>> +	const char*		name;
>> +	u64			strict_mask;
>> +	u64			sys_val;
>> +	struct arm64_ftr_bits*	ftr_bits;
>> +};
>
> Move '*' near the struct member names, not the type.
>

Ok

>> +
>>   struct arm64_cpu_capabilities {
>>   	const char *desc;
>>   	u16 capability;
>> @@ -82,6 +114,22 @@ static inline int __attribute_const__ cpuid_feature_extract_field(u64 features,
>>   	return (s64)(features << (64 - 4 - field)) >> (64 - 4);
>>   }
>>
>> +static inline s64 __attribute_const__
>> +cpuid_feature_extract_field_width(u64 features, int field, u8 width)
>> +{
>> +	return (s64)(features << (64 - width - field)) >> (64 - width);
>> +}
>
> I think you should rewrite cpuid_feature_extract_field() in terms of the
> _width one (the latter being more generic).
>

OK, somehow, I was thinking that cpuid_feature_extract_field() could be
optimised by the compiler for a fixed width of for. Hence didn't change it.


>> +
>> +static inline u64 ftr_mask(struct arm64_ftr_bits *ftrp)
>> +{
>> +	return (u64) GENMASK(ftrp->shift + ftrp->width - 1, ftrp->shift);
>> +}
>
> Nitpick: remove the space after (u64).

OK

>
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 1ae8b24..d42ad90 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -58,8 +58,442 @@ static void update_mixed_endian_el0_support(struct cpuinfo_arm64 *info)
>>   	mixed_endian_el0 &= id_aa64mmfr0_mixed_endian_el0(info->reg_id_aa64mmfr0);
>>   }
>>
>> +#define ARM64_FTR_BITS(ftr_strict, ftr_type, ftr_shift, ftr_width, ftr_safe_val) \
>> +	{							\
>> +		.strict = ftr_strict,				\
>> +		.type = ftr_type,				\
>> +		.shift = ftr_shift,				\
>> +		.width = ftr_width,				\
>> +		.safe_val = ftr_safe_val,			\
>> +	}
>
> You can drop "ftr_" from all the arguments, it makes the macro
> definition shorter.

In fact I tried that before, but then the macro expansion will replace the
field names with the supplied values and hence won't compile. Either we
should change the field names or the values.

>
> [...]
>> +static struct arm64_ftr_bits ftr_id_pfr0[] = {
>> +	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 16, 16, 0),	// RAZ
>> +	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 12, 4, 0),	// State3
>> +	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 8, 4, 0),	// State2
>> +	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 4, 4, 0),	// State1
>> +	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 0, 4, 0),	// State0
>> +	ARM64_FTR_END,
>> +};
>
> Do we care about the RAZ/RAO fields? Or we use this later to check a new
> CPU's compatibility with the overall features?

Its just for sanity checks.

> Also, you captured lots of fields that Linux does not care about. Is it
> possible to ignore them altogether, only keep those which are relevant.
>

The list is entierly from the SANITY check. If there are any registers
that we think need not be cross checked, we could get rid of them.

  
>> +
>> +/*
>> + * get_arm6_sys_reg - Lookup a feature register entry using its
>
> arm64_...

yikes, thanks for spotting.

>
>> + * sys_reg() encoding.
>> + *
>> + * We track only the following space:
>> + * Op0 = 3, Op1 = 0, CRn = 0, CRm = [1 - 7], Op2 = [0 - 7]
>> + * Op0 = 3, Op1 = 3, CRn = 0, CRm = 0, Op2 = { 1, 7 } 	(CTR, DCZID)
>> + * Op0 = 3, Op1 = 3, CRn = 14, CRm = 0, Op2 = 0		(CNTFRQ)
>> + *
>> + * The space (3, 0, 0, {1-7}, {0-7}) is arranged in a 2D array op1_0,
>> + * indexed by CRm and Op2. Since not all CRm's have fully allocated Op2's
>> + * arm64_reg_table[CRm-1].n indicates the largest Op2 tracked for CRm.
>> + *
>> + * Since we have limited number of entries with Op1 = 3, we use linear search
>> + * to find the reg.
>> + *
>> + */
>> +static struct arm64_ftr_reg* get_arm64_sys_reg(u32 sys_id)
>> +{
>> +	int i;
>> +	u8 op2, crn, crm;
>> +	u8 op1 = sys_reg_Op1(sys_id);
>> +
>> +	if (sys_reg_Op0(sys_id) != 3)
>> +		return NULL;
>> +	switch (op1) {
>> +	case 0:
>> +
>> +		crm = sys_reg_CRm(sys_id);
>> +		op2 = sys_reg_Op2(sys_id);
>> +		crn = sys_reg_CRn(sys_id);
>> +		if (crn || !crm || crm > 7)
>> +			return NULL;
>> +		if (op2 < op1_0[crm - 1].n &&
>> +			op1_0[crm - 1].regs[op2].sys_id == sys_id)
>> +			return &op1_0[crm - 1].regs[op2];
>> +		return NULL;
>> +	case 3:
>> +		for (i = 0; i < ARRAY_SIZE(op1_3); i++)
>> +			if (op1_3[i].sys_id == sys_id)
>> +				return &op1_3[i];
>> +	}
>> +	return NULL;
>> +}
>
> For this function, do we ever expect to be called with an invalid
> sys_id? You could add a BUG_ON(!ret) here.
>

It could be called for an id which Reserved RAZ in the id range, we
plan to emulate. i.e, (3, 0, 0, [0-7], [0-7]).
See emulate_sys_reg(u32 id, u64 *valp) in Patch 20/22.
Since we don't track them, we return NULL here..
We could BUG_ON() all the other cases (e.g, MIDR and the other
classes).

Thanks for pointing that out.

> Is this function ever called on a hot path? If not, just keep everything
> in an array and do a linear search rather than having different arrays
> based on op*. Especially if we managed to limit the number of registers
> to only those that Linux cares about.

I started with linear array in the RFC post. But since then the number of
users for the API has gone up. Hence thought of optimising it. The only
'intensive' user is SANITY check for each register at CPU bring up.

>
> As a general coding style comment, I would much prefer to have a "ret"
> local variable and one or two points of return from a function rather
> than multiple returns. I've seen this as a general trend in your
> patches, so please fix.
>

...

>> +
>> +static s64 arm64_ftr_safe_value(struct arm64_ftr_bits *ftrp, s64 new, s64 cur)
>> +{
>> +	switch(ftrp->type) {
>> +	case FTR_DISCRETE:
>> +		return ftrp->safe_val;
>> +	case FTR_SCALAR_MIN:
>> +		return new < cur ? new : cur;
>> +	case FTR_SCALAR_MAX:
>> +		return new > cur ? new : cur;
>> +	}
>
> Same here about the returns.

Will fix it everywhere. Thanks for pointing out.

>
>> +static void update_cpu_ftr_reg(u32 sys_reg, u64 new)
>> +{
>> +	struct arm64_ftr_bits *ftrp;
>> +	struct arm64_ftr_reg *reg = get_arm64_sys_reg(sys_reg);
>> +
>> +	BUG_ON(!reg);
>> +
>> +	for(ftrp = reg->ftr_bits; ftrp->width; ftrp++) {
>> +		s64 ftr_cur = arm64_ftr_value(ftrp, reg->sys_val);
>> +		s64 ftr_new = arm64_ftr_value(ftrp, new);
>> +
>> +		if (ftr_cur == ftr_new)
>> +			continue;
>> +		/* Find a safe value */
>> +		ftr_new = arm64_ftr_safe_value(ftrp, ftr_new, ftr_cur);
>> +		reg->sys_val = arm64_ftr_set_value(ftrp, reg->sys_val, ftr_new);
>> +	}
>> +
>> +}
>> +
>> +/* Update CPU feature register from non-boot CPU */
>
> s/register from/registers for/

OK
