From: will.deacon@arm.com (Will Deacon)
Date: Tue, 8 Oct 2013 11:26:42 +0100
Subject: [PATCH v3 5/6] ARM: mm: Recreate kernel mappings in
 early_paging_init()
In-Reply-To: <52530CD1.5010309@ti.com>
References: <1380835081-12129-1-git-send-email-santosh.shilimkar@ti.com>
 <1380835081-12129-6-git-send-email-santosh.shilimkar@ti.com>
 <20131004155958.GU24303@mudshark.cambridge.arm.com>
 <524EE8F4.4060407@ti.com> <52530CD1.5010309@ti.com>
Message-ID: <20131008102642.GC17148@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 08:34:41PM +0100, Santosh Shilimkar wrote:
> Will,

Hi Santosh,

> On Friday 04 October 2013 12:12 PM, Santosh Shilimkar wrote:
> > On Friday 04 October 2013 11:59 AM, Will Deacon wrote:
> >> On Thu, Oct 03, 2013 at 10:17:59PM +0100, Santosh Shilimkar wrote:
> >>> +	if (mdesc->init_meminfo) {
> >>> +		mdesc->init_meminfo();
> >>> +		/* Run the patch stub to update the constants */
> >>> +		fixup_pv_table(&__pv_table_begin,
> >>> +			(&__pv_table_end - &__pv_table_begin) << 2);
> >>> +
> >>> +		/*
> >>> +		 * Cache cleaning operations for self-modifying code
> >>> +		 * We should clean the entries by MVA but running a
> >>> +		 * for loop over every pv_table entry pointer would
> >>> +		 * just complicate the code.
> >>> +		 */
> >>> +		flush_cache_louis();
> >>> +		dsb();
> >>> +		isb();
> >>
> >> You don't need either of these barriers.
> >>
> > Agree. Just want to be clear, its because they are already present
> > in flush_cache_louis(), right ?
> > 
> Updated patch end of the email which addresses your comments. Regarding
> above barriers, we dropped the dsb() but I have to retain the isb()
> to commit the I-cache/BTB invalidate ops which are issued as part of
> flush_cache_louis(). Off-list I was discussing whether to patch cache-v7.S
> to add an isb to flush_cache_louis() with Russell but looking at other
> usages we though of leaving the isb() in my patch itself. Without the
> isb(), we see corruption on next v2p conversion.

Ok, further comments below.

> +void __init early_paging_init(const struct machine_desc *mdesc,
> +			      struct proc_info_list *procinfo)
> +{
> +	pmdval_t pmdprot = procinfo->__cpu_mm_mmu_flags;
> +	unsigned long map_start, map_end;
> +	pgd_t *pgd0, *pgdk;
> +	pud_t *pud0, *pudk, *pud_start;
> +	pmd_t *pmd0, *pmdk, *pmd_start;
> +	phys_addr_t phys;
> +	int i;
> +
> +	/* remap kernel code and data */
> +	map_start = init_mm.start_code;
> +	map_end   = init_mm.brk;
> +
> +	/* get a handle on things... */
> +	pgd0 = pgd_offset_k(0);
> +	pud_start = pud0 = pud_offset(pgd0, 0);
> +	pmd0 = pmd_offset(pud0, 0);
> +
> +	pgdk = pgd_offset_k(map_start);
> +	pudk = pud_offset(pgdk, map_start);
> +	pmd_start = pmdk = pmd_offset(pudk, map_start);
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
> +		 * just complicate the code. isb() is added to commit
> +		 * all the prior cp15 operations.
> +		 */
> +		flush_cache_louis();
> +		isb();

I see, you need the new __pv_tables to be visible for your page table
population below, right? In which case, I'm afraid I have to go back on my
original statement; you *do* need that dsb() prior to the isb() if you want
to ensure that the icache maintenance is complete and synchronised.

However, this really looks like an issue with the v7 cache flushing
routines. Why on Earth do they only guarantee completion on the D-side?

> +	}
> +
> +	/* remap level 1 table */
> +	for (i = 0; i < PTRS_PER_PGD; i++) {
> +		*pud0++ = __pud(__pa(pmd0) | PMD_TYPE_TABLE | L_PGD_SWAPPER);
> +		pmd0 += PTRS_PER_PMD;
> +	}
> +
> +	__cpuc_flush_dcache_area(pud_start, sizeof(pud_start) * PTRS_PER_PGD);
> +	outer_clean_range(virt_to_phys(pud_start), sizeof(pud_start) * PTRS_PER_PGD);

You don't need to flush these page tables if you're SMP. If you use
clean_dcache_area instead, it will do the right thing. The again, why can't
you use pud_populate and pmd_populate for these two loops? Is there an
interaction with coherency here? (if so, why don't you need to flush the
entire cache hierarchy anyway?)

> +	/* remap pmds for kernel mapping */
> +	phys = __pa(map_start) & PMD_MASK;
> +	i = 0;
> +	do {
> +		*pmdk++ = __pmd(phys | pmdprot);
> +		phys += PMD_SIZE;
> +		i++;
> +	} while (phys < map_end);
> +
> +	__cpuc_flush_dcache_area(pmd_start, sizeof(pmd_start) * i);
> +	outer_clean_range(virt_to_phys(pmd_start), sizeof(pmd_start) * i);
> +
> +	cpu_switch_mm(pgd0, &init_mm);
> +	cpu_set_ttbr(1, __pa(pgd0) + TTBR1_OFFSET);

I think you should have a local_flush_bp_all here.

> +	local_flush_tlb_all();

Will
