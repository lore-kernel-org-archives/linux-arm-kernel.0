From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 16 Mar 2012 10:59:41 +0000
Subject: [PATCH 2/4] ARM: opcodes: Make opcode byteswapping macros
 assembly-compatible
In-Reply-To: <alpine.LFD.2.02.1203151351180.24151@xanadu.home>
References: <1331829132-9762-1-git-send-email-dave.martin@linaro.org>
 <1331829132-9762-3-git-send-email-dave.martin@linaro.org>
 <alpine.LFD.2.02.1203151351180.24151@xanadu.home>
Message-ID: <20120316105928.GA2017@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 01:53:20PM -0400, Nicolas Pitre wrote:
> On Thu, 15 Mar 2012, Dave Martin wrote:
> 
> > Most of the existing macros don't work with assembler, due to the
> > use of type casts and C functions from <linux/swab.h>.
> > 
> > This patch abstracts out those operations and provides simple
> > explicit versions for use in assembly code.
> > 
> > __opcode_is_thumb32() and __opcode_is_thumb16() are also converted
> > to do bitmask-based testing to avoid confusion if these are used in
> > assembly code (the assembler typically treats all arithmetic values
> > as signed).
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> 
> OK.  One really has to read through the whole series to see the point of 
> this.

That's a fair comment -- I'll try to add a bit more clarification with
reference to the other patches.

The real reason for this is that the C preprocessor doesn't resolve
arithmetic expressions, so if we stringify them into inline asm, the
whole expressions just get dumped out to the assembler without getting
evaluated first.  Which means that we need the expressions in a form
which the assembler can evaluate too.

I see you understood that -- but as you say, it's non-obvious.
 
(This can be avoided by using an "i" constraint to pass those numbers
to the inline asm.  I had a local series which did things that way, but
it makes the macros very awkward to use, since you need some macros
to show where in the inline asm to insert the instructions, and different
macros to pass the correct constraints.)

> Acked-by: Nicolas Pitre <nico@linaro.org>

Thanks
---Dave

