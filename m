From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Jul 2015 18:25:29 +0100
Subject: [PATCH 05/18] arm64: introduce CONFIG_ARM64_LSE_ATOMICS as
 fallback to ll/sc atomics
In-Reply-To: <20150717163219.GA4208@e104818-lin.cambridge.arm.com>
References: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
 <1436779519-2232-6-git-send-email-will.deacon@arm.com>
 <20150717163219.GA4208@e104818-lin.cambridge.arm.com>
Message-ID: <20150717172529.GG8055@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Fri, Jul 17, 2015 at 05:32:20PM +0100, Catalin Marinas wrote:
> On Mon, Jul 13, 2015 at 10:25:06AM +0100, Will Deacon wrote:
> > In order to patch in the new atomic instructions at runtime, we need to
> > generate wrappers around the out-of-line exclusive load/store atomics.
> > 
> > This patch adds a new Kconfig option, CONFIG_ARM64_LSE_ATOMICS. which
> > causes our atomic functions to branch to the out-of-line ll/sc
> > implementations. To avoid the register spill overhead of the PCS, the
> > out-of-line functions are compiled with specific compiler flags to
> > force out-of-line save/restore of any registers that are usually
> > caller-saved.
> 
> I'm still trying to get my head around those -ffixed -fcall-used
> options.

Yeah, they're pretty funky, but note that x86 does similar tricks for
some of its patching too (see ARCH_HWEIGHT_CFLAGS).

> > +#define ATOMIC_OP(op, asm_op)					\
> > +static inline void atomic_##op(int i, atomic_t *v)			\
> > +{									\
> > +	unsigned long lr;						\
> > +	register int w0 asm ("w0") = i;					\
> > +	register atomic_t *x1 asm ("x1") = v;				\
> > +									\
> > +	asm volatile(							\
> > +	__LL_SC_SAVE_LR(%0)						\
> > +	__LL_SC_CALL(op)						\
> > +	__LL_SC_RESTORE_LR(%0)						\
> > +	: "=&r" (lr), "+r" (w0), "+Q" (v->counter)			\
> > +	: "r" (x1));							\
> > +}									\
> 
> Since that's an inline function, in most cases we wouldn't need to
> save/restore LR for a BL call, it may already be on the stack of the
> including functions. Can we just not tell gcc that LR is clobbered by
> this asm and it makes its own decision about saving/restoring?

If we put lr in the clobber list, then it will get saved/restored by GCC
even when we are using the LSE atomics and don't touch lr at all. Also
note that later on the temporary register used to hold lr for the
out-of-line case is used as part of the LSE atomic, so there's no real
cost to having it.

> As for v->counter, could we allocate it in callee-saved registers
> already and avoid the -ffixed etc. options.

The issue with that is when we don't use LSE and want to in-line the
ll/sc variants. Also, the weird compiler options also apply to any
temporary variables that the out-of-line code uses, so we'd need knowledge
of that here in order to allocate registers correctly (and then I have no
idea how you'd unpack things on the other side).

My first stab at this tried to specify fcall-used on a
per-function-prototype basis using target attributes, but GCC just silently
ignores those :(

> But note that I'm still trying to understand all these tricks, so I may
> be wrong.

Sorry for all the tricks, but it's the best I could come up with whilst
still generating decent disassembly for all cases. You get used to it
after a bit.

Will
