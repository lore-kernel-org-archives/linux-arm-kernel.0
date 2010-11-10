From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 10 Nov 2010 15:23:50 -0500 (EST)
Subject: [RFC PATCH v3] ARM: Introduce patching of phys_to_virt and vice
	versa
In-Reply-To: <20101110175549.GD27571@n2100.arm.linux.org.uk>
References: <AANLkTikhcHTRYQki3cCYbWFY_POWX4E26Jau8nYpuDs0@mail.gmail.com>
	<20101108114948.GC14138@n2100.arm.linux.org.uk>
	<20101110164508.GB27571@n2100.arm.linux.org.uk>
	<20101110175549.GD27571@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1011101327520.13911@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 8 Nov 2010, Russell King - ARM Linux wrote:

> noting that:
> 
> 	add	rd, rn, #PAGE_OFFSET - PHYS_OFFSET
> 	sub	rd, rn, #PHYS_OFFSET - PAGE_OFFSET
> 
> are equivalent.
> 
> We can do better than this - just make sure that all virt_to_phys() are an
> add instruction, and all phys_to_virt() are a sub struction.  Then we only
> need to fixup the constant.  IOW, virt_to_phys() is:
> 
> 	add	rd, rn, #PHYS_OFFSET - PAGE_OFFSET
> 
> and phys_to_virt() is:
> 
> 	sub	rd, rn, #PHYS_OFFSET - PAGE_OFFSET

Does this work even if PHYS_OFFSET - PAGE_OFFSET goes negative? 
Shouldn't we need to switch the encoding of an add into a sub and vice 
versa with a positive immediate value in that case? (I don't have the 
instruction encoding info handy at the moment).

On Wed, 10 Nov 2010, Russell King - ARM Linux wrote:

> Here's something which uses the above ideas (untested).  I think this is
> something we can (and should) do unconditionally for the !XIP cases.

What do you mean by "unconditionally"?

> We also need to fixup modules in a similar manner, so we want to place 
> the __fixup_pv_table function in the .text, and give it a wrapper 
> along the lines of:
[...]

Modules... of course.  I hadn't thought about them.

> Second version - let's get _all_ v:p translations, not just virt_to_phys
> and phys_to_virt (iow, __phys_to_virt/__virt_to_phys/__pa/__va) which will
> include all the page table manipulations, default bus<->virt translations.
> This results in a _much_ bigger fixup table.
> 
> It also results in no fixup table being generated for platforms which
> have complex v:p translations (cns3xxx, iop13xx, ixp2xxx, ks8695,
> realview, s3c24a0).

Obviously.

> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index dd6b369..bcc502f 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -93,6 +93,9 @@ ENTRY(stext)
>  #ifdef CONFIG_SMP_ON_UP
>  	bl	__fixup_smp
>  #endif
> +#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
> +	bl	__fixup_pv_table
> +#endif
>  	bl	__create_page_tables
>  
>  	/*
> @@ -426,4 +429,37 @@ smp_on_up:
>  
>  #endif
>  
> +#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
> +
> +/* __fixup_pv_table - patch the stub instructions with the delta between
> + * PHYS_OFFSET and PAGE_OFFSET, which is assumed to be 16MiB aligned and
> + * can be expressed by an immediate shifter operand. The stub instruction
> + * has a form of '(add|sub) rd, rn, #imm'.
> + */
> +__fixup_pv_table:
> +	adr	r0, 1f
> +	ldmia	r0, {r3-r5}
> +	sub	r3, r0, r3	@ PHYS_OFFSET - PAGE_OFFSET
> +	mov	r6, r3, lsr #24	@ constant for add/sub instructions
> +	teq	r3, r6, lsl #24 @ must be 16MiB aligned
> +	bne	__error
> +	orr	r6, r6, #0x400	@ mask in rotate right 8 bits
> +	add	r4, r4, r3
> +	add	r5, r5, r3
> +2:	cmp	r4, r5
> +	ldrlo	r7, [r4], #4
> +	ldrlo	ip, [r7, r3]
> +	bic	ip, ip, #0x000000ff
> +	bic	ip, ip, #0x00000f00
> +	orr	ip, ip, r6

The above 3 insns could be replaced with:

	mov	ip, ip, lsr #12
	orr	ip, r6, ip, lsl #12

> +	strlo	ip, [r7, r3]
> +	blo	2b
> +	mov	pc, lr
> +ENDPROC(__fixup_phys_virt)


Nicolas
