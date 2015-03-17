From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 17 Mar 2015 14:46:25 +0000
Subject: [PATCH 2/3] arm64: remove __calc_phys_offset
In-Reply-To: <1426587074-22390-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1426587074-22390-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426587074-22390-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150317144625.GH23340@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 17, 2015 at 10:11:13AM +0000, Ard Biesheuvel wrote:
> This removes the function __calc_phys_offset and all open coded
> virtual to physical address translations using the offset kept
> in x28.
> 
> Instead, just use absolute or PC-relative symbol references as
> appropriate when referring to virtual or physical addresses,
> respectively.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/head.S | 49 ++++++++++++------------------------------------
>  1 file changed, 12 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index fb912314d5e1..1651c0fd50e6 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -36,8 +36,6 @@
>  #include <asm/page.h>
>  #include <asm/virt.h>
>  
> -#define KERNEL_RAM_VADDR	(PAGE_OFFSET + TEXT_OFFSET)
> -
>  #if (TEXT_OFFSET & 0xfff) != 0
>  #error TEXT_OFFSET must be at least 4KB aligned
>  #elif (PAGE_OFFSET & 0x1fffff) != 0
> @@ -46,13 +44,6 @@
>  #error TEXT_OFFSET must be less than 2MB
>  #endif
>  
> -	.macro	pgtbl, ttb0, ttb1, virt_to_phys
> -	ldr	\ttb1, =swapper_pg_dir
> -	ldr	\ttb0, =idmap_pg_dir
> -	add	\ttb1, \ttb1, \virt_to_phys
> -	add	\ttb0, \ttb0, \virt_to_phys
> -	.endm
> -
>  #ifdef CONFIG_ARM64_64K_PAGES
>  #define BLOCK_SHIFT	PAGE_SHIFT
>  #define BLOCK_SIZE	PAGE_SIZE
> @@ -63,7 +54,7 @@
>  #define TABLE_SHIFT	PUD_SHIFT
>  #endif
>  
> -#define KERNEL_START	KERNEL_RAM_VADDR
> +#define KERNEL_START	_text
>  #define KERNEL_END	_end
>  
>  /*
> @@ -242,7 +233,7 @@ section_table:
>  ENTRY(stext)
>  	mov	x21, x0				// x21=FDT
>  	bl	el2_setup			// Drop to EL1, w20=cpu_boot_mode
> -	bl	__calc_phys_offset		// x24=PHYS_OFFSET, x28=PHYS_OFFSET-PAGE_OFFSET
> +	adrp	x24, KERNEL_START - TEXT_OFFSET	// x24=PHYS_OFFSET

Neat!

Perhaps we could have:

#define	PHYS_OFFSET	(KERNEL_START - TEXT_OFFSET)

Which would make the all the PHYS_OFFSET calculations self-documenting.
It shouldn't clash with the asm/memory.h definition because that's in an
#ifndef __ASSEMBLY__ block.

Either way it all looks correct (and it's nice to see head.S shrink),
so:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

I assume you'll add this to the series introducing adr_l and friends?

Mark.

>  	bl	set_cpu_boot_mode_flag
>  
>  	bl	__vet_fdt
> @@ -343,7 +334,8 @@ ENDPROC(__vet_fdt)
>   *   - pgd entry for fixed mappings (TTBR1)
>   */
>  __create_page_tables:
> -	pgtbl	x25, x26, x28			// idmap_pg_dir and swapper_pg_dir addresses
> +	adrp    x25, idmap_pg_dir
> +	adrp    x26, swapper_pg_dir
>  	mov	x27, lr
>  
>  	/*
> @@ -372,12 +364,10 @@ __create_page_tables:
>  	 * Create the identity mapping.
>  	 */
>  	mov	x0, x25				// idmap_pg_dir
> -	ldr	x3, =KERNEL_START
> -	add	x3, x3, x28			// __pa(KERNEL_START)
> +	adrp	x3, KERNEL_START		// __pa(KERNEL_START)
>  	create_pgd_entry x0, x3, x5, x6
> -	ldr	x6, =KERNEL_END
>  	mov	x5, x3				// __pa(KERNEL_START)
> -	add	x6, x6, x28			// __pa(KERNEL_END)
> +	adr_l	x6, KERNEL_END			// __pa(KERNEL_END)
>  	create_block_map x0, x7, x3, x5, x6
>  
>  	/*
> @@ -386,7 +376,7 @@ __create_page_tables:
>  	mov	x0, x26				// swapper_pg_dir
>  	mov	x5, #PAGE_OFFSET
>  	create_pgd_entry x0, x5, x3, x6
> -	ldr	x6, =KERNEL_END
> +	ldr	x6, =KERNEL_END			// __va(KERNEL_END)
>  	mov	x3, x24				// phys offset
>  	create_block_map x0, x7, x3, x5, x6
>  
> @@ -538,8 +528,7 @@ ENDPROC(el2_setup)
>   * in x20. See arch/arm64/include/asm/virt.h for more info.
>   */
>  ENTRY(set_cpu_boot_mode_flag)
> -	ldr	x1, =__boot_cpu_mode		// Compute __boot_cpu_mode
> -	add	x1, x1, x28
> +	adr_l	x1, __boot_cpu_mode
>  	cmp	w20, #BOOT_CPU_MODE_EL2
>  	b.ne	1f
>  	add	x1, x1, #4
> @@ -570,7 +559,7 @@ ENTRY(__boot_cpu_mode)
>  	 */
>  ENTRY(secondary_holding_pen)
>  	bl	el2_setup			// Drop to EL1, w20=cpu_boot_mode
> -	bl	__calc_phys_offset		// x24=PHYS_OFFSET, x28=PHYS_OFFSET-PAGE_OFFSET
> +	adrp	x24, KERNEL_START - TEXT_OFFSET	// x24=PHYS_OFFSET
>  	bl	set_cpu_boot_mode_flag
>  	mrs	x0, mpidr_el1
>  	ldr     x1, =MPIDR_HWID_BITMASK
> @@ -589,7 +578,7 @@ ENDPROC(secondary_holding_pen)
>  	 */
>  ENTRY(secondary_entry)
>  	bl	el2_setup			// Drop to EL1
> -	bl	__calc_phys_offset		// x24=PHYS_OFFSET, x28=PHYS_OFFSET-PAGE_OFFSET
> +	adrp	x24, KERNEL_START - TEXT_OFFSET	// x24=PHYS_OFFSET
>  	bl	set_cpu_boot_mode_flag
>  	b	secondary_startup
>  ENDPROC(secondary_entry)
> @@ -598,7 +587,8 @@ ENTRY(secondary_startup)
>  	/*
>  	 * Common entry point for secondary CPUs.
>  	 */
> -	pgtbl	x25, x26, x28			// x25=TTBR0, x26=TTBR1
> +	adrp    x25, idmap_pg_dir
> +	adrp    x26, swapper_pg_dir
>  	bl	__cpu_setup			// initialise processor
>  
>  	ldr	x21, =secondary_data
> @@ -636,18 +626,3 @@ __enable_mmu:
>  	isb
>  	br	x27
>  ENDPROC(__enable_mmu)
> -
> -/*
> - * Calculate the start of physical memory.
> - */
> -__calc_phys_offset:
> -	adr	x0, 1f
> -	ldp	x1, x2, [x0]
> -	sub	x28, x0, x1			// x28 = PHYS_OFFSET - PAGE_OFFSET
> -	add	x24, x2, x28			// x24 = PHYS_OFFSET
> -	ret
> -ENDPROC(__calc_phys_offset)
> -
> -	.align 3
> -1:	.quad	.
> -	.quad	PAGE_OFFSET
> -- 
> 1.8.3.2
> 
> 
