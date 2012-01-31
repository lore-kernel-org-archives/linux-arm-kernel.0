From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 31 Jan 2012 18:27:12 +0000
Subject: [PATCH v5] ARM: Add generic instruction opcode manipulation
 helpers
In-Reply-To: <1328034140.2464.3.camel@computer2.home>
References: <1328008180-28542-1-git-send-email-dave.martin@linaro.org>
 <1328034140.2464.3.camel@computer2.home>
Message-ID: <20120131182643.GA32536@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2012 at 06:22:20PM +0000, Tixy wrote:
> On Tue, 2012-01-31 at 11:09 +0000, Dave Martin wrote:
> > This patch adds some endianness-agnostic helpers to convert machine
> > instructions between canonical integer form and in-memory
> > representation.
> > 
> > A canonical integer form for representing instructions is also
> > formalised here.
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> > Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> 
> I can confirm this version applies and builds cleanly against
> linux-next. And works with Rabin 's jump label support patches.

OK -- thanks.  Can I add your Tested-by for completeness?

Cheers
---Dave

> 
> -- 
> Tixy
> 
> 
> > ---
> > Changes since v1:
> > 
> > v5: Avoid inclusion of C headers or definition of the __opcode_*
> >     macros when opcodes.h is included in assembler files.  Since
> >     the __opcode_* macros rely on C declarations, they are not
> >     directly usable in assembler anyway.
> > 
> > v4: Rebase on top of Leif's patch which created <asm/opcodes.h>
> >     ARM: 7206/1: Add generic ARM instruction set condition code checks.
> > 
> >     No functional changes.
> > 
> > v3: Fix some stupid errors:
> > 
> >   * remove bogus extra (x) in __opcode_to_mem_arm
> >   * fix use of nonexistent "thumb_opcode" argument in
> >         __opcode_thumb32_{first,second} which causes these
> >         macros to be broken.
> > 
> > v2: Remove unnecessary typedef for arm_opcode_t.
> > 
> >     The general "everything is a word" concept works just fine here --
> >     we don't need a typedef, and people will probably not use it
> >     anyway.
> > 
> >  arch/arm/include/asm/opcodes.h |   59 ++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 59 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/opcodes.h b/arch/arm/include/asm/opcodes.h
> > index c0efdd6..19c48de 100644
> > --- a/arch/arm/include/asm/opcodes.h
> > +++ b/arch/arm/include/asm/opcodes.h
> > @@ -17,4 +17,63 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
> >  #define ARM_OPCODE_CONDTEST_PASS   1
> >  #define ARM_OPCODE_CONDTEST_UNCOND 2
> >  
> > +
> > +/*
> > + * Opcode byteswap helpers
> > + *
> > + * These macros help with converting instructions between a canonical integer
> > + * format and in-memory representation, in an endianness-agnostic manner.
> > + *
> > + * __mem_to_opcode_*() convert from in-memory representation to canonical form.
> > + * __opcode_to_mem_*() convert from canonical form to in-memory representation.
> > + *
> > + *
> > + * Canonical instruction representation:
> > + *
> > + *	ARM:		0xKKLLMMNN
> > + *	Thumb 16-bit:	0x0000KKLL, where KK < 0xE8
> > + *	Thumb 32-bit:	0xKKLLMMNN, where KK >= 0xE8
> > + *
> > + * There is no way to distinguish an ARM instruction in canonical representation
> > + * from a Thumb instruction (just as these cannot be distinguished in memory).
> > + * Where this distinction is important, it needs to be tracked separately.
> > + *
> > + * Note that values in the range 0x0000E800..0xE7FFFFFF intentionally do not
> > + * represent any valid Thumb-2 instruction.  For this range,
> > + * __opcode_is_thumb32() and __opcode_is_thumb16() will both be false.
> > + */
> > +
> > +#ifndef __ASSEMBLY__
> > +
> > +#include <linux/types.h>
> > +#include <linux/swab.h>
> > +
> > +#ifdef CONFIG_CPU_ENDIAN_BE8
> > +#define __opcode_to_mem_arm(x) swab32(x)
> > +#define __opcode_to_mem_thumb16(x) swab16(x)
> > +#define __opcode_to_mem_thumb32(x) swahb32(x)
> > +#else
> > +#define __opcode_to_mem_arm(x) ((u32)(x))
> > +#define __opcode_to_mem_thumb16(x) ((u16)(x))
> > +#define __opcode_to_mem_thumb32(x) swahw32(x)
> > +#endif
> > +
> > +#define __mem_to_opcode_arm(x) __opcode_to_mem_arm(x)
> > +#define __mem_to_opcode_thumb16(x) __opcode_to_mem_thumb16(x)
> > +#define __mem_to_opcode_thumb32(x) __opcode_to_mem_thumb32(x)
> > +
> > +/* Operations specific to Thumb opcodes */
> > +
> > +/* Instruction size checks: */
> > +#define __opcode_is_thumb32(x) ((u32)(x) >= 0xE8000000UL)
> > +#define __opcode_is_thumb16(x) ((u32)(x) < 0xE800UL)
> > +
> > +/* Operations to construct or split 32-bit Thumb instructions: */
> > +#define __opcode_thumb32_first(x) ((u16)((x) >> 16))
> > +#define __opcode_thumb32_second(x) ((u16)(x))
> > +#define __opcode_thumb32_compose(first, second) \
> > +	(((u32)(u16)(first) << 16) | (u32)(u16)(second))
> > +
> > +#endif /* __ASSEMBLY__ */
> > +
> >  #endif /* __ASM_ARM_OPCODES_H */
> 
> 
> 
