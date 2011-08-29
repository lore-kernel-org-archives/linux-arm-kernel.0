From: stern@rowland.harvard.edu (Alan Stern)
Date: Sun, 28 Aug 2011 21:51:10 -0400 (EDT)
Subject: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
In-Reply-To: <20110828233648.GA14560@n2100.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44L0.1108282137270.10614-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 29 Aug 2011, Russell King - ARM Linux wrote:

> On Sun, Aug 28, 2011 at 01:00:07PM -0400, Alan Stern wrote:
> > It won't do that.  All it will do is guarantee that the CPU writes out 
> > dumy->hw_token before it writes out or reads in any values executed 
> > after the mb.
> 
> You're right from the perspective of how things are defined today.  However,
> that isn't how things work on ARM.
> 
> With ARMv6 and ARMv7, we have weak memory ordering.  This includes so
> called "DMA coherent" memory.  This means that the architecture does not
> guarantee the order of writes to DMA coherent memory (which is non-
> cacheable normal memory) without an intervening 'data synchronization
> barrier' (dsb).  Even that may not be sufficient without also poking
> at the L2 cache controller.
> 
> We get around some of that by ensuring that our MMIO read/write macros
> contain the necessary barriers to ensure that DMA memory is up to date
> before the DMA agent is programmed.  However, this doesn't cater for
> agents which continue to run in the background.
> 
> These agents will need some kind of barrier to ensure that the write
> becomes visible - there's no way to get around that.  Maybe we need
> yet another new barrier macro...

Hmmm.  Although the semantics of the various mb() macros were
originally defined only for inter-CPU synchronization, I believe they
are also supposed to work for guaranteeing the order of accesses to
DMA-coherent memory.  If that's not the case with ARM, something is
seriously wrong.  (Maybe I'm wrong about this, but if I am then there's
currently _no_ way for the kernel to order DMA-coherent accesses on
ARM.)

You know better than I do what is needed to resolve the ordering issue.  
However, contrary to what the original patch description said, this
isn't entirely a matter of making the write visible to the host
controller: No doubt in time the write will eventually become visible
anyway.  It's a matter of making the write become visible reasonably
quickly and in the correct order with respect to other writes.

Is this extra L2-cache "poke" needed for proper ordering, or is it 
needed merely to flush the write out to memory in a timely manner?

Alan Stern
