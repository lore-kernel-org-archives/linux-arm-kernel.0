From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 18 Oct 2013 16:25:47 -0400 (EDT)
Subject: [PATCH] ARM: cacheflush: consolidate single-CPU ARMv7 cache
 disabling code
In-Reply-To: <20131018104448.GA2315@localhost.localdomain>
References: <20131018104448.GA2315@localhost.localdomain>
Message-ID: <alpine.LFD.2.03.1310181559320.1951@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Oct 2013, Dave Martin wrote:

> On Tue, Oct 15, 2013 at 11:34:46PM -0400, Nicolas Pitre wrote:
> > 
> > This code is becoming duplicated in many places.  So let's consolidate
> > it into a handy macro that is known to be right and available for reuse.
> > 
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > ---
> > 
> > I forgot which version this one is.  As far as I know, I've incorporated 
> > most review comments, and ignored conflicting ones which tended to look 
> > like bikeshedding and attempted to compensate for them with additional 
> 
> Whoever can you be referring to? :)

Who knows... ;-)

> I think the discussion about whether there was some way to improve this
> was worth having ... but the answer definitely seemed to be no.

Certainly.

> > code comments.
> > 
> > ACK?
> > 
> >  arch/arm/include/asm/cacheflush.h | 45 +++++++++++++++++++++++++++++++
> >  arch/arm/mach-vexpress/dcscb.c    | 56 +++------------------------------------
> >  arch/arm/mach-vexpress/tc2_pm.c   | 48 ++-------------------------------
> >  3 files changed, 51 insertions(+), 98 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
> > index 15f2d5bf88..60a0a79b1a 100644
> > --- a/arch/arm/include/asm/cacheflush.h
> > +++ b/arch/arm/include/asm/cacheflush.h
> > @@ -435,4 +435,49 @@ static inline void __sync_cache_range_r(volatile void *p, size_t size)
> >  #define sync_cache_w(ptr) __sync_cache_range_w(ptr, sizeof *(ptr))
> >  #define sync_cache_r(ptr) __sync_cache_range_r(ptr, sizeof *(ptr))
> >  
> > +/*
> > + * Disabling cache access for one CPU in an ARMv7 SMP system is tricky.
> > + * To do so we must:
> > + *
> > + * - Clear the SCTLR.C bit to prevent further cache allocations
> > + * - Flush the desired level of cache
> > + * - Clear the ACTLR "SMP" bit to disable local coherency
> > + *
> > + * ... and so without any intervening memory access in between those steps,
> > + * not even to the stack.
> > + *
> > + * WARNING -- After this has been called:
> > + *
> > + * - No ldrex/strex (and similar) instructions must be used.
> > + * - The CPU is obviously no longer coherent with the other CPUs.
> > + * - This is unlikely to work as expected if Linux is running non-secure.
> > + *
> > + * Note:
> > + *
> > + * - This is known to apply to several ARMv7 processor implementations,
> > + *   however some exceptions may exist.  Caveat emptor.
> 
> Is it worth listing CPUs for which we know this works?  (i.e., A15, A7)
> That could get misleading if the list is not kept up to date, though.

That's what I think.  And some people would interpret it as "this works 
only for A15 and A7".



> 
> > + *
> > + * - The clobber list is dictated by the call to v7_flush_dcache_*.
> > + *   fp is preserved to the stack explicitly prior disabling the cache
> > + *   since adding it to the clobber list is incompatible with having
> > + *   CONFIG_FRAME_POINTER=y.
> > + */
> > +#define v7_exit_coherency_flush(level) \
> > +	asm volatile( \
> > +	"str	fp, [sp, #-4]! \n\t" \
> > +	"mrc	p15, 0, r0, c1, c0, 0	@ get SCTLR \n\t" \
> > +	"bic	r0, r0, #"__stringify(CR_C)" \n\t" \
> > +	"mcr	p15, 0, r0, c1, c0, 0	@ set SCTLR \n\t" \
> > +	"isb	\n\t" \
> > +	"bl	v7_flush_dcache_"__stringify(level)" \n\t" \
> > +	"clrex	\n\t" \
> > +	"mrc	p15, 0, r0, c1, c0, 1	@ get ACTLR \n\t" \
> > +	"bic	r0, r0, #(1 << 6)	@ disable local coherency \n\t" \
> > +	"mcr	p15, 0, r0, c1, c0, 1	@ set ACTLR \n\t" \
> > +	"isb	\n\t" \
> > +	"dsb	\n\t" \
> > +	"ldr	fp, [sp], #4" \
> > +	: : : "r0","r1","r2","r3","r4","r5","r6","r7", \
> > +	      "r9","r10","lr","memory" )
> 
> Should we put r12 in the clobber list too?
> 
> I think that the linker shouldn't introduce an r12-clobbering trampoline
> in practice unless the kernel text gets big (>16MB), but if we can add
> it here without the compiler complaining about register pressuse it might
> save some debugging headaches in the future.

OK.  I'll just save it on the stack alongside fp.


Nicolas
> With that change (or a reason not to do it), Ack.

Thanks.


Nicolas
