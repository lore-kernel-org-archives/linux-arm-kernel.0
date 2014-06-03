From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 3 Jun 2014 17:04:47 +0100
Subject: [PATCHv2 4/4] arm64: add better page protections to arm64
In-Reply-To: <1401742658-11841-5-git-send-email-lauraa@codeaurora.org>
References: <1401742658-11841-1-git-send-email-lauraa@codeaurora.org>
 <1401742658-11841-5-git-send-email-lauraa@codeaurora.org>
Message-ID: <CAPvkgC18+mcgKzMbABvLQfRo+XmX=pkTZOCd=JH0oMo2wsuFKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,
I have some comments below:

On 2 June 2014 21:57, Laura Abbott <lauraa@codeaurora.org> wrote:
>
> Add page protections for arm64 similar to those in arm or in
> progress for arm. This is for security reasons. The flow is
> currently:
>
> - Map all memory as either RWX or RW. We round to the nearest
>   section to avoid creating page tables before everything is mapped
> - Once everything is mapped, if either end of the RWX section should
>   not be X, we split the PMD and remap as necessary
> - When initmem is to be freed, we change the permissions back to
>   RW (using stop machine if necessary to flush the TLB)
> - If CONFIG_DEBUG_RODATA is set, the read only sections are set
>   read only.
>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
>  arch/arm64/Kconfig.debug        |  23 ++++++
>  arch/arm64/kernel/vmlinux.lds.S |  17 ++++
>  arch/arm64/mm/init.c            |   1 +
>  arch/arm64/mm/mm.h              |   2 +
>  arch/arm64/mm/mmu.c             | 173 ++++++++++++++++++++++++++++++++++++----
>  5 files changed, 200 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
> index 53979ac..f51f3af 100644
> --- a/arch/arm64/Kconfig.debug
> +++ b/arch/arm64/Kconfig.debug
> @@ -48,4 +48,27 @@ config DEBUG_SET_MODULE_RONX
>            against certain classes of kernel exploits.
>            If in doubt, say "N".
>
> +config DEBUG_RODATA
> +       bool "Make kernel text and rodata read-only"
> +       help
> +         If this is set, kernel text and rodata will be made read-only. This
> +         is to help catch accidental or malicious attempts to change the
> +         kernel's executable code. Additionally splits rodata from kernel
> +         text so it can be made explicitly non-executable.
> +
> +          If in doubt, say Y
> +
> +config DEBUG_ALIGN_RODATA
> +       depends on DEBUG_RODATA
> +       bool "Align linker sections up to SECTION_SIZE"
> +       help
> +         If this option is enabled, sections that may potentially be marked as
> +         read only or non-executable will be aligned up to the section size of
> +         the kernel. This prevents sections from being split into pages and
> +         avoids a potential TLB penalty. The downside is an increase in
> +         alignment and potentially wasted space. Turn on this option if
> +         performance is more important than memory pressure.
> +
> +         If in doubt, say N
> +
>  endmenu
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 4ba7a55..7643ae6 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -8,6 +8,7 @@
>  #include <asm/thread_info.h>
>  #include <asm/memory.h>
>  #include <asm/page.h>
> +#include <asm/pgtable.h>
>
>  #define ARM_EXIT_KEEP(x)
>  #define ARM_EXIT_DISCARD(x)    x
> @@ -52,6 +53,9 @@ SECTIONS
>                 _text = .;
>                 HEAD_TEXT
>         }
> +#ifdef DEBUG_ALIGN_RODATA
> +       . = ALIGN(1<<SECTION_SHIFT);
> +#endif
>         .text : {                       /* Real text segment            */
>                 _stext = .;             /* Text and read-only data      */
>                         __exception_text_start = .;
> @@ -68,19 +72,32 @@ SECTIONS
>                 *(.got)                 /* Global offset table          */
>         }
>
> +#ifdef DEBUG_ALIGN_RODATA
> +       . = ALIGN(1<<SECTION_SHIFT);
> +#endif
>         RO_DATA(PAGE_SIZE)
>         EXCEPTION_TABLE(8)
>         NOTES
>         _etext = .;                     /* End of text and rodata section */
>
> +#ifdef DEBUG_ALIGN_RODATA
> +       . = ALIGN(1<<SECTION_SHIFT);
> +#else
>         . = ALIGN(PAGE_SIZE);
> +#endif
>         __init_begin = .;
>
>         INIT_TEXT_SECTION(8)
>         .exit.text : {
>                 ARM_EXIT_KEEP(EXIT_TEXT)
>         }
> +
> +#ifdef DEBUG_ALIGN_RODATA
> +       . = ALIGN(1<<SECTION_SHIFT);
> +       __init_data_begin = .;
> +#else
>         . = ALIGN(16);
> +#endif
>         .init.data : {
>                 INIT_DATA
>                 INIT_SETUP(16)
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 51d5352..bc74a3a 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -325,6 +325,7 @@ void __init mem_init(void)
>
>  void free_initmem(void)
>  {
> +       fixup_init();
>         free_initmem_default(0);
>  }
>
> diff --git a/arch/arm64/mm/mm.h b/arch/arm64/mm/mm.h
> index d519f4f..82347d8 100644
> --- a/arch/arm64/mm/mm.h
> +++ b/arch/arm64/mm/mm.h
> @@ -1,2 +1,4 @@
>  extern void __init bootmem_init(void);
>  extern void __init arm64_swiotlb_init(void);
> +
> +void fixup_init(void);
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 0a472c4..1300886 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -26,6 +26,7 @@
>  #include <linux/memblock.h>
>  #include <linux/fs.h>
>  #include <linux/io.h>
> +#include <linux/stop_machine.h>
>
>  #include <asm/cputype.h>
>  #include <asm/sections.h>
> @@ -167,26 +168,67 @@ static void __init *early_alloc(unsigned long sz)
>         return ptr;
>  }
>
> -static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
> -                                 unsigned long end, unsigned long pfn)
> +/*
> + * remap a PMD into pages
> + */

