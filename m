From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Dec 2010 22:25:32 +0000
Subject: [PATCH 06/13] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <20101221182037.GA4783@n2100.arm.linux.org.uk>
References: <1276270031-1607-1-git-send-email-linus.walleij@stericsson.com>
	<20101221182037.GA4783@n2100.arm.linux.org.uk>
Message-ID: <20101221222532.GA7507@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 21, 2010 at 06:20:37PM +0000, Russell King - ARM Linux wrote:
> Having just looked at this while trying to undo the DMA API abuses
> in the PL011 UART driver, I'm getting rather frustrated with this
> code.

Here's another couple of problems:

PL011 driver:

+	dmatx->cookie = desc->tx_submit(desc);
+	if (dma_submit_error(dmatx->cookie)) {
+		/* "Complete" DMA (errorpath) */
+		complete(&dmatx->complete);
+		chan->device->device_control(chan, DMA_TERMINATE_ALL, 0);
+		return dmatx->cookie;
+	}

dmatx->cookie is of type dma_cookie_t, which is a s32.

MMCI driver:

+	dma_cookie_t cookie;
...
+	cookie = desc->tx_submit(desc);
+
+	/* Here overloaded DMA controllers may fail */
+	if (dma_submit_error(cookie))
+		goto unmap_exit;

#define dma_submit_error(cookie) ((cookie) < 0 ? 1 : 0)

So, DMA errors are negative values returned from the tx_submit function.

PL08x tx_submit method:

static dma_cookie_t pl08x_tx_submit(struct dma_async_tx_descriptor *tx)
{
        struct pl08x_dma_chan *plchan = to_pl08x_chan(tx->chan);

        atomic_inc(&plchan->last_issued);
        tx->cookie = atomic_read(&plchan->last_issued);
        /* This unlock follows the lock in the prep() function */
        spin_unlock_irqrestore(&plchan->lock, plchan->lockflags);

        return tx->cookie;
}

So, after 2^31 DMA transactions, the DMA engine layer continues happily
along with the queued DMA operation, but the driver gets a negative
cookie returned, and so bails out.

I'm also left wondering about that atomic_t.  It's incremented and
read in a locked region, which will in itself prevent two concurrent
increments.  The only other places its used is from dma_tx_status()
where it is only ever read, and on the initialization path.  That to
me makes no sense.

I'll see if I can get to looking at the PL08x stuff once I've finished
sorting out the PL011 UART driver DMA support into a state where I'm
happy that it's doing things correctly.
