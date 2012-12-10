From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Dec 2012 00:08:25 +0000
Subject: [PATCH 1/3] ARM: MM: Add the workaround of Errata 774769
In-Reply-To: <001701cdd669$19e8cdd0$4dba6970$%kim@samsung.com>
References: <001701cdd669$19e8cdd0$4dba6970$%kim@samsung.com>
Message-ID: <20121210000825.GH14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 08:58:35AM +0900, Boojin Kim wrote:
> 
> -3:	mov	r10, #0
> +	/* Cortex-A15 Errata */
> +3:	ldr	r10, =0x00000c0f		@ Cortex-A15 primary part number
> +	teq	r0, r10
> +	bne	4f
> +#ifdef CONFIG_ARM_ERRATA_774769

There's not much point testing for the part number of the work-around isn't
enabled.

> +	teq	r6, #0x4			@ present in r0p4
> +	mrceq	p15, 0, r10, c1, c0, 1		@ read aux control register

	tsteq	r10, #1 << 15

to avoid writing to the aux control register if the errata has already been
applied.

> +	orreq	r10, r10, #1 << 25		@ set bit #25
> +	mcreq	p15, 0, r10, c1, c0, 1		@ write aux control register
> +#endif
> +
> +4:	mov	r10, #0
>  	mcr	p15, 0, r10, c7, c5, 0		@ I+BTB cache invalidate
>  	dsb
>  #ifdef CONFIG_MMU
> --
> 1.7.5.4
> 
> 
> 
