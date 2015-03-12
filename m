From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 12 Mar 2015 22:15:08 +0100
Subject: [RFT/RFC PATCH 3/6] ARM: add macro to perform far branches (b/bl)
In-Reply-To: <alpine.LFD.2.11.1503121644180.27567@knanqh.ubzr>
References: <1426181892-15440-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426181892-15440-4-git-send-email-ard.biesheuvel@linaro.org>
 <alpine.LFD.2.11.1503121625401.27567@knanqh.ubzr>
 <CAKv+Gu9Jcvr2QsWiwHY9ddcLwaHGUyBLBNzUB5voDXJpD8KLKA@mail.gmail.com>
 <alpine.LFD.2.11.1503121644180.27567@knanqh.ubzr>
Message-ID: <CAKv+Gu8KegZBvE8sNAY6tnrOSEE7zxRzf8JywPxbHYL_fjJDwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 March 2015 at 22:03, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Thu, 12 Mar 2015, Ard Biesheuvel wrote:
>
>> On 12 March 2015 at 21:32, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>> > On Thu, 12 Mar 2015, Ard Biesheuvel wrote:
>> >
>> >> These macros execute PC-relative branches, but with a larger
>> >> reach than the 24 bits that are available in the b and bl opcodes.
>> >>
>> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> >> ---
>> >>  arch/arm/include/asm/assembler.h | 29 +++++++++++++++++++++++++++++
>> >>  1 file changed, 29 insertions(+)
>> >>
>> >> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
>> >> index f67fd3afebdf..bd08c3c1b73f 100644
>> >> --- a/arch/arm/include/asm/assembler.h
>> >> +++ b/arch/arm/include/asm/assembler.h
>> >> @@ -108,6 +108,35 @@
>> >>       .endm
>> >>  #endif
>> >>
>> >> +     /*
>> >> +      * Macros to emit relative branches that may exceed the range
>> >> +      * of the 24-bit immediate of the ordinary b/bl instructions.
>> >> +      * NOTE: this doesn't work with locally defined symbols, as they
>> >> +      * might lack the ARM/Thumb annotation (even if they are annotated
>> >> +      * as functions)
>> >
>> > I really hope you won't need a far call with local symbols ever!
>> >
>>
>> Well, if you use pushsection/popsection, then local, numbered labels
>> you refer to can be quite far away in the output image, and those will
>> not have the thumb bit set.
>
> Indeed.
>
>> >> +      */
>> >> +     .macro  b_far, target, tmpreg
>> >> +#if defined(CONFIG_CPU_32v7) || defined(CONFIG_CPU_32v7M)
>> >> + ARM(        movt    \tmpreg, #:upper16:(\target - (8888f + 8))      )
>> >> + ARM(        movw    \tmpreg, #:lower16:(\target - (8888f + 8))      )
>> >> + THUMB(      movt    \tmpreg, #:upper16:(\target - (8888f + 4))      )
>> >> + THUMB(      movw    \tmpreg, #:lower16:(\target - (8888f + 4))      )
>> >> +8888:        add     pc, pc, \tmpreg
>> >> +#else
>> >> +     ldr     \tmpreg, 8889f
>> >> +8888:        add     pc, pc, \tmpreg
>> >> +     .align  2
>> >> +8889:
>> >> + ARM(        .word   \target - (8888b + 8)           )
>> >
>> > The Thumb relocation value is missing here.
>> >
>>
>> Yes, this is bogus. But Thumb2 implies v7 or v7m, so it is not
>> actually incorrect in this case.
>
> The ".align 2" would be redundant in that case too.
>

Correct, the #else bit is essentially ARM only

>> But I will fix it in the next version
>
> Is it worth optimizing the ARM mode with movw/movt on ARMv7?  If not
> then this could be simplified as only:
>
>              .macro  b_far, target, tmpreg
>  THUMB(      movt    \tmpreg, #:upper16:(\target - (8888f + 4))      )
>  THUMB(      movw    \tmpreg, #:lower16:(\target - (8888f + 4))      )
>  ARM(        ldr     \tmpreg, 8888f+4                                )
>  8888:       add     pc, pc, \tmpreg
>  ARM(        .word   \target - (8888b + 8)           )
>              .endm
>

movw/movt is preferred if available, since it circumvents the D-cache.
And actually, I should rewrite the bl_far macro for v7 to use blx
instead of adr+ldr to make better use of the return stack predictor or
whatever it is called in the h/w

And, as Russell points out, I should put a PC_BIAS #define somewhere
that assumes the correct value for the used mode, instead of the +4/+8
immediates.

So I am thinking along the lines of

.macro  b_far, target, tmpreg
#if defined(CONFIG_CPU_32v7) || defined(CONFIG_CPU_32v7M)
movt \tmpreg, #:upper16:(\target - (8888f + PC_BIAS))
movw \tmpreg, #:lower16:(\target - (8888f + PC_BIAS))
8888: add pc, pc, \tmpreg
#else
ldr \tmpreg, =\target - (8888f + PC_BIAS)
8888: add pc, pc, \tmpreg
#endif
.endm

.macro bl_far, target, tmpreg=ip
#if defined(CONFIG_CPU_32v7) || defined(CONFIG_CPU_32v7M)
movt \tmpreg, #:upper16:(\target - (8887f + PC_BIAS))
movw \tmpreg, #:lower16:(\target - (8887f + PC_BIAS))
8887: add \tmpreg, \tmpreg, pc
blx \tmpreg
#else
adr lr, BSYM(8887f)
b_far \target, \tmpreg
8887:
#endif
.endm
