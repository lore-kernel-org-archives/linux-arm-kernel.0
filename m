From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Feb 2011 15:09:24 +0000
Subject: [PATCH v2 1/3] dmaengine: mxs-dma: add dma support for i.MX23/28
In-Reply-To: <201102171538.31061.arnd@arndb.de>
References: <1297650228-12762-1-git-send-email-shawn.guo@freescale.com>
	<1297650228-12762-2-git-send-email-shawn.guo@freescale.com>
	<201102171538.31061.arnd@arndb.de>
Message-ID: <20110217150924.GI24627@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 17, 2011 at 03:38:30PM +0100, Arnd Bergmann wrote:
> On Monday 14 February 2011, Shawn Guo wrote:
> > +static void mxs_dma_tasklet(unsigned long data)
> > +{
> > +	struct mxs_dma_chan *mxs_chan = (struct mxs_dma_chan *) data;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&mxs_chan->lock, flags);
> > +
> > +	if (mxs_chan->desc.callback)
> > +		mxs_chan->desc.callback(mxs_chan->desc.callback_param);
> > +
> > +	if (mxs_chan->status == DMA_SUCCESS)
> > +		mxs_chan->last_completed = mxs_chan->desc.cookie;
> > +
> > +	spin_unlock_irqrestore(&mxs_chan->lock, flags);
> > +}
> 
> Here is a different problem. The entire tasklet has interrupts
> disabled and holds the spinlock that the interrupt handler does
> not hold.
> 
> This actually makes the tasklet a stricter context than the
> actual interrupt handler, defeating the purpose of tasklets
> (i.e. that you can run code without disabling interrupts).
> 
> I don't know what the rules for dmaengine callbacks are regarding
> the context in which they are called, but it seems you should
> either get rid of the spin_lock_irqsave here or do everything
> from the interrupt handler.

dmaengine callbacks should be made from tasklet context with no locks
held.

The generally accepted way to do this is:

	dma_async_tx_callback callback;
	void *callback_param;

	spin_lock_irqsave(&mxs_chan->lock, flags);
	callback = mxs_chan->desc.callback;
	callback_param = mxs_chan->desc.callback_param;

	if (mxs_chan->status == DMA_SUCCESS)
		mxs_chan->last_completed = mxs_chan->desc.cookie;
	
	spin_unlock_irqrestore(&mxs_chan->lock, flags);

	if (callback)
		callback(callback_param);

which also avoids the locking issue when the callback starts the next
MMC request.
