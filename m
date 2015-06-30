From: dave.long@linaro.org (David Long)
Date: Mon, 29 Jun 2015 20:06:45 -0400
Subject: [PATCH v7 2/7] arm64: Add more test functions to insn.c
In-Reply-To: <CAPvkgC3epBSKmPPMxkrfiouFOr_1F=DLHGZ6ELSuDvZuFnQ_vg@mail.gmail.com>
References: <1434395229-6654-1-git-send-email-dave.long@linaro.org>	<1434395229-6654-3-git-send-email-dave.long@linaro.org>
 <CAPvkgC3epBSKmPPMxkrfiouFOr_1F=DLHGZ6ELSuDvZuFnQ_vg@mail.gmail.com>
Message-ID: <5591DD95.1060107@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/29/15 13:23, Steve Capper wrote:
> Hi David,
> Some comments below.
>
> On 15 June 2015 at 20:07, David Long <dave.long@linaro.org> wrote:
>> From: "David A. Long" <dave.long@linaro.org>
>>
>> Certain instructions are hard to execute correctly out-of-line (as in
>> kprobes).  Test functions are added to insn.[hc] to identify these.  The
>> instructions include any that use PC-relative addressing, change the PC,
>> or change interrupt masking. For efficiency and simplicity test
>> functions are also added for small collections of related instructions.
>>
>> Signed-off-by: David A. Long <dave.long@linaro.org>
>> ---
>>   arch/arm64/include/asm/insn.h | 18 ++++++++++++++++++
>>   arch/arm64/kernel/insn.c      | 28 ++++++++++++++++++++++++++++
>>   2 files changed, 46 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
>> index f81b328..1fdd237 100644
>> --- a/arch/arm64/include/asm/insn.h
>> +++ b/arch/arm64/include/asm/insn.h
>> @@ -223,8 +223,13 @@ static __always_inline bool aarch64_insn_is_##abbr(u32 code) \
>>   static __always_inline u32 aarch64_insn_get_##abbr##_value(void) \
>>   { return (val); }
>>
>> +__AARCH64_INSN_FUNCS(adr_adrp, 0x1F000000, 0x10000000)
>> +__AARCH64_INSN_FUNCS(prfm_lit, 0xFF000000, 0xD8000000)
>>   __AARCH64_INSN_FUNCS(str_reg,  0x3FE0EC00, 0x38206800)
>>   __AARCH64_INSN_FUNCS(ldr_reg,  0x3FE0EC00, 0x38606800)
>> +__AARCH64_INSN_FUNCS(ldr_lit,  0xBF000000, 0x18000000)
>> +__AARCH64_INSN_FUNCS(ldrsw_lit,        0xFF000000, 0x98000000)
>> +__AARCH64_INSN_FUNCS(exclusive,        0x3F000000, 0x08000000)
>
> Going one step back, if we're worried about the exclusive monitors
> then we'll be worried about instructions in-between the monitor pairs
> too?
>

Yes, but I don't see anything we can reasonably do about that.

>
>>   __AARCH64_INSN_FUNCS(stp_post, 0x7FC00000, 0x28800000)
>>   __AARCH64_INSN_FUNCS(ldp_post, 0x7FC00000, 0x28C00000)
>>   __AARCH64_INSN_FUNCS(stp_pre,  0x7FC00000, 0x29800000)
>> @@ -264,19 +269,29 @@ __AARCH64_INSN_FUNCS(ands,        0x7F200000, 0x6A000000)
>>   __AARCH64_INSN_FUNCS(bics,     0x7F200000, 0x6A200000)
>>   __AARCH64_INSN_FUNCS(b,                0xFC000000, 0x14000000)
>>   __AARCH64_INSN_FUNCS(bl,       0xFC000000, 0x94000000)
>> +__AARCH64_INSN_FUNCS(b_bl,     0x7C000000, 0x14000000)
>> +__AARCH64_INSN_FUNCS(cb,       0x7E000000, 0x34000000)
>>   __AARCH64_INSN_FUNCS(cbz,      0x7F000000, 0x34000000)
>>   __AARCH64_INSN_FUNCS(cbnz,     0x7F000000, 0x35000000)
>> +__AARCH64_INSN_FUNCS(tb,       0x7E000000, 0x36000000)
>>   __AARCH64_INSN_FUNCS(tbz,      0x7F000000, 0x36000000)
>>   __AARCH64_INSN_FUNCS(tbnz,     0x7F000000, 0x37000000)
>> +__AARCH64_INSN_FUNCS(b_bl_cb_tb, 0x5C000000, 0x14000000)
>>   __AARCH64_INSN_FUNCS(bcond,    0xFF000010, 0x54000000)
>>   __AARCH64_INSN_FUNCS(svc,      0xFFE0001F, 0xD4000001)
>>   __AARCH64_INSN_FUNCS(hvc,      0xFFE0001F, 0xD4000002)
>>   __AARCH64_INSN_FUNCS(smc,      0xFFE0001F, 0xD4000003)
>>   __AARCH64_INSN_FUNCS(brk,      0xFFE0001F, 0xD4200000)
>> +__AARCH64_INSN_FUNCS(exception,        0xFF000000, 0xD4000000)
>>   __AARCH64_INSN_FUNCS(hint,     0xFFFFF01F, 0xD503201F)
>>   __AARCH64_INSN_FUNCS(br,       0xFFFFFC1F, 0xD61F0000)
>>   __AARCH64_INSN_FUNCS(blr,      0xFFFFFC1F, 0xD63F0000)
>> +__AARCH64_INSN_FUNCS(br_blr,   0xFFDFFC1F, 0xD61F0000)
>>   __AARCH64_INSN_FUNCS(ret,      0xFFFFFC1F, 0xD65F0000)
>> +__AARCH64_INSN_FUNCS(msr_imm,  0xFFF8F000, 0xD5004000)
>
> Should this not be:
> __AARCH64_INSN_FUNCS(msr_imm,  0xFFF8F01F, 0xD500401F)
> As the lower 5 bits of an MSR (immediate) are all 1?
>

