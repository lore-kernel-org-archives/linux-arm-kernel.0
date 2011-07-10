From: will.deacon@arm.com (Will Deacon)
Date: Sun, 10 Jul 2011 14:21:12 +0100
Subject: [PATCH 01/17] ARM: proc: add definition of cpu_reset for ARMv6
	and ARMv7 cores
In-Reply-To: <20110710115206.GF4812@n2100.arm.linux.org.uk>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-2-git-send-email-lorenzo.pieralisi@arm.com>
	<20110709101445.GH4812@n2100.arm.linux.org.uk>
	<20110710110023.GA14312@e102144-lin.cambridge.arm.com>
	<20110710115206.GF4812@n2100.arm.linux.org.uk>
Message-ID: <20110710132112.GA15344@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 10, 2011 at 12:52:06PM +0100, Russell King - ARM Linux wrote:
> On Sun, Jul 10, 2011 at 12:00:24PM +0100, Will Deacon wrote:
> > I've had a look at a bunch of the cpu_*_reset definitions and I can't see
> > any reason why they wouldn't be callable with the flat mapping in place. In
> > fact, there's a scary comment for xscale:
> 
> However, that flat mapping doesn't save us, because this only covers
> space below PAGE_OFFSET virtual.  We're executing these generally from
> virtual space at addresses greater than this, which means when the MMU
> is turned off, the instruction stream disappears.

Yes, although I have fixed this in my kexec branch. It's still very much a
WIP, so feel free to comment when I post the next revision of that patch
series.

> > @ CAUTION: MMU turned off from this point. We count on the pipeline
> > @ already containing those two last instructions to survive.
> > 
> > which I think would disappear if the code was called via the ID map.
> 
> Yes, and everything pre-ARMv6 fundamentally relies upon the instructions
> following the MCR to turn the MMU off already being in the CPUs pipeline.
> Pre-ARMv6 relies upon this kind of behaviour from the CPU:
> 
> 	fetch	decode	execute
> 	mcr
> 	mov pc	mcr
> 	nop	mov pc	mcr
> 	nop	nop	mov pc
> 	<inst0> <--- flushed --->
> 
> where inst0 is the instruction at the target of the "mov pc" branch.
> May not be well documented in the architecture manual, but there have
> been documentation of this level against CPUs in the past.  Maybe
> back in ARMv3 times, but the trick has proven to work all the way up
> to ARMv5, and these are of course CPU specific files rather than
> architecture specific.

With more recent (>= ARMv6) CPUs, this really is implementation-specific
behaviour and, as such, is not documented by the architecture. Instead you
get:

`In addition, if the physical address of the code that enables or disables the
 MMU differs from its MVA, instruction prefetching can cause complications.
 Therefore, ARM strongly recommends that any code that enables or disables the
 MMU has identical virtual and physical addresses.'

This has the advantage of working across all CPU implementations, which is
what we need for having architectural proc-vN.S files.

> It's curious that with ARMs move to a more relaxed model, that turning
> the MMU off has visibly changed from a fairly weak operation to an
> effective strong instruction barrier.  These now have visibly this
> behaviour:
> 
> 	fetch	decode	execute
> 	mcr
> 	mov pc	mcr
> 	<inst0>	mov pc	mcr
> 	<------ flushed ------>
> 	mov pc*
> * - attempt to reload this instruction fails because MMU is now off.
> 
> I'm not saying there that the pipeline is flushed (it may be) - but this
> represents the _observed_ behaviour.

Sure. The new definitions for v6/v7 reset have an instruction barrier
following the SCTLR write anyway since the architecture doesn't make any
guarantees about immediacy of MMU disabling. The advantage is that it will
work for all v6/v7 implementations. The disadvantage is that we're
effectively coding for the worst-case scenario.

Will
