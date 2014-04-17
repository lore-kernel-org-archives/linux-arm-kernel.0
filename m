From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 17 Apr 2014 22:31:44 +0200 (CEST)
Subject: [patch 0/6] dma: edma: Provide granular residue accounting
In-Reply-To: <20140417200725.GT24070@n2100.arm.linux.org.uk>
References: <20140417133737.892475126@linutronix.de>
 <20140417200725.GT24070@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.02.1404172214230.22697@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Apr 2014, Russell King - ARM Linux wrote:

> On Thu, Apr 17, 2014 at 02:40:43PM -0000, Thomas Gleixner wrote:
> > The next obstacle was the missing per SG element reporting. We really
> > can't wait for a full SG list for notification.
> 
> Err, dmaengine doesn't have per-SG element reporting.

enum dma_residue_granularity {
        DMA_RESIDUE_GRANULARITY_DESCRIPTOR = 0,
	DMA_RESIDUE_GRANULARITY_SEGMENT = 1,
        DMA_RESIDUE_GRANULARITY_BURST = 2,
};

tells a different story.
 
> What it does allow is several transactions to be submitted consecutively,
> so that the DMA engine can move to the next transaction once the previous
> one has been submitted.
> 
> Where it's important that this happens with the minimum of delay, there's
> nothing in the API that prevents the hardware scatterlist of the previous
> transaction being linked directly to the following transaction, provided
> of course the hardware can do that.

Right. I hoped that this would be the case, as you would expect from
DMA, but as you observed correctly:
 
> Many DMA engine implementations are just lazy - they implement stuff as:
> setup hardware, run scatter list, get to the end, raise interrupt.  Fire
> off tasklet.  Tasklet runs, calls the callback, checks to see if there's
> another transaction, sets up hardware for the next one.  That (as you
> would expect) gives quite a high latency to the following transaction.

Yep. It's just unusable for low latency applications.
 
> I've coded at least one DMA engine driver to start the next transaction
> immediately that the previous one completes, before the tasklet is run.
> As I say above, there's really no reason to even wait for the interrupt...
> if people can be bothered to think about all the implications that brings
> (f.e. reporting completion status, and how many bytes remaining of a
> transaction, etc.)

The EDMA HW would allow that as well, but the driver is definitely not
up to it and to be honest I didnt have the cycles to rewrite it from
scratch as that would be the only way to make that work.
 
> If it's just that the FIFO is spread over 4 consecutive locations
> (effectively due to not decoding bits 2,3 of the address bus for the
> register) then reading the first register four times is just as
> acceptable as reading them consecutively.

It's not a FIFO. It's four different consecutive registers, which are
DMA readable. And you need to read all of them...
 
> The reason that kind of thing was done in old days was to allow the
> ARM ldmia/stmia instructions to be used to access FIFOs, thereby
> allowing multiple words to be transferred with a single instruction.
> I can't believe that there's still people designing for that
> especially if they have a DMA engine...

In that case it's a magic DMA extension superglued beside the already
horrible register interface of that particular IP block.

Thanks,

	tglx