Yeah, that does look more correct.

>> +__AARCH64_INSN_FUNCS(msr_reg,  0xFFF00000, 0xD5100000)
>> +__AARCH64_INSN_FUNCS(set_clr_daif, 0xFFFFF0DF, 0xD50340DF)
>
> Looks good, just an MSR immediate with either DAIFSet or DAIFClr.
>
>> +__AARCH64_INSN_FUNCS(rd_wr_daif, 0xFFDFFFE0, 0xD51B4220)
>
> Looks good, either MRS or MSR (register) where systemreg = DAIF.
>
>>
>>   #undef __AARCH64_INSN_FUNCS
>>
>> @@ -285,6 +300,9 @@ bool aarch64_insn_is_nop(u32 insn);
>>   int aarch64_insn_read(void *addr, u32 *insnp);
>>   int aarch64_insn_write(void *addr, u32 insn);
>>   enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
>> +bool aarch64_insn_uses_literal(u32 insn);
>> +bool aarch64_insn_is_branch(u32 insn);
>> +bool aarch64_insn_is_daif_access(u32 insn);
>>   u64 aarch64_insn_decode_immediate(enum aarch64_insn_imm_type type, u32 insn);
>>   u32 aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
>>                                    u32 insn, u64 imm);
>> diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
>> index 9249020..ecd8882 100644
>> --- a/arch/arm64/kernel/insn.c
>> +++ b/arch/arm64/kernel/insn.c
>> @@ -155,6 +155,34 @@ static bool __kprobes __aarch64_insn_hotpatch_safe(u32 insn)
>>                  aarch64_insn_is_nop(insn);
>>   }
>>
>> +bool __kprobes aarch64_insn_uses_literal(u32 insn)
>> +{
>> +       /* ldr/ldrsw (literal), prfm */
>> +
>> +       return aarch64_insn_is_ldr_lit(insn) ||
>> +               aarch64_insn_is_ldrsw_lit(insn) ||
>> +               aarch64_insn_is_adr_adrp(insn) ||
>> +               aarch64_insn_is_prfm_lit(insn);
>> +}
>> +
>> +bool __kprobes aarch64_insn_is_branch(u32 insn)
>> +{
>> +       /* b, bl, cb*, tb*, b.cond, br, blr */
>> +
>> +       return aarch64_insn_is_b_bl_cb_tb(insn) ||
>> +               aarch64_insn_is_br_blr(insn) ||
>> +               aarch64_insn_is_ret(insn) ||
>> +               aarch64_insn_is_bcond(insn);
>> +}
>> +
>> +bool __kprobes aarch64_insn_is_daif_access(u32 insn)
>> +{
>> +       /* msr daif, mrs daif, msr daifset, msr daifclr */
>> +
>> +       return aarch64_insn_is_rd_wr_daif(insn) ||
>> +               aarch64_insn_is_set_clr_daif(insn);
>> +}
>> +
>>   /*
>>    * ARM Architecture Reference Manual for ARMv8 Profile-A, Issue A.a
>>    * Section B2.6.5 "Concurrent modification and execution of instructions":
>> --
>> 1.8.1.2
>>
