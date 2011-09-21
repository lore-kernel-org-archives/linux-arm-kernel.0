From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 21 Sep 2011 16:50:41 +0200
Subject: [Linaro-mm-sig] [PATCH 1/2] ARM: initial proof-of-concept IOMMU
	mapper for DMA-mapping
In-Reply-To: <594816116217195c28de13accaf1f9f2.squirrel@www.codeaurora.org>
References: <1314971786-15140-1-git-send-email-m.szyprowski@samsung.com>
	<1314971786-15140-2-git-send-email-m.szyprowski@samsung.com>
	<594816116217195c28de13accaf1f9f2.squirrel@www.codeaurora.org>
Message-ID: <001f01cc786d$d55222c0$7ff66840$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, September 08, 2011 6:42 PM Laura Abbott wrote:

> Hi, a few comments
> On Fri, September 2, 2011 6:56 am, Marek Szyprowski wrote:
> ...
> > +
> > +struct dma_iommu_mapping {
> > +	/* iommu specific data */
> > +	struct iommu_domain	*domain;
> > +
> > +	void			*bitmap;
> 
> In the earlier version of this patch you had this as a genpool instead of
> just doing the bitmaps manually. Is there a reason genpool can't be used
> to get the iova addresses?

IMHO genpool was a bit overkill in this case and required some additional
patches for aligned allocations. In the next version I also want to extend
this bitmap based allocator to dynamically resize the bitmap for more than
one page if the io address space gets exhausted. 

> > +	size_t			bits;
> > +	unsigned int		order;
> > +	dma_addr_t		base;
> > +
> > +	struct mutex		lock;
> > +};
> <snip>
> > +int arm_iommu_attach_device(struct device *dev, dma_addr_t base, size_t
> > size, int order)
> > +{
> > +	unsigned int count = (size >> PAGE_SHIFT) - order;
> > +	unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long);
> > +	struct dma_iommu_mapping *mapping;
> > +	int err = -ENOMEM;
> > +
> > +	mapping = kzalloc(sizeof(struct dma_iommu_mapping), GFP_KERNEL);
> > +	if (!mapping)
> > +		goto err;
> > +
> > +	mapping->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> > +	if (!mapping->bitmap)
> > +		goto err2;
> > +
> > +	mapping->base = base;
> > +	mapping->bits = bitmap_size;
> > +	mapping->order = order;
> > +	mutex_init(&mapping->lock);
> > +
> > +	mapping->domain = iommu_domain_alloc();
> > +	if (!mapping->domain)
> > +		goto err3;
> > +
> > +	err = iommu_attach_device(mapping->domain, dev);
> > +	if (err != 0)
> > +		goto err4;
> > +
> > +	dev->archdata.mapping = mapping;
> > +	set_dma_ops(dev, &iommu_ops);
> > +
> > +	printk(KERN_INFO "Attached IOMMU controller to %s device.\n",
> > dev_name(dev));
> > +	return 0;
> > +
> > +err4:
> > +	iommu_domain_free(mapping->domain);
> > +err3:
> > +	kfree(mapping->bitmap);
> > +err2:
> > +	kfree(mapping);
> > +err:
> > +	return -ENOMEM;
> > +}
> > +EXPORT_SYMBOL(arm_iommu_attach_device);
> > +
> > +#endif

> Attach makes the assumption that each iommu device will exist in a
> separate domain. What if multiple devices want to use the same iommu
> domain? The msm iommu implementation has many different iommu devices but
> many of these will need the same buffer to be mapped in each context so
> currently many devices share the same domain. Without this, the same map
> call would need to happen for each device, which creates extra map calls
> and overhead.

Ah, right. I forgot about the case when devices need to share one domain.
Moving iommu_domain_alloc out of arm_iommu_attach_device and giving that
function just a pointer to the iommu domain should solve this issue. I will
change this in the next version of the patches.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
