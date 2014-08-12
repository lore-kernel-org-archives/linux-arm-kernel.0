From: keescook@chromium.org (Kees Cook)
Date: Tue, 12 Aug 2014 14:47:37 -0700
Subject: [PATCH v3 3/7] arm: use fixmap for text patching when text is RO
In-Reply-To: <53EA897D.8030901@codeaurora.org>
References: <1407867869-5194-1-git-send-email-keescook@chromium.org>
 <1407867869-5194-4-git-send-email-keescook@chromium.org>
 <53EA897D.8030901@codeaurora.org>
Message-ID: <CAGXu5j+TPBs9h9YvVDt=g4WFykHgzcde9Ujuef=cRQAou8hZoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 12, 2014 at 2:39 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 08/12/14 11:24, Kees Cook wrote:
>> diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
>> index 07314af47733..03dd4e39c833 100644
>> --- a/arch/arm/kernel/patch.c
>> +++ b/arch/arm/kernel/patch.c
>> @@ -13,21 +16,69 @@ struct patch {
>>       unsigned int insn;
>>  };
>>
>> -void __kprobes __patch_text(void *addr, unsigned int insn)
>> +static DEFINE_SPINLOCK(patch_lock);
>> +
>> +static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
>> +{
>> +     unsigned int uintaddr = (uintptr_t) addr;
>> +     bool module = !core_kernel_text(uintaddr);
>> +     struct page *page;
>> +
>> +     if (module && IS_ENABLED(CONFIG_DEBUG_SET_MODULE_RONX))
>> +             page = vmalloc_to_page(addr);
>> +     else if (!module && IS_ENABLED(CONFIG_DEBUG_RODATA))
>> +             page = virt_to_page(addr);
>> +     else
>> +             return addr;
>> +
>> +     if (flags)
>> +             spin_lock_irqsave(&patch_lock, *flags);
>> +
>> +     set_fixmap(fixmap, page_to_phys(page));
>> +
>> +     return (void *) (__fix_to_virt(fixmap) + (uintaddr & ~PAGE_MASK));
>> +}
>> +
>> +static void __kprobes patch_unmap(int fixmap, unsigned long *flags)
>> +{
>> +     clear_fixmap(fixmap);
>> +
>> +     if (flags)
>> +             spin_unlock_irqrestore(&patch_lock, *flags);
>> +}
>
> Has the kbuildbot complained about this one yet?
>
>   CHECK  arch/arm/kernel/patch.c
>   arch/arm/kernel/patch.c:47:39: warning: context imbalance in
> 'patch_unmap' - unexpected unlock
>
> I guess we're going to ignore it.

No, nothing yet from buildbot, let me do a sparse run -- I think we
can just add annotation and we'll be okay.

-Kees

-- 
Kees Cook
Chrome OS Security
