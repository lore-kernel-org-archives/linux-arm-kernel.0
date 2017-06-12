From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 12 Jun 2017 11:09:18 +0200
Subject: [PATCH v2] arm: boot/compressed: fix decompressor header layout
 for v7-M
In-Reply-To: <016d10ff-72f1-231f-9bf1-a74cd09f3038@suse.de>
References: <1495353041-24171-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu9U2n7dUjWCyYYNQy_Ta_YDM0ubTa7e-zkEzBZmoWEs9g@mail.gmail.com>
 <016d10ff-72f1-231f-9bf1-a74cd09f3038@suse.de>
Message-ID: <CAKv+Gu_SA2tZtELNVv2gh-NYL4PGyaYiexPPUc9osioMjauLsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 June 2017 at 01:09, Andreas F?rber <afaerber@suse.de> wrote:
> Am 24.05.2017 um 16:34 schrieb Ard Biesheuvel:
>> On 21 May 2017 at 00:50, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>> As reported by Patrice, the header layout of the decompressor is
>>> incorrect when building for v7-M. In this case, the __nop macro
>>> resolves to 'mov r0, r0', which is emitted as a narrow encoding,
>>> resulting in the header data fields to end up at lower offsets than
>>> required.
>>>
>>> Given the variety of targets we need to support with the same code,
>>> the startup sequence is a bit of a jumble, and uses instructions
>>> and macros whose encoding width cannot be specified (badr), or only
>>> exists in a narrow encoding (bx)
>>>
>>> So force the use of a wide encoding in __nop, and replace the start
>>> sequence with a simple jump to the label marking the start of code,
>>> preceded by a Thumb2 mode switch if required (using explicit wide
>>> encodings where appropriate). The label itself can be moved to the
>>> start of code [where it belongs] due to the larger range of branch
>>> instructions as compared to adr instructions.
>>>
>>> Reported-by: Patrice CHOTARD <patrice.chotard@st.com>
>>> Acked-by: Nicolas Pitre <nico@linaro.org>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> ---
>>> v2: use #ifdefs to simplify the code
>>>     add Nico's ack
>>>
>>>  arch/arm/boot/compressed/efi-header.S |  4 +---
>>>  arch/arm/boot/compressed/head.S       | 17 ++++++++++-------
>>>  2 files changed, 11 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/compressed/efi-header.S b/arch/arm/boot/compressed/efi-header.S
>>> index 9d5dc4fda3c1..3f7d1b74c5e0 100644
>>> --- a/arch/arm/boot/compressed/efi-header.S
>>> +++ b/arch/arm/boot/compressed/efi-header.S
>>> @@ -17,14 +17,12 @@
>>>                 @ there.
>>>                 .inst   'M' | ('Z' << 8) | (0x1310 << 16)   @ tstne r0, #0x4d000
>>>  #else
>>> -               mov     r0, r0
>>> +               W(mov)  r0, r0
>
> This change broke v7-A build...
>

Yeah, Arnd already reported the same thing. I have dropped a fix into
Russell's patch tracker already.

Apologies for the breakage,
Ard.


>>>  #endif
>>>                 .endm
>>>
>>>                 .macro  __EFI_HEADER
>>>  #ifdef CONFIG_EFI_STUB
>>> -               b       __efi_start
>>> -
>>>                 .set    start_offset, __efi_start - start
>>>                 .org    start + 0x3c
>>>                 @
>>> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
>>> index 7c711ba61417..8a756870c238 100644
>>> --- a/arch/arm/boot/compressed/head.S
>>> +++ b/arch/arm/boot/compressed/head.S
>>> @@ -130,19 +130,22 @@ start:
>>>                 .rept   7
>>>                 __nop
>
> Here the macro is called in ARM mode for A/R, resulting in:
>
> arch/arm/boot/compressed/head.S: Assembler messages:
> arch/arm/boot/compressed/head.S:132: Error: width suffixes are invalid
> in ARM mode -- `mov.w r0,r0'
> arch/arm/boot/compressed/head.S:132: Error: width suffixes are invalid
> in ARM mode -- `mov.w r0,r0'
> arch/arm/boot/compressed/head.S:132: Error: width suffixes are invalid
> in ARM mode -- `mov.w r0,r0'
> arch/arm/boot/compressed/head.S:132: Error: width suffixes are invalid
> in ARM mode -- `mov.w r0,r0'
> arch/arm/boot/compressed/head.S:132: Error: width suffixes are invalid
> in ARM mode -- `mov.w r0,r0'
> arch/arm/boot/compressed/head.S:132: Error: width suffixes are invalid
> in ARM mode -- `mov.w r0,r0'
> arch/arm/boot/compressed/head.S:132: Error: width suffixes are invalid
> in ARM mode -- `mov.w r0,r0'
>
> Regards,
> Andreas
>
>>>                 .endr
>>> -   ARM(                mov     r0, r0          )
>>> -   ARM(                b       1f              )
>>> - THUMB(                badr    r12, 1f         )
>>> - THUMB(                bx      r12             )
>>> +#ifndef CONFIG_THUMB2_KERNEL
>>> +               mov     r0, r0
>>> +#else
>>> + AR_CLASS(     sub     pc, pc, #3      )       @ A/R: switch to Thumb2 mode
>>> +  M_CLASS(     nop.w                   )       @ M: already in Thumb2 mode
>>> +               .thumb
>>> +#endif
>>> +               W(b)    1f
>>>
>>>                 .word   _magic_sig      @ Magic numbers to help the loader
>>>                 .word   _magic_start    @ absolute load/run zImage address
>>>                 .word   _magic_end      @ zImage end address
>>>                 .word   0x04030201      @ endianness flag
>>>
>>> - THUMB(                .thumb                  )
>>> -1:             __EFI_HEADER
>>> -
>>> +               __EFI_HEADER
>>> +1:
>>>   ARM_BE8(      setend  be              )       @ go BE8 if compiled for BE8
>>>   AR_CLASS(     mrs     r9, cpsr        )
>>>  #ifdef CONFIG_ARM_VIRT_EXT
>>> --
>>> 2.7.4
>>>
>>
>> I have dropped this into the patch system as 8677/1
>>
>> I will leave it up to the maintainer to decide whether this should go
>> to -stable or not, so I have submitted the patch without a Cc:stable
>> tag
>
> --
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
> GF: Felix Imend?rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N?rnberg)
