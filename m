From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 12 Oct 2016 16:04:29 +0100
Subject: [PATCH v3 1/5] arm64: mm: BUG on unsupported manipulations of
 live kernel mappings
In-Reply-To: <1476271425-19401-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1476271425-19401-1-git-send-email-ard.biesheuvel@linaro.org>
 <1476271425-19401-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20161012150428.s4gajqlnnivo6bld@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 12, 2016 at 12:23:41PM +0100, Ard Biesheuvel wrote:
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -28,8 +28,6 @@
>  #include <linux/memblock.h>
>  #include <linux/fs.h>
>  #include <linux/io.h>
> -#include <linux/slab.h>
> -#include <linux/stop_machine.h>
>  
>  #include <asm/barrier.h>
>  #include <asm/cputype.h>
> @@ -95,6 +93,12 @@ static phys_addr_t __init early_pgtable_alloc(void)
>  	return phys;
>  }
>  
> +/*
> + * The following mapping attributes may be updated in live
> + * kernel mappings without the need for break-before-make.
> + */
> +static const pteval_t modifiable_attr_mask = PTE_PXN | PTE_RDONLY | PTE_WRITE;
> +
>  static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
>  				  unsigned long end, unsigned long pfn,
>  				  pgprot_t prot,
> @@ -115,8 +119,18 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
>  
>  	pte = pte_set_fixmap_offset(pmd, addr);
>  	do {
> +		pte_t old_pte = *pte;
> +
>  		set_pte(pte, pfn_pte(pfn, prot));
>  		pfn++;
> +
> +		/*
> +		 * After the PTE entry has been populated once, we
> +		 * only allow updates to the permission attributes.
> +		 */
> +		BUG_ON(pte_val(old_pte) != 0 &&
> +		       ((pte_val(old_pte) ^ pte_val(*pte)) &
> +			~modifiable_attr_mask) != 0);

Please turn this check into a single macro. You have it in three places
already (though with different types but a macro would do). Something
like below (feel free to come up with a better macro name):

		BUG_ON(!safe_pgattr_change(old_pte, *pte));

-- 
Catalin
