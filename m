From: will.deacon@arm.com (Will Deacon)
Date: Thu, 14 Apr 2016 17:32:36 +0100
Subject: [PATCH v2 2/4] arm64: move early boot code to the .init segment
In-Reply-To: <1459352589-28721-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1459352589-28721-1-git-send-email-ard.biesheuvel@linaro.org>
 <1459352589-28721-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160414163235.GE4584@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Wed, Mar 30, 2016 at 05:43:07PM +0200, Ard Biesheuvel wrote:
> Apart from the arm64/linux and EFI header data structures, there is nothing
> in the .head.text section that must reside at the beginning of the Image.
> So let's move it to the .init section where it belongs.
> 
> Note that this involves some minor tweaking of the EFI header, primarily
> because the address of 'stext' no longer coincides with the start of the
> .text section. It also requires a couple of relocated symbol references
> to be slightly rewritten or their definition moved to the linker script.

[...]

>  ENTRY(stext)
>  	bl	preserve_boot_args
>  	bl	el2_setup			// Drop to EL1, w20=cpu_boot_mode
> @@ -223,12 +224,12 @@ ENTRY(stext)
>  	 * the TCR will have been set.
>  	 */
>  	ldr	x27, 0f				// address to jump to after
> -						// MMU has been enabled
> +	neg	x27, x27			// MMU has been enabled
>  	adr_l	lr, __enable_mmu		// return (PIC) address
>  	b	__cpu_setup			// initialise processor
>  ENDPROC(stext)
>  	.align	3
> -0:	.quad	__mmap_switched - (_head - TEXT_OFFSET) + KIMAGE_VADDR
> +0:	.quad	(_text - TEXT_OFFSET) - __mmap_switched - KIMAGE_VADDR

I'm struggling to understand why you need to change this. Furthermore,
it looks like the gas docs for expressions require that addition/subtraction
can only be performed on arguments that are in the same section, so
this feels pretty rickety.

What's the problem you're solving here?

Will
