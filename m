From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 10 Dec 2015 16:10:43 +0900
Subject: [PATCH v6 4/6] arm64: insn: add instruction decoders for ldp/stp
 and add/sub
In-Reply-To: <20151208181517.GF27393@arm.com>
References: <1447828989-4980-1-git-send-email-takahiro.akashi@linaro.org>
 <1447828989-4980-5-git-send-email-takahiro.akashi@linaro.org>
 <20151208181517.GF27393@arm.com>
Message-ID: <56692573.5020705@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

I was back from my vacation.

On 12/09/2015 03:15 AM, Will Deacon wrote:
> On Wed, Nov 18, 2015 at 03:43:07PM +0900, AKASHI Takahiro wrote:
>> A function prologue analyzer is a requisite for implementing stack tracer
>> and getting better views of stack usages on arm64.
>> To implement a function prologue analyzer, we have to be able to decode,
>> at least, stp, add, sub and mov instructions.
>>
>> This patch adds decoders for those instructions, that are used solely
>> by stack tracer for now, but generic enough for other uses.
>>
>> Reviewed-by: Jungseok Lee <jungseoklee85@gmail.com>
>> Tested-by: Jungseok Lee <jungseoklee85@gmail.com>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> ---
>>   arch/arm64/include/asm/insn.h |   18 ++++++++
>>   arch/arm64/kernel/insn.c      |  102 +++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 120 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
>> index 30e50eb..8d5c538 100644
>> --- a/arch/arm64/include/asm/insn.h
>> +++ b/arch/arm64/include/asm/insn.h
>> @@ -165,6 +165,8 @@ enum aarch64_insn_ldst_type {
>>   	AARCH64_INSN_LDST_STORE_PAIR_PRE_INDEX,
>>   	AARCH64_INSN_LDST_LOAD_PAIR_POST_INDEX,
>>   	AARCH64_INSN_LDST_STORE_PAIR_POST_INDEX,
>> +	AARCH64_INSN_LDST_LOAD_PAIR,
>> +	AARCH64_INSN_LDST_STORE_PAIR,
>
> For consistency with the rest of this header, we should be calling these
> AARCH64_INSN_LDST_{LOAD,STORE}_PAIR_REG_OFFSET...

OK.
(But taking arguments of registers and offset is also common to _PRE_INDEX and _POST_INDEX cases).

>>   };
>>
>>   enum aarch64_insn_adsb_type {
>> @@ -225,6 +227,8 @@ static __always_inline u32 aarch64_insn_get_##abbr##_value(void) \
>>
>>   __AARCH64_INSN_FUNCS(str_reg,	0x3FE0EC00, 0x38206800)
>>   __AARCH64_INSN_FUNCS(ldr_reg,	0x3FE0EC00, 0x38606800)
>> +__AARCH64_INSN_FUNCS(stp,	0x7FC00000, 0x29000000)
>> +__AARCH64_INSN_FUNCS(ldp,	0x7FC00000, 0x29400000)
>
> ... and using stp_reg/ldp_reg here.

Ditto.

>>   __AARCH64_INSN_FUNCS(stp_post,	0x7FC00000, 0x28800000)
>>   __AARCH64_INSN_FUNCS(ldp_post,	0x7FC00000, 0x28C00000)
>>   __AARCH64_INSN_FUNCS(stp_pre,	0x7FC00000, 0x29800000)
>> @@ -277,6 +281,7 @@ __AARCH64_INSN_FUNCS(hint,	0xFFFFF01F, 0xD503201F)
>>   __AARCH64_INSN_FUNCS(br,	0xFFFFFC1F, 0xD61F0000)
>>   __AARCH64_INSN_FUNCS(blr,	0xFFFFFC1F, 0xD63F0000)
>>   __AARCH64_INSN_FUNCS(ret,	0xFFFFFC1F, 0xD65F0000)
>> +__AARCH64_INSN_FUNCS(eret,	0xFFFFFFFF, 0xD69F00E0)
>
> Is this encoding correct? I ended up with 0xd69f03e0.

Fixed it in v6.

>>   #undef	__AARCH64_INSN_FUNCS
>>
>> @@ -370,6 +375,19 @@ bool aarch32_insn_is_wide(u32 insn);
>>   u32 aarch32_insn_extract_reg_num(u32 insn, int offset);
>>   u32 aarch32_insn_mcr_extract_opc2(u32 insn);
>>   u32 aarch32_insn_mcr_extract_crm(u32 insn);
>> +int aarch64_insn_decode_add_sub_imm(u32 insn,
>> +				    enum aarch64_insn_register *dst,
>> +				    enum aarch64_insn_register *src,
>> +				    int *imm,
>> +				    enum aarch64_insn_variant *variant,
>> +				    enum aarch64_insn_adsb_type *type);
>> +int aarch64_insn_decode_load_store_pair(u32 insn,
>> +					enum aarch64_insn_register *reg1,
>> +					enum aarch64_insn_register *reg2,
>> +					enum aarch64_insn_register *base,
>> +					int *offset,
>> +					enum aarch64_insn_variant *variant,
>> +					enum aarch64_insn_ldst_type *type);
>>   #endif /* __ASSEMBLY__ */
>>
>>   #endif	/* __ASM_INSN_H */
>> diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
>> index c08b9ad..b56a66c 100644
>> --- a/arch/arm64/kernel/insn.c
>> +++ b/arch/arm64/kernel/insn.c
>> @@ -33,6 +33,7 @@
>>   #include <asm/insn.h>
>>
>>   #define AARCH64_INSN_SF_BIT	BIT(31)
>> +#define AARCH64_INSN_S_BIT	BIT(29)
>>   #define AARCH64_INSN_N_BIT	BIT(22)
>>
>>   static int aarch64_insn_encoding_class[] = {
>> @@ -1141,3 +1142,104 @@ u32 aarch32_insn_mcr_extract_crm(u32 insn)
>>   {
>>   	return insn & CRM_MASK;
>>   }
>> +
>> +enum aarch64_insn_register aarch64_insn_extract_reg_num(u32 insn,
>> +				enum aarch64_insn_register_type type)
>
> Maybe call this aarch64_insn_decode_register? You're basically building
> decoders for some of the *_encode_* functions we already have.

OK, will fix it.
But please note that there are already some functions named
aarch32_insn_extract_reg_num() et al.

>> +{
>> +	int shift;
>> +
>> +	switch (type) {
>> +	case AARCH64_INSN_REGTYPE_RT:
>> +	case AARCH64_INSN_REGTYPE_RD:
>> +		shift = 0;
>> +		break;
>> +	case AARCH64_INSN_REGTYPE_RN:
>> +		shift = 5;
>> +		break;
>> +	case AARCH64_INSN_REGTYPE_RT2:
>> +	case AARCH64_INSN_REGTYPE_RA:
>> +		shift = 10;
>> +		break;
>> +	case AARCH64_INSN_REGTYPE_RM:
>> +		shift = 16;
>> +		break;
>> +	default:
>> +		pr_err("%s: unknown register type decoding %d\n", __func__,
>> +		       type);
>> +		return ~0L;
>> +	}
>
> This is largely a copy-paste from aarch64_insn_encode_register. Can you
> either work with what we have or factor out the common parts, please?

OK, will re-factor it.

>> +	return (insn & (GENMASK(4, 0) << shift)) >> shift;
>> +}
>> +
>> +int aarch64_insn_decode_add_sub_imm(u32 insn,
>
> This one could be aarch64_insn_extract_add_sub_imm, if you like.
> Then extract is the converse of gen and decode is the converse of encode.

I agree, will change the name as you suggest.
But please see the comment above about aarch32_insn_extract_*.

>> +				    enum aarch64_insn_register *dst,
>> +				    enum aarch64_insn_register *src,
>> +				    int *imm,
>> +				    enum aarch64_insn_variant *variant,
>> +				    enum aarch64_insn_adsb_type *type)
>> +{
>> +	if (aarch64_insn_is_add_imm(insn))
>> +		*type =	((insn) & AARCH64_INSN_S_BIT) ?
>> +				AARCH64_INSN_ADSB_ADD_SETFLAGS :
>> +				AARCH64_INSN_ADSB_ADD;
>> +	else if (aarch64_insn_is_sub_imm(insn))
>> +		*type =	((insn) & AARCH64_INSN_S_BIT) ?
>> +				AARCH64_INSN_ADSB_SUB_SETFLAGS :
>> +				AARCH64_INSN_ADSB_SUB;
>> +	else
>> +		return 0;
>
> Why do we need to return 0 on error? -EINVAL might make more sense.

I think that, in most failure cases of *_gen_*, 0 will be returned.
See aarch64_insn_encode_immediate() and aach64_insn_encode_register().
But returning -EINVAL is also understandable. Will change so.

>> +
>> +	*variant = (insn & AARCH64_INSN_SF_BIT) ? AARCH64_INSN_VARIANT_64BIT :
>> +					AARCH64_INSN_VARIANT_32BIT;
>> +
>> +	*dst = aarch64_insn_extract_reg_num(insn, AARCH64_INSN_REGTYPE_RD);
>> +
>> +	*src = aarch64_insn_extract_reg_num(insn, AARCH64_INSN_REGTYPE_RN);
>> +
>> +	/* TODO: ignore shilft field[23:22] */
>
> I don't understand the TODO.

Haha, we don't have to interpret 'shift' in a function prologue usage,
but yes, will fix it for general cases.

>> +	*imm = (int)aarch64_insn_decode_immediate(AARCH64_INSN_IMM_12, insn);
>
> We use u64 for imm everywhere else.

Not true.
See aarch64_insn_gen_add_sub_imm(), _bitfield() and _movewide().

>> +	return 1;
>> +}

return 0;

> Similarly here, you're trying to implement the converse of
> aarch64_insn_gen_add_sub_imm

Will change the name.

>> +
>> +int aarch64_insn_decode_load_store_pair(u32 insn,
>> +					enum aarch64_insn_register *reg1,
>> +					enum aarch64_insn_register *reg2,
>> +					enum aarch64_insn_register *base,
>> +					int *offset,
>> +					enum aarch64_insn_variant *variant,
>> +					enum aarch64_insn_ldst_type *type)
>> +{
>> +	int imm;
>> +
>> +	if (aarch64_insn_is_stp(insn))
>> +		*type = AARCH64_INSN_LDST_STORE_PAIR;
>> +	else if (aarch64_insn_is_stp_post(insn))
>> +		*type = AARCH64_INSN_LDST_STORE_PAIR_POST_INDEX;
>> +	else if (aarch64_insn_is_stp_pre(insn))
>> +		*type = AARCH64_INSN_LDST_STORE_PAIR_PRE_INDEX;
>> +	else if (aarch64_insn_is_ldp(insn))
>> +		*type = AARCH64_INSN_LDST_LOAD_PAIR;
>> +	else if (aarch64_insn_is_ldp_post(insn))
>> +		*type = AARCH64_INSN_LDST_LOAD_PAIR_POST_INDEX;
>> +	else if (aarch64_insn_is_ldp_pre(insn))
>> +		*type = AARCH64_INSN_LDST_LOAD_PAIR_PRE_INDEX;
>> +	else
>> +		return 0;

return -EINVAL;

>> +	*variant = (insn & AARCH64_INSN_S_BIT) ? AARCH64_INSN_VARIANT_64BIT :
>> +				AARCH64_INSN_VARIANT_32BIT;
>> +
>> +	*reg1 = aarch64_insn_extract_reg_num(insn, AARCH64_INSN_REGTYPE_RT);
>> +
>> +	*reg2 = aarch64_insn_extract_reg_num(insn, AARCH64_INSN_REGTYPE_RT2);
>> +
>> +	*base = aarch64_insn_extract_reg_num(insn, AARCH64_INSN_REGTYPE_RN);
>> +
>> +	imm = (int)aarch64_insn_decode_immediate(AARCH64_INSN_IMM_7, insn);
>> +	asm("sbfm %0, %0, 0, 6" : "+r" (imm));
>
> What? Can't you write this in C?

OK, will use sign_extend64().

Thanks,
-Takahiro AKASHI

> Will
>
