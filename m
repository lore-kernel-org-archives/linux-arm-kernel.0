From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Feb 2016 20:17:11 +0100
Subject: [RFC PATCH 1/2] memremap: add arch specific hook for MEMREMAP_WB
 mappings
In-Reply-To: <CAPcyv4ivN9c8PHBR77vd36ovB28OETJUr6VYf_8gNtXgqEmATw@mail.gmail.com>
References: <1456149728-16706-1-git-send-email-ard.biesheuvel@linaro.org>
 <1456149728-16706-2-git-send-email-ard.biesheuvel@linaro.org>
 <CAPcyv4ivN9c8PHBR77vd36ovB28OETJUr6VYf_8gNtXgqEmATw@mail.gmail.com>
Message-ID: <CAKv+Gu9OWVgo+Qm85jPjY7xJ1UELm-4LYORHKF8Yy+_HuzmtGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 February 2016 at 20:05, Dan Williams <dan.j.williams@intel.com> wrote:
> On Mon, Feb 22, 2016 at 6:02 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> Currently, the memremap code serves MEMREMAP_WB mappings directly from
>> the kernel direct mapping, unless the region is in high memory, in which
>> case it falls back to using ioremap_cache(). However, the semantics of
>> ioremap_cache() are not unambiguously defined, and on ARM, it will
>> actually result in a mapping type that differs from the attributes used
>> for the linear mapping, and for this reason, the ioremap_cache() call
>> fails if the region is part of the memory managed by the kernel.
>>
>> So instead, implement an optional hook 'arch_memremap_wb' whose default
>> implementation calls ioremap_cache() as before, but which can be
>> overridden by the architecture to do what is appropriate for it.
>>
>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
>
> I still have patches pending to delete ioremap_cache() from ARM and
> require memremap() to be used for cacheable mappings.  Do you see any
> use for ioremap_cache() on ARM after this change?

I am not exactly sure why ioremap_cache() does not use MT_MEMORY_RW
attributes, but the ARM architecture simply does not allow mismatched
attributes, so we cannot simply replace each instance of
ioremap_cache() with memremap()

Perhaps Russell can explain?
