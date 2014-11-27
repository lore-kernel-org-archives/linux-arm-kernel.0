From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Nov 2014 10:03:38 +0100
Subject: [RFC PATCH] ARM64: PCI: inherit root controller's dma-coherent
In-Reply-To: <1417066891-16789-1-git-send-email-ming.lei@canonical.com>
References: <1417066891-16789-1-git-send-email-ming.lei@canonical.com>
Message-ID: <2081877.zLc8dS8vkP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 November 2014 13:41:31 Ming Lei wrote:

> @@ -37,6 +38,21 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  	return res->start;
>  }
>  
> +/* Inherit root controller's dma coherent ops */
> +static void pci_dma_config(struct pci_dev *dev)
> +{
> +	struct pci_bus *bus = dev->bus;
> +	struct device *host;
> +
> +	while (!pci_is_root_bus(bus)) {
> +		bus = bus->parent;
> +	}
> +
> +	host = bus->dev.parent->parent;
> +	if (of_dma_is_coherent(host->of_node))
> +		set_arch_dma_coherent_ops(&dev->dev);
> +}
> +

I think we need something more generic than this: This is not architecture
specific at all, and we have to deal with IOMMU, swiotlb, dma offset and
dma mask as well, coherency is definitely not the only issue.

We have the of_dma_configure() function that does some of this for platform
devices and that have to extend to make it work with IOMMUs, and the
common pci_device_add() function does some other subset in architecture
independent code for PCI, so I think that's where it should go.
We will need an architecture-specific helper to set the dma_map_ops
pointer, dma_parms, dma offset, and the iommu, but that is not PCI
specific, it just gets called from both the platform device and pci
device code.

Regarding the pcibios_add_device() function, I'd rather see the existing
code moved into the PCI core and the function removed, since it also
is not architecture specific. We should be able to delete the entire
arm64/pci.c file eventually.

	Arnd
