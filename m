From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Jan 2013 10:50:23 +0000
Subject: [PATCH 1/5] dmaengine: dw_dmac: move to generic DMA binding
In-Reply-To: <1359445171.31148.30.camel@smile>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <1359410300-26113-2-git-send-email-arnd@arndb.de>
 <1359445171.31148.30.camel@smile>
Message-ID: <201301291050.23743.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(putting back the Cc list, I assumed you dropped them accidentally)

On Tuesday 29 January 2013, Andy Shevchenko wrote:
> On Mon, 2013-01-28 at 21:58 +0000, Arnd Bergmann wrote: 
> > -	if ((last_dw == dw) && (last_bus_id == param))
> > +	/* both the driver and the device must match */
> > +        if (chan->device->dev->driver != &dw_driver.driver)
> 
> Could we somehow pass the &.driver to the generic filter function (via
> *_dma_controller_register() ? ) and do this to each DMA driver?

My hope is still that we can avoid using filter functions entirely
when we use xlate() logic, and instead just go through the channels
of the dma engine we know we are looking at.

I would also assume that the argument passed to *_dma_controller_register
normally holds a pointer to the dma device. Now that I think about it,
the check 'if (dw != fargs->dw)' already implies that we are looking
at the correct driver, but it feels dirty to cast a random dma_device
pointer to a driver specific one before we know which driver it is
for.

However, since we have a valid pointer to a dw_dma object, we can
extract the driver from there:

	struct dw_dma_filter_args *fargs = param;
	struct dma_device *ddev = &fargs->dw->dma;
	if (dma != chan->device)
		return -EINVAL;

which is simpler and cleaner that what I had.

> > +	sd->dma_dev	= dw->dma.dev;
> > +	sd->cfg_hi	= fargs->cfg_hi;
> > +	sd->cfg_lo	= fargs->cfg_lo;
> > +	sd->src_master	= fargs->src;
> > +	sd->dst_master	= fargs->dst;
> 
> Could we use fargs structure directly?

We could probably have no fargs but use the dw_dma_slave structure
directly to pass the data, if cannot figure out a way to avoid
the need for a filter function.  I thought about doing that, but
intermediate versions of my patch had a different layout here.

	Arnd
