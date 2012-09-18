From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Sep 2012 13:47:24 +0100
Subject: [PATCH 02/15] ARM: Add page table and page defines needed by KVM
In-Reply-To: <20120915153443.21241.37958.stgit@ubuntu>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153443.21241.37958.stgit@ubuntu>
Message-ID: <20120918124724.GK32204@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 15, 2012 at 04:34:43PM +0100, Christoffer Dall wrote:
> KVM uses the stage-2 page tables and the Hyp page table format,
> so let's define the fields we need to access in KVM.
> 
> We use pgprot_guest to indicate stage-2 entries.
> 
> Christoffer Dall <c.dall@virtualopensystems.com>
> ---
>  arch/arm/include/asm/pgtable-3level.h |   13 +++++++++++++
>  arch/arm/include/asm/pgtable.h        |    5 +++++
>  arch/arm/mm/mmu.c                     |    3 +++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
> index b249035..7351eee 100644
> --- a/arch/arm/include/asm/pgtable-3level.h
> +++ b/arch/arm/include/asm/pgtable-3level.h
> @@ -102,11 +102,24 @@
>   */
>  #define L_PGD_SWAPPER		(_AT(pgdval_t, 1) << 55)	/* swapper_pg_dir entry */
>  
> +/*
> + * 2-nd stage PTE definitions for LPAE.
> + */

Minor nit: 2nd

> +#define L_PTE2_SHARED		L_PTE_SHARED
> +#define L_PTE2_READ		(_AT(pteval_t, 1) << 6)	/* HAP[0] */
> +#define L_PTE2_WRITE		(_AT(pteval_t, 1) << 7)	/* HAP[1] */

This is actually HAP[2:1], not HAP[1:0]. Also, can you follow what we do for
stage 1 translation and name these RDONLY and WRONLY (do you even use
that?).

> +#define L_PTE2_NORM_WB		(_AT(pteval_t, 3) << 4)	/* MemAttr[3:2] */
> +#define L_PTE2_INNER_WB		(_AT(pteval_t, 3) << 2)	/* MemAttr[1:0] */

Another minor nit: PTE2 looks awful. Maybe L_PTE_HYP_* instead?

>  #ifndef __ASSEMBLY__
>  
>  #define pud_none(pud)		(!pud_val(pud))
>  #define pud_bad(pud)		(!(pud_val(pud) & 2))
>  #define pud_present(pud)	(pud_val(pud))
> +#define pmd_table(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
> +						 PMD_TYPE_TABLE)
> +#define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
> +						 PMD_TYPE_SECT)
>  
>  #define pud_clear(pudp)			\
>  	do {				\
> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> index 41dc31f..c422f62 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -70,6 +70,7 @@ extern void __pgd_error(const char *file, int line, pgd_t);
>  
>  extern pgprot_t		pgprot_user;
>  extern pgprot_t		pgprot_kernel;
> +extern pgprot_t		pgprot_guest;
>  
>  #define _MOD_PROT(p, b)	__pgprot(pgprot_val(p) | (b))
>  
> @@ -82,6 +83,10 @@ extern pgprot_t		pgprot_kernel;
>  #define PAGE_READONLY_EXEC	_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_RDONLY)
>  #define PAGE_KERNEL		_MOD_PROT(pgprot_kernel, L_PTE_XN)
>  #define PAGE_KERNEL_EXEC	pgprot_kernel
> +#define PAGE_HYP		_MOD_PROT(pgprot_kernel, L_PTE_USER)

Just define L_PTE_HYP to L_PTE_USER, otherwise that's confusing.

> +#define PAGE_KVM_GUEST		_MOD_PROT(pgprot_guest, L_PTE2_READ | \
> +					  L_PTE2_NORM_WB | L_PTE2_INNER_WB | \
> +					  L_PTE2_SHARED)

It would be cleaner to separate the cacheability attributes out from here
and into the cache_policies array. Then you just need L_PTE_HYP_RDONLY here.

Will
