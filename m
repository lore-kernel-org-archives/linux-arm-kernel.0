From: eddie.huang@mediatek.com (Eddie Huang)
Date: Mon, 8 Jun 2015 18:15:46 +0800
Subject: [PATCH 2/3] spi: mediatek: Add spi bus for Mediatek MT8173
In-Reply-To: <20150515092543.GY2761@sirena.org.uk>
References: <1431075343-7887-1-git-send-email-leilk.liu@mediatek.com>
 <1431075343-7887-3-git-send-email-leilk.liu@mediatek.com>
 <20150508175306.GG2761@sirena.org.uk> <1431434356.2128.9.camel@mhfsdcap03>
 <20150512160540.GB3066@sirena.org.uk> <1431675522.2128.13.camel@mhfsdcap03>
 <20150515092543.GY2761@sirena.org.uk>
Message-ID: <1433758546.19786.16.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Fri, 2015-05-15 at 17:25 +0800, Mark Brown wrote:
> On Fri, May 15, 2015 at 03:38:42PM +0800, leilk liu wrote:
> > On Tue, 2015-05-12 at 17:05 +0100, Mark Brown wrote:
> 
> > > Implement can_dma() - look for drivers providing that for examples.
> 
> > MTK spi hardware uses the dmaengine in spi controller. According to
> > datasheet, spi driver just need to enable dma register bit and write a
> > physical address to relevant dma address register, so I think it may be
> > complex while the driver supports can_dma.
> 
> That's how a very large proportion of devices that work with DMA are
> done - why would this be complicated?  All can_dma() does is report if
> DMA is possible.

In include/linux/spi/spi.h, it describes if can_dma() exists and returns
true, dma_tx and dma_rx must be set.But Medaitek SPI controller has its
own dma hardware, which means this dma resides in the same base address
range with SPI controller, and only used by SPI, so we don't implement
generic DMA driver, such that can't provide dma channel and assign to
dmx_tx, dmx_rx parameter. We think it's strange to implement generic dma
driver for dma that only used by specific hardware.Can we just provide
can_dma() function and return false ? But I think it's a little odd that
there actually has dma. So can we just skip can_dma() function let it be
NULL ?

Eddie
Thanks
 
