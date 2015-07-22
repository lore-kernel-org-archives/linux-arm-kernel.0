From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 22 Jul 2015 15:17:20 +0100
Subject: [PATCH v3 1/5] mm: kasan: introduce generic
 kasan_populate_zero_shadow()
In-Reply-To: <1437561037-31995-2-git-send-email-a.ryabinin@samsung.com>
References: <1437561037-31995-1-git-send-email-a.ryabinin@samsung.com>
 <1437561037-31995-2-git-send-email-a.ryabinin@samsung.com>
Message-ID: <20150722141719.GA16627@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 22, 2015 at 01:30:33PM +0300, Andrey Ryabinin wrote:
> diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
> index e1840f3..2390dba 100644
> --- a/arch/x86/mm/kasan_init_64.c
> +++ b/arch/x86/mm/kasan_init_64.c
> @@ -12,9 +12,9 @@
>  extern pgd_t early_level4_pgt[PTRS_PER_PGD];
>  extern struct range pfn_mapped[E820_X_MAX];
>  
> -static pud_t kasan_zero_pud[PTRS_PER_PUD] __page_aligned_bss;
> -static pmd_t kasan_zero_pmd[PTRS_PER_PMD] __page_aligned_bss;
> -static pte_t kasan_zero_pte[PTRS_PER_PTE] __page_aligned_bss;
> +pud_t kasan_zero_pud[PTRS_PER_PUD] __page_aligned_bss;
> +pmd_t kasan_zero_pmd[PTRS_PER_PMD] __page_aligned_bss;
> +pte_t kasan_zero_pte[PTRS_PER_PTE] __page_aligned_bss;
>  
>  /*
>   * This page used as early shadow. We don't use empty_zero_page
> @@ -24,7 +24,7 @@ static pte_t kasan_zero_pte[PTRS_PER_PTE] __page_aligned_bss;
>   * that allowed to access, but not instrumented by kasan
>   * (vmalloc/vmemmap ...).
>   */
> -static unsigned char kasan_zero_page[PAGE_SIZE] __page_aligned_bss;
> +unsigned char kasan_zero_page[PAGE_SIZE] __page_aligned_bss;

Did you lose part of the patch when rebasing? I can see you copied
kasan_populate_zero_shadow() to the mm code but it's still present in
the x86 one and the above changes to remove static seem meaningless.

Or you plan to submit the rest of the x86 code separately?

BTW, you could even move kasan_zero_p[tme]d arrays to mm/.

> +static int __init zero_pmd_populate(pud_t *pud, unsigned long addr,
> +				unsigned long end)
> +{
> +	int ret = 0;
> +	pmd_t *pmd = pmd_offset(pud, addr);
> +	unsigned long next;
> +
> +	do {
> +		next = pmd_addr_end(addr, end);
> +
> +		if (IS_ALIGNED(addr, PMD_SIZE) && end - addr >= PMD_SIZE) {
> +			pmd_populate_kernel(&init_mm, pmd, kasan_zero_pte);
> +			continue;
> +		}
> +
> +		if (pmd_none(*pmd)) {
> +			void *p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
> +			if (!p)
> +				return -ENOMEM;
> +			pmd_populate_kernel(&init_mm, pmd, p);
> +		}
> +		zero_pte_populate(pmd, addr, pmd_addr_end(addr, end));

You could use "next" directly has the last argument here.

> +	} while (pmd++, addr = next, addr != end);
> +
> +	return ret;
> +}
> +
> +static int __init zero_pud_populate(pgd_t *pgd, unsigned long addr,
> +				unsigned long end)
> +{
> +	int ret = 0;
> +	pud_t *pud = pud_offset(pgd, addr);
> +	unsigned long next;
> +
> +	do {
> +		next = pud_addr_end(addr, end);
> +		if (IS_ALIGNED(addr, PUD_SIZE) && end - addr >= PUD_SIZE) {
> +			pmd_t *pmd;
> +
> +			pud_populate(&init_mm, pud, kasan_zero_pmd);
> +			pmd = pmd_offset(pud, addr);
> +			pmd_populate_kernel(&init_mm, pmd, kasan_zero_pte);
> +			continue;
> +		}
> +
> +		if (pud_none(*pud)) {
> +			void *p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
> +			if (!p)
> +				return -ENOMEM;
> +			pud_populate(&init_mm, pud, p);
> +		}
> +		zero_pmd_populate(pud, addr, pud_addr_end(addr, end));

Same here.

> +	} while (pud++, addr = next, addr != end);
> +
> +	return ret;
> +}
> +
> +static int __init zero_pgd_populate(unsigned long addr, unsigned long end)
> +{
> +	int ret = 0;
> +	pgd_t *pgd = pgd_offset_k(addr);
> +	unsigned long next;
> +
> +	do {
> +		next = pgd_addr_end(addr, end);
> +
> +		if (IS_ALIGNED(addr, PGDIR_SIZE) && end - addr >= PGDIR_SIZE) {
> +			pud_t *pud;
> +			pmd_t *pmd;
> +
> +			/*
> +			 * kasan_zero_pud should be populated with pmds
> +			 * at this moment.
> +			 * [pud,pmd]_populate*() bellow needed only for

s/bellow/below/

> +			 * 3,2 - level page tables where we don't have
> +			 * puds,pmds, so pgd_populate(), pud_populate()
> +			 * is noops.
> +			 */

-- 
Catalin
