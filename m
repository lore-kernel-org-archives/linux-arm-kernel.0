From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 10 Jul 2011 12:52:06 +0100
Subject: [PATCH 01/17] ARM: proc: add definition of cpu_reset for ARMv6
	and ARMv7 cores
In-Reply-To: <20110710110023.GA14312@e102144-lin.cambridge.arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-2-git-send-email-lorenzo.pieralisi@arm.com>
	<20110709101445.GH4812@n2100.arm.linux.org.uk>
	<20110710110023.GA14312@e102144-lin.cambridge.arm.com>
Message-ID: <20110710115206.GF4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 10, 2011 at 12:00:24PM +0100, Will Deacon wrote:
> I've had a look at a bunch of the cpu_*_reset definitions and I can't see
> any reason why they wouldn't be callable with the flat mapping in place. In
> fact, there's a scary comment for xscale:

However, that flat mapping doesn't save us, because this only covers
space below PAGE_OFFSET virtual.  We're executing these generally from
virtual space at addresses greater than this, which means when the MMU
is turned off, the instruction stream disappears.

> @ CAUTION: MMU turned off from this point. We count on the pipeline
> @ already containing those two last instructions to survive.
> 
> which I think would disappear if the code was called via the ID map.

Yes, and everything pre-ARMv6 fundamentally relies upon the instructions
following the MCR to turn the MMU off already being in the CPUs pipeline.
Pre-ARMv6 relies upon this kind of behaviour from the CPU:

	fetch	decode	execute
	mcr
	mov pc	mcr
	nop	mov pc	mcr
	nop	nop	mov pc
	<inst0> <--- flushed --->

where inst0 is the instruction at the target of the "mov pc" branch.
May not be well documented in the architecture manual, but there have
been documentation of this level against CPUs in the past.  Maybe
back in ARMv3 times, but the trick has proven to work all the way up
to ARMv5, and these are of course CPU specific files rather than
architecture specific.

It's curious that with ARMs move to a more relaxed model, that turning
the MMU off has visibly changed from a fairly weak operation to an
effective strong instruction barrier.  These now have visibly this
behaviour:

	fetch	decode	execute
	mcr
	mov pc	mcr
	<inst0>	mov pc	mcr
	<------ flushed ------>
	mov pc*
* - attempt to reload this instruction fails because MMU is now off.

I'm not saying there that the pipeline is flushed (it may be) - but this
represents the _observed_ behaviour.
