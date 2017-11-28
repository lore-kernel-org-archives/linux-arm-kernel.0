From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 28 Nov 2017 18:41:42 +0000
Subject: [PATCH v3 1/2] arm64: module-plts: factor out PLT generation code
 for ftrace
In-Reply-To: <20171128183009.GM9266@arm.com>
References: <20171120174130.28626-1-ard.biesheuvel@linaro.org>
 <20171128183009.GM9266@arm.com>
Message-ID: <CAKv+Gu9Ymts-_Jm-GNuhfkqm_cYSke2Y_DF_ktvrdOrfyksewg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 November 2017 at 18:30, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Nov 20, 2017 at 05:41:29PM +0000, Ard Biesheuvel wrote:
>> To allow the ftrace trampoline code to reuse the PLT entry routines,
>> factor it out and move it into asm/module.h.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>> v3: new patch
>>
>>  arch/arm64/include/asm/module.h | 44 ++++++++++++++++++++
>>  arch/arm64/kernel/module-plts.c | 38 +----------------
>>  2 files changed, 46 insertions(+), 36 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
>> index 19bd97671bb8..11d4aaee82e1 100644
>> --- a/arch/arm64/include/asm/module.h
>> +++ b/arch/arm64/include/asm/module.h
>> @@ -45,4 +45,48 @@ extern u64 module_alloc_base;
>>  #define module_alloc_base    ((u64)_etext - MODULES_VSIZE)
>>  #endif
>>
>> +struct plt_entry {
>> +     /*
>> +      * A program that conforms to the AArch64 Procedure Call Standard
>> +      * (AAPCS64) must assume that a veneer that alters IP0 (x16) and/or
>> +      * IP1 (x17) may be inserted at any branch instruction that is
>> +      * exposed to a relocation that supports long branches. Since that
>> +      * is exactly what we are dealing with here, we are free to use x16
>> +      * as a scratch register in the PLT veneers.
>> +      */
>> +     __le32  mov0;   /* movn x16, #0x....                    */
>> +     __le32  mov1;   /* movk x16, #0x...., lsl #16           */
>> +     __le32  mov2;   /* movk x16, #0x...., lsl #32           */
>> +     __le32  br;     /* br   x16                             */
>> +};
>> +
>> +static inline struct plt_entry get_plt_entry(u64 val)
>> +{
>> +     /*
>> +      * MOVK/MOVN/MOVZ opcode:
>> +      * +--------+------------+--------+-----------+-------------+---------+
>> +      * | sf[31] | opc[30:29] | 100101 | hw[22:21] | imm16[20:5] | Rd[4:0] |
>> +      * +--------+------------+--------+-----------+-------------+---------+
>> +      *
>> +      * Rd     := 0x10 (x16)
>> +      * hw     := 0b00 (no shift), 0b01 (lsl #16), 0b10 (lsl #32)
>> +      * opc    := 0b11 (MOVK), 0b00 (MOVN), 0b10 (MOVZ)
>> +      * sf     := 1 (64-bit variant)
>> +      */
>> +     return (struct plt_entry){
>> +             cpu_to_le32(0x92800010 | (((~val      ) & 0xffff)) << 5),
>> +             cpu_to_le32(0xf2a00010 | ((( val >> 16) & 0xffff)) << 5),
>> +             cpu_to_le32(0xf2c00010 | ((( val >> 32) & 0xffff)) << 5),
>> +             cpu_to_le32(0xd61f0200)
>> +     };
>> +}
>
> Not one for this series, but do you think we could use insn.c to generate
> these?
>

I think we could, yes. Another question is whether/when we need to fix
this code for 52-bit VAs, so that may be an appropriate time to
revisit the implementation (unless the kernel will never use that many
bits)