As a heads-up, I've sent off a patch that makes use of 1GB pud
mappings for the kernel:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/253516.html

And Catalin has applied it (to his devel tree I think?):
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/254803.html

So some logic may be needed for split_pud.

> +static noinline void __ref split_pmd(pmd_t *pmd, pgprot_t prot, bool early)
> +{

prot does not appear to be used by this function?

> +       pte_t *pte, *start_pte;
> +       u64 val;
> +       unsigned long pfn;
> +       int i = 0;
> +
> +       val = pmd_val(*pmd);
> +
> +       if (early)
> +               start_pte = pte = early_alloc(PTRS_PER_PTE*sizeof(pte_t));
> +       else
> +               start_pte = pte = (pte_t *)__get_free_page(PGALLOC_GFP);
> +
> +       BUG_ON(!pte);
> +
> +
> +       pfn = __phys_to_pfn(val & PHYS_MASK);

Would it be better to have:
pfn = pmd_pfn(*pmd);

> +
> +       do {
> +               set_pte(pte, pfn_pte(pfn, PAGE_KERNEL_EXEC));
> +               pfn++;
> +       } while (pte++, i++, i < PTRS_PER_PTE);
> +
> +
> +       __pmd_populate(pmd, __pa(start_pte), PMD_TYPE_TABLE);
> +       flush_tlb_all();
> +}
> +
> +static void __ref alloc_init_pte(pmd_t *pmd, unsigned long addr,
> +                                 unsigned long end, unsigned long pfn,
> +                                 pgprot_t prot, bool early)
>  {
>         pte_t *pte;
>
>         if (pmd_none(*pmd)) {
> -               pte = early_alloc(PTRS_PER_PTE * sizeof(pte_t));
> +               if (early)
> +                       pte = early_alloc(PTRS_PER_PTE * sizeof(pte_t));
> +               else
> +                       pte = (pte_t *)__get_free_page(PGALLOC_GFP);
> +               BUG_ON(!pte);
>                 __pmd_populate(pmd, __pa(pte), PMD_TYPE_TABLE);
>         }
> -       BUG_ON(pmd_bad(*pmd));
> +
> +       if (pmd_bad(*pmd))
> +               split_pmd(pmd, prot, early);
>
>         pte = pte_offset_kernel(pmd, addr);
>         do {
> -               set_pte(pte, pfn_pte(pfn, PAGE_KERNEL_EXEC));
> +               set_pte(pte, pfn_pte(pfn, prot));
>                 pfn++;
>         } while (pte++, addr += PAGE_SIZE, addr != end);
>  }
>
> -static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
> -                                 unsigned long end, phys_addr_t phys)
> +static void __ref alloc_init_pmd(pud_t *pud, unsigned long addr,
> +                                 unsigned long end, phys_addr_t phys,
> +                                 pgprot_t sect_prot, pgprot_t pte_prot,
> +                                 bool early)
>  {
>         pmd_t *pmd;
>         unsigned long next;
> @@ -195,7 +237,11 @@ static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
>          * Check for initial section mappings in the pgd/pud and remove them.
>          */
>         if (pud_none(*pud) || pud_bad(*pud)) {
> -               pmd = early_alloc(PTRS_PER_PMD * sizeof(pmd_t));
> +               if (early)
> +                       pmd = early_alloc(PTRS_PER_PMD * sizeof(pmd_t));
> +               else
> +                       pmd = pmd_alloc_one(&init_mm, addr);
> +               BUG_ON(!pmd);
>                 pud_populate(&init_mm, pud, pmd);
>         }
>
> @@ -213,21 +259,25 @@ static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
>                         if (!pmd_none(old_pmd))
>                                 flush_tlb_all();
>                 } else {
> -                       alloc_init_pte(pmd, addr, next, __phys_to_pfn(phys));
> +                       alloc_init_pte(pmd, addr, next, __phys_to_pfn(phys),
> +                                       pte_prot, early);
>                 }
>                 phys += next - addr;
>         } while (pmd++, addr = next, addr != end);
>  }
>
> -static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
> -                                 unsigned long end, unsigned long phys)
> +static void __ref alloc_init_pud(pgd_t *pgd, unsigned long addr,
> +                                 unsigned long end, unsigned long phys,
> +                                 pgprot_t sect_prot, pgprot_t pte_prot,
> +                                 bool early)
>  {
>         pud_t *pud = pud_offset(pgd, addr);
>         unsigned long next;
>
>         do {
>                 next = pud_addr_end(addr, end);
> -               alloc_init_pmd(pud, addr, next, phys);
> +               alloc_init_pmd(pud, addr, next, phys, sect_prot, pte_prot,
> +                               early);
>                 phys += next - addr;
>         } while (pud++, addr = next, addr != end);
>  }
> @@ -236,8 +286,10 @@ static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
>   * Create the page directory entries and any necessary page tables for the
>   * mapping specified by 'md'.
>   */
> -static void __init create_mapping(phys_addr_t phys, unsigned long virt,
> -                                 phys_addr_t size)
> +static void __ref __create_mapping(phys_addr_t phys, unsigned long virt,
> +                                 phys_addr_t size,
> +                                 pgprot_t sect_prot, pgprot_t pte_prot,
> +                                 bool early)
>  {
>         unsigned long addr, length, end, next;
>         pgd_t *pgd;
> @@ -255,15 +307,37 @@ static void __init create_mapping(phys_addr_t phys, unsigned long virt,
>         end = addr + length;
>         do {
>                 next = pgd_addr_end(addr, end);
> -               alloc_init_pud(pgd, addr, next, phys);
> +               alloc_init_pud(pgd, addr, next, phys, sect_prot, pte_prot,
> +                               early);
>                 phys += next - addr;
>         } while (pgd++, addr = next, addr != end);
>  }
>
> +static void __ref create_mapping(phys_addr_t phys, unsigned long virt,
> +                                 phys_addr_t size,
> +                                 pgprot_t sect_prot, pgprot_t pte_prot)
> +{
> +       return __create_mapping(phys, virt, size, sect_prot, pte_prot, true);
> +}
> +
> +static void __ref create_mapping_late(phys_addr_t phys, unsigned long virt,
> +                                 phys_addr_t size,
> +                                 pgprot_t sect_prot, pgprot_t pte_prot)
> +{
> +       return __create_mapping(phys, virt, size, sect_prot, pte_prot, false);
> +}
> +
>  static void __init map_mem(void)
>  {
>         struct memblock_region *reg;
>         phys_addr_t limit;
> +       /*
> +        * Set up the executable regions using the exising section mappings

nit: existing

> +        * foir now. This will get more fine grained later once all memory

nit: for

> +        * is mapped
> +        */
> +       unsigned long kernel_x_start = round_down(__pa(_stext), SECTION_SIZE);
> +       unsigned long kernel_x_end = round_up(__pa(__init_end), SECTION_SIZE);

This logic is rounded to SECTION_SIZE, again a heads-up, the 1GB
mappings would benefit from some different logic.

>
>         /*
>          * Temporarily limit the memblock range. We need to do this as
> @@ -301,13 +375,79 @@ static void __init map_mem(void)
>                 }
>  #endif
>
> -               create_mapping(start, __phys_to_virt(start), end - start);
> +               if (end < kernel_x_start) {
> +                       create_mapping(start, __phys_to_virt(start), end - start,
> +                               prot_sect_kernel, pgprot_default);
> +               } else if (start >= kernel_x_end) {
> +                       create_mapping(start, __phys_to_virt(start), end - start,
> +                               prot_sect_kernel | PMD_SECT_PXN, pgprot_default | PTE_PXN);
> +               } else {
> +                       if (start < kernel_x_start)
> +                               create_mapping(start, __phys_to_virt(start), kernel_x_start - start,
> +                                       prot_sect_kernel | PMD_SECT_PXN, pgprot_default | PTE_PXN);
> +                       create_mapping(kernel_x_start, __phys_to_virt(kernel_x_start), kernel_x_end - kernel_x_start,
> +                               prot_sect_kernel, pgprot_default);
> +                       if (kernel_x_end < end)
> +                               create_mapping(kernel_x_end, __phys_to_virt(kernel_x_end), end - kernel_x_end,
> +                                       prot_sect_kernel | PMD_SECT_PXN, pgprot_default | PTE_PXN);
> +
> +
> +               }
> +

Could a config option perhaps be made available for people who are
happy to run with the simpler mappings?
create_mapping(start, __phys_to_virt(start), end - start);


>         }
>
>         /* Limit no longer required. */
>         memblock_set_current_limit(MEMBLOCK_ALLOC_ANYWHERE);
>  }
>
> +void __init fixup_executable(void)
> +{
> +       /* now that we are actually fully mapped, make the start/end more fine grained */
> +       if (!IS_ALIGNED((unsigned long)_stext, SECTION_SIZE)) {
> +               unsigned long aligned_start = round_down(__pa(_stext), SECTION_SIZE);
> +
> +               create_mapping(aligned_start, __phys_to_virt(aligned_start),
> +                               __pa(_stext) - aligned_start,
> +                               prot_sect_kernel | PMD_SECT_PXN,
> +                               pgprot_default | PTE_PXN);
> +       }
> +
> +       if (!IS_ALIGNED((unsigned long)__init_end, SECTION_SIZE)) {
> +               unsigned long aligned_end = round_up(__pa(__init_end), SECTION_SIZE);
> +               create_mapping(__pa(__init_end), (unsigned long)__init_end,
> +                               aligned_end - __pa(__init_end),
> +                               prot_sect_kernel | PMD_SECT_PXN, pgprot_default | PTE_PXN);
> +       }
> +}
> +
> +#ifdef CONFIG_DEBUG_RODATA
> +void mark_rodata_ro(void)
> +{
> +       create_mapping_late(__pa(_stext), (unsigned long)_stext, (unsigned long)_etext - (unsigned long)_stext,
> +                               prot_sect_kernel | PMD_SECT_RDONLY,
> +                               pgprot_default | PTE_RDONLY);
> +
> +}
> +#endif
> +
> +static int __flush_mappings(void *unused)
> +{
> +       flush_tlb_kernel_range((unsigned long)__init_begin, (unsigned long)__init_end);
> +       return 0;
> +}
> +
> +void __ref fixup_init(void)
> +{
> +       phys_addr_t start = __pa(__init_begin);
> +       phys_addr_t end = __pa(__init_end);
> +
> +       create_mapping_late(start, (unsigned long)__init_begin,
> +                       end - start,
> +                       prot_sect_kernel | PMD_SECT_PXN, pgprot_default | PTE_PXN);
> +       if (!IS_ALIGNED(start, SECTION_SIZE) || !IS_ALIGNED(end, SECTION_SIZE))
> +               stop_machine(__flush_mappings, NULL, NULL);
> +}
> +
>  /*
>   * paging_init() sets up the page tables, initialises the zone memory
>   * maps and sets up the zero page.
> @@ -317,6 +457,7 @@ void __init paging_init(void)
>         void *zero_page;
>
>         map_mem();
> +       fixup_executable();
>
>         /*
>          * Finally flush the caches and tlb to ensure that we're in a
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
>

Cheers,
--
Steve
