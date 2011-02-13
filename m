From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 13 Feb 2011 11:42:43 +0000
Subject: [PATCH 2/2] P2V: Thumb2 support
In-Reply-To: <alpine.LFD.2.00.1102121331220.14920@xanadu.home>
References: <alpine.LFD.2.00.1102121331220.14920@xanadu.home>
Message-ID: <20110213114243.GC4799@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 12, 2011 at 01:33:42PM -0500, Nicolas Pitre wrote:
>  __fixup_a_pv_table:
> +#ifdef CONFIG_THUMB2_KERNEL
> +#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_16BIT
> +	lsls	r0, r6, #24
> +	lsr	r6, #8
> +	beq	1f
> +	clz	r7, r0
> +	lsrs	r0, #24
> +	lsls	r0, r7

Why do these instructions need to update the PSR?

> +	bic	r0, 0x0080
> +	lsrs	r7, #1
> +	orrcs   r0, #0x0080
> +	orr	r0, r0, r7, lsl #12
> +#endif
> +1:	lsls	r6, #24
> +	beq	4f
> +	clz	r7, r6
> +	lsrs	r6, #24
> +	lsls	r6, r7
> +	bic	r6, #0x0080
> +	lsrs	r7, #1
> +	orrcs	r6, #0x0080
> +	orr	r6, r6, r7, lsl #12
> +	orr	r6, #0x4000
> +	b	4f
> +2:	add     r7, r3
> +#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_16BIT
> +	ldrh	ip, [r7]
> +	tst	ip, 0x0400	@ the i bit tells us LS or MS byte
> +	beq	3f
> +	cmp	r0, #0		@ set C flag, and ...
> +	biceq	ip, 0x0400	@ immediate zero value has a special encoding
> +	streqh	ip, [r7]	@ that requires the i bit cleared
> +#endif
> +3:	ldrh	ip, [r7, #2]
> +	and	ip, 0x8f00
> +	orrcc	ip, r6	@ mask in offset bits 31-24
> +	orrcs	ip, r0	@ mask in offset bits 23-16
> +	strh	ip, [r7, #2]
> +4:	cmp	r4, r5
> +        ldrcc   r7, [r4], #4	@ use branch for delay slot
> +        bcc	2b
> +        bx	lr

Something's wrong with the indentation here.
