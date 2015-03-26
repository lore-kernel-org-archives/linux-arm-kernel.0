From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 26 Mar 2015 01:28:08 +0000
Subject: [PATCH 2/4] arm64: fixmap: move translation tables to dedicated
 region
In-Reply-To: <1427125016-3873-3-git-send-email-ard.biesheuvel@linaro.org>
References: <20150317164353.GN23340@leverpostej>
 <1427125016-3873-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150326012808.GD1676@flaeskesteg-linux.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Mon, Mar 23, 2015 at 03:36:54PM +0000, Ard Biesheuvel wrote:
> This moves the fixmap translation tables to a dedicated region
> in the linker map. This is needed for a split kernel text from
> the linear mapping, to ensure that the contents of the tables
> rely on a single translation regime.

I'm not sure what you mean by this. Could you elaborate?

What problem would we have if we didn't have this section, and how does this
section solve that?

Regardless, I have some comments on the implementation below.

> Also make the population of the translation levels conditional,
> so that the kernel text can share some levels of translation if
> needed.

I guess you mean shared with the tables for the text mapping?

Please word this to be explicit w.r.t. what is shared between whom, and when.

> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/linkage.h |  2 ++
>  arch/arm64/kernel/vmlinux.lds.S  | 15 ++++++++++-----
>  arch/arm64/mm/mmu.c              | 15 +++++++++------
>  3 files changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/linkage.h b/arch/arm64/include/asm/linkage.h
> index 636c1bced7d4..dc9354de6f52 100644
> --- a/arch/arm64/include/asm/linkage.h
> +++ b/arch/arm64/include/asm/linkage.h
> @@ -4,4 +4,6 @@
>  #define __ALIGN		.align 4
>  #define __ALIGN_STR	".align 4"
>  
> +#define __pgdir		__attribute__((__section__(".pgdir")))

It would be nice for this to also provide page alignment, like
__page_aligned_bss that this replaces uses of.

> +
>  #endif
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 434ef407ef0f..d3885043f0b7 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -149,11 +149,16 @@ SECTIONS
>  
>  	BSS_SECTION(0, 0, 0)
>  
> -	. = ALIGN(PAGE_SIZE);
> -	idmap_pg_dir = .;
> -	. += IDMAP_DIR_SIZE;
> -	swapper_pg_dir = .;
> -	. += SWAPPER_DIR_SIZE;
> +	.pgdir : {
> +		. = ALIGN(PAGE_SIZE);
> +		__pgdir_start = .;
> +		idmap_pg_dir = .;
> +		. += IDMAP_DIR_SIZE;
> +		*(.pgdir)
> +		swapper_pg_dir = .;
> +		. += SWAPPER_DIR_SIZE;
> +		__pgdir_stop = .;

Nit: __pgdir_end would be consitent with our other vmlinux.lds.S symbols.

> +	}
>  
>  	_end = .;
>  
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 43496748e3d9..bb3ce41130f3 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -549,12 +549,12 @@ void vmemmap_free(unsigned long start, unsigned long end)
>  }
>  #endif	/* CONFIG_SPARSEMEM_VMEMMAP */
>  
> -static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
> +static pte_t bm_pte[PTRS_PER_PTE] __pgdir;
>  #if CONFIG_ARM64_PGTABLE_LEVELS > 2
> -static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss;
> +static pmd_t bm_pmd[PTRS_PER_PMD] __pgdir;
>  #endif
>  #if CONFIG_ARM64_PGTABLE_LEVELS > 3
> -static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss;
> +static pud_t bm_pud[PTRS_PER_PUD] __pgdir;
>  #endif

These used to be zeroed (by the bss init code in head.S), but now they won't
be, and as they live after all the initialized data they could contain garbage
if we're unlucky. So I suspect this is broken.

If we zero these before use then that's fine. We could define the swapper and
idmap similarly in this C file for consistency (we zero those in head.S). That
would bring all the page table allocations into the same file, and .pgdir could
be simpler:

	.pgdir {
		. = ALIGN(PAGE_SIZE);
		__pgdir_start = .;
		*(.pgdir)
		__pgdir_end = .;
	}

>  
>  static inline pud_t * fixmap_pud(unsigned long addr)
> @@ -592,11 +592,14 @@ void __init early_fixmap_init(void)
>  	unsigned long addr = FIXADDR_START;
>  
>  	pgd = pgd_offset_k(addr);
> -	pgd_populate(&init_mm, pgd, bm_pud);
> +	if (pgd_none(*pgd))
> +		pgd_populate(&init_mm, pgd, bm_pud);
>  	pud = pud_offset(pgd, addr);
> -	pud_populate(&init_mm, pud, bm_pmd);
> +	if (pud_none(*pud))
> +		pud_populate(&init_mm, pud, bm_pmd);
>  	pmd = pmd_offset(pud, addr);
> -	pmd_populate_kernel(&init_mm, pmd, bm_pte);
> +	if (pmd_none(*pmd))
> +		pmd_populate_kernel(&init_mm, pmd, bm_pte);

It's a bit confusing to have this change in the same patch as the other
changes, given that this shouldn't be required yet. It might make more sense
for this to live in the patch moving the text mapping.

Mark.
