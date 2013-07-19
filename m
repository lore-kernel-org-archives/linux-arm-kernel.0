From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 19 Jul 2013 11:59:07 +0100
Subject: [PATCH 1/4] ARM: vexpress/dcscb: fix cache disabling sequences
In-Reply-To: <20130719102844.GA3746@localhost.localdomain>
References: <1374118116-16836-1-git-send-email-nicolas.pitre@linaro.org>
 <1374118116-16836-2-git-send-email-nicolas.pitre@linaro.org>
 <20130718150408.GB2655@localhost.localdomain>
 <alpine.LFD.2.03.1307181231510.14924@syhkavp.arg>
 <20130718180323.GC2655@localhost.localdomain>
 <alpine.LFD.2.03.1307181452480.14924@syhkavp.arg>
 <20130719102844.GA3746@localhost.localdomain>
Message-ID: <20130719105907.GB27389@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 19, 2013 at 11:28:49AM +0100, Dave Martin wrote:
> On Thu, Jul 18, 2013 at 02:59:06PM -0400, Nicolas Pitre wrote:
> > On Thu, 18 Jul 2013, Dave Martin wrote:
> > 
> > > On Thu, Jul 18, 2013 at 01:24:48PM -0400, Nicolas Pitre wrote:
> > > > [ added Russell for his opinion on the patch below ]
> > > 
> > > [...]
> > > 
> > > > commit 390cf8b9b83eeeebdfef51912f5003a6a9b84115
> > > > Author: Nicolas Pitre <nicolas.pitre@linaro.org>
> > > > Date:   Thu Jul 18 13:12:48 2013 -0400
> > > > 
> > > >     ARM: cacheflush: consolidate single-CPU ARMv7 cache disabling code
> > > >     
> > > >     This code is becoming duplicated in many places.  So let's consolidate
> > > >     it into a handy macro that is known to be right and available for reuse.
> > > >     
> > > >     Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > > > 
> > > > diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
> > > > index 17d0ae8672..8a76933e80 100644
> > > > --- a/arch/arm/include/asm/cacheflush.h
> > > > +++ b/arch/arm/include/asm/cacheflush.h
> > > > @@ -436,4 +436,33 @@ static inline void __sync_cache_range_r(volatile void *p, size_t size)
> > > >  #define sync_cache_w(ptr) __sync_cache_range_w(ptr, sizeof *(ptr))
> > > >  #define sync_cache_r(ptr) __sync_cache_range_r(ptr, sizeof *(ptr))
> > > >  
> > > > +/*
> > > > + * Disabling cache access for one CPU in an ARMv7 SMP system is tricky.
> > > > + * To do so we must:
> > > > + *
> > > > + * - Clear the SCTLR.C bit to prevent further cache allocations
> > > > + * - Flush the desired level of cache
> > > > + * - Clear the ACTLR "SMP" bit to disable local coherency
> > > > + *
> > > > + * ... and so without any intervening memory access in between those steps,
> > > > + * not even to the stack.
> > > > + *
> > > > + * The clobber list is dictated by the call to v7_flush_dcache_*.
> > > > + */
> > > > +#define v7_disable_flush_cache(level) \
> > > > +	asm volatile( \
> > > > +	"mrc	p15, 0, r0, c1, c0, 0	@ get CR \n\t" \
> > > > +	"bic	r0, r0, #"__stringify(CR_C)" \n\t" \
> > > > +	"mcr	p15, 0, r0, c1, c0, 0	@ set CR \n\t" \
> > > > +	"isb	\n\t" \
> > > > +	"bl	v7_flush_dcache_"__stringify(level)" \n\t" \
> > > > +	"clrex	\n\t" \
> > > > +	"mrc	p15, 0, r0, c1, c0, 1	@ get AUXCR \n\t" \
> > > > +	"bic	r0, r0, #(1 << 6)	@ disable local coherency \n\t" \
> > > > +	"mcr	p15, 0, r0, c1, c0, 1	@ set AUXCR \n\t" \
> > > > +	"isb	\n\t" \
> > > > +	"dsb	" \
> > > > +	: : : "r0","r1","r2","r3","r4","r5","r6","r7", \
> > > > +	      "r9","r10","r11","lr","memory" )
> > > > +
> > > >  #endif
> > > 
> > > That's roughly what I had in mind, though it might belong somewhere more
> > > obscure than cacheflush.h(?)
> > 
> > Any suggestions for that?  Maybe asm/mcpm.h but that might be used in 
> > other circumstances as well.
> 
> I don't really have a better idea...  if nobody objects strongly to
> putting it in cacheflush.h, I happy to go with that.
> > 
> > > "disable_flush_cache" sounds a too general-purpose for my liking.
> > > 
> > > "v7" isn't really right because we touch the ACTLR.  This only works
> > > on certain CPUs and when Linux is running Secure.  Maybe saying "a15"
> > > instead of "a7" is reasonable, since a7 is supposed to be an a15
> > > workalike in most places.
> > 
> > Isn't this how this should be done on an A9 too?  Lorenzo asked me to do 
> 
> Quite possibly -- the point is, it's not guaranteed that all v7 CPUs will
> work the same way, especially the custom implementations.   Third-party v7
> implementations like Snapdragon etc. need not be in any way the same as
> ARM's CPUs with regard to details like the SMP bit.

Well, if they change the SMP bit behaviour from what the TRM describes they
certainly know what they are doing, I am not sure we should cater for that,
they will just use their own function if their behaviour differs from
"standard".

At least all v7 implementations I've run into in the kernel (mainline
and platform trees) could have used the sequence above (well, security
notwithstanding).

Also, we should point out that after clearing the C bit ldr/str exclusive
must not be used anymore (even though this is implementation defined since it
depends on a global monitor in DRAM). The macro is also a barrier in
terms of coherency when we call it we should know what to expect,
basically a CPU with caches that are not coherent anymore.

> > it this way, by fear of seeing people copy the previous implementation, 
> > so the same sequence works on A9 as well as A15.
> 
> Would it make sense to have things like
> 
> #define a15_something() asm(volatile ... )
> #define a7_something() a15_something()
> #define a9_something() a15_something()
> 
> (where the correct one to call for a b.L system would probably be the
> one corresponding to the big cluster)
> 
> ... or just call is something like
> 
> cortex_a_something()
> 
> with a big comment (or alias macros, as above) documenting which CPUs we
> know it works for, and warning people to stop and think before using it
> on some other CPU.

It might be, even though a well written comment would do IMHO.

> > > I had other names in mind, like "coherency_exit" or "cache_exit".
> > > Those are not very intelligible, but that might at least make people
> > > pause and think before blindly using it.
> > 
> > Good point.  It should still embody the architecture name for which it 
> > is valid though.
> 
> Sure, I was assuming something would be pasted on the start of the name.

v7 :-) with a comment describing the assumptions (in particular related
as Dave mentioned to the SMP bit behaviour) ?

Lorenzo
