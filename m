From: will.deacon@arm.com (Will Deacon)
Date: Fri, 4 Oct 2013 16:59:59 +0100
Subject: [PATCH v3 5/6] ARM: mm: Recreate kernel mappings in
 early_paging_init()
In-Reply-To: <1380835081-12129-6-git-send-email-santosh.shilimkar@ti.com>
References: <1380835081-12129-1-git-send-email-santosh.shilimkar@ti.com>
 <1380835081-12129-6-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20131004155958.GU24303@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 10:17:59PM +0100, Santosh Shilimkar wrote:
> This patch adds a step in the init sequence, in order to recreate
> the kernel code/data page table mappings prior to full paging
> initialization.  This is necessary on LPAE systems that run out of
> a physical address space outside the 4G limit.  On these systems,
> this implementation provides a machine descriptor hook that allows
> the PHYS_OFFSET to be overridden in a machine specific fashion.

[...]

> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index b1d17ee..47c7497 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -28,6 +28,7 @@
>  #include <asm/highmem.h>
>  #include <asm/system_info.h>
>  #include <asm/traps.h>
> +#include <asm/procinfo.h>
>  
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
> @@ -1315,6 +1316,87 @@ static void __init map_lowmem(void)
>  	}
>  }
>  
> +#ifdef CONFIG_ARM_LPAE
> +extern void fixup_pv_table(const void *, unsigned long);
> +extern const void *__pv_table_begin, *__pv_table_end;
> +
> +/*
> + * early_paging_init() recreates boot time page table setup, allowing machines
> + * to switch over to a high (>4G) address space on LPAE systems
> + */
> +void __init early_paging_init(const struct machine_desc *mdesc,
> +			      struct proc_info_list *procinfo)
> +{
> +	pmdval_t pmdprot = procinfo->__cpu_mm_mmu_flags;
> +	unsigned long map_start, map_end;
> +	pgd_t *pgd0, *pgdk;
> +	pud_t *pud0, *pudk;
> +	pmd_t *pmd0, *pmdk;
> +	phys_addr_t phys;
> +	int i;
> +
> +	/* remap kernel code and data */
> +	map_start = init_mm.start_code;
> +	map_end   = init_mm.brk;
> +
> +	/* get a handle on things... */
> +	pgd0 = pgd_offset_k(0);
> +	pud0 = pud_offset(pgd0, 0);
> +	pmd0 = pmd_offset(pud0, 0);
> +
> +	pgdk = pgd_offset_k(map_start);
> +	pudk = pud_offset(pgdk, map_start);
> +	pmdk = pmd_offset(pudk, map_start);
> +
> +	phys = PHYS_OFFSET;
> +
> +	if (mdesc->init_meminfo) {
> +		mdesc->init_meminfo();
> +		/* Run the patch stub to update the constants */
> +		fixup_pv_table(&__pv_table_begin,
> +			(&__pv_table_end - &__pv_table_begin) << 2);
> +
> +		/*
> +		 * Cache cleaning operations for self-modifying code
> +		 * We should clean the entries by MVA but running a
> +		 * for loop over every pv_table entry pointer would
> +		 * just complicate the code.
> +		 */
> +		flush_cache_louis();
> +		dsb();
> +		isb();

You don't need either of these barriers.

> +	}
> +
> +	/* remap level 1 table */
> +	for (i = 0; i < PTRS_PER_PGD; i++) {
> +		*pud0++ = __pud(__pa(pmd0) | PMD_TYPE_TABLE | L_PGD_SWAPPER);
> +		pmd0 += PTRS_PER_PMD;
> +	}
> +
> +	/* remap pmds for kernel mapping */
> +	phys = __pa(map_start) & PMD_MASK;
> +	do {
> +		*pmdk++ = __pmd(phys | pmdprot);
> +		phys += PMD_SIZE;
> +	} while (phys < map_end);
> +
> +	flush_cache_all();

Why are you being so heavyweight with your cacheflushing? If you're just
interested in flushing the new page tables, then use the proper accessors to
build them. The only case I think you need to flush the world is for VIVT,
which you won't have with LPAE (you could have a BUG_ON here).

> +	cpu_set_ttbr(0, __pa(pgd0));
> +	cpu_set_ttbr(1, __pa(pgd0) + TTBR1_OFFSET);

Can you not use cpu_switch_mm with the init_mm for this?

Will
