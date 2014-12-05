From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Dec 2014 17:05:29 +0100
Subject: [RFC PATCH] ARM64: PCI: inherit root controller's dma-coherent
In-Reply-To: <5481B283.6030407@ti.com>
References: <1417066891-16789-1-git-send-email-ming.lei@canonical.com>
 <CACVXFVPgchwZKQYdBWu+q0b21zeB6Lob-rD2C8mzTWb7dpZ86g@mail.gmail.com>
 <5481B283.6030407@ti.com>
Message-ID: <7705416.b49xSXIHeP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 December 2014 15:26:27 Grygorii Strashko wrote:
> ---
> From 5e078b1ba148aa280181c4f695e567875a0f4ae9 Mon Sep 17 00:00:00 2001
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> Date: Fri, 28 Feb 2014 19:11:39 +0200
> Subject: [RFC PATCH] common: dma-mapping: introduce dma_init_dev_from_parent() helper
> 
> Now, in Kernel, Parent device's DMA configuration has to by applied
> to the child as is, to enable DMA support for this device. Usually, this
> is happened in places where child device is manually instantiated by
> Parent device device using Platform APIs
> (see drivers/usb/dwc3/host.c or drivers/pci/probe.c:pci_device_add()
>  for example).
> 
> The DMA configuration is represented in Device data structure was
> extended recently (dma_pfn_offset was added) and going to extended
> in future to support IOMMU. Therefore, the code used by drivers to
> copy DMA configuration from parent to child device isn't working
> properly, for example:
> (drivers/usb/dwc3/host.c)
>    	dma_set_coherent_mask(&xhci->dev, dwc->dev->coherent_dma_mask);
> 
> 	xhci->dev.parent	= dwc->dev;
> 	xhci->dev.dma_mask	= dwc->dev->dma_mask;
> 	xhci->dev.dma_parms	= dwc->dev->dma_parms;
> above code will miss to copy dma_pfn_offset.


I'm not too thrilled about this implementation either. It immediately
breaks as soon as we have IOMMU support, as the IOMMU configuration
is by definition device dependent, and you have introduced a few bugs
by copying the pointers to dma_mask and dma_parms.

> Hence, intoroduce common dma_init_dev_from_parent() helper to
> initialize device's DMA parameters using from parent device's configuration,
> use __weak to allow arches to overwrite it if needed.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
>  drivers/base/dma-mapping.c  | 25 +++++++++++++++++++++++++
>  include/linux/dma-mapping.h |  3 +++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
> index 9e8bbdd..4556698 100644
> --- a/drivers/base/dma-mapping.c
> +++ b/drivers/base/dma-mapping.c
> @@ -270,6 +270,31 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
>  }
>  EXPORT_SYMBOL(dma_common_mmap);
>  
> +/*
> + * Initialize device's DMA parameters using parent device
> + * @dev: Device to be configured
> + * @parent: Pointer on parent device to get DMA configuration from
> + *
> + * parent can be NULL - then DMA configuration will be teken from dev->parent.
> + */
> +void __weak dma_init_dev_from_parent(struct device *dev, struct device *parent)
> +{

Please let's try to avoid weak functions

> +	struct device *parent_dev = parent;

One of these two is not needed.

> +	/* if parent is NULL assume, dev->parent is the one to use */
> +	if (!parent_dev)
> +		parent_dev = dev->parent;
> +
> +	if (is_device_dma_capable(parent_dev)) {
> +		dev->dma_mask	= parent_dev->dma_mask;

This is always wrong: dev->dma_mask is a pointer!

> +		dev->coherent_dma_mask = parent_dev->coherent_dma_mask;

What if someone has already set a mask that is greater than 32-bit?

> +		dev->dma_parms	= parent_dev->dma_parms;

same  problem here.

> +		dev->dma_pfn_offset = parent_dev->dma_pfn_offset;
> +		set_dma_ops(dev, get_dma_ops(parent_dev));
> +	}
> +}
> +EXPORT_SYMBOL(dma_init_dev_from_parent);

	Arnd
