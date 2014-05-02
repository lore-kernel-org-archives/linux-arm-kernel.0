From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 May 2014 20:59:53 +0200
Subject: [PATCH v3 4/7] of: configure the platform device dma parameters
In-Reply-To: <20140502165459.GA29511@google.com>
References: <1398353407-2345-1-git-send-email-santosh.shilimkar@ti.com>
 <1398353407-2345-5-git-send-email-santosh.shilimkar@ti.com>
 <20140502165459.GA29511@google.com>
Message-ID: <20923376.buVzFR52Qe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 May 2014 10:54:59 Bjorn Helgaas wrote:
> > +static void of_dma_configure(struct device *dev)
> > +{
> > +     u64 dma_addr, paddr, size;
> > +     int ret;
> > +
> > +     dev->coherent_dma_mask = DMA_BIT_MASK(32);
> > +     if (!dev->dma_mask)
> > +             dev->dma_mask = &dev->coherent_dma_mask;
> > +
> > +     /*
> > +      * if dma-coherent property exist, call arch hook to setup
> > +      * dma coherent operations.
> > +      */
> > +     if (of_dma_is_coherent(dev->of_node)) {
> > +             set_arch_dma_coherent_ops(dev);
> > +             dev_dbg(dev, "device is dma coherent\n");
> > +     }
> > +
> > +     /*
> > +      * if dma-ranges property doesn't exist - just return else
> > +      * setup the dma offset
> > +      */
> > +     ret = of_dma_get_range(dev->of_node, &dma_addr, &paddr, &size);
> > +     if ((ret == -ENODEV) || (ret < 0)) {
> > +             dev_dbg(dev, "no dma range information to setup\n");
> > +             return;
> > +     }
> > +
> > +     /* DMA ranges found. Calculate and set dma_pfn_offset */
> > +     dev->dma_pfn_offset = PFN_DOWN(paddr - dma_addr);
> > +     dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", dev->dma_pfn_offset);
> 
> Is this effectively the same as an IOMMU that applies a constant offset
> to the bus address?  Could or should this be done by adding a simple IOMMU
> driver instead of adding dma_pfn_offset to struct device?

We currently have two dma_map_ops variants on ARM (plus another set for
coherent/noncoherent differences, but we can ignore that for the sake
of this discussion): one that handles linear mappings and one that
handles IOMMUs by calling into the linux/iommu.h APIs.

I guess what you mean by 'a simple IOMMU driver' would be another
dma_map_ops implementation that is separate from real IOMMUs, right?

That could certainly be done, but in effect it is almost the same as
the linear mapping we already have.

> If we had both dma-ranges (and we set dma_pfn_offset as you do here) and an
> IOMMU, how would the combination work?  If the IOMMU driver managed
> dma_pfn_offset internally, it seems like we'd have two entities dealing
> with it.  If the IOMMU driver doesn't use dma_pfn_offset, it seems like
> it would be exposing a weird intermediate address space that's not usable
> by either CPU or device.

The iommu dma_map_ops implementation does not need to worry about the
dma_pfn_offset. We are still debating how to represent IOMMUs in DT
at the moment, so it's not clear yet if we would consider a device node
with both a dma-ranges property and an iommu reference as valid.

What we will probably need is a way to represent the valid bus addresses
that can be used for transfers from the DMA master through the IOMMU.
This could be done through dma-ranges, or some other property, we will
have to decide that soon.

	Arnd
