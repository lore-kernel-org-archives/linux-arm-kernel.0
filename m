From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 26 Nov 2015 14:48:59 +0000
Subject: [PATCH RFT] arm64: kasan: Make KASAN work with 16K pages + 48
 bit VA
In-Reply-To: <1448543686-31869-1-git-send-email-aryabinin@virtuozzo.com>
References: <1448543686-31869-1-git-send-email-aryabinin@virtuozzo.com>
Message-ID: <20151126144859.GE32343@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 26, 2015 at 04:14:46PM +0300, Andrey Ryabinin wrote:
> Currently kasan assumes that shadow memory covers one or more entire PGDs.
> That's not true for 16K pages + 48bit VA space, where PGDIR_SIZE is bigger
> than the whole shadow memory.
> 
> This patch tries to fix that case.
> clear_page_tables() is a new replacement of clear_pgs(). Instead of always
> clearing pgds it clears top level page table entries that entirely belongs
> to shadow memory.
> In addition to 'tmp_pg_dir' we now have 'tmp_pud' which is used to store
> puds that now might be cleared by clear_page_tables.
> 
> Reported-by: Suzuki K. Poulose <Suzuki.Poulose@arm.com>
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> ---
> 
>  *** THIS is not tested with 16k pages ***
> 
>  arch/arm64/mm/kasan_init.c | 87 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 76 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index cf038c7..ea9f92a 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -22,6 +22,7 @@
>  #include <asm/tlbflush.h>
>  
>  static pgd_t tmp_pg_dir[PTRS_PER_PGD] __initdata __aligned(PGD_SIZE);
> +static pud_t tmp_pud[PAGE_SIZE/sizeof(pud_t)] __initdata __aligned(PAGE_SIZE);
>  
>  static void __init kasan_early_pte_populate(pmd_t *pmd, unsigned long addr,
>  					unsigned long end)
> @@ -92,20 +93,84 @@ asmlinkage void __init kasan_early_init(void)
>  {
>  	BUILD_BUG_ON(KASAN_SHADOW_OFFSET != KASAN_SHADOW_END - (1UL << 61));
>  	BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_START, PGDIR_SIZE));
> -	BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_END, PGDIR_SIZE));
> +	BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_END, PUD_SIZE));

We also assume that even in the shared PUD case, the shadow region falls
within the same PGD entry, or we would need more than a single tmp_pud.

It would be good to test for that.