> 
> 
> 
> > ---
> >  arch/arm/include/asm/opcodes.h |   97 +++++++++++++++++++++++++++++++++------
> >  1 files changed, 82 insertions(+), 15 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/opcodes.h b/arch/arm/include/asm/opcodes.h
> > index cf877c8..32730a8 100644
> > --- a/arch/arm/include/asm/opcodes.h
> > +++ b/arch/arm/include/asm/opcodes.h
> > @@ -19,6 +19,33 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
> >  
> >  
> >  /*
> > + * Assembler opcode byteswap helpers.
> > + * These are only intended for use by this header: don't use them directly,
> > + * because they will be suboptimal in most cases.
> > + */
> > +#define ___asm_opcode_swab32(x) (	\
> > +	  (((x) << 24) & 0xFF000000)	\
> > +	| (((x) <<  8) & 0x00FF0000)	\
> > +	| (((x) >>  8) & 0x0000FF00)	\
> > +	| (((x) >> 24) & 0x000000FF)	\
> > +)
> > +#define ___asm_opcode_swab16(x) (	\
> > +	  (((x) << 8) & 0xFF00)		\
> > +	| (((x) >> 8) & 0x00FF)		\
> > +)
> > +#define ___asm_opcode_swahb32(x) (	\
> > +	  (((x) << 8) & 0xFF00FF00)	\
> > +	| (((x) >> 8) & 0x00FF00FF)	\
> > +)
> > +#define ___asm_opcode_swahw32(x) (	\
> > +	  (((x) << 16) & 0xFFFF0000)	\
> > +	| (((x) >> 16) & 0x0000FFFF)	\
> > +)
> > +#define ___asm_opcode_identity32(x) ((x) & 0xFFFFFFFF)
> > +#define ___asm_opcode_identity16(x) ((x) & 0xFFFF)
> > +
> > +
> > +/*
> >   * Opcode byteswap helpers
> >   *
> >   * These macros help with converting instructions between a canonical integer
> > @@ -41,30 +68,58 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
> >   * Note that values in the range 0x0000E800..0xE7FFFFFF intentionally do not
> >   * represent any valid Thumb-2 instruction.  For this range,
> >   * __opcode_is_thumb32() and __opcode_is_thumb16() will both be false.
> > + *
> > + * The ___asm variants are intended only for use by this header, in situations
> > + * involving inline assembler.  For .S files, the normal __opcode_*() macros
> > + * should do the right thing.
> >   */
> > +#ifdef __ASSEMBLY__
> >  
> > -#ifndef __ASSEMBLY__
> > +#define ___opcode_swab32(x) ___asm_opcode_swab32(x)
> > +#define ___opcode_swab16(x) ___asm_opcode_swab16(x)
> > +#define ___opcode_swahb32(x) ___asm_opcode_swahb32(x)
> > +#define ___opcode_swahw32(x) ___asm_opcode_swahw32(x)
> > +#define ___opcode_identity32(x) ___asm_opcode_identity32(x)
> > +#define ___opcode_identity16(x) ___asm_opcode_identity16(x)
> > +
> > +#else /* ! __ASSEMBLY__ */
> >  
> >  #include <linux/types.h>
> >  #include <linux/swab.h>
> >  
> > +#define ___opcode_swab32(x) swab32(x)
> > +#define ___opcode_swab16(x) swab16(x)
> > +#define ___opcode_swahb32(x) swahb32(x)
> > +#define ___opcode_swahw32(x) swahw32(x)
> > +#define ___opcode_identity32(x) ((u32)(x))
> > +#define ___opcode_identity16(x) ((u16)(x))
> > +
> > +#endif /* ! __ASSEMBLY__ */
> > +
> > +
> >  #ifdef CONFIG_CPU_ENDIAN_BE8
> >  
> > -#define __opcode_to_mem_arm(x) swab32(x)
> > -#define __opcode_to_mem_thumb16(x) swab16(x)
> > -#define __opcode_to_mem_thumb32(x) swahb32(x)
> > +#define __opcode_to_mem_arm(x) ___opcode_swab32(x)
> > +#define __opcode_to_mem_thumb16(x) ___opcode_swab16(x)
> > +#define __opcode_to_mem_thumb32(x) ___opcode_swahb32(x)
> > +#define ___asm_opcode_to_mem_arm(x) ___asm_opcode_swab32(x)
> > +#define ___asm_opcode_to_mem_thumb16(x) ___asm_opcode_swab16(x)
> > +#define ___asm_opcode_to_mem_thumb32(x) ___asm_opcode_swahb32(x)
> >  
> >  #else /* ! CONFIG_CPU_ENDIAN_BE8 */
> >  
> > -#define __opcode_to_mem_arm(x) ((u32)(x))
> > -#define __opcode_to_mem_thumb16(x) ((u16)(x))
> > +#define __opcode_to_mem_arm(x) ___opcode_identity32(x)
> > +#define __opcode_to_mem_thumb16(x) ___opcode_identity16(x)
> > +#define ___asm_opcode_to_mem_arm(x) ___asm_opcode_identity32(x)
> > +#define ___asm_opcode_to_mem_thumb16(x) ___asm_opcode_identity16(x)
> >  #ifndef CONFIG_CPU_ENDIAN_BE32
> >  /*
> >   * On BE32 systems, using 32-bit accesses to store Thumb instructions will not
> >   * work in all cases, due to alignment constraints.  For now, a correct
> >   * version is not proivided for BE32.
> >   */
> > -#define __opcode_to_mem_thumb32(x) swahw32(x)
> > +#define __opcode_to_mem_thumb32(x) ___opcode_swahw32(x)
> > +#define ___asm_opcode_to_mem_thumb32(x) ___asm_opcode_swahw32(x)
> >  #endif
> >  
> >  #endif /* ! CONFIG_CPU_ENDIAN_BE8 */
> > @@ -78,15 +133,27 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
> >  /* Operations specific to Thumb opcodes */
> >  
> >  /* Instruction size checks: */
> > -#define __opcode_is_thumb32(x) ((u32)(x) >= 0xE8000000UL)
> > -#define __opcode_is_thumb16(x) ((u32)(x) < 0xE800UL)
> > +#define __opcode_is_thumb32(x) (		\
> > +	   ((x) & 0xF8000000) == 0xE8000000	\
> > +	|| ((x) & 0xF0000000) == 0xF0000000	\
> > +)
> > +#define __opcode_is_thumb16(x) (					\
> > +	   ((x) & 0xFFFF0000) == 0					\
> > +	&& !(((x) & 0xF800) == 0xE800 || ((x) & 0xF000) == 0xF000)	\
> > +)
> >  
> >  /* Operations to construct or split 32-bit Thumb instructions: */
> > -#define __opcode_thumb32_first(x) ((u16)((x) >> 16))
> > -#define __opcode_thumb32_second(x) ((u16)(x))
> > -#define __opcode_thumb32_compose(first, second) \
> > -	(((u32)(u16)(first) << 16) | (u32)(u16)(second))
> > -
> > -#endif /* __ASSEMBLY__ */
> > +#define __opcode_thumb32_first(x) (___opcode_identity16((x) >> 16))
> > +#define __opcode_thumb32_second(x) (___opcode_identity16(x))
> > +#define __opcode_thumb32_compose(first, second) (			\
> > +	  (___opcode_identity32(___opcode_identity16(first)) << 16)	\
> > +	| ___opcode_identity32(___opcode_identity16(second))		\
> > +)
> > +#define ___asm_opcode_thumb32_first(x) (___asm_opcode_identity16((x) >> 16))
> > +#define ___asm_opcode_thumb32_second(x) (___asm_opcode_identity16(x))
> > +#define ___asm_opcode_thumb32_compose(first, second) (			    \
> > +	  (___asm_opcode_identity32(___asm_opcode_identity16(first)) << 16) \
> > +	| ___asm_opcode_identity32(___asm_opcode_identity16(second))	    \
> > +)
> >  
> >  #endif /* __ASM_ARM_OPCODES_H */
> > -- 
> > 1.7.4.1
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
