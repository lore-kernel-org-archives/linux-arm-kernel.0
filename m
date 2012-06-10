From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 10 Jun 2012 12:22:18 +0100
Subject: RFC: changing DMA slave configuration API
In-Reply-To: <CAGsJ_4xHNdEcfsmtypDHcJ0uyhtFz43xBojgHw2RSvrH8ohRcA@mail.gmail.com>
References: <20120610102023.GC11404@n2100.arm.linux.org.uk>
 <CAGsJ_4xHNdEcfsmtypDHcJ0uyhtFz43xBojgHw2RSvrH8ohRcA@mail.gmail.com>
Message-ID: <20120610112217.GD11404@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 10, 2012 at 07:19:47PM +0800, Barry Song wrote:
> 2012/6/10 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > Dan, Vinod,
> >
> > There's a change I would like to do to the DMA slave configuration.
> > It's currently a pain to have the source and destination parameters in
> > the dma_slave_config structure as separate elements; it means when you
> > want to extract them, you end up with code in DMA engine drivers like:
> >
> > + ? ? ? if (dir == DMA_DEV_TO_MEM) {
> > + ? ? ? ? ? ? ? dev_addr = c->src_addr;
> > + ? ? ? ? ? ? ? dev_width = c->src_addr_width;
> > + ? ? ? ? ? ? ? burst = c->src_maxburst;
> > + ? ? ? } else if (dir == DMA_MEM_TO_DEV) {
> > + ? ? ? ? ? ? ? dev_addr = c->dst_addr;
> > + ? ? ? ? ? ? ? dev_width = c->dst_addr_width;
> > + ? ? ? ? ? ? ? burst = c->dst_maxburst;
> > + ? ? ? }
> >
> > If we redefine the structure as below, this all becomes more simple:
> >
> > + ? ? ? if (dir == DMA_DEV_TO_MEM)
> > + ? ? ? ? ? ? ? cfg = &c->dev_src;
> > + ? ? ? else if (dir == DMA_MEM_TO_DEV)
> > + ? ? ? ? ? ? ? cfg = &c->dev_dst;
> 
> it seems that might mean an union in your dma_slave_cfg, but not
> co-exitense of both?

No, I want both so it's possible to select between the two when preparing
a DMA slave transfer.

> struct dma_slave_cfg {
> +       union {
>               struct dma_dev_cfg dev_src;
>               struct dma_dev_cfg dev_dst;
>        }
>        bool device_fc;
> };

If you do that, the union becomes pointless, and you might as well have:

struct dma_slave_cfg {
	struct dma_dev_cfg dev;
	bool device_fc;
};

instead.
