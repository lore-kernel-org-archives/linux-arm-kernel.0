From: vkoul@infradead.org (Vinod Koul)
Date: Mon, 25 Jul 2011 16:31:57 +0530
Subject: [PATCH V4 04/14] DMA: PL330: Add DMA_CYCLIC capability
In-Reply-To: <20110725105754.GG9653@n2100.arm.linux.org.uk>
References: <1311557312-26107-1-git-send-email-boojin.kim@samsung.com>
	<1311557312-26107-5-git-send-email-boojin.kim@samsung.com>
	<20110725092749.GB9653@n2100.arm.linux.org.uk>
	<002001cc4ab6$0d7cd590$287680b0$%kim@samsung.com>
	<20110725103629.GF9653@n2100.arm.linux.org.uk>
	<1311590884.29703.2.camel@vkoul-mobl4>
	<20110725105754.GG9653@n2100.arm.linux.org.uk>
Message-ID: <1311591717.29703.7.camel@vkoul-mobl4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-07-25 at 11:57 +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 25, 2011 at 04:18:04PM +0530, Vinod Koul wrote:
> > On Mon, 2011-07-25 at 11:36 +0100, Russell King - ARM Linux wrote:
> > > On Mon, Jul 25, 2011 at 07:31:45PM +0900, Boojin Kim wrote:
> > > > > On Mon, Jul 25, 2011 at 10:28:22AM +0900, Boojin Kim wrote:
> > > > > > +static void pl330_tasklet_cyclic(unsigned long data)
> > > > > > +{
> > > > > > +	struct dma_pl330_chan *pch = (struct dma_pl330_chan *)data;
> > > > > > +	struct dma_pl330_desc *desc, *_dt;
> > > > > > +	unsigned long flags;
> > > > > > +	LIST_HEAD(list);
> > > > > > +
> > > > > > +	spin_lock_irqsave(&pch->lock, flags);
> > > > > ...
> > > > > > +			callback = desc->txd.callback;
> > > > > > +			if (callback)
> > > > > > +				callback(desc->txd.callback_param);
> > > > >
> > > > > On this again - what if the callback wants to terminate the DMA activity
> > > > > because there's no more audio data to be sent/received from the device?
> > > > 
> > > > Do you mean what is happened if the callback() is called after channel is
> > > > terminated ?
> > > > Or What is happened if Callback() calls 'dma_release_channel()' to terminate
> > > > DMA?
> > > 
> > > No.  I mean what if the callback wants to call dmaengine_terminate_all().
> > you are supposed to drop the lock here, that way callback can call any
> > DMA API, otherwise it will result in deadlock.
> > This make me wonder you haven't read the documentation at all, please
> > ensure you have read Documentation/dmaengine.txt before next posting
> 
> I know that very well thank you.  Please look at my previous post in the
> previous round of patches, and the response from Boojin Kim to see why
> I used this as an *EXAMPLE* to get this fixed.
Russell,
Sorry that was not intended for you but for the author of patch Boojin
Kim... Agree on your EXAMPLE, just wanted to ensure authors have read it
as going thru this patch made it clear that they haven't.

-- 
~Vinod Koul
Intel Corp.
