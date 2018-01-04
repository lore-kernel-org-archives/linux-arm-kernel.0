From: hch@lst.de (Christoph Hellwig)
Date: Thu, 4 Jan 2018 09:52:05 +0100
Subject: [PATCH 27/67] dma-direct: add dma address sanity checks
In-Reply-To: <CAMuHMdWg3PnTXezMCcr3oGf-83-cjvcj4wGiPk7j2pY1Tgzo9Q@mail.gmail.com>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-28-hch@lst.de>
 <CAMuHMdWg3PnTXezMCcr3oGf-83-cjvcj4wGiPk7j2pY1Tgzo9Q@mail.gmail.com>
Message-ID: <20180104085205.GC3251@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 29, 2017 at 03:12:25PM +0100, Geert Uytterhoeven wrote:
> > +check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
> > +               const char *caller)
> > +{
> > +       if (unlikely(dev && !dma_capable(dev, dma_addr, size))) {
> > +               if (*dev->dma_mask >= DMA_BIT_MASK(32)) {
> > +                       dev_err(dev,
> > +                               "%s: overflow %llx+%zu of device mask %llx\n",
> 
> Please use "%pad" to format dma_addr_t ...
> 
> > +                               caller, (long long)dma_addr, size,
> 
> ... and use &dma_addr.
> 
> > +                               (long long)*dev->dma_mask);
> 
> This cast is not needed, as u64 is unsigned long long in kernelspace on
> all architectures.

Thanks, fixed.
