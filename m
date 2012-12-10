From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 10 Dec 2012 18:08:16 +0000
Subject: [PATCH] ARM: head: Remove boot-time HYP mode check for v5 and
 below
In-Reply-To: <20121210180235.GC1953@linaro.org>
References: <1354887959-14863-1-git-send-email-dave.martin@linaro.org>
 <20121210105743.GA1953@linaro.org>
 <CAHod+GdDN-hMKreQNXfGpe9vDLV8+a55JFM2R4wW_r5kyFaYww@mail.gmail.com>
 <20121210180235.GC1953@linaro.org>
Message-ID: <50C62510.7050204@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/12 18:02, Dave Martin wrote:
> On Mon, Dec 10, 2012 at 06:39:55PM +0100, Marko Kati? wrote:
>> On Mon, Dec 10, 2012 at 11:57 AM, Dave Martin <dave.martin@linaro.org> wrote:
>>> Hi Russell,
>>>
>>> Do you want me to send this patch to the patch system?
>>>
>>> Until we have confirmation from Marko (or someone else with a board)
>>> there's no way to know whether it fixes the problem.  But it should
>>> restore us back to the old behaviour older hardware, reducing the
>>> likelihood of side issues.
>>>
>>> This could be reverted later if it proves to be unnecessary.
>>>
>>> Cheers
>>> ---Dave
>>>
>>> On Fri, Dec 07, 2012 at 01:45:59PM +0000, Dave Martin wrote:
>>>> The kernel can only be entered on HYP mode on CPUs which actually
>>>> support it, i.e.  >= ARMv7.  pre-v6 platform support cannot coexist
>>>> in the same kernel as support for v7 and higher, so there is no
>>>> advantage in having the HYP mode check on pre-v6 hardware.
>>>>
>>>> At least one pre-v6 board is known to fail when the HYP mode check
>>>> code is present, although the exact cause remains unknown and may
>>>> be unrelated.  [1]
>>>>
>>>> This patch restores the old behaviour for pre-v6 platforms, whereby
>>>> the CPSR is forced directly to SVC mode with IRQs and FIQs masked.
>>>> All kernels capable of booting on v7 hardware will retain the
>>>> check, so this should not impair functionality.
>>>>
>>>> [1] http://lists.arm.linux.org.uk/lurker/message/20121130.013814.19218413.en.html
>>>> ([ARM] head.S change broke platform device registration?)
>>>>
>>>> Signed-off-by: Dave Martin <dave.martin@linaro.org>
>>>> ---
>>>>  arch/arm/include/asm/assembler.h |    8 ++++++++
>>>>  1 files changed, 8 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
>>>> index 2ef9581..eb87200 100644
>>>> --- a/arch/arm/include/asm/assembler.h
>>>> +++ b/arch/arm/include/asm/assembler.h
>>>> @@ -250,6 +250,7 @@
>>>>   * Beware, it also clobers LR.
>>>>   */
>>>>  .macro safe_svcmode_maskall reg:req
>>>> +#if __LINUX_ARM_ARCH__ >= 6
>>>>       mrs     \reg , cpsr
>>>>       mov     lr , \reg
>>>>       and     lr , lr , #MODE_MASK
>>>> @@ -266,6 +267,13 @@ THUMB(   orr     \reg , \reg , #PSR_T_BIT        )
>>>>       __ERET
>>>>  1:   msr     cpsr_c, \reg
>>>>  2:
>>>> +#else
>>>> +/*
>>>> + * workaround for possibly broken pre-v6 hardware
>>>> + * (akita, Sharp Zaurus C-1000, PXA270-based)
>>>> + */
>>>> +     setmode PSR_F_BIT | PSR_I_BIT | SVC_MODE, \reg
>>>> +#endif
>>>>  .endm
>>>>
>>>>  /*
>>>> --
>>>> 1.7.4.1
>>>>
>>
>> I confirm that this patch fixes the regression on Akita machines
>> introduced with commit:
>>
>> 424e5994e63326a42012f003f1174f3c363c7b62
>> ARM: zImage/virt: hyp mode entry support for the zImage loader
>>
>> The abovementioned commit breaks Zaurus machine ID detection code
>> (arm/boot/compressed/head-sharpsl.S)
>> causing Akita machines to boot with the wrong machine ID.
> 
> Thanks for testing.  I've now posted the patch to the patch system.
> 
>> Just a minor nitpick:
>> s/clobers/clobbers/g
> 
> Good spot, but I'll leave the patch unchanged for now.
> 
> This typo is in the existing code, not part of the fix.
> I'll try to tidy this up if I touch this code again.

I think Will already carries a patch authored by RMK, getting rid of the
use of LR and of my spelling mistake.

	M.
-- 
Jazz is not dead. It just smells funny...
