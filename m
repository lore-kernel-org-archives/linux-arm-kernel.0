From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 14 Feb 2011 10:00:23 -0500 (EST)
Subject: [PATCH v4 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
In-Reply-To: <20110214131750.GA2869@arm.com>
References: <1297263683-10621-1-git-send-email-dave.martin@linaro.org>
	<87pqqy6tdj.fsf@ti.com> <20110214131750.GA2869@arm.com>
Message-ID: <alpine.LFD.2.00.1102140950580.14920@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Feb 2011, Dave Martin wrote:

> @@ -289,8 +297,20 @@ clean_l2:
>  	 *  - should be faster and will change with kernel
>  	 *  - 'might' have to copy address, load and jump to it
>  	 */
> +#ifdef CONFIG_THUMB2_KERNEL
> +	/* kernel is non-interworking : must do this from Thumb */
> +	adr	r1, . + 1
> +	bx	r1
> +	.thumb
> +#endif
>  	ldr	r1, kernel_flush

Didn't you mean this instead:

	/* kernel is non-interworking : must do this from Thumb */
	adr	r1, 1f + 1
	bx	r1
	.thumb
1:	ldr	r1, kernel_flush
	...

?

>  	blx	r1
> +#ifdef CONFIG_THUMB2_KERNEL
> +	.align
> +	bx	pc
> +	nop
> +	.arm

Also here, the .align has the potential to introduce a zero halfword in 
the instruction stream before the bx.  What about:

	adr	r3, 1f
	bx	r3
	.align
	.arm
1:	...


Nicolas
