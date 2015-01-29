From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 29 Jan 2015 16:01:24 +0000
Subject: randconfig bug: ARM/KVM link error in hyp_idmap section
In-Reply-To: <1611315.VFEsrxkfBf@wuerfel>
References: <3919069.MpPCrczKD2@wuerfel>
 <CAEDV+gJ3YO8oeka_yaJGg+LXA0Od0TGkZb8vD_q74xNRx9g0Rg@mail.gmail.com>
 <1611315.VFEsrxkfBf@wuerfel>
Message-ID: <54CA5954.8060506@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 29/01/15 15:53, Arnd Bergmann wrote:
> On Thursday 29 January 2015 16:23:42 Christoffer Dall wrote:
>> On Wed, Jan 28, 2015 at 8:57 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>>> 8<----
>>> Subject: [PATCH] ARM: KVM: avoid "HYP init code too big" error
>>>
>>> When building large kernels, the linker will emit lots of veneers
>>> into the .hyp.idmap.text section, which causes it to grow beyond
>>> one page, and that triggers the build error.
>>>
>>
>> do you have a config handy that generates this error?
> 
> Attached to this mail. Use on linux-next
> 
>>> This moves the section into .rodata instead, which avoids the
>>> veneers and is safe because the code is not executed directly
>>> but always copied into a separate page first.
>>>
>>> I am unsure if I wrote this the correct way though, so
>>> it needs to be reviewed carefully.
>>>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>>
>>> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
>>> index ce01a2d3339f..f4de6e16d951 100644
>>> --- a/arch/arm/kernel/vmlinux.lds.S
>>> +++ b/arch/arm/kernel/vmlinux.lds.S
>>> @@ -23,10 +23,14 @@
>>>         VMLINUX_SYMBOL(__idmap_text_start) = .;                         \
>>>         *(.idmap.text)                                                  \
>>>         VMLINUX_SYMBOL(__idmap_text_end) = .;                           \
>>> -       . = ALIGN(32);                                                  \
>>> +       . = ALIGN(32);
>>> +
>>> +#define IDMAP_RODATA                                                   \
>>> +       .rodata : {                                                     \
>>>         VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;                     \
>>>         *(.hyp.idmap.text)                                              \
>>> -       VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
>>> +       VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;                       \
>>> +       }
>>>
>>>  #ifdef CONFIG_HOTPLUG_CPU
>>>  #define ARM_CPU_DISCARD(x)
>>> @@ -123,6 +127,7 @@ SECTIONS
>>>         . = ALIGN(1<<SECTION_SHIFT);
>>>  #endif
>>>         RO_DATA(PAGE_SIZE)
>>> +       IDMAP_RODATA
>>>
>>>         . = ALIGN(4);
>>>         __ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
>>>
>>>
>> the changes look ok, but I don't understand why putting stuff in rodata is
>> a good solution, is it simply by chance that the linker then generates
>> fewer veneers there?  I think we're only branching internally in the hyp
>> idmap text page anyhow, so wondering why this appears in the first place...
>> hmmm.
> 
> The linker will not generate any veneers for .rodata because it does not
> expect executable code in there. As I said, above, this is also correct
> because it matches how we access that section (read-only, never execute).

Not sure about the later point. We only copy the code if it is not page
aligned, and use it in place otherwise. I guess we could change that,
but we'd need the same change for arm64.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
