From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 29 Mar 2018 09:54:31 +0100
Subject: [PATCH resend 1/2] arm64: assembler: add utility macros to
 push/pop stack frames
In-Reply-To: <20180328163452.GM16308@e103592.cambridge.arm.com>
References: <20180328124129.6459-1-ard.biesheuvel@linaro.org>
 <20180328124129.6459-2-ard.biesheuvel@linaro.org>
 <20180328163452.GM16308@e103592.cambridge.arm.com>
Message-ID: <CAKv+Gu9+c610HwdBOkhV3Z0nBePZZ+jf4_OTukRfEgCm0FNtFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 March 2018 at 17:34, Dave Martin <Dave.Martin@arm.com> wrote:
> On Wed, Mar 28, 2018 at 02:41:28PM +0200, Ard Biesheuvel wrote:
>> We are going to add code to all the NEON crypto routines that will
>> turn them into non-leaf functions, so we need to manage the stack
>> frames. To make this less tedious and error prone, add some macros
>> that take the number of callee saved registers to preserve and the
>
> Apologies for the delay in looking at these patches...
>
> Anyway:
>
> Nit: for all instances of "callee saved" in this patch, do you mean             "caller saved"?
>

'Caller saved' means that the caller needs to stack/unstack a register
itself if it needs its value to be preserved across a function call.
'Callee saved' means that the caller can rely on the callee to ensure
that the register will retain its value.

So we are dealing with the latter here, afaict. Or am I missing something?

> A few stylistic comments below, but I don't consider them essential to
> address unless someone feels like it.
>
> Otherwise,
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
>

Thanks.

>> extra size to allocate in the stack frame (for locals) and emit
>> the ldp/stp sequences.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/include/asm/assembler.h | 58 ++++++++++++++++++++
>>  1 file changed, 58 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
>> index 053d83e8db6f..d354eb7f2f0c 100644
>> --- a/arch/arm64/include/asm/assembler.h
>> +++ b/arch/arm64/include/asm/assembler.h
>> @@ -565,4 +565,62 @@ USER(\label, ic  ivau, \tmp2)                    // invalidate I line PoU
>>  #endif
>>       .endm
>>
>> +     /*
>> +      * frame_push - Push @regcount callee saved registers to the stack,
>> +      *              starting at x19, as well as x29/x30, and set x29 to
>> +      *              the new value of sp. Add @extra bytes of stack space
>> +      *              for locals.
>> +      */
>> +     .macro          frame_push, regcount:req, extra
>> +     __frame         st, \regcount, \extra
>> +     .endm
>> +
>> +     /*
>> +      * frame_pop  - Pop the callee saved registers from the stack that were
>> +      *              pushed in the most recent call to frame_push, as well
>> +      *              as x29/x30 and any extra stack space that may have been
>> +      *              allocated.
>> +      */
>> +     .macro          frame_pop
>> +     __frame         ld
>> +     .endm
>> +
>> +     .macro          __frame_regs, reg1, reg2, op, num
>> +     .if             .Lframe_regcount == \num
>> +     \op\()r         \reg1, [sp, #(\num + 1) * 8]
>> +     .elseif         .Lframe_regcount > \num
>> +     \op\()p         \reg1, \reg2, [sp, #(\num + 1) * 8]
>> +     .endif
>> +     .endm
>> +
>> +     .macro          __frame, op, regcount, extra=0
>> +     .ifc            \op, st
>> +     .if             (\regcount) < 0 || (\regcount) > 10
>> +     .error          "regcount should be in the range [0 ... 10]"
>> +     .endif
>> +     .if             ((\extra) % 16) != 0
>> +     .error          "extra should be a multiple of 16 bytes"
>> +     .endif
>> +     .set            .Lframe_regcount, \regcount
>> +     .set            .Lframe_extra, \extra
>> +     .set            .Lframe_local_offset, ((\regcount + 3) / 2) * 16
>> +     stp             x29, x30, [sp, #-.Lframe_local_offset - .Lframe_extra]!
>> +     mov             x29, sp
>> +     .endif
>> +
>> +     __frame_regs    x19, x20, \op, 1
>> +     __frame_regs    x21, x22, \op, 3
>> +     __frame_regs    x23, x24, \op, 5
>> +     __frame_regs    x25, x26, \op, 7
>> +     __frame_regs    x27, x28, \op, 9
>> +
>> +     .ifc            \op, ld
>> +     .if             .Lframe_regcount == -1
>
> We could also have
>
>         .ifc            \op, st
>         .ifdef          .Lframe_regcount
>         .if             .Lframe_regcount != -1
>         .error [...]
>
> on the push side, which would trip on the first nested frame_push
> rather than waiting until a frame_pop appears.
>
> Your existing code could be retained to guard against a double pop.
>

Nice. I'll try that.

>> +     .error          "frame_push/frame_pop may not be nested"
>> +     .endif
>> +     ldp             x29, x30, [sp], #.Lframe_local_offset + .Lframe_extra
>> +     .set            .Lframe_regcount, -1
>> +     .endif
>> +     .endm
>> +
>>  #endif       /* __ASM_ASSEMBLER_H */
>> --
>> 2.11.0
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
