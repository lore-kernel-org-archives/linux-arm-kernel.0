From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Sep 2009 11:00:56 +0100
Subject: LDREX/STREX and pre-emption on SMP hardware
In-Reply-To: <20090914014353.GA4762@shareable.org>
References: <4A8EB836.3000406@plxtech.com>
	<1250869355.10642.10.camel@pc1117.cambridge.arm.com>
	<20090821155011.GB8583@shareable.org>
	<1250870319.10642.23.camel@pc1117.cambridge.arm.com>
	<1250890146.29685.18.camel@david-laptop>
	<1251128692.28977.17.camel@pc1117.cambridge.arm.com>
	<1251134043.31975.23.camel@david-laptop>
	<1251135709.28977.40.camel@pc1117.cambridge.arm.com>
	<20090914014353.GA4762@shareable.org>
Message-ID: <20090914100056.GC16644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 14, 2009 at 02:43:53AM +0100, Jamie Lokier wrote:
> Catalin Marinas wrote:
> > With interrupts (I1, I2 interrupt handlers)
> > 
> > I1			I2
> > LDREX
> > 			LDREX
> > 			STREX (succeeds)
> > STREX (fails)
> > 
> > In the interrupt case, they are nested so the STREX in I2 is always
> > executed before STREX in I1 (you can extrapolate with several nested
> > interrupts).
> 
> This assumes LDREX/STREX are always called in pairs.  But this is in
> fact _not_ the case.  Take a look at atomic_cmpxchg:
> 
> 	do {
> 		__asm__ __volatile__("@ atomic_cmpxchg\n"
> 		"ldrex	%1, [%2]\n"
> 		"mov	%0, #0\n"
> 		"teq	%1, %3\n"
> 		"strexeq %0, %4, [%2]\n"
> 		    : "=&r" (res), "=&r" (oldval)
> 		    : "r" (&ptr->counter), "Ir" (old), "r" (new)
> 		    : "cc");
> 	} while (res);
> 
> In the case where ptr->counter != old, STREX is not executed, and the
> do{...}while loop does not loop.  Thus LDREX/STREX aren't paired.

It doesn't matter though - consider two threads using LDREX on the same
location:

	T1		T2
	LDREX
			LDREX
			STREXEQ (not satsified)
	STREX


T1's STREX ultimately succeeds.  The value stored there hasn't changed
since it did the LDREX, so it's perfectly fine for the STREX to occur.
This is really no different from this case:

	T1		T2
	LDREX
			LDREX
	STREX (succeeds)
			STREX (fails)


What is not fine is for there to be STREX instructions without a
preceding LDREX unless it can be guaranteed that the location being
stored to doesn't matter whether the store succeeds or not.
