From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 2 Feb 2016 09:57:15 +0100
Subject: [PATCHv2 2/3] arm64: Add support for ARCH_SUPPORTS_DEBUG_PAGEALLOC
In-Reply-To: <56AFCD09.8000807@redhat.com>
References: <1454111218-3461-1-git-send-email-labbott@fedoraproject.org>
 <1454111218-3461-3-git-send-email-labbott@fedoraproject.org>
 <20160201122911.GF674@leverpostej> <56AFCD09.8000807@redhat.com>
Message-ID: <CAKv+Gu9hfBgK7WKMOUMWsgqSHMAKvnisqXje5tbNNKB+3Zo3KQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 February 2016 at 22:24, Laura Abbott <labbott@redhat.com> wrote:
> On 02/01/2016 04:29 AM, Mark Rutland wrote:
>>
>> Hi,
>>
>> On Fri, Jan 29, 2016 at 03:46:57PM -0800, Laura Abbott wrote:
>>>
>>>
>>> ARCH_SUPPORTS_DEBUG_PAGEALLOC provides a hook to map and unmap
>>> pages for debugging purposes. This requires memory be mapped
>>> with PAGE_SIZE mappings since breaking down larger mappings
>>> at runtime will lead to TLB conflicts. Check if debug_pagealloc
>>> is enabled at runtime and if so, map everyting with PAGE_SIZE
>>> pages. Implement the functions to actually map/unmap the
>>> pages at runtime.
>>>
>>>
>>> Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
>>
>>
>> I tried to apply atop of the arm64 for-next/pgtable branch, but git
>> wasn't very happy about that -- which branch/patches is this based on?
>>
>> I'm not sure if I'm missing something, have something I shouldn't, or if
>> my MTA is corrupting patches again...
>>
>
> Hmmm, I based it off of your arm64-pagetable-rework-20160125 tag and
> Ard's patch for vmalloc and set_memory_* . The patches seem to apply
> on the for-next/pgtable branch as well so I'm guessing you are missing
> Ard's patch.
>
>
>
>>>
>>> ---
>>>   arch/arm64/Kconfig       |  3 +++
>>>   arch/arm64/mm/mmu.c      | 10 +++++++---
>>>   arch/arm64/mm/pageattr.c | 40 +++++++++++++++++++++++++++++++++-------
>>>   3 files changed, 43 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index 8cc6228..0f33218 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -537,6 +537,9 @@ config HOTPLUG_CPU
>>>   source kernel/Kconfig.preempt
>>>   source kernel/Kconfig.hz
>>>
>>> +config ARCH_SUPPORTS_DEBUG_PAGEALLOC
>>> +       def_bool y
>>> +
>>>   config ARCH_HAS_HOLES_MEMORYMODEL
>>>         def_bool y if SPARSEMEM
>>>
>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>> index 103ebc0..5abbd30 100644
>>> --- a/arch/arm64/mm/mmu.c
>>> +++ b/arch/arm64/mm/mmu.c
>>> @@ -181,7 +181,8 @@ static void alloc_init_pmd(pud_t *pud, unsigned long
>>> addr, unsigned long end,
>>>         do {
>>>                 next = pmd_addr_end(addr, end);
>>>                 /* try section mapping first */
>>> -               if (((addr | next | phys) & ~SECTION_MASK) == 0) {
>>> +               if (((addr | next | phys) & ~SECTION_MASK) == 0 &&
>>> +                     (!debug_pagealloc_enabled() || !pgtable_alloc)) {
>>>                         pmd_t old_pmd =*pmd;
>>>                         set_pmd(pmd, __pmd(phys |
>>>
>>> pgprot_val(mk_sect_prot(prot))));
>>> @@ -208,8 +209,11 @@ static void alloc_init_pmd(pud_t *pud, unsigned long
>>> addr, unsigned long end,
>>>   }
>>>
>>>   static inline bool use_1G_block(unsigned long addr, unsigned long next,
>>> -                       unsigned long phys)
>>> +                       unsigned long phys, phys_addr_t
>>> (*pgtable_alloc)(void))
>>>   {
>>> +       if (pgtable_alloc && debug_pagealloc_enabled())
>>> +               return false;
>>> +
>>>         if (PAGE_SHIFT != 12)
>>>                 return false;
>>>
>>> @@ -241,7 +245,7 @@ static void alloc_init_pud(pgd_t *pgd, unsigned long
>>> addr, unsigned long end,
>>>                 /*
>>>                  * For 4K granule only, attempt to put down a 1GB block
>>>                  */
>>> -               if (use_1G_block(addr, next, phys)) {
>>> +               if (use_1G_block(addr, next, phys, pgtable_alloc)) {
>>>                         pud_t old_pud = *pud;
>>>                         set_pud(pud, __pud(phys |
>>>
>>> pgprot_val(mk_sect_prot(prot))));
>>
>>
>> The checks for pgtable_alloc is to allow create_mapping_noalloc to use
>> sections regardless, right?
>>
>> I got a little confused by that initially, but that seems to make sense.
>>
>
> Yeah, that was what I was going for. I went for the implication with
> pgtable_alloc
> over adding a bool variable to create_mapping. I'll see if I can put a
> comment
> in somewhere to clarify the intentions.
>

Yes, the logic becomes slightly fuzzy, so it would be good to document
this one way or the other.

-- 
Ard.

>
>>>
>>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>>> index 1360a02..69a8a7d 100644
>>> --- a/arch/arm64/mm/pageattr.c
>>> +++ b/arch/arm64/mm/pageattr.c
>>> @@ -38,7 +38,8 @@ static int change_page_range(pte_t *ptep, pgtable_t
>>> token, unsigned long addr,
>>>   }
>>>
>>>   static int change_memory_common(unsigned long addr, int numpages,
>>> -                               pgprot_t set_mask, pgprot_t clear_mask)
>>> +                               pgprot_t set_mask, pgprot_t clear_mask,
>>> +                               bool ignore_vma_check)
>>>   {
>>>         unsigned long start = addr;
>>>         unsigned long size = PAGE_SIZE*numpages;
>>> @@ -65,11 +66,14 @@ static int change_memory_common(unsigned long addr,
>>> int numpages,
>>>          *
>>>          * So check whether the [addr, addr + size) interval is entirely
>>>          * covered by precisely one VM area that has the VM_ALLOC flag
>>> set.
>>> +        *
>>> +        * The one exception to this is is we're forcing everything to be
>>> +        * page mapped with DEBUG_PAGEALLOC
>>>          */
>>>         area = find_vm_area((void *)addr);
>>> -       if (!area ||
>>> +       if (!ignore_vma_check && (!area ||
>>>             end > (unsigned long)area->addr + area->size ||
>>> -           !(area->flags & VM_ALLOC))
>>> +           !(area->flags & VM_ALLOC)))
>>>                 return -EINVAL;
>>
>>
>> Perhaps we could pull out everything but the VMA checks into a static
>> __change_memory_common. Then we can call that directly in
>> __kernel_map_pages, and don't need to pass a confusing boolean
>> parameter.
>
>
> Sounds fine.
>
>>
>> Otherwise, this looks good to me.
>>  Mark.
>>
>
> Thanks,
> Laura
>
>
>>>
>>>
>>>         data.set_mask = set_mask;
>>> @@ -86,21 +90,24 @@ int set_memory_ro(unsigned long addr, int numpages)
>>>   {
>>>         return change_memory_common(addr, numpages,
>>>                                         __pgprot(PTE_RDONLY),
>>> -                                       __pgprot(PTE_WRITE));
>>> +                                       __pgprot(PTE_WRITE),
>>> +                                       false);
>>>   }
>>>
>>>   int set_memory_rw(unsigned long addr, int numpages)
>>>   {
>>>         return change_memory_common(addr, numpages,
>>>                                         __pgprot(PTE_WRITE),
>>> -                                       __pgprot(PTE_RDONLY));
>>> +                                       __pgprot(PTE_RDONLY),
>>> +                                       false);
>>>   }
>>>
>>>   int set_memory_nx(unsigned long addr, int numpages)
>>>   {
>>>         return change_memory_common(addr, numpages,
>>>                                         __pgprot(PTE_PXN),
>>> -                                       __pgprot(0));
>>> +                                       __pgprot(0),
>>> +                                       false);
>>>   }
>>>   EXPORT_SYMBOL_GPL(set_memory_nx);
>>>
>>> @@ -108,6 +115,25 @@ int set_memory_x(unsigned long addr, int numpages)
>>>   {
>>>         return change_memory_common(addr, numpages,
>>>                                         __pgprot(0),
>>> -                                       __pgprot(PTE_PXN));
>>> +                                       __pgprot(PTE_PXN),
>>> +                                       false);
>>>   }
>>>   EXPORT_SYMBOL_GPL(set_memory_x);
>>> +
>>> +#ifdef CONFIG_DEBUG_PAGEALLOC
>>> +void __kernel_map_pages(struct page *page, int numpages, int enable)
>>> +{
>>> +       unsigned long addr = (unsigned long) page_address(page);
>>> +
>>> +       if (enable)
>>> +               change_memory_common(addr, numpages,
>>> +                                       __pgprot(PTE_VALID),
>>> +                                       __pgprot(0),
>>> +                                       true);
>>> +       else
>>> +               change_memory_common(addr, numpages,
>>> +                                       __pgprot(0),
>>> +                                       __pgprot(PTE_VALID),
>>> +                                       true);
>>> +}
>>> +#endif
>>> --
>>> 2.5.0
>>>
>
