From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Apr 2014 21:38:15 +0100
Subject: [patch 0/6] dma: edma: Provide granular residue accounting
In-Reply-To: <alpine.DEB.2.02.1404172214230.22697@ionos.tec.linutronix.de>
References: <20140417133737.892475126@linutronix.de>
 <20140417200725.GT24070@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1404172214230.22697@ionos.tec.linutronix.de>
Message-ID: <20140417203815.GV24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 10:31:44PM +0200, Thomas Gleixner wrote:
> On Thu, 17 Apr 2014, Russell King - ARM Linux wrote:
> 
> > On Thu, Apr 17, 2014 at 02:40:43PM -0000, Thomas Gleixner wrote:
> > > The next obstacle was the missing per SG element reporting. We really
> > > can't wait for a full SG list for notification.
> > 
> > Err, dmaengine doesn't have per-SG element reporting.
> 
> enum dma_residue_granularity {
>         DMA_RESIDUE_GRANULARITY_DESCRIPTOR = 0,
> 	DMA_RESIDUE_GRANULARITY_SEGMENT = 1,
>         DMA_RESIDUE_GRANULARITY_BURST = 2,
> };
> 
> tells a different story.

That's to do with the residue though, not to do with callbacks.

> > If it's just that the FIFO is spread over 4 consecutive locations
> > (effectively due to not decoding bits 2,3 of the address bus for the
> > register) then reading the first register four times is just as
> > acceptable as reading them consecutively.
> 
> It's not a FIFO. It's four different consecutive registers, which are
> DMA readable. And you need to read all of them...
>  
> > The reason that kind of thing was done in old days was to allow the
> > ARM ldmia/stmia instructions to be used to access FIFOs, thereby
> > allowing multiple words to be transferred with a single instruction.
> > I can't believe that there's still people designing for that
> > especially if they have a DMA engine...
> 
> In that case it's a magic DMA extension superglued beside the already
> horrible register interface of that particular IP block.

So it's more a copy-from-peripheral-to-memory - a DMA copy operation
triggered in a similar manner to the DMA slave mode.  There are a
number of use cases for this, but no one has yet put their head above
the parapet to spear-head that cause. :)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
