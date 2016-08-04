From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 4 Aug 2016 09:43:51 +0200
Subject: [PATCH 1/8] ARM: assembler: introduce adr_l,
 ldr_l and str_l macros
In-Reply-To: <20160803164940.GC7147@e103592.cambridge.arm.com>
References: <1470238730-30038-1-git-send-email-ard.biesheuvel@linaro.org>
 <1470238730-30038-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160803164940.GC7147@e103592.cambridge.arm.com>
Message-ID: <CAKv+Gu_QL_rtfkD90uD0DbqphY3ymPjinV4d57kpYKp7QyDcuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 August 2016 at 18:49, Dave Martin <Dave.Martin@arm.com> wrote:
> On Wed, Aug 03, 2016 at 05:38:43PM +0200, Ard Biesheuvel wrote:
>> Like arm64, ARM supports position independent code sequences that
>> produce symbol references with a greater reach than the ordinary
>> adr/ldr instructions.
>>
>> Introduce adr_l, that takes the address of a symbol in a PC relative
>> manner, and ldr_l/str_l that perform a 32-bit loads/stores from a
>> PC-relative offset.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm/include/asm/assembler.h | 59 ++++++++++++++++++++
>>  1 file changed, 59 insertions(+)
>>
>> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
>> index 4eaea2173bf8..e1450889f96b 100644
>> --- a/arch/arm/include/asm/assembler.h
>> +++ b/arch/arm/include/asm/assembler.h
>> @@ -512,4 +512,63 @@ THUMB(   orr     \reg , \reg , #PSR_T_BIT        )
>>  #endif
>>       .endm
>>
>> +/*
>> + * Pseudo-ops for PC-relative adr/ldr/str <reg>, <symbol> operations
>> + */
>> +
>> +     /*
>> +      * @dst: destination register
>> +      * @sym: name of the symbol
>> +      */
>> +     .macro  adr_l, dst, sym
>> +#ifdef CONFIG_THUMB2_KERNEL
>> +     movw    \dst, #:lower16:(\sym) - (. + 12)
>> +     movt    \dst, #:upper16:(\sym) - (. + 8)
>> +     add     \dst, \dst, pc
>
> pc always reads as the address of that add plus 4, right?  I remember
> some special case where it gets rounded down to a 4-byte boundary, but
> IIRC that only applies to certain ldr ..., [pc, ...] forms.
>
>> +#else
>> +     add     \dst, pc, #:pc_g0_nc:(\sym) - 8
>> +     add     \dst, \dst, #:pc_g1_nc:(\sym) - 4
>> +     add     \dst, \dst, #:pc_g2:(\sym)
>
> Whoah.  I've never seen this syntax before...  does this work for any
> named reloc, or just for certain blessed relocs?  (I'm also _assuming_
> the assembler support for this functionality is ancient -- if not,
> there may be toolchain compatibility issues.)
>

(Missed this question in my first reply)

There is no 1:1 mapping between these tokens and the actual relocs.
For instance, pc_g2 will be converted into

R_ARM_ALU_PC_G2 for an add instruction
R_ARM_LDR_PC_G2 for an ldr/str instruction
etc etc

so that means relocations have to be 'blessed' in some way, indeed.

You can still emit arbitrary relocs if you wanted, though, using the
.reloc pseudo op in GAS

-- 
Ard.
