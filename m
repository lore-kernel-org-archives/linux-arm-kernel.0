From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Aug 2011 09:52:09 +0100
Subject: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
In-Reply-To: <Pine.LNX.4.44L0.1108282137270.10614-100000@netrider.rowland.org>
References: <20110828233648.GA14560@n2100.arm.linux.org.uk>
	<Pine.LNX.4.44L0.1108282137270.10614-100000@netrider.rowland.org>
Message-ID: <20110829085209.GB26917@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 28, 2011 at 09:51:10PM -0400, Alan Stern wrote:
> Hmmm.  Although the semantics of the various mb() macros were
> originally defined only for inter-CPU synchronization, I believe they
> are also supposed to work for guaranteeing the order of accesses to
> DMA-coherent memory.  If that's not the case with ARM, something is
> seriously wrong.  (Maybe I'm wrong about this, but if I am then there's
> currently _no_ way for the kernel to order DMA-coherent accesses on
> ARM.)

That is the case with ARM - mb() and wmb() does everything that's
required.  rmb() is weaker than the other two.

> You know better than I do what is needed to resolve the ordering issue.  
> However, contrary to what the original patch description said, this
> isn't entirely a matter of making the write visible to the host
> controller: No doubt in time the write will eventually become visible
> anyway.  It's a matter of making the write become visible reasonably
> quickly and in the correct order with respect to other writes.

I'm not entirely sure what the problem is - I think its about a write
by the CPU to dma coherent memory being delayed and not being visible
to the HC in a timely manner.  Either mb() or wmb() placed after the
write on ARM will do that - and ARM has no requirement to do a read-
back after the barrier.

> Is this extra L2-cache "poke" needed for proper ordering, or is it 
> needed merely to flush the write out to memory in a timely manner?

Both, though primerily it's about ensuring correct ordering.  A side
effect of it is that it will flush all pending writes in L2 before
completing.
