From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 11 Oct 2016 08:44:19 +0100
Subject: [PATCH] arm64: mmu: set the contiguous for kernel mappings when
 appropriate
In-Reply-To: <1476123164-10532-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1476123164-10532-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20161011074419.GA20213@remoulade>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Mon, Oct 10, 2016 at 07:12:44PM +0100, Ard Biesheuvel wrote:
> Now that we no longer allow live kernel PMDs to be split, it is safe to
> start using the contiguous bit for kernel mappings. So set the contiguous
> bit in the kernel page mappings for regions whose size and alignment are
> suitable for this.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Given the splitting is now gone, using the contiguous bit makes sense to me.

With 16K pages, we can have contiguous PMD entries. Should we handle those,
too? e.g. have separate {PMD,PTE}_CONT{,_SIZE}?

Otherwise, I have some comments below.

> ---
>  arch/arm64/mm/mmu.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 05615a3fdc6f..c491025c6a70 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -98,8 +98,11 @@ static phys_addr_t __init early_pgtable_alloc(void)
>  static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
>  				  unsigned long end, unsigned long pfn,
>  				  pgprot_t prot,
> -				  phys_addr_t (*pgtable_alloc)(void))
> +				  phys_addr_t (*pgtable_alloc)(void),
> +				  bool allow_block_mappings)

Not a big deal, but the 'block' part here and elsewhere is now arguably
misleading (given 'block' is an architectural term).

I haven't come up with a better term, so again, not a big deal. ;)

>  {
> +	pgprot_t prot_cont = __pgprot(pgprot_val(prot) | PTE_CONT);
> +	bool cont = false;
>  	pte_t *pte;
>  
>  	BUG_ON(pmd_sect(*pmd));
> @@ -115,7 +118,20 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
>  
>  	pte = pte_set_fixmap_offset(pmd, addr);
>  	do {
> -		set_pte(pte, pfn_pte(pfn, prot));
> +		/*
> +		 * Set the contiguous bit for the subsequent group of PTEs if
> +		 * its size and alignment are suitable.
> +		 */
> +		if (((addr | PFN_PHYS(pfn)) & ~CONT_MASK) == 0)
> +			cont = allow_block_mappings && end - addr >= CONT_SIZE;

Given we increment addr by PAGE_SIZE in the loop, isn't this only true for the
first CONT_SIZE aligned entry, and not its (intended-to-be-contiguous)
siblings?

It be better to loop over CONT_SIZE increments, and then within that, pass the
prot (with the contiguous bit set as required) to a loop with a PAGE_SIZE
increment.

Or have I misunderstood something?

> +
> +		/*
> +		 * Ensure that we do not change the contiguous bit once this
> +		 * PTE has been assigned.
> +		 */
> +		BUG_ON(!pte_none(*pte) && (cont ^ !!(pte_val(*pte) & PTE_CONT)));

IIRC, we only ever intended to mess with the AP bits when remapping an existing region.

So we could mask those out and ensure everything else is identical, rather than
checking the cont bit specifically. Likewise at the {PMD,PUD,PGD} level.

> +
> +		set_pte(pte, pfn_pte(pfn, cont ? prot_cont : prot));

It would be clearer if we just assigned to a local pte_prot variable when
checking allow_block_mappings and so on above (or split the loop as above).

Thanks,
Mark.
