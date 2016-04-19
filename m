From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Tue, 19 Apr 2016 14:29:27 +0000
Subject: [PATCH 5/8] arm64: kernel: replace early 64-bit literal loads
 with move-immediates
In-Reply-To: <1460992188-23295-6-git-send-email-ard.biesheuvel@linaro.org>
References: <1460992188-23295-1-git-send-email-ard.biesheuvel@linaro.org>
 <1460992188-23295-6-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <571640C6.4040901@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/2016 06:09 PM, Ard Biesheuvel wrote:
> When building a relocatable kernel, we currently rely on the fact that
> early 64-bit literal loads need to be deferred to after the relocation
> has been performed only if they involve symbol references, and not if
> they involve assemble time constants. While this is not an unreasonable
> assumption to make, it is better to switch to movk/movz sequences, since
> these are guaranteed to be resolved at link time, simply because there are
> no dynamic relocation types to describe them.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/head.S | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 0d487d90d221..dae9cabaadf5 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -337,7 +337,7 @@ __create_page_tables:
>  	cmp	x0, x6
>  	b.lo	1b
>  
> -	ldr	x7, =SWAPPER_MM_MMUFLAGS
> +	mov	x7, SWAPPER_MM_MMUFLAGS

mov_q here too?

---
Best Regards, Laurentiu

>  
>  	/*
>  	 * Create the identity mapping.
> @@ -393,7 +393,7 @@ __create_page_tables:
>  	 * Map the kernel image (starting with PHYS_OFFSET).
>  	 */
>  	mov	x0, x26				// swapper_pg_dir
> -	ldr	x5, =KIMAGE_VADDR
> +	mov_q	x5, KIMAGE_VADDR
>  	add	x5, x5, x23			// add KASLR displacement
>  	create_pgd_entry x0, x5, x3, x6
>  	ldr	w6, =kernel_img_size
> @@ -631,7 +631,7 @@ ENTRY(secondary_holding_pen)
>  	bl	el2_setup			// Drop to EL1, w20=cpu_boot_mode
>  	bl	set_cpu_boot_mode_flag
>  	mrs	x0, mpidr_el1
> -	ldr     x1, =MPIDR_HWID_BITMASK
> +	mov_q	x1, MPIDR_HWID_BITMASK
>  	and	x0, x0, x1
>  	adr_l	x3, secondary_holding_pen_release
>  pen:	ldr	x4, [x3]
> @@ -773,7 +773,7 @@ __primary_switch:
>  	ldr	w9, =__rela_offset		// offset to reloc table
>  	ldr	w10, =__rela_size		// size of reloc table
>  
> -	ldr	x11, =KIMAGE_VADDR		// default virtual offset
> +	mov_q	x11, KIMAGE_VADDR		// default virtual offset
>  	add	x11, x11, x23			// actual virtual offset
>  	add	x8, x8, x11			// __va(.dynsym)
>  	add	x9, x9, x11			// __va(.rela)
> 
