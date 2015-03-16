From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 16 Mar 2015 17:14:27 +0000
Subject: [RFC PATCH 1/3] arm64: head.S: replace early literals with
 constant immediates
In-Reply-To: <1426519423-28263-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1426519423-28263-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426519423-28263-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150316171427.GC18277@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Mon, Mar 16, 2015 at 03:23:41PM +0000, Ard Biesheuvel wrote:
> In preparation of making the kernel relocatable, replace literal
> symbol references with immediate constants. This is necessary, as
> the literals will not be populated with meaningful values until
> after the relocation code has executed.

The majority of these changes look like nice cleanups/simplifications
regardless of whether the kernel is relocatable, so I like most of the
patch.

> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/efi-entry.S |  2 +-
>  arch/arm64/kernel/head.S      | 36 +++++++++++++++---------------------
>  2 files changed, 16 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm64/kernel/efi-entry.S b/arch/arm64/kernel/efi-entry.S
> index 8ce9b0577442..f78e6a1de825 100644
> --- a/arch/arm64/kernel/efi-entry.S
> +++ b/arch/arm64/kernel/efi-entry.S
> @@ -61,7 +61,7 @@ ENTRY(efi_stub_entry)
>  	 */
>  	mov	x20, x0		// DTB address
>  	ldr	x0, [sp, #16]	// relocated _text address
> -	ldr	x21, =stext_offset
> +	movz	x21, #:abs_g0:stext_offset

This looks a little scary. Why do we need to use a movz with a special
relocation rather than a simple mov? As far as I can see mov has
sufficient range.

>  	add	x21, x0, x21
>  
>  	/*
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 9c856f2aa7a5..1ea3cd2aba34 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -46,11 +46,9 @@
>  #error TEXT_OFFSET must be less than 2MB
>  #endif
>  
> -	.macro	pgtbl, ttb0, ttb1, virt_to_phys
> -	ldr	\ttb1, =swapper_pg_dir
> -	ldr	\ttb0, =idmap_pg_dir
> -	add	\ttb1, \ttb1, \virt_to_phys
> -	add	\ttb0, \ttb0, \virt_to_phys
> +	.macro	pgtbl, ttb0, ttb1
> +	adrp	\ttb1, swapper_pg_dir
> +	adrp	\ttb0, idmap_pg_dir
>  	.endm

I reckon we should just kill pgtbl and use adrp inline in both of the
callsites. That way we can also get rid of the comment in each case,
beacuse the assembly itself will document which register gets which
table address.

>  #ifdef CONFIG_ARM64_64K_PAGES
> @@ -63,7 +61,7 @@
>  #define TABLE_SHIFT	PUD_SHIFT
>  #endif
>  
> -#define KERNEL_START	KERNEL_RAM_VADDR
> +#define KERNEL_START	_text

We can kill the KERNEL_RAM_VADDR definition too, I believe. It's only
used here.

>  #define KERNEL_END	_end
>  
>  /*
> @@ -322,7 +320,7 @@ ENDPROC(stext)
>   *     been enabled
>   */
>  __create_page_tables:
> -	pgtbl	x25, x26, x28			// idmap_pg_dir and swapper_pg_dir addresses
> +	pgtbl	x25, x26			// idmap_pg_dir and swapper_pg_dir addresses

Here we could just have:

	adrp	x25, idmap_pg_dir
	adrp	x26, swapper_pg_dir

>  	mov	x27, lr
>  
>  	/*
> @@ -351,8 +349,7 @@ __create_page_tables:
>  	 * Create the identity mapping.
>  	 */
>  	mov	x0, x25				// idmap_pg_dir
> -	ldr	x3, =KERNEL_START
> -	add	x3, x3, x28			// __pa(KERNEL_START)
> +	adr_l	x3, KERNEL_START		// __pa(KERNEL_START)
>  
>  #ifndef CONFIG_ARM64_VA_BITS_48
>  #define EXTRA_SHIFT	(PGDIR_SHIFT + PAGE_SHIFT - 3)
> @@ -391,9 +388,8 @@ __create_page_tables:
>  #endif
>  
>  	create_pgd_entry x0, x3, x5, x6
> -	ldr	x6, =KERNEL_END
>  	mov	x5, x3				// __pa(KERNEL_START)
> -	add	x6, x6, x28			// __pa(KERNEL_END)
> +	adr_l	x6, KERNEL_END			// __pa(KERNEL_END)
>  	create_block_map x0, x7, x3, x5, x6
>  
>  	/*
> @@ -402,8 +398,10 @@ __create_page_tables:
>  	mov	x0, x26				// swapper_pg_dir
>  	mov	x5, #PAGE_OFFSET
>  	create_pgd_entry x0, x5, x3, x6
> -	ldr	x6, =KERNEL_END
> +	adr_l	x6, KERNEL_END
>  	mov	x3, x24				// phys offset
> +	sub	x6, x6, x3			// kernel memsize
> +	add	x6, x6, x5			// __va(KERNEL_END)

I'm not sure on this; it makes it consistent with the rest w.r.t. using
adr* but it's now a little harder to read :/

>  	create_block_map x0, x7, x3, x5, x6
>  
>  	/*
> @@ -538,8 +536,7 @@ ENDPROC(el2_setup)
>   * in x20. See arch/arm64/include/asm/virt.h for more info.
>   */
>  ENTRY(set_cpu_boot_mode_flag)
> -	ldr	x1, =__boot_cpu_mode		// Compute __boot_cpu_mode
> -	add	x1, x1, x28
> +	adr_l	x1, __boot_cpu_mode		// Compute __boot_cpu_mode

The comment seems redundant now (and arguably was before). I think it's
a distraction we can drop.

>  	cmp	w20, #BOOT_CPU_MODE_EL2
>  	b.ne	1f
>  	add	x1, x1, #4
> @@ -598,7 +595,7 @@ ENTRY(secondary_startup)
>  	/*
>  	 * Common entry point for secondary CPUs.
>  	 */
> -	pgtbl	x25, x26, x28			// x25=TTBR0, x26=TTBR1
> +	pgtbl	x25, x26			// x25=TTBR0, x26=TTBR1

As mentioned above, I think this is clearer as:

	adrp	x25, idmap_pg_dir
	adrp	x26, swapper_pg_dir

>  	bl	__cpu_setup			// initialise processor
>  
>  	ldr	x21, =secondary_data
> @@ -655,17 +652,14 @@ ENDPROC(__turn_mmu_on)
>   * Calculate the start of physical memory.
>   */
>  __calc_phys_offset:
> -	adr	x0, 1f
> -	ldp	x1, x2, [x0]
> +	adrp	x0, KERNEL_START		// __pa(KERNEL_START)
> +	ldr	x1, =KERNEL_RAM_VADDR		// __va(KERNEL_START)
> +	mov	x2, PAGE_OFFSET

Missing '#' on the PAGE_OFFSET immediate.

Thanks,
Mark.

>  	sub	x28, x0, x1			// x28 = PHYS_OFFSET - PAGE_OFFSET
>  	add	x24, x2, x28			// x24 = PHYS_OFFSET
>  	ret
>  ENDPROC(__calc_phys_offset)
>  
> -	.align 3
> -1:	.quad	.
> -	.quad	PAGE_OFFSET
> -
>  /*
>   * Exception handling. Something went wrong and we can't proceed. We ought to
>   * tell the user, but since we don't have any guarantee that we're even
> -- 
> 1.8.3.2
> 
> 
