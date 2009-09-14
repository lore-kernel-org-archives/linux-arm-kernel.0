From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Sep 2009 15:29:36 +0100
Subject: LDREX/STREX and pre-emption on SMP hardware
In-Reply-To: <20090914142333.GF21580@n2100.arm.linux.org.uk>
References: <1250869355.10642.10.camel@pc1117.cambridge.arm.com>
	<20090821155011.GB8583@shareable.org>
	<1250870319.10642.23.camel@pc1117.cambridge.arm.com>
	<1250890146.29685.18.camel@david-laptop>
	<1251128692.28977.17.camel@pc1117.cambridge.arm.com>
	<1251134043.31975.23.camel@david-laptop>
	<1251135709.28977.40.camel@pc1117.cambridge.arm.com>
	<20090914014353.GA4762@shareable.org>
	<20090914100056.GC16644@n2100.arm.linux.org.uk>
	<1252922773.16853.62.camel@pc1117.cambridge.arm.com>
	<20090914142333.GF21580@n2100.arm.linux.org.uk>
Message-ID: <1252938577.16853.122.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-09-14 at 15:23 +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 14, 2009 at 11:06:13AM +0100, Catalin Marinas wrote:
> > On Mon, 2009-09-14 at 11:00 +0100, Russell King - ARM Linux wrote:
> > > On Mon, Sep 14, 2009 at 02:43:53AM +0100, Jamie Lokier wrote:
> > > > Catalin Marinas wrote:
> > > > > With interrupts (I1, I2 interrupt handlers)
> > > > > 
> > > > > I1			I2
> > > > > LDREX
> > > > > 			LDREX
> > > > > 			STREX (succeeds)
> > > > > STREX (fails)
> > > > > 
> > > > > In the interrupt case, they are nested so the STREX in I2 is always
> > > > > executed before STREX in I1 (you can extrapolate with several nested
> > > > > interrupts).
> > > > 
> > > > This assumes LDREX/STREX are always called in pairs.  But this is in
> > > > fact _not_ the case.  Take a look at atomic_cmpxchg:
> > > > 
> > > > 	do {
> > > > 		__asm__ __volatile__("@ atomic_cmpxchg\n"
> > > > 		"ldrex	%1, [%2]\n"
> > > > 		"mov	%0, #0\n"
> > > > 		"teq	%1, %3\n"
> > > > 		"strexeq %0, %4, [%2]\n"
> > > > 		    : "=&r" (res), "=&r" (oldval)
> > > > 		    : "r" (&ptr->counter), "Ir" (old), "r" (new)
> > > > 		    : "cc");
> > > > 	} while (res);
> > > > 
> > > > In the case where ptr->counter != old, STREX is not executed, and the
> > > > do{...}while loop does not loop.  Thus LDREX/STREX aren't paired.
> > > 
> > > It doesn't matter though - consider two threads using LDREX on the same
> > > location:
> > > 
> > > 	T1		T2
> > > 	LDREX
> > > 			LDREX
> > > 			STREXEQ (not satsified)
> > > 	STREX
> > 
> > As I replied to Jamie on a similar issue, you can have:
> > 
> > T1			T2
> > LDREX
> > 			LDREX
> > 			STREXEQ (satisfied, succeeds)
> > 			LDREX
> > 			STREXEQ (not satisfied)
> > STREX (succeeds)
> > 
> > Though this may be an unlikely sequence.
> 
> Actually, both of these can't happen because they imply a context switch
> and a context switch clears the exclusive monitor.  

T2 here in an interrupt handler (misleadingly called thread, though the
architecture people here in ARM just call everything a thread of
execution). Jamie's reply here was referring to interrupt handlers.

> So the real sequence
> is:
> 
> > > 	T1		T2
> > > 	LDREX
> 		CLREX
> > > 			LDREX
> > > 			STREXEQ (not satsified)
> 		CLREX
> > > 	STREX
> 
> which results in the STREX not succeeding.  Ditto for your case.

The other case where I replied was discussing the need for CLREX at
context switch and that's needed to get the correct behaviour (T1 and T2
are OS threads in this case).

-- 
Catalin
