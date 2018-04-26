From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 26 Apr 2018 16:19:26 +0200
Subject: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
In-Reply-To: <20180314180155.19492-3-toshi.kani@hpe.com>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
 <20180314180155.19492-3-toshi.kani@hpe.com>
Message-ID: <20180426141926.GN15462@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Toshi, Andrew,

this patch(-set) is broken in several ways, please see below.

On Wed, Mar 14, 2018 at 12:01:55PM -0600, Toshi Kani wrote:
> Implement pud_free_pmd_page() and pmd_free_pte_page() on x86, which
> clear a given pud/pmd entry and free up lower level page table(s).
> Address range associated with the pud/pmd entry must have been purged
> by INVLPG.

An INVLPG before actually unmapping the page is useless, as other cores
or even speculative instruction execution can bring the TLB entry back
before the code actually unmaps the page.

>  int pud_free_pmd_page(pud_t *pud)
>  {
> -	return pud_none(*pud);
> +	pmd_t *pmd;
> +	int i;
> +
> +	if (pud_none(*pud))
> +		return 1;
> +
> +	pmd = (pmd_t *)pud_page_vaddr(*pud);
> +
> +	for (i = 0; i < PTRS_PER_PMD; i++)
> +		if (!pmd_free_pte_page(&pmd[i]))
> +			return 0;
> +
> +	pud_clear(pud);

TLB flush needed here, before the page is freed.

> +	free_page((unsigned long)pmd);
> +
> +	return 1;
>  }
>  
>  /**
> @@ -724,6 +739,15 @@ int pud_free_pmd_page(pud_t *pud)
>   */
>  int pmd_free_pte_page(pmd_t *pmd)
>  {
> -	return pmd_none(*pmd);
> +	pte_t *pte;
> +
> +	if (pmd_none(*pmd))
> +		return 1;
> +
> +	pte = (pte_t *)pmd_page_vaddr(*pmd);
> +	pmd_clear(pmd);

Same here, TLB flush needed.

Further this needs synchronization with other page-tables in the system
when the kernel PMDs are not shared between processes. In x86-32 with
PAE this causes a BUG_ON() being triggered at arch/x86/mm/fault.c:268
because the page-tables are not correctly synchronized.

> +	free_page((unsigned long)pte);
> +
> +	return 1;
>  }
>  #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
