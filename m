From: james.morse@arm.com (James Morse)
Date: Mon, 04 Apr 2016 16:13:58 +0100
Subject: [PATCH 2/8] arm64/kernel: reuse boot_args array to get to
 __fdt_pointer
In-Reply-To: <1459781544-14310-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1459781544-14310-1-git-send-email-ard.biesheuvel@linaro.org>
 <1459781544-14310-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <570284B6.9000006@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On 04/04/16 15:52, Ard Biesheuvel wrote:
> Since we record the boot_args [x0 .. x3] early at boot anyway, there is
> no need to keep the FDT address in a callee saved register with file scope
> in head.S. So simply refer to boot_args[0] directly in the call to
> setup_machine(), and drop the handling of x21 from head.S entirely.

Won't this break Big Endian?
(or more accurately: bootloader-endian != kernel-endian)

The stores in preserve_boot_args happen before the EE/E0E bits have been
set/cleared by el2_setup(), so they happen with boot-loader:endianness. The
loads after el2_setup() happen with kernel:endianness.


Thanks,

James


> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/head.S  | 14 ++++++--------
>  arch/arm64/kernel/setup.c |  4 +---
>  2 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 69b33535911e..9d8f928c355c 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -234,16 +234,15 @@ ENDPROC(stext)
>   * Preserve the arguments passed by the bootloader in x0 .. x3
>   */
>  preserve_boot_args:
> -	mov	x21, x0				// x21=FDT
> -
> -	adr_l	x0, boot_args			// record the contents of
> -	stp	x21, x1, [x0]			// x0 .. x3 at kernel entry
> -	stp	x2, x3, [x0, #16]
> +	adr_l	x4, boot_args			// record the contents of
> +	stp	x0, x1, [x4]			// x0 .. x3 at kernel entry
> +	stp	x2, x3, [x4, #16]
>  
>  	dmb	sy				// needed before dc ivac with
>  						// MMU off
>  
> -	add	x1, x0, #0x20			// 4 x 8 bytes
> +	mov	x0, x4
> +	add	x1, x4, #0x20			// 4 x 8 bytes
>  	b	__inval_cache_range		// tail call
>  ENDPROC(preserve_boot_args)
>  
> @@ -480,7 +479,6 @@ __mmap_switched:
>  	mov	x4, sp
>  	and	x4, x4, #~(THREAD_SIZE - 1)
>  	msr	sp_el0, x4			// Save thread_info
> -	str_l	x21, __fdt_pointer, x5		// Save FDT pointer
>  
>  	ldr_l	x4, kimage_vaddr		// Save the offset between
>  	sub	x4, x4, x24			// the kernel virtual and
> @@ -492,7 +490,7 @@ __mmap_switched:
>  #endif
>  #ifdef CONFIG_RANDOMIZE_BASE
>  	cbnz	x23, 0f				// already running randomized?
> -	mov	x0, x21				// pass FDT address in x0
> +	ldr_l	x0, boot_args			// pass FDT address in x0
>  	bl	kaslr_early_init		// parse FDT for KASLR options
>  	cbz	x0, 0f				// KASLR disabled? just proceed
>  	mov	x23, x0				// record KASLR offset
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 9dc67769b6a4..83a3e484a90a 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -64,8 +64,6 @@
>  #include <asm/xen/hypervisor.h>
>  #include <asm/mmu_context.h>
>  
> -phys_addr_t __fdt_pointer __initdata;
> -
>  /*
>   * Standard memory resources
>   */
> @@ -304,7 +302,7 @@ void __init setup_arch(char **cmdline_p)
>  	early_fixmap_init();
>  	early_ioremap_init();
>  
> -	setup_machine_fdt(__fdt_pointer);
> +	setup_machine_fdt(boot_args[0]);
>  
>  	parse_early_param();
>  
> 
