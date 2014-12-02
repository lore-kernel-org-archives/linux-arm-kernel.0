From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 2 Dec 2014 18:28:27 +0000
Subject: [PATCHv6] arm64: add better page protections to arm64
In-Reply-To: <1416606645-25633-9-git-send-email-lauraa@codeaurora.org>
References: <1416606645-25633-1-git-send-email-lauraa@codeaurora.org>
 <1416606645-25633-9-git-send-email-lauraa@codeaurora.org>
Message-ID: <20141202182827.GF29792@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 09:50:45PM +0000, Laura Abbott wrote:
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -26,6 +26,7 @@
>  #include <linux/memblock.h>
>  #include <linux/fs.h>
>  #include <linux/io.h>
> +#include <linux/stop_machine.h>
> 
>  #include <asm/cputype.h>
>  #include <asm/fixmap.h>
> @@ -137,17 +138,50 @@ static void __init *early_alloc(unsigned long sz)
>         return ptr;
>  }
> 
> -static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
> +/*
> + * remap a PMD into pages
> + */
> +static noinline void split_pmd(pmd_t *pmd,
> +                               void *(*alloc)(unsigned long size))

Please drop the inline/noinline annotations, just let the compiler do
the work.

> +{
> +       pte_t *pte, *start_pte;
> +       unsigned long pfn;
> +       int i = 0;
> +
> +       start_pte = pte = alloc(PTRS_PER_PTE*sizeof(pte_t));
> +       BUG_ON(!pte);
> +
> +       pfn = pmd_pfn(*pmd);
> +
> +       do {
> +               /*
> +                * Need to have the least restrictive permissions available
> +                * permissions will be fixed up later
> +                */
> +               set_pte(pte, pfn_pte(pfn, PAGE_KERNEL_EXEC));
> +               pfn++;
> +       } while (pte++, i++, i < PTRS_PER_PTE);
> +
> +
> +       __pmd_populate(pmd, __pa(start_pte), PMD_TYPE_TABLE);
> +       flush_tlb_all();
> +}

For consistency, can we not have split_pmd similar to split_pud (i.e.
avoid allocation in split_pmd, just populate with the given pmd)?

> +
> +static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
>                                   unsigned long end, unsigned long pfn,
> -                                 pgprot_t prot)
> +                                 pgprot_t prot,
> +                                 void *(*alloc)(unsigned long size))
>  {
>         pte_t *pte;
> 
>         if (pmd_none(*pmd)) {
> -               pte = early_alloc(PTRS_PER_PTE * sizeof(pte_t));
> +               pte = alloc(PTRS_PER_PTE * sizeof(pte_t));
> +               BUG_ON(!pte);

I wonder whether we should put the BUG_ON in the alloc functions to keep
the code simpler.

>                 __pmd_populate(pmd, __pa(pte), PMD_TYPE_TABLE);
>         }
> -       BUG_ON(pmd_bad(*pmd));
> +
> +       if (pmd_bad(*pmd))
> +               split_pmd(pmd, alloc);

I would use pmd_sect(*pmd) instead, it gives an indication on why it
needs splitting.

> +static inline bool use_1G_block(unsigned long addr, unsigned long next,
> +                       unsigned long phys, pgprot_t sect_prot,
> +                       pgprot_t pte_prot)
> +{
> +       if (PAGE_SHIFT != 12)
> +               return false;
> +
> +       if (((addr | next | phys) & ~PUD_MASK) != 0)
> +               return false;
> +
> +       /*
> +        * The assumption here is that if the memory is anything other
> +        * than normal we should not be using a block type
> +        */

Why? I know the original code had a !map_io check but I don't remember
why we actually need this limitation.

> +#ifdef CONFIG_DEBUG_RODATA
> +static void __init __map_memblock(phys_addr_t start, phys_addr_t end)
> +{
> +       /*
> +        * Set up the executable regions using the existing section mappings
> +        * for now. This will get more fine grained later once all memory
> +        * is mapped
> +        */
> +       unsigned long kernel_x_start = round_down(__pa(_stext), SECTION_SIZE);
> +       unsigned long kernel_x_end = round_up(__pa(__init_end), SECTION_SIZE);
> +
> +       if (end < kernel_x_start) {
> +               create_mapping(start, __phys_to_virt(start),
> +                       end - start, PROT_SECT_NORMAL, PAGE_KERNEL);
> +       } else if (start >= kernel_x_end) {
> +               create_mapping(start, __phys_to_virt(start),
> +                       end - start, PROT_SECT_NORMAL, PAGE_KERNEL);
> +       } else {
> +               if (start < kernel_x_start)
> +                       create_mapping(start, __phys_to_virt(start),
> +                               kernel_x_start - start,
> +                               PROT_SECT_NORMAL,
> +                               PAGE_KERNEL);
> +               create_mapping(kernel_x_start,
> +                               __phys_to_virt(kernel_x_start),
> +                               kernel_x_end - kernel_x_start,
> +                               PROT_SECT_NORMAL_EXEC, PAGE_KERNEL_EXEC);
> +               if (kernel_x_end < end)
> +                       create_mapping(kernel_x_end,
> +                               __phys_to_virt(kernel_x_end),
> +                               end - kernel_x_end,
> +                               PROT_SECT_NORMAL,
> +                               PAGE_KERNEL);
> +       }

Do we care about the init section? It will get freed eventually (though
I guess we could spot early bugs modifying such code).

Anyway, can you not do something similar here for the rest of the kernel
text to avoid re-adjusting the page attributes later?

> +struct flush_addr {
> +       unsigned long start;
> +       unsigned long end;
> +};
> +
> +static int __flush_mappings(void *val)
> +{
> +       struct flush_addr *data = val;
> +
> +       flush_tlb_kernel_range(data->start, data->end);
> +       return 0;
> +}
> +
> +static void adjust_mem(unsigned long vstart, unsigned long vend,
> +                       phys_addr_t phys,
> +                       pgprot_t sect_prot, pgprot_t pte_prot)
> +{
> +       struct flush_addr f;
> +
> +       create_mapping_late(phys, vstart, vend - vstart,
> +                       sect_prot, pte_prot);
> +
> +       if (!IS_ALIGNED(vstart, SECTION_SIZE) || !IS_ALIGNED(vend, SECTION_SIZE)) {
> +               f.start = vstart;
> +               f.end = vend;
> +               stop_machine(__flush_mappings, &f, NULL);
> +       }

Maybe this was discussed on earlier versions of this patch but why do
you need stop_machine() here? A TLB flush would be broadcast by hardware
automatically to all the other CPUs.

I need to go again through this patch and see if there is a better
option than overloading the alloc_init_*() functions for adjusting ptes
(or maybe avoid adjusting altogether if we create them with the right
attributes from the beginning).

-- 
Catalin
