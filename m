From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 28 Oct 2014 12:44:51 +0100
Subject: [PATCHv4 7/7] arm64: add better page protections to arm64
In-Reply-To: <20141028112949.GA7978@linaro.org>
References: <1414440752-9411-1-git-send-email-lauraa@codeaurora.org>
 <1414440752-9411-8-git-send-email-lauraa@codeaurora.org>
 <20141028112949.GA7978@linaro.org>
Message-ID: <CAKv+Gu9GiN8GF2wK=2Z2b15e+NYfQov7rNT2cjmDpRqjMwx1yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 October 2014 12:29, Steve Capper <steve.capper@linaro.org> wrote:
> On Mon, Oct 27, 2014 at 01:12:32PM -0700, Laura Abbott wrote:
>> Add page protections for arm64 similar to those in arm.
>> This is for security reasons to prevent certain classes
>> of exploits. The current method:
>>
>> - Map all memory as either RWX or RW. We round to the nearest
>>   section to avoid creating page tables before everything is mapped
>> - Once everything is mapped, if either end of the RWX section should
>>   not be X, we split the PMD and remap as necessary
>> - When initmem is to be freed, we change the permissions back to
>>   RW (using stop machine if necessary to flush the TLB)
>> - If CONFIG_DEBUG_RODATA is set, the read only sections are set
>>   read only.
>>
>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>
> Hi Laura,
> I have some comments below.
>
>> ---
>> v4: Combined the Kconfig options
>> ---
>>  arch/arm64/Kconfig.debug            |  23 +++
>>  arch/arm64/include/asm/cacheflush.h |   4 +
>>  arch/arm64/kernel/vmlinux.lds.S     |  17 ++
>>  arch/arm64/mm/init.c                |   1 +
>>  arch/arm64/mm/mm.h                  |   2 +
>>  arch/arm64/mm/mmu.c                 | 303 +++++++++++++++++++++++++++++++-----
>>  6 files changed, 314 insertions(+), 36 deletions(-)
>>
[...]
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index e92f633..0428294 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -26,6 +26,7 @@
>>  #include <linux/memblock.h>
>>  #include <linux/fs.h>
>>  #include <linux/io.h>
>> +#include <linux/stop_machine.h>
>>
>>  #include <asm/cputype.h>
>>  #include <asm/fixmap.h>
>> @@ -137,17 +138,55 @@ static void __init *early_alloc(unsigned long sz)
>>       return ptr;
>>  }
>>
>> -static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
>> +/*
>> + * remap a PMD into pages
>> + */
>> +static noinline void __ref split_pmd(pmd_t *pmd, bool early)
>> +{
>> +     pte_t *pte, *start_pte;
>> +     unsigned long pfn;
>> +     int i = 0;
>> +
>> +     if (early)
>> +             start_pte = pte = early_alloc(PTRS_PER_PTE*sizeof(pte_t));
>> +     else
>> +             start_pte = pte = (pte_t *)__get_free_page(PGALLOC_GFP);
>> +
>> +     BUG_ON(!pte);
>> +
>> +     pfn = pmd_pfn(*pmd);
>> +
>> +     do {
>> +             /*
>> +              * Need to have the least restrictive permissions available
>> +              * permissions will be fixed up later
>> +              */
>> +             set_pte(pte, pfn_pte(pfn, PAGE_KERNEL_EXEC));
>> +             pfn++;
>> +     } while (pte++, i++, i < PTRS_PER_PTE);
>> +
>> +
>> +     __pmd_populate(pmd, __pa(start_pte), PMD_TYPE_TABLE);
>> +     flush_tlb_all();
>> +}
>> +
>> +static void __ref alloc_init_pte(pmd_t *pmd, unsigned long addr,
>>                                 unsigned long end, unsigned long pfn,
>> -                               pgprot_t prot)
>> +                               pgprot_t prot, bool early)
>>  {
>>       pte_t *pte;
>>
>>       if (pmd_none(*pmd)) {
>> -             pte = early_alloc(PTRS_PER_PTE * sizeof(pte_t));
>> +             if (early)
>> +                     pte = early_alloc(PTRS_PER_PTE * sizeof(pte_t));
>> +             else
>> +                     pte = (pte_t *)__get_free_page(PGALLOC_GFP);
>> +             BUG_ON(!pte);
>>               __pmd_populate(pmd, __pa(pte), PMD_TYPE_TABLE);
>>       }
>> -     BUG_ON(pmd_bad(*pmd));
>> +
>> +     if (pmd_bad(*pmd))
>> +             split_pmd(pmd, early);
>>
>>       pte = pte_offset_kernel(pmd, addr);
>>       do {
>> @@ -156,29 +195,52 @@ static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
>>       } while (pte++, addr += PAGE_SIZE, addr != end);
>>  }
>>
>> -static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
>> +void __ref split_pud(pud_t *old_pud, pmd_t *pmd)
>> +{
>> +     unsigned long pfn = pud_pfn(*old_pud);
>> +        const pmdval_t mask = PMD_SECT_USER | PMD_SECT_PXN | PMD_SECT_UXN |
>> +                              PMD_SECT_RDONLY | PMD_SECT_PROT_NONE |
>> +                              PMD_SECT_VALID;
>> +     pgprot_t prot = __pgprot(pud_val(*old_pud) & mask);
>
> This looks a little fragile, if I've understood things correctly then
> all we want to do is create a set of pmds with the same pgprot_t as the
> original pud?
>
> In that case it would probably be easier to simply mask out the pfn
> from our pud to create the pgprot rather than mask in a set of
> attributes (that may change in future)?
>
>> +     int i = 0;
>> +
>> +     do {
>> +             set_pmd(pmd, pfn_pmd(pfn, prot));
>> +             pfn++;
>> +     } while (pmd++, i++, i < PTRS_PER_PMD);
>> +}
>> +
>> +static void __ref alloc_init_pmd(pud_t *pud, unsigned long addr,
>>                                 unsigned long end, phys_addr_t phys,
>> -                               int map_io)
>> +                               pgprot_t sect_prot, pgprot_t pte_prot,
>> +                               bool early, int map_io)
>>  {
>>       pmd_t *pmd;
>>       unsigned long next;
>> -     pmdval_t prot_sect;
>> -     pgprot_t prot_pte;
>>
>>       if (map_io) {
>> -             prot_sect = PROT_SECT_DEVICE_nGnRE;
>> -             prot_pte = __pgprot(PROT_DEVICE_nGnRE);
>> -     } else {
>> -             prot_sect = PROT_SECT_NORMAL_EXEC;
>> -             prot_pte = PAGE_KERNEL_EXEC;
>> +             sect_prot = PROT_SECT_DEVICE_nGnRE;
>> +             pte_prot = __pgprot(PROT_DEVICE_nGnRE);
>>       }
>
> I think we should wipe out map_io from all these functions as it's
> causing too much complexity. It's enough to have just sect_prot and
> pte_prot. I posted some similar feedback to Ard:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/296918.html
>

I do agree. But could we have a single enum that maps onto {sect_prot,
pte_prot} tuples rather than having to pass both values everywhere we
call any of these functions?
I.e., { MMU_PROT_DEFAULT, MMU_PROT_READONLY, MMU_PROT_READWRITE,
MMU_PROT_READEXEC, MMU_PROT_DEVICE }, with the mapping local to mmu.c?

>>
>>       /*
>>        * Check for initial section mappings in the pgd/pud and remove them.
>>        */
>>       if (pud_none(*pud) || pud_bad(*pud)) {
>> -             pmd = early_alloc(PTRS_PER_PMD * sizeof(pmd_t));
>> +             if (early)
>> +                     pmd = early_alloc(PTRS_PER_PMD * sizeof(pmd_t));
>> +             else
>> +                     pmd = pmd_alloc_one(&init_mm, addr);
>> +             BUG_ON(!pmd);
>> +             if (pud_sect(*pud)) {
>> +                     /*
>> +                      * need to have the 1G of mappings continue to be
>> +                      * present
>> +                      */
>> +                     split_pud(pud, pmd);
>> +             }
>>               pud_populate(&init_mm, pud, pmd);
>> +             flush_tlb_all();
>>       }
>>
>>       pmd = pmd_offset(pud, addr);
>> @@ -186,8 +248,8 @@ static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
>>               next = pmd_addr_end(addr, end);
>>               /* try section mapping first */
>>               if (((addr | next | phys) & ~SECTION_MASK) == 0) {
>> -                     pmd_t old_pmd =*pmd;
>> -                     set_pmd(pmd, __pmd(phys | prot_sect));
>> +                     pmd_t old_pmd = *pmd;
>> +                     set_pmd(pmd, __pmd(phys | sect_prot));
>>                       /*
>>                        * Check for previous table entries created during
>>                        * boot (__create_page_tables) and flush them.
>> @@ -196,15 +258,16 @@ static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
>>                               flush_tlb_all();
>>               } else {
>>                       alloc_init_pte(pmd, addr, next, __phys_to_pfn(phys),
>> -                                    prot_pte);
>> +                                     pte_prot, early);
>>               }
>>               phys += next - addr;
>>       } while (pmd++, addr = next, addr != end);
>>  }
>>
>> -static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
>> +static void __ref alloc_init_pud(pgd_t *pgd, unsigned long addr,
>>                                 unsigned long end, unsigned long phys,
>> -                               int map_io)
>> +                               pgprot_t sect_prot, pgprot_t pte_prot,
>> +                               bool early, int map_io)
>>  {
>>       pud_t *pud;
>>       unsigned long next;
>> @@ -222,10 +285,10 @@ static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
>>               /*
>>                * For 4K granule only, attempt to put down a 1GB block
>>                */
>> -             if (!map_io && (PAGE_SHIFT == 12) &&
>> +             if (!map_io && early && (PAGE_SHIFT == 12) &&
>>                   ((addr | next | phys) & ~PUD_MASK) == 0) {
>>                       pud_t old_pud = *pud;
>> -                     set_pud(pud, __pud(phys | PROT_SECT_NORMAL_EXEC));
>> +                     set_pud(pud, __pud(phys | sect_prot));
>>
>>                       /*
>>                        * If we have an old value for a pud, it will
>> @@ -240,7 +303,8 @@ static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
>>                               flush_tlb_all();
>>                       }
>>               } else {
>> -                     alloc_init_pmd(pud, addr, next, phys, map_io);
>> +                     alloc_init_pmd(pud, addr, next, phys, sect_prot,
>> +                                     pte_prot, early, map_io);
>>               }
>>               phys += next - addr;
>>       } while (pud++, addr = next, addr != end);
>> @@ -250,9 +314,11 @@ static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
>>   * Create the page directory entries and any necessary page tables for the
>>   * mapping specified by 'md'.
>>   */
>> -static void __init __create_mapping(pgd_t *pgd, phys_addr_t phys,
>> -                                 unsigned long virt, phys_addr_t size,
>> -                                 int map_io)
>> +static void __ref __create_mapping(pgd_t *pgd, phys_addr_t phys,
>> +                               unsigned long virt,
>> +                               phys_addr_t size,
>> +                               pgprot_t sect_prot, pgprot_t pte_prot,
>> +                               int map_io, bool early)
>>  {
>>       unsigned long addr, length, end, next;
>>
>> @@ -262,31 +328,140 @@ static void __init __create_mapping(pgd_t *pgd, phys_addr_t phys,
>>       end = addr + length;
>>       do {
>>               next = pgd_addr_end(addr, end);
>> -             alloc_init_pud(pgd, addr, next, phys, map_io);
>> +             alloc_init_pud(pgd, addr, next, phys, sect_prot, pte_prot,
>> +                             early, map_io);
>>               phys += next - addr;
>>       } while (pgd++, addr = next, addr != end);
>>  }
>>
>> -static void __init create_mapping(phys_addr_t phys, unsigned long virt,
>> -                               phys_addr_t size)
>> +void __init create_id_mapping(phys_addr_t addr, phys_addr_t size, int map_io)
>> +{
>> +     if ((addr >> PGDIR_SHIFT) >= ARRAY_SIZE(idmap_pg_dir)) {
>> +             pr_warn("BUG: not creating id mapping for %pa\n", &addr);
>> +             return;
>> +     }
>> +     __create_mapping(&idmap_pg_dir[pgd_index(addr)],
>> +                      addr, addr, size, PROT_SECT_NORMAL_EXEC,
>> +                      PAGE_KERNEL_EXEC, map_io, false);
>> +}
>> +
>> +static inline pmd_t *pmd_off_k(unsigned long virt)
>> +{
>> +     return pmd_offset(pud_offset(pgd_offset_k(virt), virt), virt);
>> +}
>> +
>> +#ifdef CONFIG_EARLY_PRINTK
>> +/*
>> + * Create an early I/O mapping using the pgd/pmd entries already populated
>> + * in head.S as this function is called too early to allocated any memory. The
>> + * mapping size is 2MB with 4KB pages or 64KB or 64KB pages.
>> + */
>> +void __iomem * __init early_io_map(phys_addr_t phys, unsigned long virt)
>> +{
>> +     unsigned long size, mask;
>> +     bool page64k = IS_ENABLED(CONFIG_ARM64_64K_PAGES);
>> +     pgd_t *pgd;
>> +     pud_t *pud;
>> +     pmd_t *pmd;
>> +     pte_t *pte;
>> +
>> +     /*
>> +      * No early pte entries with !ARM64_64K_PAGES configuration, so using
>> +      * sections (pmd).
>> +      */
>> +     size = page64k ? PAGE_SIZE : SECTION_SIZE;
>> +     mask = ~(size - 1);
>> +
>> +     pgd = pgd_offset_k(virt);
>> +     pud = pud_offset(pgd, virt);
>> +     if (pud_none(*pud))
>> +             return NULL;
>> +     pmd = pmd_offset(pud, virt);
>> +
>> +     if (page64k) {
>> +             if (pmd_none(*pmd))
>> +                     return NULL;
>> +             pte = pte_offset_kernel(pmd, virt);
>> +             set_pte(pte, __pte((phys & mask) | PROT_DEVICE_nGnRE));
>> +     } else {
>> +             set_pmd(pmd, __pmd((phys & mask) | PROT_SECT_DEVICE_nGnRE));
>> +     }
>> +
>> +     return (void __iomem *)((virt & mask) + (phys & ~mask));
>> +}
>> +#endif
>> +
>> +static void __ref create_mapping(phys_addr_t phys, unsigned long virt,
>> +                               phys_addr_t size,
>> +                               pgprot_t sect_prot, pgprot_t pte_prot)
>>  {
>>       if (virt < VMALLOC_START) {
>>               pr_warn("BUG: not creating mapping for %pa at 0x%016lx - outside kernel range\n",
>>                       &phys, virt);
>>               return;
>>       }
>> -     __create_mapping(pgd_offset_k(virt & PAGE_MASK), phys, virt, size, 0);
>> +
>> +     return __create_mapping(pgd_offset_k(virt & PAGE_MASK), phys, virt,
>> +                             size, sect_prot, pte_prot, 0, true);
>>  }
>>
>> -void __init create_id_mapping(phys_addr_t addr, phys_addr_t size, int map_io)
>> +static void __ref create_mapping_late(phys_addr_t phys, unsigned long virt,
>> +                               phys_addr_t size,
>> +                               pgprot_t sect_prot, pgprot_t pte_prot)
>>  {
>> -     if ((addr >> PGDIR_SHIFT) >= ARRAY_SIZE(idmap_pg_dir)) {
>> -             pr_warn("BUG: not creating id mapping for %pa\n", &addr);
>> +     if (virt < VMALLOC_START) {
>> +             pr_warn("BUG: not creating mapping for %pa at 0x%016lx - outside kernel range\n",
>> +                     &phys, virt);
>>               return;
>>       }
>> -     __create_mapping(&idmap_pg_dir[pgd_index(addr)],
>> -                      addr, addr, size, map_io);
>> +
>> +     return __create_mapping(pgd_offset_k(virt & PAGE_MASK), phys, virt,
>> +                             size, sect_prot, pte_prot, 0, false);
>> +}
>> +
>> +#ifdef CONFIG_DEBUG_RODATA
>> +static void __init __map_memblock(phys_addr_t start, phys_addr_t end)
>> +{
>> +     /*
>> +      * Set up the executable regions using the existing section mappings
>> +      * for now. This will get more fine grained later once all memory
>> +      * is mapped
>> +      */
>> +     unsigned long kernel_x_start = round_down(__pa(_stext), SECTION_SIZE);
>> +     unsigned long kernel_x_end = round_up(__pa(__init_end), SECTION_SIZE);
>> +
>> +     if (end < kernel_x_start) {
>> +             create_mapping(start, __phys_to_virt(start),
>> +                     end - start, PROT_SECT_NORMAL, PAGE_KERNEL);
>> +     } else if (start >= kernel_x_end) {
>> +             create_mapping(start, __phys_to_virt(start),
>> +                     end - start, PROT_SECT_NORMAL, PAGE_KERNEL);
>> +     } else {
>> +             if (start < kernel_x_start)
>> +                     create_mapping(start, __phys_to_virt(start),
>> +                             kernel_x_start - start,
>> +                             PROT_SECT_NORMAL,
>> +                             PAGE_KERNEL);
>> +             create_mapping(kernel_x_start,
>> +                             __phys_to_virt(kernel_x_start),
>> +                             kernel_x_end - kernel_x_start,
>> +                             PROT_SECT_NORMAL_EXEC, PAGE_KERNEL_EXEC);
>> +             if (kernel_x_end < end)
>> +                     create_mapping(kernel_x_end,
>> +                             __phys_to_virt(kernel_x_end),
>> +                             end - kernel_x_end,
>> +                             PROT_SECT_NORMAL,
>> +                             PAGE_KERNEL);
>> +     }
>> +
>> +}
>> +#else
>> +static void __init __map_memblock(phys_addr_t start, phys_addr_t end)
>> +{
>> +     create_mapping(start, __phys_to_virt(start), end - start,
>> +                     PROT_SECT_NORMAL_EXEC, PAGE_KERNEL_EXEC);
>>  }
>> +#endif
>>
>>  static void __init map_mem(void)
>>  {
>> @@ -328,14 +503,69 @@ static void __init map_mem(void)
>>                       memblock_set_current_limit(limit);
>>               }
>>  #endif
>> -
>> -             create_mapping(start, __phys_to_virt(start), end - start);
>> +             __map_memblock(start, end);
>>       }
>>
>>       /* Limit no longer required. */
>>       memblock_set_current_limit(MEMBLOCK_ALLOC_ANYWHERE);
>>  }
>>
>> +void __init fixup_executable(void)
>> +{
>> +#ifdef CONFIG_DEBUG_RODATA
>> +     /* now that we are actually fully mapped, make the start/end more fine grained */
>> +     if (!IS_ALIGNED((unsigned long)_stext, SECTION_SIZE)) {
>> +             unsigned long aligned_start = round_down(__pa(_stext),
>> +                                                     SECTION_SIZE);
>> +
>> +             create_mapping(aligned_start, __phys_to_virt(aligned_start),
>> +                             __pa(_stext) - aligned_start,
>> +                             PROT_SECT_NORMAL,
>> +                             PAGE_KERNEL);
>> +     }
>> +
>> +     if (!IS_ALIGNED((unsigned long)__init_end, SECTION_SIZE)) {
>> +             unsigned long aligned_end = round_up(__pa(__init_end),
>> +                                                     SECTION_SIZE);
>> +             create_mapping(__pa(__init_end), (unsigned long)__init_end,
>> +                             aligned_end - __pa(__init_end),
>> +                             PROT_SECT_NORMAL,
>> +                             PAGE_KERNEL);
>> +     }
>> +#endif
>> +}
>> +
>> +#ifdef CONFIG_DEBUG_RODATA
>> +void mark_rodata_ro(void)
>> +{
>> +     create_mapping_late(__pa(_stext), (unsigned long)_stext,
>> +                             (unsigned long)_etext - (unsigned long)_stext,
>> +                             PROT_SECT_NORMAL_EXEC | PMD_SECT_RDONLY,
>> +                             PAGE_KERNEL_EXEC | PTE_RDONLY);
>> +
>> +}
>> +#endif
>> +
>> +static int __flush_mappings(void *unused)
>> +{
>> +     flush_tlb_kernel_range((unsigned long)__init_begin,
>> +                             (unsigned long)__init_end);
>> +     return 0;
>> +}
>> +
>> +void __ref fixup_init(void)
>> +{
>> +     phys_addr_t start = __pa(__init_begin);
>> +     phys_addr_t end = __pa(__init_end);
>> +
>> +     create_mapping_late(start, (unsigned long)__init_begin,
>> +                     end - start,
>> +                     PROT_SECT_NORMAL,
>> +                     PAGE_KERNEL);
>> +     if (!IS_ALIGNED(start, SECTION_SIZE) || !IS_ALIGNED(end, SECTION_SIZE))
>> +             stop_machine(__flush_mappings, NULL, NULL);
>> +}
>> +
>>  /*
>>   * paging_init() sets up the page tables, initialises the zone memory
>>   * maps and sets up the zero page.
>> @@ -345,6 +575,7 @@ void __init paging_init(void)
>>       void *zero_page;
>>
>>       map_mem();
>> +     fixup_executable();
>>
>>       /*
>>        * Finally flush the caches and tlb to ensure that we're in a
>> --
>> Qualcomm Innovation Center, Inc.
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
>>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
