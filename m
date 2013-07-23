From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 23 Jul 2013 08:28:16 -0400 (EDT)
Subject: [PATCH 1/4] ARM: vexpress/dcscb: fix cache disabling sequences
In-Reply-To: <20130723104352.GA3023@localhost.localdomain>
References: <1374118116-16836-1-git-send-email-nicolas.pitre@linaro.org>
 <1374118116-16836-2-git-send-email-nicolas.pitre@linaro.org>
 <20130718150408.GB2655@localhost.localdomain>
 <alpine.LFD.2.03.1307181231510.14924@syhkavp.arg>
 <20130718180323.GC2655@localhost.localdomain>
 <alpine.LFD.2.03.1307181452480.14924@syhkavp.arg>
 <20130719102844.GA3746@localhost.localdomain>
 <20130719105907.GB27389@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.03.1307221353360.15022@syhkavp.arg>
 <20130723104352.GA3023@localhost.localdomain>
Message-ID: <alpine.LFD.2.03.1307230821270.15022@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Jul 2013, Dave Martin wrote:

> On Mon, Jul 22, 2013 at 01:58:12PM -0400, Nicolas Pitre wrote:
> > On Fri, 19 Jul 2013, Lorenzo Pieralisi wrote:
> > 
> > > On Fri, Jul 19, 2013 at 11:28:49AM +0100, Dave Martin wrote:
> > > > On Thu, Jul 18, 2013 at 02:59:06PM -0400, Nicolas Pitre wrote:
> > > > > On Thu, 18 Jul 2013, Dave Martin wrote:
> > > > > 
> > > > > > I had other names in mind, like "coherency_exit" or "cache_exit".
> > > > > > Those are not very intelligible, but that might at least make people
> > > > > > pause and think before blindly using it.
> > > > > 
> > > > > Good point.  It should still embody the architecture name for which it 
> > > > > is valid though.
> > > > 
> > > > Sure, I was assuming something would be pasted on the start of the name.
> > > 
> > > v7 :-) with a comment describing the assumptions (in particular related
> > > as Dave mentioned to the SMP bit behaviour) ?
> > 
> > OK... What about this then:
> > 
> > ----- >8
> > From: Nicolas Pitre <nicolas.pitre@linaro.org>
> > Date: Thu, 18 Jul 2013 13:12:48 -0400
> > Subject: [PATCH] ARM: cacheflush: consolidate single-CPU ARMv7 cache disabling
> >  code
> > 
> > This code is becoming duplicated in many places.  So let's consolidate
> > it into a handy macro that is known to be right and available for reuse.
> > 
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > 
> > diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
> > index 17d0ae8672..8f4e2297e2 100644
> > --- a/arch/arm/include/asm/cacheflush.h
> > +++ b/arch/arm/include/asm/cacheflush.h
> > @@ -436,4 +436,44 @@ static inline void __sync_cache_range_r(volatile void *p, size_t size)
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
> > + * - No ldr/str exclusive must be used.
> 
> Maybe write ldrex/strex (I misread that the first time around as "no
> ldr/str ... must be used", which seemed a bit drastic)

OK.

> > + * - The CPU is obviously no longer coherent with the other CPUs.
> > + *
> > + * Further considerations:
> > + *
> > + * - This relies on the presence and behavior of the AUXCR.SMP bit as
> > + *   documented in the ARMv7 TRM.  Vendor implementations that deviate from
> 
> Sorry to be pedantic here, but there is no "ARMv7 TRM".  The SMP bit is
> not part of ARMv7 at all.

Well, I just copied Lorenzo's words here, trusting he knew more about it 
than I do.

> Also, it seems that A9 isn't precisely the
> same: two ACTLR bits need to be twiddled.  R-class CPUs are generally
> not the same either.
> 
> This is why I preferred to treat the whole sequence as specific to a
> particular CPU implementation.  The similarity between A7 and A15
> might be viewed as a happy coincidence (it also makes life easier in
> big.LITTLE land).

Fair enough.

> (Also, you mix the names "ACTLR" and "AUXCR", but people will generally
> be able to guess those are the same thing)

We apparently use both in the kernel already.  Which one is the 
canonical one?

> > + *   that will need their own procedure.
> > + * - This is unlikely to work if Linux is running non-secure.
> > + */
> > +#define v7_exit_coherency_flush(level) \
> 
> ... hence:
> 
> #define cortex_a15_exit_coherency(level) ...
> 
> #define cortex_a7_exit_coherency(level) cortex_a15_exit_coherency(level)
> 
> What do you think?

To be pedantic again, we don't really exit coherency at some cache 
level.  Hence my usage of "flush" indicating that the level argument 
applies only to that and not to the coherency status.


Nicolas
