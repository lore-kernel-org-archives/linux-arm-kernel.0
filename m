From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 17 Apr 2014 23:14:13 +0200 (CEST)
Subject: [patch 0/6] dma: edma: Provide granular residue accounting
In-Reply-To: <20140417203815.GV24070@n2100.arm.linux.org.uk>
References: <20140417133737.892475126@linutronix.de>
 <20140417200725.GT24070@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1404172214230.22697@ionos.tec.linutronix.de>
 <20140417203815.GV24070@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.02.1404172249320.22697@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Apr 2014, Russell King - ARM Linux wrote:

> On Thu, Apr 17, 2014 at 10:31:44PM +0200, Thomas Gleixner wrote:
> > On Thu, 17 Apr 2014, Russell King - ARM Linux wrote:
> > 
> > > On Thu, Apr 17, 2014 at 02:40:43PM -0000, Thomas Gleixner wrote:
> > > > The next obstacle was the missing per SG element reporting. We really
> > > > can't wait for a full SG list for notification.
> > > 
> > > Err, dmaengine doesn't have per-SG element reporting.
> > 
> > enum dma_residue_granularity {
> >         DMA_RESIDUE_GRANULARITY_DESCRIPTOR = 0,
> > 	DMA_RESIDUE_GRANULARITY_SEGMENT = 1,
> >         DMA_RESIDUE_GRANULARITY_BURST = 2,
> > };
> > 
> > tells a different story.
> 
> That's to do with the residue though, not to do with callbacks.

Right. That's what I tripped over. Sorry for mixing up the naming
conventions.

I don't care about per element reporting in terms of callbacks as
that's completely counterproductive if you deal with a network
device.

What I care about is the ability to figure out how many packets have
been transmitted into the DMA buffer.

In the particular case of DCAN the cyclic buffer is the most optimal
one, because if I use skb based SG then I cannot just drop the skb as
is into the network stack. I still need to get the information from
the skb and bring it into the required CAN skb frame format, write it
back and then submit a new SG element. So just reading the data from
the cyclic buffer, formatting it and storing the result into the skb
is way more efficient.
 
> > > If it's just that the FIFO is spread over 4 consecutive locations
> > > (effectively due to not decoding bits 2,3 of the address bus for the
> > > register) then reading the first register four times is just as
> > > acceptable as reading them consecutively.
> > 
> > It's not a FIFO. It's four different consecutive registers, which are
> > DMA readable. And you need to read all of them...
> >  
> > > The reason that kind of thing was done in old days was to allow the
> > > ARM ldmia/stmia instructions to be used to access FIFOs, thereby
> > > allowing multiple words to be transferred with a single instruction.
> > > I can't believe that there's still people designing for that
> > > especially if they have a DMA engine...
> > 
> > In that case it's a magic DMA extension superglued beside the already
> > horrible register interface of that particular IP block.
> 
> So it's more a copy-from-peripheral-to-memory - a DMA copy operation
> triggered in a similar manner to the DMA slave mode.  There are a
> number of use cases for this, but no one has yet put their head above
> the parapet to spear-head that cause. :)

The EDMA and most other DMA engines have HW support for this, we just
have no interface to make use of it. My burst=1/width=16 workaround is
just abusing the internal implementation details of EDMA.

That's why I was asking.

Would extending the dma_slave_config struct by the following fields
make sense?

 struct dma_slave_config {
        enum dma_transfer_direction direction;
        dma_addr_t src_addr;
        dma_addr_t dst_addr;
        enum dma_slave_buswidth src_addr_width;
        enum dma_slave_buswidth dst_addr_width;
	u32 src_maxburst;
        u32 dst_maxburst;
+       u32 src_stride;
+       u32 dst_stride;
        bool device_fc;
        unsigned int slave_id;
 };

The default for these fields would be 0, so no change for existing
implementations. If set to !0 the hardware driver can either bail out
if not supported (in HW or SW) or setup the transfer in the right way
to increment the src/dst field for the burst by stride.

Thoughts?

Thanks,

	tglx
