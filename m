From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 22 Nov 2010 13:28:51 -0500 (EST)
Subject: [PATCH v2 7/9] ARM: Thumb-2: Restore sensible zImage header layout
	for CONFIG_THUMB2_KERNEL
In-Reply-To: <1290449065-28843-8-git-send-email-dave.martin@linaro.org>
References: <1290449065-28843-1-git-send-email-dave.martin@linaro.org>
	<1290449065-28843-8-git-send-email-dave.martin@linaro.org>
Message-ID: <alpine.LFD.2.00.1011221312500.9313@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Nov 2010, Dave Martin wrote:

> The code which makes up the zImage header intends to leave a
> 32-byte gap followed by a branch to the real entry point, a
> magic number, and a word containing the absolute entry point
> address.
> 
> This gets messed up with with CONFIG_THUMB2_KERNEL, because the
> size of the initial padding NOPs changes.
> 
> Instead, the header can be made fully compatible by restoring
> it to ARM.
> 
> In the Thumb-2 case, we can replace the initial NOPs with a
> sequence which switches to Thumb and jumps to the real entry
> point.
> 
> As a consequence, the zImage entry point is now always ARM, so
> no special magic is needed any more for the uImage rules in the
> Thumb-2 case.
> 
> Applies on v2.6.37-rc3.

Ideally you should keep that line above outside of the actual commit log 
text, as no one will care on what version it applies to once it is 
merged.  It is best to put that below the --- line, or omit it entirely 
if using 'git send-email'.

> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Looking at it again there is a problem with the patch as is...

> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -125,16 +125,21 @@ wait:		mrc	p14, 0, pc, c0, c1, 0
>   * sort out different calling conventions
>   */
>  		.align
> +		.arm				@ Always enter in ARM state
>  start:
>  		.type	start,#function
> -		.rept	8
> + THUMB(		adr	r12, BSYM(1f)	)
> + THUMB(		bx	r12		)
> + THUMB(		.rept	6		)
> + ARM(		.rept	8		)
>  		mov	r0, r0
>  		.endr
>  
> -		b	1f
> +		nop				@ Pad magic number to 0x24

Why is this branch removed?  With an ARM mode kernel this means we'll 
attempt to execute the magic number that follows.

>  		.word	0x016f2818		@ Magic numbers to help the loader
>  		.word	start			@ absolute load/run zImage address
>  		.word	_edata			@ zImage end address
> + THUMB(		.thumb			)
>  1:		mov	r7, r1			@ save architecture ID
>  		mov	r8, r2			@ save atags pointer
>  

Nicolas
