From: broonie@kernel.org (Mark Brown)
Date: Mon, 8 Jun 2015 18:59:27 +0100
Subject: [PATCH 2/3] spi: mediatek: Add spi bus for Mediatek MT8173
In-Reply-To: <1433758546.19786.16.camel@mtksdaap41>
References: <1431075343-7887-1-git-send-email-leilk.liu@mediatek.com>
 <1431075343-7887-3-git-send-email-leilk.liu@mediatek.com>
 <20150508175306.GG2761@sirena.org.uk>
 <1431434356.2128.9.camel@mhfsdcap03>
 <20150512160540.GB3066@sirena.org.uk>
 <1431675522.2128.13.camel@mhfsdcap03>
 <20150515092543.GY2761@sirena.org.uk>
 <1433758546.19786.16.camel@mtksdaap41>
Message-ID: <20150608175927.GO14071@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 08, 2015 at 06:15:46PM +0800, Eddie Huang wrote:
> On Fri, 2015-05-15 at 17:25 +0800, Mark Brown wrote:

> > That's how a very large proportion of devices that work with DMA are
> > done - why would this be complicated?  All can_dma() does is report if
> > DMA is possible.

> In include/linux/spi/spi.h, it describes if can_dma() exists and returns
> true, dma_tx and dma_rx must be set.But Medaitek SPI controller has its
> own dma hardware, which means this dma resides in the same base address
> range with SPI controller, and only used by SPI, so we don't implement
> generic DMA driver, such that can't provide dma channel and assign to
> dmx_tx, dmx_rx parameter. We think it's strange to implement generic dma
> driver for dma that only used by specific hardware.Can we just provide
> can_dma() function and return false ? But I think it's a little odd that
> there actually has dma. So can we just skip can_dma() function let it be
> NULL ?

If it's simply the unavailbility of a struct dma_chan we must be able to
get a better solution than just open coding all the DMA mapping and
unmapping in the driver.  The only thing we actually use the channel for
is to get the device we need to use to do the mapping and unmapping,
either we need a way for devices to provide their own channels easily or
a way for SPI drivers to specify a device here instead of a channel.
The latter seems easier if a bit clunky (with having to work with both).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150608/6285d102/attachment.sig>
