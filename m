From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Feb 2014 11:00:46 +0100
Subject: [PATCH v2 5/7] ARM: of: introduce common routine for DMA
 configuration
In-Reply-To: <1393535872-20915-6-git-send-email-santosh.shilimkar@ti.com>
References: <1393535872-20915-1-git-send-email-santosh.shilimkar@ti.com>
 <1393535872-20915-6-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <9618080.kpE3Kl6X8p@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 February 2014 16:17:50 Santosh Shilimkar wrote:
> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
> index f751714..926b5dd 100644
> --- a/arch/arm/kernel/devtree.c
> +++ b/arch/arm/kernel/devtree.c
> @@ -235,3 +238,61 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
>  
>  	return mdesc;
>  }
> +
> +void arm_dt_dma_configure(struct device *dev)
> +{
> +	dma_addr_t dma_addr;
> +	phys_addr_t paddr, size;
> +	dma_addr_t dma_mask;
> +	int ret;
> +
> +	/*
> +	 * if dma-ranges property doesn't exist - use 32 bits DMA mask
> +	 * by default and don't set skip archdata.dma_pfn_offset
> +	 */
> +	ret = of_dma_get_range(dev->of_node, &dma_addr, &paddr, &size);
> +	if (ret == -ENODEV) {
> +		dev->coherent_dma_mask = DMA_BIT_MASK(32);
> +		if (!dev->dma_mask)
> +			dev->dma_mask = &dev->coherent_dma_mask;
> +		return;
> +	}

I think this is a reasonable default, but I also want Russell's
opinion on this, since I suspect he will argue that we shouldn't
default to setting a DMA mask for devices that are not DMA capable.

Maybe someone has an idea how we can detect all three important cases:

a) A device is marked as DMA capable using a dma-ranges property
b) A device is known not to be DMA capable
c) we don't have any dma-ranges properties in an old dtb file
   but still want 32 bit masks by default.

> +	/* if failed - disable DMA for device */
> +	if (ret < 0) {
> +		dev_err(dev, "failed to configure DMA\n");
> +		return;
> +	}

I guess this is also where other platforms (shmobile, highbank, ...)
will want the IOMMU detection to happen.

> +	/* DMA ranges found. Calculate and set dma_pfn_offset */
> +	dev->archdata.dma_pfn_offset = PFN_DOWN(paddr - dma_addr);
> +
> +	/* Configure DMA mask */
> +	dev->dma_mask = kmalloc(sizeof(*dev->dma_mask), GFP_KERNEL);
> +	if (!dev->dma_mask)
> +		return;

Do we have to worry about freeing this? We could in theory put the
mask into pdev_archdata (as on microblaze), or point to
coherent_dma_mask (as of_platform_device_create_pdata does).
I can't think of a case where the latter won't actually work,
since coherent_dma_mask!=*dma_mask doesn't happen on any platform
device I have ever seen. coherent_dma_mask was introduced to handle
some special requirements of PCI devices on ia64 or parisc.

> +       dma_mask = dma_addr + size - 1;

I can never remember if this is actually correct, or if it would have to
be 

	dma_mask = size - 1;

instead. Russell knows.

> +	ret = arm_dma_set_mask(dev, dma_mask);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to set DMA mask %#08x\n", dma_mask);
> +		kfree(dev->dma_mask);
> +		dev->dma_mask = NULL;
> +		return;
> +	}

Again I'm hoping for Russell to provide the correct answer: Should we
set the correct mask initially for the device here, or should we
rely on dma_set_mask() to refuse a mask that is larger than we
can handle?

For PCI devices, we normally assume that we can always set a 32-bit
DMA mask, but drivers can set a smaller mask if the device can
support a smaller space than the bus can. In this case, the mask
is already the intersection of what the device and all the parent
buses support, and I'm not sure how the API describe in
Documentation/DMA-API-HOWTO.txt would deal with this.

> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 404d1da..97d5533 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -213,10 +213,13 @@ static struct platform_device *of_platform_device_create_pdata(
>  
>  #if defined(CONFIG_MICROBLAZE)
>  	dev->archdata.dma_mask = 0xffffffffUL;
> -#endif
> +#elif defined(CONFIG_ARM_LPAE)
> +	arm_dt_dma_configure(&dev->dev);
> +#else
>  	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>  	if (!dev->dev.dma_mask)
>  		dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
> +#endif

The dependency on CONFIG_ARM_LPAE is not correct the general case,
that would be a special case on keystone. I'd suggest using
CONFIG_ARM here, and finding a different way to return false
for dma_is_coherent() on keystone with LPAE disabled.

	Arnd
