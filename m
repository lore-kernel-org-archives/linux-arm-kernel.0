From: imre.deak@nokia.com (Imre Deak)
Date: Thu, 18 Mar 2010 21:00:23 +0200
Subject: [PATCH 1/1] [RFC] arm: add half-word __xchg
In-Reply-To: <20100318172141.GB1902@Krystal>
References: <20100318123223.GA6855@Krystal>
	<1268919221-2748-1-git-send-email-virtuoso@slind.org>
	<20100318135008.GA11800@Krystal> <20100318163315.GJ30422@localhost>
	<20100318172141.GB1902@Krystal>
Message-ID: <20100318190023.GA30833@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 18, 2010 at 06:21:41PM +0100, ext Mathieu Desnoyers wrote:
> * Imre Deak (imre.deak at nokia.com) wrote:
> > On Thu, Mar 18, 2010 at 02:50:08PM +0100, ext Mathieu Desnoyers wrote:
> > > * Alexander Shishkin (virtuoso at slind.org) wrote:
> > > > On systems where ldrexh/strexh are not available, use a generic local
> > > > version or __bad_xchg() on SMP.
> > > > 
> > > > Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
> > > > CC: linux-arm-kernel-bounces at lists.infradead.org
> > > > CC: Imre Deak <imre.deak@nokia.com>
> > > > CC: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
> > > > ---
> > > >  arch/arm/include/asm/system.h |   65 ++++++++++++++++++++++++++++++++++------
> > > >  1 files changed, 55 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> > > > index d65b2f5..82248ae 100644
> > > > --- a/arch/arm/include/asm/system.h
> > > > +++ b/arch/arm/include/asm/system.h
> > > > @@ -218,6 +218,39 @@ do {									\
> > > >  	last = __switch_to(prev,task_thread_info(prev), task_thread_info(next));	\
> > > >  } while (0)
> > > >  
> > > > +static inline unsigned long __xchg_local_generic(unsigned long x,
> > > > +						 volatile void *ptr, int size)
> > > > +{
> > > > +	extern void __bad_xchg(volatile void *, int);
> > > > +	unsigned long ret;
> > > > +	unsigned long flags;
> > > > +
> > > > +	switch (size) {
> > > > +	case 1:
> > > > +		raw_local_irq_save(flags);
> > > > +		ret = *(volatile unsigned char *)ptr;
> > > > +		*(volatile unsigned char *)ptr = x;
> > > > +		raw_local_irq_restore(flags);
> > > > +		break;
> > > > +
> > > > +	case 2:
> > > > +		raw_local_irq_save(flags);
> > > > +		ret = *(volatile unsigned short *)ptr;
> > > > +		*(volatile unsigned short *)ptr = x;
> > > > +		raw_local_irq_restore(flags);
> > > > +		break;
> > > > +
> > > > +	case 4:
> > > > +		raw_local_irq_save(flags);
> > > > +		ret = *(volatile unsigned long *)ptr;
> > > > +		*(volatile unsigned long *)ptr = x;
> > > > +		raw_local_irq_restore(flags);
> > > > +		break;
> > > > +	}
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > >  #if defined(CONFIG_CPU_SA1100) || defined(CONFIG_CPU_SA110)
> > > >  /*
> > > >   * On the StrongARM, "swp" is terminally broken since it bypasses the
> > > > @@ -262,6 +295,26 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
> > > >  			: "r" (x), "r" (ptr)
> > > >  			: "memory", "cc");
> > > >  		break;
> > > > +#ifdef CONFIG_CPU_32v6K
> > > > +	case 2:
> > > > +		asm volatile("@	__xchg2\n"
> > > > +		"1:	ldrexh	%0, [%3]\n"
> > > > +		"	strexh	%1, %2, [%3]\n"
> > > > +		"	teq	%1, #0\n"
> > > > +		"	bne	1b"
> > > > +			: "=&r" (ret), "=&r" (tmp)
> > > > +			: "r" (x), "r" (ptr)
> > > > +			: "memory", "cc");
> > > > +		break;
> > > > +#else
> > > > +	case 2:
> > > > +#ifdef CONFIG_SMP
> > > > +		__bad_xchg(ptr, size), ret = 0;
> > > 
> > 
> > On a related note, why can't we have __bad_xchg as an undefined function
> > for detecting the error already in build time? That seems to be the
> > approach in similar places.
> 
> And, unless I am missing your point entirely, this is exactly what is
> done here.

__bad_xchg is defined in arch/arm/kernel/traps.c, so at the moment
we'll only get a runtime error.

--Imre
