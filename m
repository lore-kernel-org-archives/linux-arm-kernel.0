From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 25 Jul 2011 11:57:54 +0100
Subject: [PATCH V4 04/14] DMA: PL330: Add DMA_CYCLIC capability
In-Reply-To: <1311590884.29703.2.camel@vkoul-mobl4>
References: <1311557312-26107-1-git-send-email-boojin.kim@samsung.com>
	<1311557312-26107-5-git-send-email-boojin.kim@samsung.com>
	<20110725092749.GB9653@n2100.arm.linux.org.uk>
	<002001cc4ab6$0d7cd590$287680b0$%kim@samsung.com>
	<20110725103629.GF9653@n2100.arm.linux.org.uk>
	<1311590884.29703.2.camel@vkoul-mobl4>
Message-ID: <20110725105754.GG9653@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 04:18:04PM +0530, Vinod Koul wrote:
> On Mon, 2011-07-25 at 11:36 +0100, Russell King - ARM Linux wrote:
> > On Mon, Jul 25, 2011 at 07:31:45PM +0900, Boojin Kim wrote:
> > > > On Mon, Jul 25, 2011 at 10:28:22AM +0900, Boojin Kim wrote:
> > > > > +static void pl330_tasklet_cyclic(unsigned long data)
> > > > > +{
> > > > > +	struct dma_pl330_chan *pch = (struct dma_pl330_chan *)data;
> > > > > +	struct dma_pl330_desc *desc, *_dt;
> > > > > +	unsigned long flags;
> > > > > +	LIST_HEAD(list);
> > > > > +
> > > > > +	spin_lock_irqsave(&pch->lock, flags);
> > > > ...
> > > > > +			callback = desc->txd.callback;
> > > > > +			if (callback)
> > > > > +				callback(desc->txd.callback_param);
> > > >
> > > > On this again - what if the callback wants to terminate the DMA activity
> > > > because there's no more audio data to be sent/received from the device?
> > > 
> > > Do you mean what is happened if the callback() is called after channel is
> > > terminated ?
> > > Or What is happened if Callback() calls 'dma_release_channel()' to terminate
> > > DMA?
> > 
> > No.  I mean what if the callback wants to call dmaengine_terminate_all().
> you are supposed to drop the lock here, that way callback can call any
> DMA API, otherwise it will result in deadlock.
> This make me wonder you haven't read the documentation at all, please
> ensure you have read Documentation/dmaengine.txt before next posting

I know that very well thank you.  Please look at my previous post in the
previous round of patches, and the response from Boojin Kim to see why
I used this as an *EXAMPLE* to get this fixed.
