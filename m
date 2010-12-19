From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 19 Dec 2010 11:09:13 +0000
Subject: [PATCH v4 3/6] ARM: U8500 core machine support
In-Reply-To: <1259279756.13327.72.camel@vinay-desktop>
References: <1259279756.13327.72.camel@vinay-desktop>
Message-ID: <20101219110913.GA23979@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... going back to this patch...

On Fri, Nov 27, 2009 at 05:25:56AM +0530, srinidhi kasagar wrote:
> +/*
> + * U8500 specific entry point for secondary CPUs.
> + */
> +ENTRY(u8500_secondary_startup)
> +	mrc	p15, 0, r0, c0, c0, 5
> +	and	r0, r0, #15
> +	adr	r4, 1f
> +	ldmia	r4, {r5, r6}
> +	sub	r4, r4, r5
> +	add	r6, r6, r4
> +	dsb

Can you please explain why you added a dsb here, whereas most other
platforms don't require it?

> +pen:	ldr	r7, [r6]
> +	cmp	r7, r0
> +	bne	pen
> +
> +	/*
> +	 * we've been released from the holding pen: secondary_stack
> +	 * should now contain the SVC stack for this core
> +	 */
> +	b	secondary_startup
> +
> +1:	.long	.
> +	.long	pen_release
