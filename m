From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Feb 2014 12:14:04 +0100
Subject: [PATCH v2 5/7] ARM: of: introduce common routine for DMA
 configuration
In-Reply-To: <531077CE.5050501@ti.com>
References: <1393535872-20915-1-git-send-email-santosh.shilimkar@ti.com>
 <9618080.kpE3Kl6X8p@wuerfel> <531077CE.5050501@ti.com>
Message-ID: <8423517.a5cbRXVOQZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 February 2014 13:49:34 Grygorii Strashko wrote:
> On 02/28/2014 12:00 PM, Arnd Bergmann wrote:
> > On Thursday 27 February 2014 16:17:50 Santosh Shilimkar wrote:
> >> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
> >> +
> >> +void arm_dt_dma_configure(struct device *dev)
> >> +{
> >> +	dma_addr_t dma_addr;
> >> +	phys_addr_t paddr, size;
> >> +	dma_addr_t dma_mask;
> >> +	int ret;
> >> +
> >> +	/*
> >> +	 * if dma-ranges property doesn't exist - use 32 bits DMA mask
> >> +	 * by default and don't set skip archdata.dma_pfn_offset
> >> +	 */
> >> +	ret = of_dma_get_range(dev->of_node, &dma_addr, &paddr, &size);
> >> +	if (ret == -ENODEV) {
> >> +		dev->coherent_dma_mask = DMA_BIT_MASK(32);
> >> +		if (!dev->dma_mask)
> >> +			dev->dma_mask = &dev->coherent_dma_mask;
> >> +		return;
> >> +	}
> > 
> > I think this is a reasonable default, but I also want Russell's
> > opinion on this, since I suspect he will argue that we shouldn't
> > default to setting a DMA mask for devices that are not DMA capable.
> 
> Just to note, that's current default behavior used in of_platform_device_create_pdata()

Right, I realized that later.

> > Maybe someone has an idea how we can detect all three important cases:
> > 
> > a) A device is marked as DMA capable using a dma-ranges property
> > b) A device is known not to be DMA capable
> > c) we don't have any dma-ranges properties in an old dtb file
> >     but still want 32 bit masks by default.
> 
> Yep, This patch set supports [a, c]. But, case be [b] can be patched 
> by arch/mach code using Platform Bus notifier if needed.
> (Platform Bus notifiers will be called after arm_dt_dma_configure is 
> finished).

It would be nice to have a way to do it without a platform specific
notifier, I just haven't found a nice way to express that in DT.

> >> +	/* if failed - disable DMA for device */
> >> +	if (ret < 0) {
> >> +		dev_err(dev, "failed to configure DMA\n");
> >> +		return;
> >> +	}
> > 
> > I guess this is also where other platforms (shmobile, highbank, ...)
> > will want the IOMMU detection to happen.
> 
> This error path handling - means, DT contains wrong data :)

I wasn't referring to the error path here, sorry for being
ambiguous. What I meant that we could add code after this line
to look for an IOMMU.

> >> +	/* DMA ranges found. Calculate and set dma_pfn_offset */
> >> +	dev->archdata.dma_pfn_offset = PFN_DOWN(paddr - dma_addr);
> >> +
> >> +	/* Configure DMA mask */
> >> +	dev->dma_mask = kmalloc(sizeof(*dev->dma_mask), GFP_KERNEL);
> >> +	if (!dev->dma_mask)
> >> +		return;
> > 
> > Do we have to worry about freeing this? We could in theory put the
> > mask into pdev_archdata (as on microblaze), or point to
> > coherent_dma_mask (as of_platform_device_create_pdata does).
> > I can't think of a case where the latter won't actually work,
> > since coherent_dma_mask!=*dma_mask doesn't happen on any platform
> > device I have ever seen. coherent_dma_mask was introduced to handle
> > some special requirements of PCI devices on ia64 or parisc.
> 
> I've used platform_device_register_full() as ref here. It actually contains
> good comment regarding this mem leak issue:
> /*
>  * This memory isn't freed when the device is put,
>  * I don't have a nice idea for that though.  Conceptually
>  * dma_mask in struct device should not be a pointer.
>  * See http://thread.gmane.org/gmane.linux.kernel.pci/9081
>  */

Right. Maybe the best solution for that code path however is to
make it the same as the of_platform code where we today set the
mask pointer to &dev->coherent_mask.

> > Again I'm hoping for Russell to provide the correct answer: Should we
> > set the correct mask initially for the device here, or should we
> > rely on dma_set_mask() to refuse a mask that is larger than we
> > can handle?
> > 
> > For PCI devices, we normally assume that we can always set a 32-bit
> > DMA mask, but drivers can set a smaller mask if the device can
> > support a smaller space than the bus can. In this case, the mask
> > is already the intersection of what the device and all the parent
> > buses support, and I'm not sure how the API describe in
> > Documentation/DMA-API-HOWTO.txt would deal with this.
> 
> As mentioned by Santosh in cover letter,
> PCI (and other buses) is problem here as they may have different "dma-ranges"
> prop format (PCI #address-cells = <3>) and need to handled in different way. 
> 
> May be, this code can be limited to platform_bus_type devices only somehow.

Doesn't that already get handled correctly by of_bus_pci_translate()?
We have bus specific translation functions that should work for
both 'ranges' and 'dma-ranges'.

	Arnd
