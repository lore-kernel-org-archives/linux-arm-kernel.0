From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Feb 2011 10:46:46 +0100
Subject: [PATCH] mmci: make sure DMA transfers wait for FIFO drain
In-Reply-To: <20110201110348.GB31216@n2100.arm.linux.org.uk>
References: <1296509980-29987-1-git-send-email-linus.walleij@linaro.org>
	<20110201110348.GB31216@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=jP1G=foehWYNai5H=_F372FwpkLEO4wSkmqBc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After discussing this with Ulf I think something like this is
still needed...

2011/2/1 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Mon, Jan 31, 2011 at 10:39:40PM +0100, Linus Walleij wrote:
>> The DMA mode also needs to wait until the FIFO is drained before
>> enabling the MCI_DATAEND IRQ.
>
> Hmm. ?This will cause attempted DMA usage on ARM MMCI primecells to get
> stuck as we'll wait for the never-delivered callback.

I don' know if we have semantics for the DMA completion callback,
either:

A) it's to be called whenever the transaction is complete without
 errors - in this case the driver using it must supply some timeout
 mechanism to avoid hanging on DMA or:

B) It's supposed to be called whenever the DMA stops working
 no matter whether this was due to errors or not.

Since the callback isn't supplying any status indication I
assume it's case (A). But if we're allowed to call
.device_tx_status() on the channel in callback context, we can
get the status here and determine whether the transaction was
OK or not, and then it's case (B).

So I should either reconsider this patch to either do:

(A) a timeout that terminates the DMA if too much time passes
   (which will in turn have to be caclulated from the xfer size and
   MCLK frequency) or

(B) a call to device_tx_status() and check whether there was an
  error and set data->error accordingly in the error case.
  (This may in turn require changed to amba-pl08x to e.g. timeout
  and report such errors properly.) or

(C) (Dan) will dma_sync_wait(chan, cookie) on the descriptor
  in the MCI_DATAEND IRQ path suffice? If that happens we
  may have a bug in the DMA engine(s) in that it doesn't
  timeout or error out if a DMA job locks up.
  I don't particularly like dma_sync_wait() since it is hardwired
  to wait 5 seconds, which seems arbitrarily chosen. If that is
  the approach, a new sync wait function taking timeout as
  argument will likely be needed.

My current assumption is something like (A)...

> With the code I have in place, you'll notice I have:
>
> ? ? ? ?/* Wait up to 1ms for the DMA to complete */
> ? ? ? ?for (i = 0; ; i++) {
> ? ? ? ? ? ? ? ?status = readl(host->base + MMCISTATUS);
> ? ? ? ? ? ? ? ?if (!(status & MCI_RXDATAAVLBLMASK) || i >= 100)
> ? ? ? ? ? ? ? ? ? ? ? ?break;
> ? ? ? ? ? ? ? ?udelay(10);
> ? ? ? ?}
>
> This waits for the DMA controller to read the last data out of the FIFO
> before allowing the request to complete. ?As it has a timeout, it is
> able to detect ARMs broken DMA setup on their MMCI/DMAC, and disable DMA
> support for this primecell rather than getting stuck.
>
> This may be sufficient without using the DMA callbacks.

According to our tests this does not really cut it on
Ux500. Sometimes we get the DMA completion before the
MCI_DATAEND IRQ, and sometimes after.

When  we get the callback *after* the MCI_DATAEND irq
this does not work properly, since we still don't know if the DMA
job is complete, so the DMA engine is not in sync and we mess up
the channels by issuing a new job, hammering the DMA engine
while it's still busy on the channel.

We either have to sync in the DMA engine or timeout
on the DMA job as far as I can tell. One of A thru C.

Yours,
Linus Walleij
