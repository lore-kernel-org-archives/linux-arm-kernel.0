From: will.deacon@arm.com (Will Deacon)
Date: Thu, 27 Nov 2014 10:22:03 +0000
Subject: [RFC PATCH] ARM64: PCI: inherit root controller's dma-coherent
In-Reply-To: <2081877.zLc8dS8vkP@wuerfel>
References: <1417066891-16789-1-git-send-email-ming.lei@canonical.com>
 <2081877.zLc8dS8vkP@wuerfel>
Message-ID: <20141127102203.GD20649@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 09:03:38AM +0000, Arnd Bergmann wrote:
> On Thursday 27 November 2014 13:41:31 Ming Lei wrote:
> 
> > @@ -37,6 +38,21 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> >  	return res->start;
> >  }
> >  
> > +/* Inherit root controller's dma coherent ops */
> > +static void pci_dma_config(struct pci_dev *dev)
> > +{
> > +	struct pci_bus *bus = dev->bus;
> > +	struct device *host;
> > +
> > +	while (!pci_is_root_bus(bus)) {
> > +		bus = bus->parent;
> > +	}
> > +
> > +	host = bus->dev.parent->parent;
> > +	if (of_dma_is_coherent(host->of_node))
> > +		set_arch_dma_coherent_ops(&dev->dev);
> > +}
> > +
> 
> I think we need something more generic than this: This is not architecture
> specific at all, and we have to deal with IOMMU, swiotlb, dma offset and
> dma mask as well, coherency is definitely not the only issue.

Yeah, and we need to extend the IOMMU binding to express RequesterID ->
StreamID (master ID) mappings at the host controller, too.

Will
