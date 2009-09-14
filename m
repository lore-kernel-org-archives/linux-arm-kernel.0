From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 14 Sep 2009 02:43:53 +0100
Subject: LDREX/STREX and pre-emption on SMP hardware
In-Reply-To: <1251135709.28977.40.camel@pc1117.cambridge.arm.com>
References: <4A8EB836.3000406@plxtech.com>
	<1250869355.10642.10.camel@pc1117.cambridge.arm.com>
	<20090821155011.GB8583@shareable.org>
	<1250870319.10642.23.camel@pc1117.cambridge.arm.com>
	<1250890146.29685.18.camel@david-laptop>
	<1251128692.28977.17.camel@pc1117.cambridge.arm.com>
	<1251134043.31975.23.camel@david-laptop>
	<1251135709.28977.40.camel@pc1117.cambridge.arm.com>
Message-ID: <20090914014353.GA4762@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> With interrupts (I1, I2 interrupt handlers)
> 
> I1			I2
> LDREX
> 			LDREX
> 			STREX (succeeds)
> STREX (fails)
> 
> In the interrupt case, they are nested so the STREX in I2 is always
> executed before STREX in I1 (you can extrapolate with several nested
> interrupts).

This assumes LDREX/STREX are always called in pairs.  But this is in
fact _not_ the case.  Take a look at atomic_cmpxchg:

	do {
		__asm__ __volatile__("@ atomic_cmpxchg\n"
		"ldrex	%1, [%2]\n"
		"mov	%0, #0\n"
		"teq	%1, %3\n"
		"strexeq %0, %4, [%2]\n"
		    : "=&r" (res), "=&r" (oldval)
		    : "r" (&ptr->counter), "Ir" (old), "r" (new)
		    : "cc");
	} while (res);

In the case where ptr->counter != old, STREX is not executed, and the
do{...}while loop does not loop.  Thus LDREX/STREX aren't paired.

It may be that atomic_cmpxchg() is always called in a loop, but if so
I don't think that's a documented requirement for all callers.

A simple solution is to either call CLREXNE after STREXEQ, or change
STREXEQ to STREX and change the logic so that if ptr->counter != old,
the value it tries to store is what it read.  The latter uses fewer
instructions - and even eliminates the do...while, making it really
compact, but may cause more cache line dirtying.

If you think I'm right and tell me what you prefer I'll prepare a
patch.

-- Jamie
