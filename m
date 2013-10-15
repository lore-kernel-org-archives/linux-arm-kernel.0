From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 15 Oct 2013 14:24:32 -0400
Subject: [RFC PATCH 3/4] ARM64: Big Endian fixes for kernel booting
In-Reply-To: <1381494135-15085-4-git-send-email-ankit.jindal@linaro.org>
References: <1381494135-15085-1-git-send-email-ankit.jindal@linaro.org>
 <1381494135-15085-4-git-send-email-ankit.jindal@linaro.org>
Message-ID: <525D8860.7080204@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ankit,

On 10/11/2013 08:22 AM, Ankit Jindal wrote:
> - Enable appropriate bits for big endian kernel in SYSCTLR.EL2 and
>   SYSCTLR.EL1 registers
> - Swap entry point for secondary core for big endian kernel
> - Set machine type to "aarch64b" for big endian and "aarch64l"
>   for little endian.
[...]
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -122,6 +122,7 @@
>  	.word	0				// reserved
>  
>  ENTRY(stext)
> +	ARM_BE(bl      setend_be)
>  	mov	x21, x0				// x21=FDT
>  	bl	__calc_phys_offset		// x24=PHYS_OFFSET, x28=PHYS_OFFSET-PAGE_OFFSET
>  	bl	el2_setup			// Drop to EL1
> @@ -148,6 +149,34 @@ ENTRY(stext)
>  ENDPROC(stext)
>  
>  /*
> + * Set el0-el1-el2 to Big endian
> + */

It might be helpful to say why this has to be done (each level needs to be set
up before it's used?) and maybe list them in the order they're set up in.

> +#if defined(CONFIG_CPU_BIG_ENDIAN)
> +ENTRY(setend_be)
> +	mrs     x21, CurrentEL
> +        cmp     x21, #PSR_MODE_EL2t
> +	b.ne  	setend_be_el1_el0

Make sure to use tabs rather than spaces and run checkpatch.pl.

> +
> +setend_be_el2:
> +	mrs     x21, sctlr_el2
> +        mov     x22, #(1<<25)
> +        orr     x21, x21, x22
> +        msr     sctlr_el2, x21
> +	isb
> +
> +setend_be_el1_el0:
> +	mrs     x21, sctlr_el1
> +        mov     x22, #(3<<24)
> +        orr     x21, x21, x22
> +        msr     sctlr_el1, x21
> +	isb
> +
> +	ret
> +ENDPROC(setend_be)
> +#endif /* defined(CONFIG_CPU_BIG_ENDIAN) */
> +
> +/*
>   * If we're fortunate enough to boot at EL2, ensure that the world is
>   * sane before dropping to EL1.
>   */
> @@ -181,7 +210,11 @@ ENTRY(el2_setup)
>  
>  	/* sctlr_el1 */
>  	mov	x0, #0x0800			// Set/clear RES{1,0} bits
> +#if defined(CONFIG_CPU_BIG_ENDIAN)
> +	movk	x0, #0x33d0, lsl #16
> +#else
>  	movk	x0, #0x30d0, lsl #16
> +#endif
>  	msr	sctlr_el1, x0

This may be easier to read if the magic number were ifdef'ed instead of the code.

[...]

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
