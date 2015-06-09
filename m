From: eddie.huang@mediatek.com (Eddie Huang)
Date: Tue, 9 Jun 2015 18:05:21 +0800
Subject: [PATCH 2/3] spi: mediatek: Add spi bus for Mediatek MT8173
In-Reply-To: <20150608175927.GO14071@sirena.org.uk>
References: <1431075343-7887-1-git-send-email-leilk.liu@mediatek.com>
 <1431075343-7887-3-git-send-email-leilk.liu@mediatek.com>
 <20150508175306.GG2761@sirena.org.uk> <1431434356.2128.9.camel@mhfsdcap03>
 <20150512160540.GB3066@sirena.org.uk> <1431675522.2128.13.camel@mhfsdcap03>
 <20150515092543.GY2761@sirena.org.uk>
 <1433758546.19786.16.camel@mtksdaap41>
 <20150608175927.GO14071@sirena.org.uk>
Message-ID: <1433844321.16178.6.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Mon, 2015-06-08 at 18:59 +0100, Mark Brown wrote:
> On Mon, Jun 08, 2015 at 06:15:46PM +0800, Eddie Huang wrote:
> > On Fri, 2015-05-15 at 17:25 +0800, Mark Brown wrote:
> 
> > > That's how a very large proportion of devices that work with DMA are
> > > done - why would this be complicated?  All can_dma() does is report if
> > > DMA is possible.
> 
> > In include/linux/spi/spi.h, it describes if can_dma() exists and returns
> > true, dma_tx and dma_rx must be set.But Medaitek SPI controller has its
> > own dma hardware, which means this dma resides in the same base address
> > range with SPI controller, and only used by SPI, so we don't implement
> > generic DMA driver, such that can't provide dma channel and assign to
> > dmx_tx, dmx_rx parameter. We think it's strange to implement generic dma
> > driver for dma that only used by specific hardware.Can we just provide
> > can_dma() function and return false ? But I think it's a little odd that
> > there actually has dma. So can we just skip can_dma() function let it be
> > NULL ?
> 
> If it's simply the unavailbility of a struct dma_chan we must be able to
> get a better solution than just open coding all the DMA mapping and
> unmapping in the driver.  The only thing we actually use the channel for
> is to get the device we need to use to do the mapping and unmapping,
> either we need a way for devices to provide their own channels easily or
> a way for SPI drivers to specify a device here instead of a channel.
> The latter seems easier if a bit clunky (with having to work with both).

I list two ways you mention.
Pesudo code of your first suggestion:

static int mtk_spi_probe(struct platform_device *pdev) {
  struct dma_chan *tx_chan;
  struct dma_device *tx_dma;

  tx_chan = devm_kzalloc(&pdev->dev, sizeof(*tx_chan), GFP_KERNEL);
  tx_dma = devm_kzalloc(&pdev->dev, sizeof(*tx_dma), GFP_KERNEL);

  tx_dma->dev = &pdev->dev;
  tx_chan->device = tx_dma;
  master->dma_tx = tx_chan;
  ...
}

Modification of your second suggestion:

--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -539,8 +539,8 @@ static int __spi_map_msg(struct spi_master *master,
struct spi_message *msg)
        if (!master->can_dma)
                return 0;

-       tx_dev = master->dma_tx->device->dev;
-       rx_dev = master->dma_rx->device->dev;
+       tx_dev = master->dma_tx ? master->dma_tx->device->dev :
master->dev;
+       rx_dev = master->dma_rx ? master->dma_rx->device->dev : master-


Is this what you want ? Actually, I don't like first one at all.


Eddie
Thanks