>  	kasan_map_early_shadow();
>  }
>  
> -static void __init clear_pgds(unsigned long start,
> -			unsigned long end)
> +static void __init clear_pmds(pud_t *pud, unsigned long addr, unsigned long end)
>  {
> +	pmd_t *pmd;
> +	unsigned long next;
> +
> +	pmd = pmd_offset(pud, addr);
> +
> +	do {
> +		next = pmd_addr_end(addr, end);
> +		if (IS_ALIGNED(addr, PMD_SIZE) && end - addr >= PMD_SIZE)
> +			pmd_clear(pmd);
> +
> +	} while (pmd++, addr = next, addr != end);
> +}
> +
> +static void __init clear_puds(pgd_t *pgd, unsigned long addr, unsigned long end)
> +{
> +	pud_t *pud;
> +	unsigned long next;
> +
> +	pud = pud_offset(pgd, addr);
> +
> +	do {
> +		next = pud_addr_end(addr, end);
> +		if (IS_ALIGNED(addr, PUD_SIZE) && end - addr >= PUD_SIZE)
> +			pud_clear(pud);

I think this can just be:

		if (next - addr == PUD_SIZE)
			pud_clear(pud);

Given that next can at most be PUD_SIZE from addr, and if so we knwo
addr is aligned.

> +
> +		if (!pud_none(*pud))
> +			clear_pmds(pud, addr, next);

I don't understand this. The KASAN shadow region is PUD_SIZE aligned at
either end, so KASAN should never own a partial pud entry like this.

Regardless, were this case to occur, surely we'd be clearing pmd entries
in the active page tables? We didn't copy anything at the pmd level.

That doesn't seem right.

> +	} while (pud++, addr = next, addr != end);
> +}
> +
> +static void __init clear_page_tables(unsigned long addr, unsigned long end)
> +{
> +	pgd_t *pgd;
> +	unsigned long next;
> +
> +	pgd = pgd_offset_k(addr);
> +
> +	do {
> +		next = pgd_addr_end(addr, end);
> +		if (IS_ALIGNED(addr, PGDIR_SIZE) && end - addr >= PGDIR_SIZE)
> +			pgd_clear(pgd);

As with clear_puds, I think this can be:

		if (next - addr == PGDIR_SIZE)
			pgd_clear(pgd);

> +
> +		if (!pgd_none(*pgd))
> +			clear_puds(pgd, addr, next);
> +	} while (pgd++, addr = next, addr != end);
> +}
> +
> +static void copy_pagetables(void)
> +{
> +	pgd_t *pgd = tmp_pg_dir + pgd_index(KASAN_SHADOW_START);
> +
> +	memcpy(tmp_pg_dir, swapper_pg_dir, sizeof(tmp_pg_dir));
> +
>  	/*
> -	 * Remove references to kasan page tables from
> -	 * swapper_pg_dir. pgd_clear() can't be used
> -	 * here because it's nop on 2,3-level pagetable setups
> +	 * If kasan shadow shares PGD with other mappings,
> +	 * clear_page_tables() will clear puds instead of pgd,
> +	 * so we need temporary pud table to keep early shadow mapped.
>  	 */
> -	for (; start < end; start += PGDIR_SIZE)
> -		set_pgd(pgd_offset_k(start), __pgd(0));
> +	if (PGDIR_SIZE > KASAN_SHADOW_END - KASAN_SHADOW_START) {
> +		pud_t *pud;
> +		pmd_t *pmd;
> +		pte_t *pte;
> +
> +		memcpy(tmp_pud, pgd_page_vaddr(*pgd), sizeof(tmp_pud));
> +
> +		pgd_populate(&init_mm, pgd, tmp_pud);
> +		pud = pud_offset(pgd, KASAN_SHADOW_START);
> +		pmd = pmd_offset(pud, KASAN_SHADOW_START);
> +		pud_populate(&init_mm, pud, pmd);
> +		pte = pte_offset_kernel(pmd, KASAN_SHADOW_START);
> +		pmd_populate_kernel(&init_mm, pmd, pte);

I don't understand why we need to do anything below the pud level here.
We only copy down to the pud level, and we already initialised the
shared ptes and pmds earlier.

Regardless of this patch, we currently initialise the shared tables
repeatedly, which is redundant after the first time we initialise them.
We could improve that.

> +	}
>  }
>  
>  static void __init cpu_set_ttbr1(unsigned long ttbr1)
> @@ -123,16 +188,16 @@ void __init kasan_init(void)
>  
>  	/*
>  	 * We are going to perform proper setup of shadow memory.
> -	 * At first we should unmap early shadow (clear_pgds() call bellow).
> +	 * At first we should unmap early shadow (clear_page_tables()).
>  	 * However, instrumented code couldn't execute without shadow memory.
>  	 * tmp_pg_dir used to keep early shadow mapped until full shadow
>  	 * setup will be finished.
>  	 */
> -	memcpy(tmp_pg_dir, swapper_pg_dir, sizeof(tmp_pg_dir));
> +	copy_pagetables();
>  	cpu_set_ttbr1(__pa(tmp_pg_dir));
>  	flush_tlb_all();

As a heads-up, I will shortly have patches altering the swap of TTBR1,
as it risks conflicting TLB entries and misses barriers.

Otherwise, we need a dsb(ishst) between the memcpy and writing to the
TTBR to ensure that the tables are visible to the MMU.

Thanks,
Mark.
