From: keescook@chromium.org (Kees Cook)
Date: Thu, 4 Sep 2014 07:00:31 -0700
Subject: [PATCH v4 4/8] arm: use fixmap for text patching when text is RO
In-Reply-To: <20140904092720.GA7156@arm.com>
References: <1407949593-16121-1-git-send-email-keescook@chromium.org>
 <1407949593-16121-5-git-send-email-keescook@chromium.org>
 <20140819122933.GI23128@arm.com>
 <CAGXu5jLxqyfJtg8rR9nzOrSBSsRC6y34rG6mZ8bb=AoxbSHkWQ@mail.gmail.com>
 <CAGXu5jJ890ruLO8Nit2exMSWigSM71kfZOkLoF0DcY1viFiX_A@mail.gmail.com>
 <20140904092720.GA7156@arm.com>
Message-ID: <CAGXu5jJJyLkw38VyZ6fuKf5k5EcQNf+Ke0G0=qZ+pc+CptvXmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 4, 2014 at 2:27 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Sep 03, 2014 at 10:43:58PM +0100, Kees Cook wrote:
>> On Wed, Aug 20, 2014 at 5:28 AM, Kees Cook <keescook@chromium.org> wrote:
>> > On Tue, Aug 19, 2014 at 7:29 AM, Will Deacon <will.deacon@arm.com> wrote:
>> >> On Wed, Aug 13, 2014 at 06:06:29PM +0100, Kees Cook wrote:
>> >>> +static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
>> >>> +     __acquires(&patch_lock)
>> >>> +{
>> >>> +     unsigned int uintaddr = (uintptr_t) addr;
>> >>> +     bool module = !core_kernel_text(uintaddr);
>> >>> +     struct page *page;
>> >>> +
>> >>> +     if (module && IS_ENABLED(CONFIG_DEBUG_SET_MODULE_RONX))
>> >>> +             page = vmalloc_to_page(addr);
>> >>> +     else if (!module && IS_ENABLED(CONFIG_DEBUG_RODATA))
>> >>> +             page = virt_to_page(addr);
>> >>> +     else
>> >>> +             return addr;
>> >>> +
>> >>> +     if (flags)
>> >>> +             spin_lock_irqsave(&patch_lock, *flags);
>> >>> +     else
>> >>> +             __acquire(&patch_lock);
>> >>
>> >> I don't understand the locking here. Why is it conditional, why do we need
>> >> to disable interrupts, and are you just racing against yourself?
>> >
>> > AIUI, the locking is here to avoid multiple users of the text poking
>> > fixmaps. It's conditional because there are two fixmaps
>> > (FIX_TEXT_POKE0 and FIX_TEXT_POKE1). Locking happens around 0 so
>> > locking around 1 is not needed since it is only ever used when 0 is in
>> > use. (__patch_text_real locks patch_lock before setting 0 when it uses
>> > remapping, and if it also needs 1, it doesn't have to lock since the
>> > lock is already held.)
>> >
>> >>> +     set_fixmap(fixmap, page_to_phys(page));
>> >>
>> >> set_fixmap does TLB invalidation, right? I think that means it can block on
>> >> 11MPCore and A15 w/ the TLBI erratum, so it's not safe to call this with
>> >> interrupts disabled anyway.
>> >
>> > Oh right. Hrm.
>> >
>> > In an earlier version of this series set_fixmap did not perform TLB
>> > invalidation. I wonder if this is not needed at all? (Wouldn't that be
>> > nice...)
>>
>> As suspected, my tests fail spectacularly without the TLB flush.
>> Adding WARN_ON(!irqs_disabled()) doesn't warn, so I think we're safe
>> here. Should I leave the WARN_ON in place for clarity, or some other
>> comments?
>
> I thought there was a potential call to spin_lock_irqsave right before
> this TLB flush?

I'm not sure I understand what you mean. Should I change something
here? It looks like irqs are disabled, so isn't this a safe code path?

-Kees

-- 
Kees Cook
Chrome OS Security
