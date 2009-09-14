From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Sep 2009 09:53:24 +0100
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
Message-ID: <1252918404.16853.23.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-09-14 at 02:43 +0100, Jamie Lokier wrote:
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

I think you are correct here, though we may not have code to trigger
this (but it needs to be fixed anyway).

> A simple solution is to either call CLREXNE after STREXEQ, or change
> STREXEQ to STREX and change the logic so that if ptr->counter != old,
> the value it tries to store is what it read.  The latter uses fewer
> instructions - and even eliminates the do...while, making it really
> compact, but may cause more cache line dirtying.

The do...while loop is still needed for the case where STREX fails
because of a STREX on a different thread of execution (same CPU or a
different one).

I would prefer the CLREXNE because of cache line dirtying (which is even
more expensive on SMP). But on ARM1136 you may not have the CLREX
instruction, so either dummy STREX would be useful. Maybe you could make
it conditional on CONFIG_CPU_32v6K.

Alternatively, a return from exception could clear the exclusive monitor
- this would also allow us to use STR for atomic_set() (if it has any
benefits). It also solves a similar issue with user-space atomic
operations in signal handlers (I had some past discussion with Hans
Boehm on the atomic and memory model in C++0x and they intend to use STR
for atomic set).

I'm more in favour of the latter option as there isn't really any
significant performance impact but I remember Russell objected to it in
the past. If that's still the case, I would prefer the conditional
compilation with STREX and CLREXNE.

Russell, any opinion here?

-- 
Catalin
