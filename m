From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Jan 2016 12:20:55 +0100
Subject: Speeding up dma_unmap
In-Reply-To: <20160128103105.GR14823@e104818-lin.cambridge.arm.com>
References: <CAJFSRaCRvx=+_fEYAr8OeWGHnnz+rOWjLzLcm+wZiEstbHwxAw@mail.gmail.com>
 <20160127180944.GZ10826@n2100.arm.linux.org.uk>
 <20160128103105.GR14823@e104818-lin.cambridge.arm.com>
Message-ID: <24650183.WoXLVmr0Vj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 January 2016 10:31:06 Catalin Marinas wrote:
> On Wed, Jan 27, 2016 at 06:09:45PM +0000, Russell King - ARM Linux wrote:
> > On Wed, Jan 27, 2016 at 04:06:30PM +0000, Catalin Marinas wrote:
> > > On Wed, Jan 27, 2016 at 01:23:27PM +0100, Arnd Bergmann wrote:
> > > > up reading cache lines back in randomly on a speculative prefetch,
> > > > but as far as I can tell, the Cortex-A8 (or A5/A7) won't do that.
> > > 
> > > Are you sure about A5 and A7? I'm not even sure about the A8 but there
> > > are good chances that A7 and A5 do speculative prefetches.
> > 
> > I thought when I was re-implementing the DMA API on ARM (which was
> > around early v7 times) that there were CPUs that did speculative
> > prefetching, which included the A8.  I seem to remember it was pretty
> > urgent to have the DMA API fixed for _any_ ARMv7 CPU because of the
> > speculative prefetching.
> 
> Indeed, it's a safe assumption to say that any ARMv7 CPU perform
> speculative accesses. Even if some of them may only do I-cache
> prefetching (just guessing), in the presence of a unified L2 this
> distinction no longer matters.

Ok, I was thrown off by the code comment then, and by my incorrect
assumption that only the out-of-order cores were doing any speculative
execution (prefetch or not). According to the Cortex-A5 TRM, "The
Cortex-A5 MPCore data cache implements an automatic prefetcher that
monitors cache misses done by the processor. When a pattern is detected,
the automatic prefetcher starts linefills in the background."

I have looked at the documentation for a couple of cores and found that:

* Cortex-A9 always does speculative prefetching
* Cortex-A8 does not have this mentioned in the manual, which would
  be a hint that it indeed does not do it at all, but that could be
  wrong. It does explicitly mention prefetching into icache, and
  mentions prefetching using the PLD instruction and the L2 PLE.
* A5/A7/A15/A17 all do prefetching unless disabled in the ACTLR
  register. CPUs that have L2 caches can control this separately
  for L1 and L2 as needed.

This means that there are still some cores on which one could try
if disabling the prefetching and the flushes in DMA unmap provides
any serious performance boost.

	Arnd
