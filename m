From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Nov 2010 11:49:48 +0000
Subject: [RFC PATCH v3] ARM: Introduce patching of phys_to_virt and
	vice versa
In-Reply-To: <AANLkTikhcHTRYQki3cCYbWFY_POWX4E26Jau8nYpuDs0@mail.gmail.com>
References: <AANLkTikhcHTRYQki3cCYbWFY_POWX4E26Jau8nYpuDs0@mail.gmail.com>
Message-ID: <20101108114948.GC14138@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 06, 2010 at 02:40:46AM +0800, Eric Miao wrote:
> +__fixup_phys_virt:
> + 	/*
> +	 * r0 - PHYS_OFFSET
> +	 * r6 - bits to set in phys_to_virt stub instructions
> +	 * r7 - bits to set in virt_to_phys stub instructions
> +	 */
> +	ldr	r0, =PHYS_OFFSET
> +	cmp	r0, #PAGE_OFFSET
> +	subhi	r1, r0, #PAGE_OFFSET
> +	rsbls	r1, r0, #PAGE_OFFSET
> +	lsr	r1, r1, #24
> +	orr	r1, r1, #0x400
> +	orrhi	r6, r1, #PATCH_INSTR_SUB
> +	orrhi	r7, r1, #PATCH_INSTR_ADD
> +	orrls	r6, r1, #PATCH_INSTR_ADD
> +	orrls	r7, r1, #PATCH_INSTR_SUB
> +
> +	/* r0 - instruction to patch
> +	 * r1 - address offset
> +	 * r2 - index into __patch_table
> +	 * r3 - __patch_table_end
> +	 */
> +	adr	r0, 1f
> +	ldmia	r0, {r1, r2, r3}
> +	sub	r1, r0, r1

Also note that r1 here is (PHYS_OFFSET - PAGE_OFFSET) - r0 was the physical
address of '1f', and the loaded value of r1 is the virtual address of '1f'.

So, I think the above code can be replaced by:

	adr	r0, 1f
	ldmia	r0, {r1-r3}
	sub	r1, r0, r1
	mov	r4, r1, lsr #24
	orr	r4, r4, #0x0400
	orr	r6, r4, #PATCH_INSTR_SUB
	orr	r7, r4, #PATCH_INSTR_ADD
	teq	r1, r4, lsl #24
	bne	error

noting that:

	add	rd, rn, #PAGE_OFFSET - PHYS_OFFSET
	sub	rd, rn, #PHYS_OFFSET - PAGE_OFFSET

are equivalent.

We can do better than this - just make sure that all virt_to_phys() are an
add instruction, and all phys_to_virt() are a sub struction.  Then we only
need to fixup the constant.  IOW, virt_to_phys() is:

	add	rd, rn, #PHYS_OFFSET - PAGE_OFFSET

and phys_to_virt() is:

	sub	rd, rn, #PHYS_OFFSET - PAGE_OFFSET
