From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Mon, 27 Jul 2015 20:52:05 +0300
Subject: [PATCH v4 2/7] mm: kasan: introduce generic
 kasan_populate_zero_shadow()
In-Reply-To: <55B63EE3.6040104@gmail.com>
References: <1437756119-12817-1-git-send-email-a.ryabinin@samsung.com>
 <1437756119-12817-3-git-send-email-a.ryabinin@samsung.com>
 <55B63EE3.6040104@gmail.com>
Message-ID: <55B66FC5.30406@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/27/2015 05:23 PM, Yury wrote:
>> +
>> +#if CONFIG_PGTABLE_LEVELS > 3
>> +pud_t kasan_zero_pud[PTRS_PER_PUD] __page_aligned_bss;
>> +#endif
>> +#if CONFIG_PGTABLE_LEVELS > 2
>> +pmd_t kasan_zero_pmd[PTRS_PER_PMD] __page_aligned_bss;
>> +#endif
> 
> You declare kasan_zero_pud and kasan_zero_pmd conditionally now, but use
> unconditionally, at least in kasan_init in patch #5. If I'm not missing
> something, this is wrong...
> 

These are used conditionally. E.g. pgd_populate() is nop if we have 2 or 3-level page tables
kasan_zero_pud will be unused (otherwise this wouldn't compile).


>> +pte_t kasan_zero_pte[PTRS_PER_PTE] __page_aligned_bss;
>> +
>> +static __init void *early_alloc(size_t size, int node)
>> +{
>> +    return memblock_virt_alloc_try_nid(size, size, __pa(MAX_DMA_ADDRESS),
>> +                    BOOTMEM_ALLOC_ACCESSIBLE, node);
>> +}
>> +
>> +static void __init zero_pte_populate(pmd_t *pmd, unsigned long addr,
>> +                unsigned long end)
>> +{
>> +    pte_t *pte = pte_offset_kernel(pmd, addr);
>> +    pte_t zero_pte;
>> +
>> +    zero_pte = pfn_pte(PFN_DOWN(__pa(kasan_zero_page)), PAGE_KERNEL);
>> +    zero_pte = pte_wrprotect(zero_pte);
>> +
>> +    while (addr + PAGE_SIZE <= end) {
>> +        set_pte_at(&init_mm, addr, pte, zero_pte);
>> +        addr += PAGE_SIZE;
>> +        pte = pte_offset_kernel(pmd, addr);
>> +    }
>> +}
>> +
>> +static void __init zero_pmd_populate(pud_t *pud, unsigned long addr,
>> +                unsigned long end)
> 
> Functions zero_pmd_populate, zero_pud_populate and kasan_populate_zero_shadow
> are suspiciously similar. I think we can isolate common pieces to helpers to
> reduce code duplication and increase readability...
> 

I don't see how we could reduce duplication without hurting readability.

>> +{
>> +    pmd_t *pmd = pmd_offset(pud, addr);
>> +    unsigned long next;
>> +
>> +    do {
>> +        next = pmd_addr_end(addr, end);
>> +
>> +        if (IS_ALIGNED(addr, PMD_SIZE) && end - addr >= PMD_SIZE) {
> 
> This line is repeated 3 times. For me, it's more than enough to
> wrap it to helper (if something similar does not exist somewhere):
> static inline is_whole_entry(unsigned long start, unsigned long end, unsigned long size);
> 

This is quite trivial one line condition, I don't think we need helper for this.
And is_whole_entry() looks like a bad name for such function.


>> +            pmd_populate_kernel(&init_mm, pmd, kasan_zero_pte);
>> +            continue;
>> +        }
>> +
>> +        if (pmd_none(*pmd)) {
>> +            pmd_populate_kernel(&init_mm, pmd,
>> +                    early_alloc(PAGE_SIZE, NUMA_NO_NODE));
>> +        }
>> +        zero_pte_populate(pmd, addr, next);
>> +    } while (pmd++, addr = next, addr != end);
>> +}
>> +
>> +static void __init zero_pud_populate(pgd_t *pgd, unsigned long addr,
>> +                unsigned long end)
>> +{
>> +    pud_t *pud = pud_offset(pgd, addr);
>> +    unsigned long next;
>> +
>> +    do {
>> +        next = pud_addr_end(addr, end);
>> +        if (IS_ALIGNED(addr, PUD_SIZE) && end - addr >= PUD_SIZE) {
>> +            pmd_t *pmd;
>> +
>> +            pud_populate(&init_mm, pud, kasan_zero_pmd);
>> +            pmd = pmd_offset(pud, addr);
>> +            pmd_populate_kernel(&init_mm, pmd, kasan_zero_pte);
> 
> This three lines are repeated in kasan_populate_zero_shadow()
> So, maybe you'd wrap it with some
> 'pud_zero_populate_whole_pmd(pud, addr)'?
> 

And I'm also disagree here. This doesn't even save any LOC, and
reviewer will have too look into this "pud_zero_populate_whole_pmd()"
to understand what it does (It's not clear from function's name).
So I think this will be worse than current code.

>> +            continue;
>> +        }
>> +
>> +        if (pud_none(*pud)) {
>> +            pud_populate(&init_mm, pud,
>> +                early_alloc(PAGE_SIZE, NUMA_NO_NODE));
>> +        }
>> +        zero_pmd_populate(pud, addr, next);
>> +    } while (pud++, addr = next, addr != end);
>> +}
>> +
>> +/**
>> + * kasan_populate_zero_shadow - populate shadow memory region with
>> + *                               kasan_zero_page
>> + * @from - start of the memory range to populate
>> + * @to   - end of the memory range to populate
> 
> In description and here in comment you underline that 1st parameter is
> start, and second is end. But you name them finally 'from' and 'to', and
> for me this names are confusing. And for you too, in so far as you add
> comment explaining it.
>

Right, I forgot to update commit description.

> I'm not insisting, but why don't you give parameters
> more straight names? (If you are worrying about internal vars naming conflict,
> just use '_start' and '_end' for them.)
> 

Yes, I choose 'from', 'to' to avoid conflict with internal end variable.
But don't like this 'from', 'to', as I'm also don't like underscores, so
I think it would be better to name parameters as 'shadow_start' and 'shadow_end'.
Pretty clear and no conflicts.
