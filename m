From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 17 Mar 2011 14:42:39 -0400 (EDT)
Subject: [PATCH] ARM:boot:device tree: Allow the device tree binary to be
	appended to zImage
In-Reply-To: <20110309215800.26377.43925.stgit@riker>
References: <20110309215800.26377.43925.stgit@riker>
Message-ID: <alpine.LFD.2.00.1103171422500.26889@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Mar 2011, John Bonesio wrote:

> This patch provides the ability to boot using a device tree that is appended
> to the raw binary zImage (e.g. cat zImage <filename>.dtb > zImage_w_dtb).
> 
> Signed-off-by: John Bonesio <bones@secretlab.ca>

You're almost there, but there are still remaining issues with this 
patch.

> ---
> 
>  arch/arm/Kconfig                |    7 ++++
>  arch/arm/boot/compressed/head.S |   75 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 79 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index d8a330f..1a55e3e 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1593,6 +1593,13 @@ config USE_OF
>  	help
>  	  Include support for flattened device tree machine descriptions.
>  
> +config ARM_APPENDED_DTB
> +	bool "Use appended device tree blob"
> +	depends on OF
> +	help
> +	  With this option, the boot code will look for a device tree binary
> +	  (dtb) appended to zImage.
> +

I'd put this option below the ZBOOT_ROM option, and make it dependent on 
!ZBOOT_ROM, e.g.:

	depends on OF && !ZBOOT_ROM

> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 200625c..611719e 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -210,6 +210,58 @@ restart:	adr	r0, LC0
>  		 */
>  		mov	r10, r6
>  #endif
> +#ifdef CONFIG_ARM_APPENDED_DTB
> +/*
> + *   r0  = delta
> + *   r2  = BSS start
> + *   r3  = BSS end
> + *   r4  = final kernel address
> + *   r5  = start of this image
> + *   r6  = _edata
> + *   r7  = architecture ID
> + *   r8  = atags/device tree pointer
> + *   r9  = size of decompressed image
> + *   r10 = end of this image, including  bss/stack/malloc space if non XIP
> + *   r11 = GOT start
> + *   r12 = GOT end
> + *
> + * if there are device trees (dtb) appended to zImage, advance r10 so that the
> + * dtb data will get relocated along with the kernel if necessary.
> + */
> +
> +		ldr	lr, [r6, #0]
> +#ifndef __ARMEB__
> +		ldr	r1, =0xedfe0dd0		@ sig is 0xd00dfeed big endian
> +#else
> +		ldr	r1, =0xd00dfeed
> +#endif
> +		cmp	lr, r1
> +		bne	dtb_check_done
> +
> +		mov	r8, r6			@ use the appended device tree
> +
> +		/* Get the dtb's size */
> +		ldr	lr, [r6, #4]
> +
> +#ifndef __ARMEB__
> +		/* convert lr (dtb size) to little endian */
> +		eor	r1, lr, lr, ror #16
> +		bic	r1, r1, #0x00ff0000
> +		mov	lr, lr, ror #8
> +		eor	lr, lr, r1, lsr #8
> +#endif
> +		/*
> +		 * dtb size rounded up to a multiple of 8 bytes so a
> +		 * misaligned GOT entry doesn't cause the end of the
> +		 * dtb binary to be overwritten.
> +		 */
> +		add	lr, lr, #7
> +		bic	lr, lr, #7
> +
> +		add	r10, r10, lr
> +		add	r6, r6, lr
> +dtb_check_done:
> +#endif

Now if no dtb was found, or if that code is not configured, then lr 
contains garbage and that may have random consequences with the code 
that follows, which would explain the reported bad behaviors with this 
patch applied even if not configured in the kernel.


>  /*
>   * Check to see if we will overwrite ourselves.
> @@ -272,7 +324,8 @@ wont_overwrite:
>   *   r12 = GOT end
>   *   sp  = stack pointer
>   */
> -		teq	r0, #0
> +		add	r1, r0, lr
> +		teq	r1, #0
>  		beq	not_relocated

A better way to write the above is simply:

		orrs	r1, r0, lr
  		beq	not_relocated

>  		add	r11, r11, r0
>  		add	r12, r12, r0
> @@ -288,12 +341,28 @@ wont_overwrite:
>  
>  		/*
>  		 * Relocate all entries in the GOT table.
> +		 * Bump bss entries to _edata + dtb size
>  		 */
>  1:		ldr	r1, [r11, #0]		@ relocate entries in the GOT
> -		add	r1, r1, r0		@ table.  This fixes up the
> -		str	r1, [r11], #4		@ C references.
> +		add	r1, r1, r0		@ This fixes up C references
> +		cmp	r1, r2			@ if entry >= bss_start &&
> +		cmphs	r3, r1			@       bss_end > entry
> +		addhi	r1, lr			@    entry += dtb size
> +		str	r1, [r11], #4		@ next entry
>  		cmp	r11, r12
>  		blo	1b
> +
> +		/* bump our bss registers too */
> +		add	r2, r2, lr
> +		add	r3, r3, lr
> +
> +		/*
> +		 * bump the stack pinter
> +		 *
> + 		 * If the linker script changes so the stack is not after
> +		 * the bss section, this code will be wrong.
> +		 */
> +		add	sp, sp, lr
>  #else
>  
>  		/*
> 

Nicolas
