From: james.morse@arm.com (James Morse)
Date: Wed, 25 Jan 2017 15:49:56 +0000
Subject: [PATCH v30 04/11] arm64: mm: allow for unmapping memory region
 from kernel mapping
In-Reply-To: <20170124085004.3892-3-takahiro.akashi@linaro.org>
References: <20170124084638.3770-1-takahiro.akashi@linaro.org>
 <20170124085004.3892-3-takahiro.akashi@linaro.org>
Message-ID: <5888C924.9080100@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 24/01/17 08:49, AKASHI Takahiro wrote:
> The current implementation of create_mapping_late() is only allowed
> to modify permission attributes (read-only or read-write) against
> the existing kernel mapping.
> 
> In this patch, PAGE_KERNEL_INVALID protection attribute is introduced.
> We will now be able to invalidate (or unmap) some part of the existing

Can we stick to calling this 'unmap', otherwise 'invalidate this page range'
becomes ambiguous, cache maintenance or page-table manipulation?!


> kernel mapping by specifying PAGE_KERNEL_INVALID to create_mapping_late().
> 
> This feature will be used in a suceeding kdump patch to protect
> the memory reserved for crash dump kernel once after loaded.

> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 17243e43184e..9c7adcce8e4e 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -190,7 +192,8 @@ static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
>  			 * Set the contiguous bit for the subsequent group of
>  			 * PMDs if its size and alignment are appropriate.
>  			 */
> -			if (((addr | phys) & ~CONT_PMD_MASK) == 0) {

> +			if ((pgprot_val(prot) | PMD_VALID) &&

& PMD_VALID?


> +			    ((addr | phys) & ~CONT_PMD_MASK) == 0) {
>  				if (end - addr >= CONT_PMD_SIZE)
>  					__prot = __pgprot(pgprot_val(prot) |
>  							  PTE_CONT);
> @@ -203,7 +206,8 @@ static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
>  			 * After the PMD entry has been populated once, we
>  			 * only allow updates to the permission attributes.
>  			 */
> -			BUG_ON(!pgattr_change_is_safe(pmd_val(old_pmd),
> +			BUG_ON(pmd_valid(old_pmd) && pmd_valid(*pmd) &&
> +			       !pgattr_change_is_safe(pmd_val(old_pmd),
>  						      pmd_val(*pmd)));

Could you add PTE_VALID checks to pgattr_change_is_safe() instead of at every
call? I think (old == 0 || new == 0) is probably doing something similar.


>  		} else {
>  			alloc_init_pte(pmd, addr, next, __phys_to_pfn(phys),
> @@ -791,14 +796,20 @@ int __init arch_ioremap_pmd_supported(void)
>  int pud_set_huge(pud_t *pud, phys_addr_t phys, pgprot_t prot)
>  {
>  	BUG_ON(phys & ~PUD_MASK);
> -	set_pud(pud, __pud(phys | PUD_TYPE_SECT | pgprot_val(mk_sect_prot(prot))));
> +	set_pud(pud, __pud(phys |
> +			   ((pgprot_val(prot) & PUD_VALID) ?
> +					PUD_TYPE_SECT : 0) |
> +			   pgprot_val(mk_sect_prot(prot))));

This looks complicated. Is this equivalent?:

>    prot = mk_sect_prot(prot);
>    if (pgprot_val(prot) & PUD_VALID)
>        prot |= PUD_TYPE_SECT;
>
>    set_pud(pud, __pud(phys | pgprot_val(prot)));


Given you defined PUD_VALID as being PUD_TYPE_SECT, I think you can then reduce
it to:
>    set_pud(pud, __pud(phys | pgprot_val(mk_sect_prot(prot))));

It looks like mk_sect_prot() doesn't touch the valid bit so all this is doing is
clearing the table bit making it a section and keeping the valid bit from the
caller.


Thanks,

James
