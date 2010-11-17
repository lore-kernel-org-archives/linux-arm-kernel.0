From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 17 Nov 2010 11:17:01 -0500 (EST)
Subject: [PATCH 7/7 v1.1] ARM: Thumb-2: Restore sensible zImage header
	layout for CONFIG_THUMB2_KERNEL
In-Reply-To: <1289992294-7181-1-git-send-email-dave.martin@linaro.org>
References: <1289913277-8822-7-git-send-email-dave.martin@linaro.org>
	<1289992294-7181-1-git-send-email-dave.martin@linaro.org>
Message-ID: <alpine.LFD.2.00.1011171056540.6448@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Nov 2010, Dave Martin wrote:

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
> Applies cleanly on v2.6.37-rc2.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Only a nanonit below that is not that important.

> index 1f65080..ab95391 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -125,16 +125,21 @@ wait:		mrc	p14, 0, pc, c0, c1, 0
>   * sort out different calling conventions
>   */
>  		.align
> + THUMB(		.arm			)

Maybe the THUMB() can be omitted here and .arm be unconditional?

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
>  		.word	0x016f2818		@ Magic numbers to help the loader
>  		.word	start			@ absolute load/run zImage address
>  		.word	_edata			@ zImage end address
> + THUMB(		.thumb			)
>  1:		mov	r7, r1			@ save architecture ID
>  		mov	r8, r2			@ save atags pointer
>  
> -- 
> 1.7.1
> 
