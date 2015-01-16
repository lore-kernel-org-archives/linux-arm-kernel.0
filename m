From: dave.long@linaro.org (David Long)
Date: Fri, 16 Jan 2015 16:27:48 -0500
Subject: [PATCH v4 2/6] arm64: Add more test functions to insn.c
In-Reply-To: <CAHM4w1=nJVr8P-us8+E42kY9jpcWoRKWyd1ASzfsUpb-_DNPYw@mail.gmail.com>
References: <1420949002-3726-1-git-send-email-dave.long@linaro.org>	<1420949002-3726-3-git-send-email-dave.long@linaro.org>
 <CAHM4w1=nJVr8P-us8+E42kY9jpcWoRKWyd1ASzfsUpb-_DNPYw@mail.gmail.com>
Message-ID: <54B98254.1000204@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/15 04:32, Pratyush Anand wrote:
> On Sun, Jan 11, 2015 at 9:33 AM, David Long <dave.long@linaro.org> wrote:
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
>>   arch/arm64/include/asm/insn.h | 21 +++++++++++++++++++--
>>   arch/arm64/kernel/insn.c      | 18 ++++++++++++++++++
>>   2 files changed, 37 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
>> index e2ff32a..466afd4 100644
>> --- a/arch/arm64/include/asm/insn.h
>> +++ b/arch/arm64/include/asm/insn.h
>> @@ -223,8 +223,13 @@ static __always_inline bool aarch64_insn_is_##abbr(u32 code) \
>>   static __always_inline u32 aarch64_insn_get_##abbr##_value(void) \
>>   { return (val); }
>>
>> +__AARCH64_INSN_FUNCS(adr,      0x9F000000, 0x10000000)
>
> Should n't it be
> __AARCH64_INSN_FUNCS(adr_adrp,      0x1F000000, 0x10000000)
>
> So, that it also take care about adrp

Yes, that does look like a mistake.

>> +__AARCH64_INSN_FUNCS(prfm_lit, 0xFF000000, 0xD8000000)
>
> [...]
>
>>
>> +bool aarch64_insn_uses_literal(u32 insn)
>> +{
>> +       /* ldr/ldrsw (literal), prfm */
>> +
>> +       return aarch64_insn_is_ldr_lit(insn) ||
>> +               aarch64_insn_is_ldrsw_lit(insn) ||
>
> also aarch64_insn_is_adr_adrp(insn) ||
>

Yup.

>> +               aarch64_insn_is_prfm_lit(insn);
>> +}
>> +
>> +bool aarch64_insn_is_branch(u32 insn)
>> +{
>> +       /* b, bl, cb*, tb*, b.cond, br, blr */
>> +
>> +       return aarch64_insn_is_b_bl_cb_tb(insn) ||
>> +               aarch64_insn_is_br_blr(insn) ||
>
> also aarch64_insn_is_ret(insn) ||

The goal was to catch intructions that use a PC-relative branch, since 
the PC will not be what is expected.  Of course any instruction that 
changes the PC will have a problem too because the PC will be rewritten 
after the probe is completed.  So, yeah, this needs to be fixed.

>> +               aarch64_insn_is_bcond(insn);
>> +}
>> +
>>   /*

-dl
