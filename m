From: dave.hansen@intel.com (Dave Hansen)
Date: Fri, 2 Jun 2017 09:03:34 -0700
Subject: [PATCH] mm: vmalloc: make vmalloc_to_page() deal with PMD/PUD
 mappings
In-Reply-To: <CAKv+Gu964bDsV52gZ7QCJf26kXVaWgmuwXZSm0qWxa-34Eqttw@mail.gmail.com>
References: <20170602112720.28948-1-ard.biesheuvel@linaro.org>
 <e98368d8-b1bc-5804-2115-370ec7109e9b@intel.com>
 <CAKv+Gu964bDsV52gZ7QCJf26kXVaWgmuwXZSm0qWxa-34Eqttw@mail.gmail.com>
Message-ID: <747b71d8-86a7-3b96-cf90-60d6c2ce0171@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/2017 08:11 AM, Ard Biesheuvel wrote:
>>> +     pte_t pte = huge_ptep_get((pte_t *)pud);
>>> +
>>> +     if (pte_present(pte))
>>> +             page = pud_page(*pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
>> x86 has pmd/pud_page().  Seems a bit silly to open-code it here.
>>
> So I should replace pud_page() with what exactly?

Whoops, I was reading that wrong.

So, the pud in this case is a huge pud pointing to data.  pud_page()
gives us the head page, but not the base (tail) page.  The 'addr' math
gets us that.

First of all, this math isn't guaranteed to work.  We don't guarantee
virtual contiguity for all mem_map[]s.  I think you need to go to a pfn
or paddr first, add the pud offset, then convert to a 'struct page'.

But, what *is* the right thing to return here?  Do the users here want
the head page or the tail page?

BTW, _are_ your huge vmalloc pages compound?

>>> +#else
>>> +     VIRTUAL_BUG_ON(1);
>>> +#endif
>>> +     return page;
>>> +}
>> So if somebody manages to call this function on a huge page table entry,
>> but doesn't have hugetlbfs configured on, we kill the machine?
> Yes. But only if you have CONFIG_DEBUG_VIRTUAL defined, in which case
> it seems appropriate to signal a failure rather than proceed with
> dereferencing the huge PMD entry as if it were a table entry.

Why kill the machine rather than just warning and returning NULL?
