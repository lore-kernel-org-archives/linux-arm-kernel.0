From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 2 Jun 2017 15:11:17 +0000
Subject: [PATCH] mm: vmalloc: make vmalloc_to_page() deal with PMD/PUD
 mappings
In-Reply-To: <e98368d8-b1bc-5804-2115-370ec7109e9b@intel.com>
References: <20170602112720.28948-1-ard.biesheuvel@linaro.org>
 <e98368d8-b1bc-5804-2115-370ec7109e9b@intel.com>
Message-ID: <CAKv+Gu964bDsV52gZ7QCJf26kXVaWgmuwXZSm0qWxa-34Eqttw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 June 2017 at 14:29, Dave Hansen <dave.hansen@intel.com> wrote:
> On 06/02/2017 04:27 AM, Ard Biesheuvel wrote:
>> +static struct page *vmalloc_to_pud_page(unsigned long addr, pud_t *pud)
>> +{
>> +     struct page *page = NULL;
>> +#ifdef CONFIG_HUGETLB_PAGE
>
> Do we really want this based on hugetlbfs?  Won't this be dead code on x86?
>

I don't see why one would follow from the other, but perhaps it is
better to make this depend on CONFIG_HAVE_ARCH_HUGE_VMAP instead,
which is already meant to imply that huge mappings may exist in the
vmalloc region.

> Also, don't we discourage #ifdefs in .c files?
>

Yes. But the alternative is to define a dummy huge_ptep_get(), which
is undefined otherwise. I am not sure that is better in this case. I
will try to address this more elegantly though, perhaps by folding the
huge_ptep_get() into the VIRTUAL_BUG_ON().

>> +     pte_t pte = huge_ptep_get((pte_t *)pud);
>> +
>> +     if (pte_present(pte))
>> +             page = pud_page(*pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
>
> x86 has pmd/pud_page().  Seems a bit silly to open-code it here.
>

So I should replace pud_page() with what exactly?

>> +#else
>> +     VIRTUAL_BUG_ON(1);
>> +#endif
>> +     return page;
>> +}
>
> So if somebody manages to call this function on a huge page table entry,
> but doesn't have hugetlbfs configured on, we kill the machine?

Yes. But only if you have CONFIG_DEBUG_VIRTUAL defined, in which case
it seems appropriate to signal a failure rather than proceed with
dereferencing the huge PMD entry as if it were a table entry.

-- 
Ard.
