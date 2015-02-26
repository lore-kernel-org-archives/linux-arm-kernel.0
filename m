From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 26 Feb 2015 18:41:01 +0000
Subject: [RFC PATCH 1/3] ARM, arm64: kvm: get rid of the bounce page
In-Reply-To: <54EF64E8.4090605@arm.com>
References: <1424964547-2118-1-git-send-email-ard.biesheuvel@linaro.org>
 <1424964547-2118-2-git-send-email-ard.biesheuvel@linaro.org>
 <54EF458A.4090205@arm.com>
 <CAKv+Gu_HuVuh7VE8shn4WnLfq0ankvkt2uSP2eG_2cczRAfApw@mail.gmail.com>
 <54EF64E8.4090605@arm.com>
Message-ID: <CAKv+Gu_iEenucbmMdrSTZFHP543=y2TGtSZ-G5GgnpgUrONEjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 February 2015 at 18:24, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 26/02/15 17:31, Ard Biesheuvel wrote:
>> On 26 February 2015 at 16:10, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> On 26/02/15 15:29, Ard Biesheuvel wrote:
>>>> The HYP init bounce page is a runtime construct that ensures that the
>>>> HYP init code does not cross a page boundary. However, this is something
>>>> we can do perfectly well at build time, by aligning the code appropriately.
>>>>
>>>> For arm64, we just align to 4 KB, and enforce that the code size is less
>>>> than 4 KB, regardless of the chosen page size.
>>>>
>>>> For ARM, the whole code is less than 256 bytes, so we tweak the linker
>>>> script to align at a power of 2 upper bound of the code size
>>>>
>>>> Note that this also fixes a benign off-by-one error in the original bounce
>>>> page code, where a bounce page would be allocated unnecessarily if the code
>>>> was exactly 1 page in size.
>>>
>>> I really like this simplification. Can you please check that it still
>>> work on 32bit with this patch from Arnd?
>>>
>>> https://www.mail-archive.com/kvm at vger.kernel.org/msg112364.html
>>>
>>
>> Yes, it does.
>>
>> Note that the kernel's RODATA permissions shouldn't affect whether
>> this code is executable or not in HYP mode, so I think this code
>> belongs in RODATA in the 1st place.
>
> Yup. Maybe we should do the same for arm64, shouldn't we?
>

In fact, patch 2/2 of the series I sent earlier today has a similar
side effect, by putting the HYP idmap before _stext.

>>> Another question below:
>>>
>>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>> ---
>>>>  arch/arm/kernel/vmlinux.lds.S   | 12 +++++++++---
>>>>  arch/arm/kvm/init.S             | 11 +++++++++++
>>>>  arch/arm/kvm/mmu.c              | 42 +++++------------------------------------
>>>>  arch/arm64/kernel/vmlinux.lds.S | 18 ++++++++++++------
>>>>  4 files changed, 37 insertions(+), 46 deletions(-)
>>>>
>>>> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
>>>> index b31aa73e8076..8179d3903dee 100644
>>>> --- a/arch/arm/kernel/vmlinux.lds.S
>>>> +++ b/arch/arm/kernel/vmlinux.lds.S
>>>> @@ -23,7 +23,7 @@
>>>>       VMLINUX_SYMBOL(__idmap_text_start) = .;                         \
>>>>       *(.idmap.text)                                                  \
>>>>       VMLINUX_SYMBOL(__idmap_text_end) = .;                           \
>>>> -     . = ALIGN(32);                                                  \
>>>> +     . = ALIGN(1 << __hyp_idmap_align_order);                        \
>>>>       VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;                     \
>>>>       *(.hyp.idmap.text)                                              \
>>>>       VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
>>>> @@ -346,8 +346,14 @@ SECTIONS
>>>>   */
>>>>  ASSERT((__proc_info_end - __proc_info_begin), "missing CPU support")
>>>>  ASSERT((__arch_info_end - __arch_info_begin), "no machine record defined")
>>>> +
>>>>  /*
>>>> - * The HYP init code can't be more than a page long.
>>>> + * The HYP init code can't be more than a page long,
>>>> + * and should not cross a page boundary.
>>>>   * The above comment applies as well.
>>>>   */
>>>> -ASSERT(((__hyp_idmap_text_end - __hyp_idmap_text_start) <= PAGE_SIZE), "HYP init code too big")
>>>> +ASSERT(((__hyp_idmap_text_end - 1) & PAGE_MASK) -
>>>> +     (__hyp_idmap_text_start & PAGE_MASK) == 0,
>>>> +     "HYP init code too big or unaligned")
>>>> +ASSERT(__hyp_idmap_size <= (1 << __hyp_idmap_align_order),
>>>> +     "__hyp_idmap_size should be <= (1 << __hyp_idmap_align_order)")
>>>> diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
>>>> index 3988e72d16ff..7a279bc8e0e1 100644
>>>> --- a/arch/arm/kvm/init.S
>>>> +++ b/arch/arm/kvm/init.S
>>>> @@ -157,3 +157,14 @@ target:  @ We're now in the trampoline code, switch page tables
>>>>  __kvm_hyp_init_end:
>>>>
>>>>       .popsection
>>>> +
>>>> +     /*
>>>> +      * When making changes to this file, make sure that the value of
>>>> +      * __hyp_idmap_align_order is updated if the size of the code ends up
>>>> +      * exceeding (1 << __hyp_idmap_align_order). This helps ensure that the
>>>> +      * code never crosses a page boundary, without wasting too much memory
>>>> +      * on aligning to PAGE_SIZE.
>>>> +      */
>>>> +     .global __hyp_idmap_size, __hyp_idmap_align_order
>>>> +     .set    __hyp_idmap_size, __kvm_hyp_init_end - __kvm_hyp_init
>>>> +     .set    __hyp_idmap_align_order, 8
>>>
>>> Is there a way to generate this __hyp_idmap_align_order automatically?
>>> We're already pretty close to this 8 bit limit...
>>>
>>
>> This seems to work:
>>
>> #define HYP_IDMAP_ALIGN \
>> __hyp_idmap_size <= 0x100 ? 0x100 : \
>> __hyp_idmap_size <= 0x200 ? 0x200 : \
>> __hyp_idmap_size <= 0x400 ? 0x400 : \
>> __hyp_idmap_size <= 0x800 ? 0x800 : 0x1000
>>
>> and
>>
>> . = ALIGN(HYP_IDMAP_ALIGN); \
>>
>> and we are limited at 1 page anyway.
>
> Ah, excellent.
>
>> Should I respin and include the move to RODATA at the same time?
>> Or would you like me to rebase onto Arnd's patch?
>
> [adding Arnd on CC]
>
> Rebasing on top of Arnd's patch seems fair, as he came up with the idea
> the first place.
>

OK, that's fine.

@Arnd: I think you should move the ALIGN(32) along with the idmap bits
into .rodata.
Could you cc me on the updated patch? I will rebase this on top of it then.

Thanks,
Ard.
