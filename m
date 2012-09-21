From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Sep 2012 08:16:00 +0000
Subject: [RFC PATCH 10/13] spi: omap2-mcspi: dma_request_slave_channel()
 support for DT platforms
In-Reply-To: <20120920220931.GJ28835@atomide.com>
References: <1348152226-13588-1-git-send-email-mporter@ti.com>
 <1348152226-13588-11-git-send-email-mporter@ti.com>
 <20120920220931.GJ28835@atomide.com>
Message-ID: <201209210816.01473.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 September 2012, Tony Lindgren wrote:
> >  /* use PIO for small transfers, avoiding DMA setup/teardown overhead and
> > @@ -798,14 +801,26 @@ static int omap2_mcspi_request_dma(struct spi_device *spi)
> >       dma_cap_zero(mask);
> >       dma_cap_set(DMA_SLAVE, mask);
> >       sig = mcspi_dma->dma_rx_sync_dev;
> > -     mcspi_dma->dma_rx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
> > +     if (spi->dev.of_node)
> > +             mcspi_dma->dma_rx =
> > +                     dma_request_slave_channel(&master->dev,
> > +                                               mcspi_dma->dma_rx_ch_name);
> > +     else
> > +             mcspi_dma->dma_rx =
> > +                     dma_request_channel(mask, omap_dma_filter_fn, &sig);
> >       if (!mcspi_dma->dma_rx) {
> >               dev_err(&spi->dev, "no RX DMA engine channel for McSPI\n");
> >               return -EAGAIN;
> >       }
> >  
> 
> Hmm this does not look nice.. We should be able to somehow not to care about
> the configuration at the mcspi driver level.

I agree, but as far as I understand Vinod's plans, we would actually move
all drivers over to dma_request_slave_channel() when we have an interface
to register the lookup tables from platform code.

I think the above is ok for a transitional phase and we can remove the
fallback path when we have converted all platforms using this driver
to either use DT or move to the new style way of passing the channel
configuration.

	Arnd
