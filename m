From: r.sricharan@ti.com (R, Sricharan)
Date: Fri, 17 Aug 2012 16:32:22 +0530
Subject: [PATCH v2 1/1] ARM: LPAE: Fix mapping in alloc_init_pte for
 unaligned addresses.
In-Reply-To: <1344238885-13683-1-git-send-email-r.sricharan@ti.com>
References: <1344238885-13683-1-git-send-email-r.sricharan@ti.com>
Message-ID: <CAJ7qFSeoyVGie__3mJ8=edeEf7Jh7TQY8vcWgGdOtWVXa8TU0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> With LPAE, When either the start address or end address
> or physical address to be mapped is unaligned,
> alloc_init_section creates page granularity mappings.
> alloc_init_section calls alloc_init_pte which populates
> one pmd entry and sets up the ptes. But if the size is
> greater than what can be mapped by one pmd entry,
> then the rest remains unmapped.
>
> The issue becomes visible when LPAE is enabled, where we have
> the 3 levels with seperate pgd and pmd's.
> When a static mapping for 3MB is requested, only 2MB is mapped
> and the remaining 1MB is unmapped. Fixing this here, by looping
> in to map the entire unaligned address range.
>
> Boot tested on OMAP5 evm with both LPAE enabled/disabled
> and verified that static mappings with unaligned addresses
> are properly mapped.
>
> Signed-off-by: R Sricharan <r.sricharan@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
> [V2] Moved the loop to alloc_init_pte as per Russell's
>      feedback and changed the subject accordingly.
>      Using PMD_XXX instead of SECTION_XXX to avoid
>      different loop increments with/without LPAE.
>
>  arch/arm/mm/mmu.c |   22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index cf4528d..0ed8808 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -585,11 +585,25 @@ static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
>                                   unsigned long end, unsigned long pfn,
>                                   const struct mem_type *type)
>  {
> -       pte_t *pte = early_pte_alloc(pmd, addr, type->prot_l1);
> +       unsigned long next;
> +       pte_t *pte;
> +       phys_addr_t phys;
> +
>         do {
> -               set_pte_ext(pte, pfn_pte(pfn, __pgprot(type->prot_pte)), 0);
> -               pfn++;
> -       } while (pte++, addr += PAGE_SIZE, addr != end);
> +               if ((end-addr) & PMD_MASK)
> +                       next = (addr + PMD_SIZE) & PMD_MASK;
> +               else
> +                       next = end;
> +
> +               pte = early_pte_alloc(pmd, addr, type->prot_l1);
> +               do {
> +                       set_pte_ext(pte, pfn_pte(pfn,
> +                                       __pgprot(type->prot_pte)), 0);
> +                       pfn++;
> +               } while (pte++, addr += PAGE_SIZE, addr != next);
> +
> +               phys += next - addr;
> +       } while (pmd++, addr = next, addr != end);
>  }
>
  ping..

Thanks,
 Sricharan
