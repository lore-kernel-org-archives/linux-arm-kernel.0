From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 2 Jun 2017 18:30:17 +0100
Subject: [PATCH v2] mm: vmalloc: make vmalloc_to_page() deal with PMD/PUD
 mappings
In-Reply-To: <20170602155416.32706-1-ard.biesheuvel@linaro.org>
References: <20170602155416.32706-1-ard.biesheuvel@linaro.org>
Message-ID: <20170602173017.GP28299@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 02, 2017 at 03:54:16PM +0000, Ard Biesheuvel wrote:
> While vmalloc() itself strictly uses page mappings only on all
> architectures, some of the support routines are aware of the possible
> existence of PMD or PUD size mappings inside the VMALLOC region.
> This is necessary given that vmalloc() shares this region and the
> unmap routines with ioremap(), which may use huge pages on some
> architectures (HAVE_ARCH_HUGE_VMAP).
> 
> On arm64 running with 4 KB pages, VM_MAP mappings will exist in the
> VMALLOC region that are mapped to some extent using PMD size mappings.
> As reported by Zhong Jiang, this confuses the kcore code, given that
> vread() does not expect having to deal with PMD mappings, resulting
> in oopses.
> 
> Even though we could work around this by special casing kcore or vmalloc
> code for the VM_MAP mappings used by the arm64 kernel, the fact is that
> there is already a precedent for dealing with PMD/PUD mappings in the
> VMALLOC region, and so we could update the vmalloc_to_page() routine to
> deal with such mappings as well. This solves the problem, and brings us
> a step closer to huge page support in vmalloc/vmap, which could well be
> in our future anyway.
> 
> Reported-by: Zhong Jiang <zhongjiang@huawei.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> v2:
> - simplify so we can get rid of #ifdefs (drop huge_ptep_get(), which seems
>   unnecessary given that p?d_huge() can be assumed to imply p?d_present())
> - use HAVE_ARCH_HUGE_VMAP Kconfig define as indicator whether huge mappings
>   in the vmalloc range are to be expected, and VM_BUG_ON() otherwise

[...]

> @@ -289,9 +290,17 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
>  	pud = pud_offset(p4d, addr);
>  	if (pud_none(*pud))
>  		return NULL;
> +	if (pud_huge(*pud)) {
> +		VM_BUG_ON(!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP));
> +		return pud_page(*pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
> +	}
>  	pmd = pmd_offset(pud, addr);
>  	if (pmd_none(*pmd))
>  		return NULL;
> +	if (pmd_huge(*pmd)) {
> +		VM_BUG_ON(!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP));
> +		return pmd_page(*pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
> +	}

I don't think that it's correct to use the *_huge() helpers. Those
account for huge user mappings, and not arbitrary kernel space block
mappings.

You can disable CONFIG_HUGETLB_PAGE by deselecting  HUGETLBFS and
CGROUP_HUGETLB, in which cases the *_huge() helpers always return false,
even though the kernel may use block mappings.

Thanks,
Mark.
