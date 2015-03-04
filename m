From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 4 Mar 2015 11:57:18 +0000
Subject: [PATCH v2 1/3] arm64: remove processor_id
In-Reply-To: <1425468197-22377-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1425468197-22377-1-git-send-email-ard.biesheuvel@linaro.org>
 <1425468197-22377-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150304115718.GA32320@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Wed, Mar 04, 2015 at 11:23:15AM +0000, Ard Biesheuvel wrote:
> The global processor_id is assigned the MIDR_EL1 value of the boot
> CPU in the early init code, but is never referenced afterwards.

I think it's also worth noting that it's also non-sensical and
misleading for big.LITTLE systems, and getting rid of it removes the
potential for confusion.

> So remove it.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/head.S  | 10 +++-------
>  arch/arm64/kernel/setup.c |  3 ---
>  2 files changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 8ce88e08c030..003db2eadd7a 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -244,8 +244,7 @@ ENTRY(stext)
>  	bl	el2_setup			// Drop to EL1, w20=cpu_boot_mode
>  	bl	__calc_phys_offset		// x24=PHYS_OFFSET, x28=PHYS_OFFSET-PAGE_OFFSET
>  	bl	set_cpu_boot_mode_flag
> -	mrs	x22, midr_el1			// x22=cpuid
> -	mov	x0, x22
> +	mrs	x0, midr_el1
>  	bl	lookup_processor_type
>  	mov	x23, x0				// x23=current cpu_table
>  	/*
> @@ -439,7 +438,6 @@ __switch_data:
>  	.quad	__mmap_switched
>  	.quad	__bss_start			// x6
>  	.quad	__bss_stop			// x7
> -	.quad	processor_id			// x4
>  	.quad	__fdt_pointer			// x5
>  	.quad	memstart_addr			// x6
>  	.quad	init_thread_union + THREAD_START_SP // sp
> @@ -457,11 +455,10 @@ __mmap_switched:
>  	str	xzr, [x6], #8			// Clear BSS
>  	b	1b
>  2:
> -	ldp	x4, x5, [x3], #16
> +	ldr	x5, [x3], #8
>  	ldr	x6, [x3], #8

Here it would be possible to instead do:

-	ldp	x4, x5, [x3], #16
+	ldp	x5, x6, [x3], #16
-	ldr	x6, [x3], #8

But given this will change in a later patch anyway I guess it doesn't
matter either way.

Other that those comments, the patch looks good to me:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

>  	ldr	x16, [x3]
>  	mov	sp, x16
> -	str	x22, [x4]			// Save processor ID
>  	str	x21, [x5]			// Save FDT pointer
>  	str	x24, [x6]			// Save PHYS_OFFSET
>  	mov	x29, #0
> @@ -633,8 +630,7 @@ ENTRY(secondary_startup)
>  	/*
>  	 * Common entry point for secondary CPUs.
>  	 */
> -	mrs	x22, midr_el1			// x22=cpuid
> -	mov	x0, x22
> +	mrs	x0, midr_el1
>  	bl	lookup_processor_type
>  	mov	x23, x0				// x23=current cpu_table
>  	cbz	x23, __error_p			// invalid processor (x23=0)?
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index e8420f635bd4..8b82ef19b81b 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -63,9 +63,6 @@
>  #include <asm/psci.h>
>  #include <asm/efi.h>
>  
> -unsigned int processor_id;
> -EXPORT_SYMBOL(processor_id);
> -
>  unsigned long elf_hwcap __read_mostly;
>  EXPORT_SYMBOL_GPL(elf_hwcap);
>  
> -- 
> 1.8.3.2
> 
> 
