From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 17 Jul 2014 12:18:06 -0400
Subject: [PATCH 0/3] ARM: mvebu: disable I/O coherency on !SMP
In-Reply-To: <20140717161010.GY21766@n2100.arm.linux.org.uk>
References: <1404318070-8503-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <10673994.kkICTRHJxL@wuerfel> <20140717153401.GX21766@n2100.arm.linux.org.uk>
 <5105942.b7kcvNdlC8@wuerfel> <53C7F40A.800@ti.com>
 <20140717161010.GY21766@n2100.arm.linux.org.uk>
Message-ID: <53C7F73E.1020901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 July 2014 12:10 PM, Russell King - ARM Linux wrote:
> On Thu, Jul 17, 2014 at 12:04:26PM -0400, Santosh Shilimkar wrote:
>> Thanks for spotting it RMK. Will have a loot at it.
> 
> I already have this for it - which includes a lot more comments on the
> code (some in anticipation of the reply from the architecture people.)
> The first hunk alone should fix the spotted problem.
> 
Cool. The alignment fix was easy but I was more worried about the
other part. Thanks for the those additional comments. 

> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index ab14b79b03f0..917aabd6b2dc 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1406,8 +1406,8 @@ void __init early_paging_init(const struct machine_desc *mdesc,
>  		return;
>  
>  	/* remap kernel code and data */
> -	map_start = init_mm.start_code;
> -	map_end   = init_mm.brk;
> +	map_start = init_mm.start_code & PMD_MASK;
> +	map_end   = ALIGN(init_mm.brk, PMD_SIZE);
>  
>  	/* get a handle on things... */
>  	pgd0 = pgd_offset_k(0);
> @@ -1434,23 +1434,60 @@ void __init early_paging_init(const struct machine_desc *mdesc,
>  	dsb(ishst);
>  	isb();
>  
> -	/* remap level 1 table */
> +	/*
> +	 * WARNING: This code is not architecturally compliant: we modify
> +	 * the mappings in-place, indeed while they are in use by this
> +	 * very same code.
> +	 *
> +	 * Even modifying the mappings in a separate page table does
> +	 * not resolve this.
> +	 *
> +	 * The architecture strongly recommends that when a mapping is
> +	 * changed, that it is changed by first going via an invalid
> +	 * mapping and back to the new mapping.  This is to ensure
> +	 * that no TLB conflicts (caused by the TLB having more than
> +	 * one TLB entry match a translation) can occur.
> +	 */
> +
> +	/*
> +	 * Remap level 1 table.  This changes the physical addresses
> +	 * used to refer to the level 2 page tables to the high
> +	 * physical address alias, leaving everything else the same.
> +	 */
>  	for (i = 0; i < PTRS_PER_PGD; pud0++, i++) {
>  		set_pud(pud0,
>  			__pud(__pa(pmd0) | PMD_TYPE_TABLE | L_PGD_SWAPPER));
>  		pmd0 += PTRS_PER_PMD;
>  	}
>  
> -	/* remap pmds for kernel mapping */
> -	phys = __pa(map_start) & PMD_MASK;
> +	/*
> +	 * Remap the level 2 table, pointing the mappings at the high
> +	 * physical address alias of these pages.
> +	 */
> +	phys = __pa(map_start);
>  	do {
>  		*pmdk++ = __pmd(phys | pmdprot);
>  		phys += PMD_SIZE;
>  	} while (phys < map_end);
>  
> +	/*
> +	 * Ensure that the above updates are flushed out of the cache.
> +	 * This is not strictly correct; on a system where the caches
> +	 * are coherent with each other, but the MMU page table walks
> +	 * may not be coherent, flush_cache_all() may be a no-op, and
> +	 * this will fail.
> +	 */
>  	flush_cache_all();
> +
> +	/*
> +	 * Re-write the TTBR values to point them at the high physical
> +	 * alias of the page tables.  We expect __va() will work on
> +	 * cpu_get_pgd(), which returns the value of TTBR0.
> +	 */
>  	cpu_switch_mm(pgd0, &init_mm);
>  	cpu_set_ttbr(1, __pa(pgd0) + TTBR1_OFFSET);
> +
> +	/* Finally flush any stale TLB values. */
>  	local_flush_bp_all();
>  	local_flush_tlb_all();
>  }
> 
> 
