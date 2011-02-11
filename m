From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Feb 2011 10:10:56 +0000
Subject: [PATCH] mmci: make sure DMA transfers wait for FIFO drain
In-Reply-To: <AANLkTi=jP1G=foehWYNai5H=_F372FwpkLEO4wSkmqBc@mail.gmail.com>
References: <1296509980-29987-1-git-send-email-linus.walleij@linaro.org>
	<20110201110348.GB31216@n2100.arm.linux.org.uk>
	<AANLkTi=jP1G=foehWYNai5H=_F372FwpkLEO4wSkmqBc@mail.gmail.com>
Message-ID: <20110211101056.GB23404@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 11, 2011 at 10:46:46AM +0100, Linus Walleij wrote:
> After discussing this with Ulf I think something like this is
> still needed...
> 
> 2011/2/1 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > With the code I have in place, you'll notice I have:
> >
> > ? ? ? ?/* Wait up to 1ms for the DMA to complete */
> > ? ? ? ?for (i = 0; ; i++) {
> > ? ? ? ? ? ? ? ?status = readl(host->base + MMCISTATUS);
> > ? ? ? ? ? ? ? ?if (!(status & MCI_RXDATAAVLBLMASK) || i >= 100)
> > ? ? ? ? ? ? ? ? ? ? ? ?break;
> > ? ? ? ? ? ? ? ?udelay(10);
> > ? ? ? ?}
> >
> > This waits for the DMA controller to read the last data out of the FIFO
> > before allowing the request to complete. ?As it has a timeout, it is
> > able to detect ARMs broken DMA setup on their MMCI/DMAC, and disable DMA
> > support for this primecell rather than getting stuck.
> >
> > This may be sufficient without using the DMA callbacks.
> 
> According to our tests this does not really cut it on
> Ux500. Sometimes we get the DMA completion before the
> MCI_DATAEND IRQ, and sometimes after.
> 
> When  we get the callback *after* the MCI_DATAEND irq
> this does not work properly, since we still don't know if the DMA
> job is complete, so the DMA engine is not in sync and we mess up
> the channels by issuing a new job, hammering the DMA engine
> while it's still busy on the channel.

That may be a problem if the channel is still busy, but it in any case
it shouldn't result in the DMA engine being hammered.  The DMA
engine API is a queue based API - you submit requests to it and it
deals with them one after each other.  If you submit two requests in
succession, it should process the first request, complete that, before
it starts to process the second request.  I'd suggest fixing this in
any case.

Maybe a solution to this is to use the DMA callback to signal that the
data path has completed, but still have the data end interrupt in place
so that it can trigger the stop command.  That shouldn't result in
additional delays or even the requirement for a timeout.
