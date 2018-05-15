From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 15 May 2018 16:05:49 +0200
Subject: [PATCH 2/3] x86/mm: add TLB purge to free pmd/pte page interfaces
In-Reply-To: <20180430175925.2657-3-toshi.kani@hpe.com>
References: <20180430175925.2657-1-toshi.kani@hpe.com>
 <20180430175925.2657-3-toshi.kani@hpe.com>
Message-ID: <20180515140549.GE18595@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2018 at 11:59:24AM -0600, Toshi Kani wrote:
>  int pud_free_pmd_page(pud_t *pud, unsigned long addr)
>  {
> -	pmd_t *pmd;
> +	pmd_t *pmd, *pmd_sv;
> +	pte_t *pte;
>  	int i;
>  
>  	if (pud_none(*pud))
>  		return 1;
>  
>  	pmd = (pmd_t *)pud_page_vaddr(*pud);
> +	pmd_sv = (pmd_t *)__get_free_page(GFP_KERNEL);

So you need to allocate a page to free a page? It is better to put the
pages into a list with a list_head on the stack.

I am still on favour of just reverting the broken commit and do a
correct and working fix for the/a merge window.


	Joerg
