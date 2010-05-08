From: mathieu.desnoyers@polymtl.ca (Mathieu Desnoyers)
Date: Sat, 8 May 2010 19:30:50 -0400
Subject: [PATCH 2/2] [RFCv3] arm: add half-word __xchg
In-Reply-To: <20100505080155.GF27062@shisha.kicks-ass.net>
References: <1272741800-30115-1-git-send-email-virtuoso@slind.org>
	<1272741897-30369-1-git-send-email-virtuoso@slind.org>
	<20100503172755.GA4248@Krystal>
	<20100505080155.GF27062@shisha.kicks-ass.net>
Message-ID: <20100508233050.GA32130@Krystal>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Alexander Shishkin (virtuoso at slind.org) wrote:
> On Mon, May 03, 2010 at 01:27:55 -0400, Mathieu Desnoyers wrote:
> > * Alexander Shishkin (virtuoso at slind.org) wrote:
> > > On systems where ldrexh/strexh are not available,
> > >   * for pre-v6 systems, use a generic local version,
> > >   * for v6 without v6K, emulate xchg2 using 32-bit cmpxchg()
> > >     (it is not yet clear if xchg1 has to be emulated on such
> > >     systems as well, thus the "size" parameter).
> > > 
> > > The __xchg_generic() function is based on the code that Jamie
> > > posted earlier.
> > > 
> > > Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
> > > CC: linux-arm-kernel-bounces at lists.infradead.org
> > > CC: Imre Deak <imre.deak@nokia.com>
> > > CC: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
> > > CC: Jamie Lokier <jamie@shareable.org>
> > > ---
> > >  arch/arm/include/asm/system.h |   56 +++++++++++++++++++++++++++++++++++++++++
> > >  1 files changed, 56 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> > > index d65b2f5..7a5983f 100644
> > > --- a/arch/arm/include/asm/system.h
> > > +++ b/arch/arm/include/asm/system.h
> > > @@ -218,6 +218,39 @@ do {									\
> > >  	last = __switch_to(prev,task_thread_info(prev), task_thread_info(next));	\
> > >  } while (0)
> > >  
> > > +#if __LINUX_ARM_ARCH__ >= 6
> > > +
> > > +#include <linux/align.h>
> > > +
> > > +static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
> > > +				      unsigned long new, int size);
> > > +
> > > +/*
> > > + * emulate __xchg() using 32-bit __cmpxchg()
> > > + */
> > > +static inline unsigned long __xchg_generic(unsigned long x,
> > > +						 volatile void *ptr, int size)
> > > +{
> > > +	unsigned long *ptrbig = object_align_floor((unsigned long *)ptr);
> > 
> > ptrbig could be renamed to something more relevant. Maybe ptralign ?
> 
> Well, yes, it's not any bigger than any other pointer here. :)
> 

:)

> > > +	int shift = ((unsigned)ptr - (unsigned)ptrbig) * 8;
> > 
> > "unsigned int" everywhere above would be cleaner. Also, it's worth
> > checking the generated assembly: does gcc perform the transformation:
> > 
> >   * 8   ->   << 3    automatically ?
> 
> Yes, it's such a basic optimisation that even tinycc will perform it without
> asking. I've checked anyway, thought. It is indeed a shift instruction for
> both << 3 and * 8.

OK

> 
> > > +	unsigned long mask, add, ret;
> > > +
> > > +	mask = ~(((1 << (size * 8)) - 1) << shift);
> > 
> > Maybe better to do:
> > 
> > +	mask = ~((((1UL << 3) << size) - 1) << shift);
> 
> I think it's slightly less readable for little gain.

I'm fine either way, as I expect the resulting code to be the same.

> 
> > But, other question: what assumptions are you doing about endianness
> > here ? I recall that ARM supports switchable endianness. Dunno about the
> > Linux-specific case though.
> 

[side-node: the variable "add" should be renamed to e.g. "new" in
__xchg_generic]

> Isn't the endiannes case dealt with by the object_align_floor() there?

Pointer alignment and endianness are two completely separate issues.

> The difference would be (for size==2 case, for example) whether shift is
> 0 or 16 (for say, LE and BE), the mask should always be placed correctly
> regardless.
> Please correct me if I'm missing something here.
> 

Well, the __xchg_generic code seems broken on big endian at least in
the size==2 case, because no shift is needed (but __xchg_generic is
doing one). The mask is just selecting the rest of the bits, so if the
shift is incorrect in the first place, I expect the mask to be similarly
broken.

Thanks,

Mathieu


> Regards,
> --
> Alex

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
