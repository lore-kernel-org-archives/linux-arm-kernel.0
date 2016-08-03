From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 3 Aug 2016 17:49:43 +0100
Subject: [PATCH 1/8] ARM: assembler: introduce adr_l, ldr_l and str_l
 macros
In-Reply-To: <1470238730-30038-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1470238730-30038-1-git-send-email-ard.biesheuvel@linaro.org>
 <1470238730-30038-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160803164940.GC7147@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 03, 2016 at 05:38:43PM +0200, Ard Biesheuvel wrote:
> Like arm64, ARM supports position independent code sequences that
> produce symbol references with a greater reach than the ordinary
> adr/ldr instructions.
> 
> Introduce adr_l, that takes the address of a symbol in a PC relative
> manner, and ldr_l/str_l that perform a 32-bit loads/stores from a
> PC-relative offset.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm/include/asm/assembler.h | 59 ++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index 4eaea2173bf8..e1450889f96b 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -512,4 +512,63 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
>  #endif
>  	.endm
>  
> +/*
> + * Pseudo-ops for PC-relative adr/ldr/str <reg>, <symbol> operations
> + */
> +
> +	/*
> +	 * @dst: destination register
> +	 * @sym: name of the symbol
> +	 */
> +	.macro	adr_l, dst, sym
> +#ifdef CONFIG_THUMB2_KERNEL
> +	movw	\dst, #:lower16:(\sym) - (. + 12)
> +	movt	\dst, #:upper16:(\sym) - (. + 8)
> +	add	\dst, \dst, pc

pc always reads as the address of that add plus 4, right?  I remember
some special case where it gets rounded down to a 4-byte boundary, but
IIRC that only applies to certain ldr ..., [pc, ...] forms.

> +#else
> +	add	\dst, pc, #:pc_g0_nc:(\sym) - 8
> +	add	\dst, \dst, #:pc_g1_nc:(\sym) - 4
> +	add	\dst, \dst, #:pc_g2:(\sym)

Whoah.  I've never seen this syntax before...  does this work for any
named reloc, or just for certain blessed relocs?  (I'm also _assuming_
the assembler support for this functionality is ancient -- if not,
there may be toolchain compatibility issues.)

Based on my understanding of how these relocs work, this should do the
right thing, though.


Second question: for arm, this reduces the range addressable to
pc +/- 26-bit offset (24-bit if sym is not word aligned, but that
probably never happens).

I can't remember the de facto limit on the size of vmlinux for arm --
are you sure this extra limitation won't break some cases of huge
initramfs where adr_l gets used for cross-section references?

(For Thumb2, :lower16:/:upper16: give a full 32-bit range, so no problem
there -- sad that this isn't available before ARMv7).

Cheers
---Dave

> +#endif
> +	.endm
> +
> +	/*
> +	 * @dst: destination register
> +	 * @sym: name of the symbol
> +	 * @tmp: optional scratch register to be used if <dst> == sp, which
> +	 *       is not allowed in a Thumb2 ldr instruction
> +	 */
> +	.macro	ldr_l, dst, sym, tmp
> +#ifdef CONFIG_THUMB2_KERNEL
> +	.ifnb	\tmp
> +	adr_l	\tmp, \sym
> +	ldr	\dst, [\tmp]
> +	.else
> +	adr_l	\dst, \sym
> +	ldr	\dst, [\dst]
> +	.endif
> +#else
> +	add	\dst, pc, #:pc_g0_nc:(\sym) - 8
> +	add	\dst, \dst, #:pc_g1_nc:(\sym) - 4
> +	ldr	\dst, [\dst, #:pc_g2:(\sym)]
> +#endif
> +	.endm
> +
> +	/*
> +	 * @src: source register
> +	 * @sym: name of the symbol
> +	 * @tmp: mandatory scratch register to calculate the address
> +	 *       while <src> needs to be preserved.
> +	 */
> +	.macro	str_l, src, sym, tmp:req
> +#ifdef CONFIG_THUMB2_KERNEL
> +	adr_l	\tmp, \sym
> +	str	\src, [\tmp]
> +#else
> +	add	\tmp, pc, #:pc_g0_nc:(\sym) - 8
> +	add	\tmp, \tmp, #:pc_g1_nc:(\sym) - 4
> +	str	\src, [\tmp, #:pc_g2:(\sym)]
> +#endif
> +	.endm
> +
>  #endif /* __ASM_ASSEMBLER_H__ */
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
