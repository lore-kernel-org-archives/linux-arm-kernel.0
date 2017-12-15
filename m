From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 15 Dec 2017 17:45:21 +0000
Subject: [PATCH 04/10] arm64: head.S: handle 52-bit PAs in PTEs in early
 page table setup
In-Reply-To: <1513184845-8711-5-git-send-email-kristina.martsenko@arm.com>
References: <1513184845-8711-1-git-send-email-kristina.martsenko@arm.com>
 <1513184845-8711-5-git-send-email-kristina.martsenko@arm.com>
Message-ID: <25bbee12-dfbf-9f49-ab52-c209b81c1db6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/12/17 17:07, Kristina Martsenko wrote:
> The top 4 bits of a 52-bit physical address are positioned at bits
> 12..15 in page table entries. Introduce a macro to move the bits there,
> and change the early ID map and swapper table setup code to use it.
> 
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> ---
>   arch/arm64/include/asm/pgtable-hwdef.h |  6 ++++++
>   arch/arm64/kernel/head.S               | 36 +++++++++++++++++++++++++---------
>   2 files changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index 2b3104af79d0..c59c69e02036 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -168,6 +168,12 @@
>   #define PTE_UXN			(_AT(pteval_t, 1) << 54)	/* User XN */
>   #define PTE_HYP_XN		(_AT(pteval_t, 1) << 54)	/* HYP XN */
>   
> +#ifdef CONFIG_ARM64_PA_BITS_52
> +#define PTE_ADDR_LOW		(((_AT(pteval_t, 1) << (48 - PAGE_SHIFT)) - 1) << PAGE_SHIFT)
> +#define PTE_ADDR_HIGH		(_AT(pteval_t, 0xf) << 12)
> +#define PTE_ADDR_MASK_52	(PTE_ADDR_LOW | PTE_ADDR_HIGH)
> +#endif
> +
>   /*
>    * AttrIndx[2:0] encoding (mapping attributes defined in the MAIR* registers).
>    */
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 0addea3760a6..ddee8b347f60 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -148,6 +148,22 @@ preserve_boot_args:
>   ENDPROC(preserve_boot_args)
>   
>   /*
> + * Macro to arrange a physical address in a page table entry, taking care of
> + * 52-bit addresses.
> + *
> + * Preserves:	phys
> + * Returns:	pte
> + */
> +	.macro	phys_to_pte, phys, pte
> +#ifdef CONFIG_ARM64_PA_BITS_52
> +	orr	\pte, \phys, \phys, lsr #36
> +	and	\pte, \pte, #PTE_ADDR_MASK_52

We could have a corrupt "pte" if the "phys" is not aligned
to page size (i.e, 64K here). However, given that the only callers
of this (create_table_entry and create_block_map) passes page
aligned addresses, we are fine. It would be good to add a comment
mentioning that, to prevent future misuses.

> +#else
> +	mov	\pte, \phys
> +#endif
> +	.endm
> +
> +/*
>    * Macro to create a table entry to the next page.
>    *
>    *	tbl:	page table address
> @@ -160,10 +176,11 @@ ENDPROC(preserve_boot_args)
>    * Returns:	tbl -> next level table page address
>    */
>   	.macro	create_table_entry, tbl, virt, shift, ptrs, tmp1, tmp2
> +	add	\tmp1, \tbl, #PAGE_SIZE
> +	phys_to_pte \tmp1, \tmp2
> +	orr	\tmp2, \tmp2, #PMD_TYPE_TABLE	// address of next table and entry type
>   	lsr	\tmp1, \virt, #\shift
>   	and	\tmp1, \tmp1, #\ptrs - 1	// table index
> -	add	\tmp2, \tbl, #PAGE_SIZE
> -	orr	\tmp2, \tmp2, #PMD_TYPE_TABLE	// address of next table and entry type
>   	str	\tmp2, [\tbl, \tmp1, lsl #3]
>   	add	\tbl, \tbl, #PAGE_SIZE		// next level table page
>   	.endm
> @@ -190,16 +207,17 @@ ENDPROC(preserve_boot_args)
>    * virtual range (inclusive).
>    *
>    * Preserves:	tbl, flags
> - * Corrupts:	phys, start, end, pstate
> + * Corrupts:	phys, start, end, tmp
>    */

nit: We still corrupt pstate. So, it would be good retain that here.

Other than those nits, looks good to me.

Reviewed-by : Suzuki K Poulose <suzuki.poulose@arm.com>
