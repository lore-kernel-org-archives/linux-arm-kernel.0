From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 30 Aug 2016 15:26:38 +0100
Subject: [PATCH v2 7/9] arm64: kernel: drop use of x24 from primary boot
 path
In-Reply-To: <1472049366-10922-8-git-send-email-ard.biesheuvel@linaro.org>
References: <1472049366-10922-1-git-send-email-ard.biesheuvel@linaro.org>
 <1472049366-10922-8-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160830142637.GJ1223@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 04:36:04PM +0200, Ard Biesheuvel wrote:
> Keeping __PHYS_OFFSET in x24 is actually less clear than simply taking
> the value of __PHYS_OFFSET using an adrp instruction in the three places
> that we need it. So change that.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/head.S | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index c112c153821e..27f51272de68 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -211,8 +211,8 @@ efi_header_end:
>  ENTRY(stext)
>  	bl	preserve_boot_args
>  	bl	el2_setup			// Drop to EL1, w0=cpu_boot_mode
> -	adrp	x24, __PHYS_OFFSET
> -	and	x23, x24, MIN_KIMG_ALIGN - 1	// KASLR offset, defaults to 0
> +	adrp	x23, __PHYS_OFFSET
> +	and	x23, x23, MIN_KIMG_ALIGN - 1	// KASLR offset, defaults to 0
>  	bl	set_cpu_boot_mode_flag
>  	bl	__create_page_tables
>  	/*
> @@ -412,6 +412,8 @@ ENDPROC(__create_page_tables)
>  
>  /*
>   * The following fragment of code is executed with the MMU enabled.
> + *
> + *   x0 = __PHYS_OFFSET
>   */
>  	.set	initial_sp, init_thread_union + THREAD_START_SP
>  __primary_switched:
> @@ -420,6 +422,12 @@ __primary_switched:
>  	msr	vbar_el1, x8			// vector table address
>  	isb
>  
> +	str_l	x21, __fdt_pointer, x5		// Save FDT pointer
> +
> +	ldr_l	x4, kimage_vaddr		// Save the offset between
> +	sub	x4, x4, x0			// the kernel virtual and
> +	str_l	x4, kimage_voffset, x5		// physical mappings
> +
>  	// Clear BSS
>  	adr_l	x0, __bss_start
>  	mov	x1, xzr
> @@ -432,12 +440,6 @@ __primary_switched:
>  	mov	x4, sp
>  	and	x4, x4, #~(THREAD_SIZE - 1)
>  	msr	sp_el0, x4			// Save thread_info
> -	str_l	x21, __fdt_pointer, x5		// Save FDT pointer
> -
> -	ldr_l	x4, kimage_vaddr		// Save the offset between
> -	sub	x4, x4, x24			// the kernel virtual and
> -	str_l	x4, kimage_voffset, x5		// physical mappings
> -
>  	mov	x29, #0
>  #ifdef CONFIG_KASAN
>  	bl	kasan_early_init
> @@ -792,6 +794,7 @@ __primary_switch:
>  	bl	__relocate_kernel
>  #ifdef CONFIG_RANDOMIZE_BASE
>  	ldr	x8, =__primary_switched
> +	adrp	x0, __PHYS_OFFSET
>  	blr	x8
>  
>  	/*
> @@ -813,5 +816,6 @@ __primary_switch:
>  #endif
>  #endif
>  	ldr	x8, =__primary_switched
> +	adrp	x0, __PHYS_OFFSET
>  	br	x8
>  ENDPROC(__primary_switch)
> -- 
> 2.7.4
> 
