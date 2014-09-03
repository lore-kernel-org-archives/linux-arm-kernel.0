From: keescook@chromium.org (Kees Cook)
Date: Wed, 3 Sep 2014 14:43:58 -0700
Subject: [PATCH v4 4/8] arm: use fixmap for text patching when text is RO
In-Reply-To: <CAGXu5jLxqyfJtg8rR9nzOrSBSsRC6y34rG6mZ8bb=AoxbSHkWQ@mail.gmail.com>
References: <1407949593-16121-1-git-send-email-keescook@chromium.org>
 <1407949593-16121-5-git-send-email-keescook@chromium.org>
 <20140819122933.GI23128@arm.com>
 <CAGXu5jLxqyfJtg8rR9nzOrSBSsRC6y34rG6mZ8bb=AoxbSHkWQ@mail.gmail.com>
Message-ID: <CAGXu5jJ890ruLO8Nit2exMSWigSM71kfZOkLoF0DcY1viFiX_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 20, 2014 at 5:28 AM, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Aug 19, 2014 at 7:29 AM, Will Deacon <will.deacon@arm.com> wrote:
>> Hello,
>>
>> On Wed, Aug 13, 2014 at 06:06:29PM +0100, Kees Cook wrote:
>>> From: Rabin Vincent <rabin@rab.in>
>>>
>>> Use fixmaps for text patching when the kernel text is read-only,
>>> inspired by x86.  This makes jump labels and kprobes work with the
>>> currently available CONFIG_DEBUG_SET_MODULE_RONX and the upcoming
>>> CONFIG_DEBUG_RODATA options.
>>>
>>> Signed-off-by: Rabin Vincent <rabin@rab.in>
>>> [kees: fixed up for merge with "arm: use generic fixmap.h"]
>>> [kees: added parse acquire/release annotations to pass C=1 builds]
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>> [...]
>>
>>> diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
>>> index 07314af47733..a1dce690446a 100644
>>> --- a/arch/arm/kernel/patch.c
>>> +++ b/arch/arm/kernel/patch.c
>>> @@ -1,8 +1,11 @@
>>>  #include <linux/kernel.h>
>>> +#include <linux/spinlock.h>
>>>  #include <linux/kprobes.h>
>>> +#include <linux/mm.h>
>>>  #include <linux/stop_machine.h>
>>>
>>>  #include <asm/cacheflush.h>
>>> +#include <asm/fixmap.h>
>>>  #include <asm/smp_plat.h>
>>>  #include <asm/opcodes.h>
>>>
>>> @@ -13,21 +16,77 @@ struct patch {
>>>       unsigned int insn;
>>>  };
>>>
>>> -void __kprobes __patch_text(void *addr, unsigned int insn)
>>> +static DEFINE_SPINLOCK(patch_lock);
>>> +
>>> +static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
>>> +     __acquires(&patch_lock)
>>> +{
>>> +     unsigned int uintaddr = (uintptr_t) addr;
>>> +     bool module = !core_kernel_text(uintaddr);
>>> +     struct page *page;
>>> +
>>> +     if (module && IS_ENABLED(CONFIG_DEBUG_SET_MODULE_RONX))
>>> +             page = vmalloc_to_page(addr);
>>> +     else if (!module && IS_ENABLED(CONFIG_DEBUG_RODATA))
>>> +             page = virt_to_page(addr);
>>> +     else
>>> +             return addr;
>>> +
>>> +     if (flags)
>>> +             spin_lock_irqsave(&patch_lock, *flags);
>>> +     else
>>> +             __acquire(&patch_lock);
>>
>> I don't understand the locking here. Why is it conditional, why do we need
>> to disable interrupts, and are you just racing against yourself?
>
> AIUI, the locking is here to avoid multiple users of the text poking
> fixmaps. It's conditional because there are two fixmaps
> (FIX_TEXT_POKE0 and FIX_TEXT_POKE1). Locking happens around 0 so
> locking around 1 is not needed since it is only ever used when 0 is in
> use. (__patch_text_real locks patch_lock before setting 0 when it uses
> remapping, and if it also needs 1, it doesn't have to lock since the
> lock is already held.)
>
>>> +     set_fixmap(fixmap, page_to_phys(page));
>>
>> set_fixmap does TLB invalidation, right? I think that means it can block on
>> 11MPCore and A15 w/ the TLBI erratum, so it's not safe to call this with
>> interrupts disabled anyway.
>
> Oh right. Hrm.
>
> In an earlier version of this series set_fixmap did not perform TLB
> invalidation. I wonder if this is not needed at all? (Wouldn't that be
> nice...)

As suspected, my tests fail spectacularly without the TLB flush.
Adding WARN_ON(!irqs_disabled()) doesn't warn, so I think we're safe
here. Should I leave the WARN_ON in place for clarity, or some other
comments?

-Kees

-- 
Kees Cook
Chrome OS Security
