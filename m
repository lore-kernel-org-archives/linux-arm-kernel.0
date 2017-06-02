From: dave.hansen@intel.com (Dave Hansen)
Date: Fri, 2 Jun 2017 07:29:42 -0700
Subject: [PATCH] mm: vmalloc: make vmalloc_to_page() deal with PMD/PUD
 mappings
In-Reply-To: <20170602112720.28948-1-ard.biesheuvel@linaro.org>
References: <20170602112720.28948-1-ard.biesheuvel@linaro.org>
Message-ID: <e98368d8-b1bc-5804-2115-370ec7109e9b@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/2017 04:27 AM, Ard Biesheuvel wrote:
> +static struct page *vmalloc_to_pud_page(unsigned long addr, pud_t *pud)
> +{
> +	struct page *page = NULL;
> +#ifdef CONFIG_HUGETLB_PAGE

Do we really want this based on hugetlbfs?  Won't this be dead code on x86?

Also, don't we discourage #ifdefs in .c files?

> +	pte_t pte = huge_ptep_get((pte_t *)pud);
> +
> +	if (pte_present(pte))
> +		page = pud_page(*pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);

x86 has pmd/pud_page().  Seems a bit silly to open-code it here.

> +#else
> +	VIRTUAL_BUG_ON(1);
> +#endif
> +	return page;
> +}

So if somebody manages to call this function on a huge page table entry,
but doesn't have hugetlbfs configured on, we kill the machine?
