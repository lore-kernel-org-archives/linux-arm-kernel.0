From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Mon, 11 Jun 2012 10:20:49 +0530
Subject: RFC: changing DMA slave configuration API
In-Reply-To: <20120610112217.GD11404@n2100.arm.linux.org.uk>
References: <20120610102023.GC11404@n2100.arm.linux.org.uk>
 <CAGsJ_4xHNdEcfsmtypDHcJ0uyhtFz43xBojgHw2RSvrH8ohRcA@mail.gmail.com>
 <20120610112217.GD11404@n2100.arm.linux.org.uk>
Message-ID: <1339390249.1927.1623.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2012-06-10 at 12:22 +0100, Russell King - ARM Linux wrote:
> On Sun, Jun 10, 2012 at 07:19:47PM +0800, Barry Song wrote:
> > 2012/6/10 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > > Dan, Vinod,
> > >
> > > There's a change I would like to do to the DMA slave configuration.
> > > It's currently a pain to have the source and destination parameters in
> > > the dma_slave_config structure as separate elements; it means when you
> > > want to extract them, you end up with code in DMA engine drivers like:
> > >
> > > +       if (dir == DMA_DEV_TO_MEM) {
> > > +               dev_addr = c->src_addr;
> > > +               dev_width = c->src_addr_width;
> > > +               burst = c->src_maxburst;
> > > +       } else if (dir == DMA_MEM_TO_DEV) {
> > > +               dev_addr = c->dst_addr;
> > > +               dev_width = c->dst_addr_width;
> > > +               burst = c->dst_maxburst;
> > > +       }
> > >
> > > If we redefine the structure as below, this all becomes more simple:
> > >
> > > +       if (dir == DMA_DEV_TO_MEM)
> > > +               cfg = &c->dev_src;
> > > +       else if (dir == DMA_MEM_TO_DEV)
> > > +               cfg = &c->dev_dst;
> > 
> > it seems that might mean an union in your dma_slave_cfg, but not
> > co-exitense of both?
> 
> No, I want both so it's possible to select between the two when preparing
> a DMA slave transfer.
> 
> > struct dma_slave_cfg {
> > +       union {
> >               struct dma_dev_cfg dev_src;
> >               struct dma_dev_cfg dev_dst;
> >        }
> >        bool device_fc;
> > };
> 
> If you do that, the union becomes pointless, and you might as well have:
> 
> struct dma_slave_cfg {
> 	struct dma_dev_cfg dev;
> 	bool device_fc;
> };
> 
> instead.
Hi Russell,

I think it is a good idea. And I would like to extend it even a little
bit. Do we have any users of peripheral to peripheral slave dma?
IIRC  that is not the case, or does anyone know of existence or plans
for such a h/w?

If not, lets junk the src/dst fields and keep burst, length, addr fields
which point to the peripheral values.

Alternatively if we need both, then we can't have union and Russell's
idea seems good one :)


-- 
~Vinod
