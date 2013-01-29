From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Jan 2013 13:13:03 +0000
Subject: [PATCH 2/5] spi: pl022: use generic DMA slave configuration if
 possible
In-Reply-To: <1359445794.31148.34.camel@smile>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <1359410300-26113-3-git-send-email-arnd@arndb.de>
 <1359445794.31148.34.camel@smile>
Message-ID: <201301291313.03511.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 January 2013, Andy Shevchenko wrote:

> > +static int pl022_dma_autoprobe(struct pl022 *pl022)
> > +{
> > +	struct device *dev = &pl022->adev->dev;
> > +
> > +	/* automatically configure DMA channels from platform, normally using DT */
> > +	pl022->dma_rx_channel = dma_request_slave_channel(dev, "rx");
> > +	if (!pl022->dma_rx_channel)
> > +		goto err_no_rxchan;
> > +
> > +	pl022->dma_tx_channel = dma_request_slave_channel(dev, "tx");
> > +	if (!pl022->dma_tx_channel)
> > +		goto err_no_txchan;
> > +
> > +	pl022->dummypage = kmalloc(PAGE_SIZE, GFP_KERNEL);
> 
> Where this memory will be freed?
> In dependence of the answer could you consider to use
> devm_kmalloc or __get_free_page?

There is another function like this called pl022_dma_probe()
that has the same allocation, and it gets freed in the same place.

It's probably worth changing this into something different, but
I felt that it didn't belong into this patch. I was also not
sure if the best option would be dmam_alloc_coherent, dev_kzalloc,
or __get_free_page.

	Arnd
