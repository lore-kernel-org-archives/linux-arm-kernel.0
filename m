From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Apr 2014 21:07:25 +0100
Subject: [patch 0/6] dma: edma: Provide granular residue accounting
In-Reply-To: <20140417133737.892475126@linutronix.de>
References: <20140417133737.892475126@linutronix.de>
Message-ID: <20140417200725.GT24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 02:40:43PM -0000, Thomas Gleixner wrote:
> The next obstacle was the missing per SG element reporting. We really
> can't wait for a full SG list for notification.

Err, dmaengine doesn't have per-SG element reporting.

What it does allow is several transactions to be submitted consecutively,
so that the DMA engine can move to the next transaction once the previous
one has been submitted.

Where it's important that this happens with the minimum of delay, there's
nothing in the API that prevents the hardware scatterlist of the previous
transaction being linked directly to the following transaction, provided
of course the hardware can do that.

Many DMA engine implementations are just lazy - they implement stuff as:
setup hardware, run scatter list, get to the end, raise interrupt.  Fire
off tasklet.  Tasklet runs, calls the callback, checks to see if there's
another transaction, sets up hardware for the next one.  That (as you
would expect) gives quite a high latency to the following transaction.

I've coded at least one DMA engine driver to start the next transaction
immediately that the previous one completes, before the tasklet is run.
As I say above, there's really no reason to even wait for the interrupt...
if people can be bothered to think about all the implications that brings
(f.e. reporting completion status, and how many bytes remaining of a
transaction, etc.)

> So we'd trade the CAN interrupt per packet against the EDMA interrupt
> per packet. And the notification which is done via a tasklet is not
> really helpful either.

Again, the DMA engine API allows for the reception of the interrupt to
be turned off (not every DMA engine implementation supports it though.)
However, no interrupts means no callbacks (or an implementation may
decide that the presence of a callback means that you do want interrupts -
that's because a number of buggy drivers forget to give DMA_PREP_INTERRUPT.)

However, not using the callbacks then means you need to poll for
completion - that's where tracking the cookies for the submitted
transactions, calling dmaengine_tx_status() with a state argument, or
dma_async_is_tx_complete() then allows you to use dma_async_is_complete()
to quickly ascertain whether any of the other cookies have completed.

What you can't do though is decide whether you want an interrupt after
submission.

> The DCAN readout is 4 consecutive 32bit registers. The only way I got
> that working is by configuring the engine with:
> 
>        cfg.direction = DMA_DEV_TO_MEM;
>        cfg.src_addr_width = 16;

Hmm.  This is an enum, and the expected values are limited to 1, 2, 4,
and 8 for 8-bit, 16-bit, 32-bit and 64-bit respectively.  The width is
supposed to represent the width of the access used on the bus to the
peripheral.

So, if we did have a DMA engine which supported 128-bit accesses, it
would end up doing a 128-bit access for the above...

>        cfg.src_maxburst = 1;

This is supposed to indicate the maximum number of accesses in a burst
to the same register.  It kind of makes sense, but I'm not sure it's in
the spirit of the DMA engine API.  I think strictly, to have a DMA engine
perform 4 consecutive 32-bit accesses is quite a special requirement that
we don't have a way to represent it at present.

> With
>        cfg.src_addr_width = 4;
>        cfg.src_maxburst = 4;
> 
> it reads just 4 times the first register.

If it's just that the FIFO is spread over 4 consecutive locations
(effectively due to not decoding bits 2,3 of the address bus for the
register) then reading the first register four times is just as
acceptable as reading them consecutively.

The reason that kind of thing was done in old days was to allow the
ARM ldmia/stmia instructions to be used to access FIFOs, thereby
allowing multiple words to be transferred with a single instruction.
I can't believe that there's still people designing for that
especially if they have a DMA engine...

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
