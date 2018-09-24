From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 24 Sep 2018 17:54:21 +0100
Subject: [PATCH v5 5/6] arm64/mm: Populate the swapper_pg_dir by fixmap.
In-Reply-To: <20180917044333.30051-6-yaojun8558363@gmail.com>
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
 <20180917044333.30051-6-yaojun8558363@gmail.com>
Message-ID: <20180924165421.77bjq5m32h5w7ffh@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2018 at 12:43:32PM +0800, Jun Yao wrote:
> Since we will move the swapper_pg_dir to rodata section, we need a
> way to update it. The fixmap can handle it. When the swapper_pg_dir
> needs to be updated, we map it dynamically. The map will be
> canceled after the update is complete. In this way, we can defend
> against KSMA(Kernel Space Mirror Attack).
> 
> Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 38 ++++++++++++++++++++++++++------
>  arch/arm64/mm/mmu.c              | 25 +++++++++++++++++++--
>  2 files changed, 54 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index b11d6fc62a62..9e643fc2453d 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -429,8 +429,29 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>  				 PUD_TYPE_TABLE)
>  #endif
>  
> +extern pgd_t init_pg_dir[PTRS_PER_PGD];
> +extern pgd_t init_pg_end[];
> +extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
> +extern pgd_t swapper_pg_end[];
> +extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
> +extern pgd_t tramp_pg_dir[PTRS_PER_PGD];
> +
> +extern void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd);
> +
> +static inline bool in_swapper_pgdir(void *addr)
> +{
> +	return ((unsigned long)addr & PAGE_MASK) ==
> +		((unsigned long)swapper_pg_dir & PAGE_MASK);
> +}
> +
>  static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>  {
> +#ifdef __PAGETABLE_PMD_FOLDED
> +	if (in_swapper_pgdir(pmdp)) {
> +		set_swapper_pgd((pgd_t *)pmdp, __pgd(pmd_val(pmd)));
> +		return;
> +	}
> +#endif

So that we can get consistent build coverage, could we make this:

	if (__is_defined(__PAGETABLE_PMD_FOLDED) && in_swapper_pgdir(pmdp)) {
		set_swapper_pgd((pgd_t *)pmdp, __pgd(pmd_val(pmd)));
		return;
	}

>  	WRITE_ONCE(*pmdp, pmd);
>  
>  	if (pmd_valid(pmd))
> @@ -484,6 +505,12 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
>  
>  static inline void set_pud(pud_t *pudp, pud_t pud)
>  {
> +#ifdef __PAGETABLE_PUD_FOLDED
> +	if (in_swapper_pgdir(pudp)) {
> +		set_swapper_pgd((pgd_t *)pudp, __pgd(pud_val(pud)));
> +		return;
> +	}
> +#endif

... and likewise:

	if (__is_enabled(__PAGETABLE_PUD_FOLDED) && in_swapper_pgdir(pudp)) {
		set_swapper_pgd((pgd_t *)pudp, __pgd(pud_val(pud)));
		return;
	}

Thanks,
Mark.
