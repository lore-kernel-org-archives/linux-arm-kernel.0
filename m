From: eddie.huang@mediatek.com (Eddie Huang)
Date: Wed, 17 Jun 2015 17:08:03 +0800
Subject: [PATCH 2/3] spi: mediatek: Add spi bus for Mediatek MT8173
In-Reply-To: <1433923569.22080.1.camel@mtksdaap41>
References: <1431075343-7887-1-git-send-email-leilk.liu@mediatek.com>
 <1431075343-7887-3-git-send-email-leilk.liu@mediatek.com>
 <20150508175306.GG2761@sirena.org.uk> <1431434356.2128.9.camel@mhfsdcap03>
 <20150512160540.GB3066@sirena.org.uk> <1431675522.2128.13.camel@mhfsdcap03>
 <20150515092543.GY2761@sirena.org.uk>
 <1433758546.19786.16.camel@mtksdaap41>
 <20150608175927.GO14071@sirena.org.uk>
 <1433844321.16178.6.camel@mtksdaap41>
 <20150609103951.GA14071@sirena.org.uk>
 <1433923569.22080.1.camel@mtksdaap41>
Message-ID: <1434532083.19346.27.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, 2015-06-10 at 16:06 +0800, Eddie Huang wrote:
> On Tue, 2015-06-09 at 11:39 +0100, Mark Brown wrote:
> > On Tue, Jun 09, 2015 at 06:05:21PM +0800, Eddie Huang wrote:
> > 
> > > --- a/drivers/spi/spi.c
> > > +++ b/drivers/spi/spi.c
> > > @@ -539,8 +539,8 @@ static int __spi_map_msg(struct spi_master *master,
> > > struct spi_message *msg)
> > >         if (!master->can_dma)
> > >                 return 0;
> > 
> > > -       tx_dev = master->dma_tx->device->dev;
> > > -       rx_dev = master->dma_rx->device->dev;
> > > +       tx_dev = master->dma_tx ? master->dma_tx->device->dev :
> > > master->dev;
> > > +       rx_dev = master->dma_rx ? master->dma_rx->device->dev : master-
> > 
> > > Is this what you want ? Actually, I don't like first one at all.
> > 
> > Not quite what I'd been thinking of - we can't just pick the device in
> > the core safely, the device might be a MFD or have some other
> > restriction that needs us to use a separate struct device.  However most
> > of those cases are likely to point towards implementing a dmaengine
> > device so probably the above will work for most cases and is fine.  Can
> > you send a proper patch please?
> 

After further investigate, we found problem when use can_dma() to
implement spi driver.

If can_dma() return true in __spi_map_msg() function, it will map data
buffer to sg_table, then pass this sg_table to transfer function. In
transfer function, spi hardware can do tx and rx at the same time (full
duplex), and the data size must be the same.

Here comes the problem, although total length of tx, rx is the same,
each entry in rx and tx scatterlist may not be the same (in the case
data buffer allocate from vmalloc). Other vendor have dmaengine driver
to send entry-by-entry automatically, so it is ok due to total length is
the same.But mediatek hw can only send tx and rx scatterlist entry one
by on, which means in full duplex, mediatek SPI hardware need send each
entry separately, will cause full duplex fail because tx/rx entry size
or entry number may not be the same.

The problem is not dma map discuss earlier, it is mediatek spi hardware
limitation that can't support scatterlist dma transfer in full-duplex
mode. We can only support both tx and rx has the same size continuous
memory data in full-duplex mode. I don't know whether should modify
spi.c to support mediatek spi, or we just return can_dma() false and do
transfer one continuous data in transfer function.

By the way, I think maybe it is better to change can_dma() to
can_dma_sg().

Eddie
Thanks
