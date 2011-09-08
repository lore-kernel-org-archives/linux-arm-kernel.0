From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 8 Sep 2011 09:41:46 -0700 (PDT)
Subject: [Linaro-mm-sig] [PATCH 1/2] ARM: initial proof-of-concept
	IOMMU mapper for DMA-mapping
In-Reply-To: <1314971786-15140-2-git-send-email-m.szyprowski@samsung.com>
References: <1314971786-15140-1-git-send-email-m.szyprowski@samsung.com>
	<1314971786-15140-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <594816116217195c28de13accaf1f9f2.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi, a few comments
On Fri, September 2, 2011 6:56 am, Marek Szyprowski wrote:
...
> +
> +struct dma_iommu_mapping {
> +	/* iommu specific data */
> +	struct iommu_domain	*domain;
> +
> +	void			*bitmap;

In the earlier version of this patch you had this as a genpool instead of
just doing the bitmaps manually. Is there a reason genpool can't be used
to get the iova addresses?
> +	size_t			bits;
> +	unsigned int		order;
> +	dma_addr_t		base;
> +
> +	struct mutex		lock;
> +};
<snip>
> +int arm_iommu_attach_device(struct device *dev, dma_addr_t base, size_t
> size, int order)
> +{
> +	unsigned int count = (size >> PAGE_SHIFT) - order;
> +	unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long);
> +	struct dma_iommu_mapping *mapping;
> +	int err = -ENOMEM;
> +
> +	mapping = kzalloc(sizeof(struct dma_iommu_mapping), GFP_KERNEL);
> +	if (!mapping)
> +		goto err;
> +
> +	mapping->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> +	if (!mapping->bitmap)
> +		goto err2;
> +
> +	mapping->base = base;
> +	mapping->bits = bitmap_size;
> +	mapping->order = order;
> +	mutex_init(&mapping->lock);
> +
> +	mapping->domain = iommu_domain_alloc();
> +	if (!mapping->domain)
> +		goto err3;
> +
> +	err = iommu_attach_device(mapping->domain, dev);
> +	if (err != 0)
> +		goto err4;
> +
> +	dev->archdata.mapping = mapping;
> +	set_dma_ops(dev, &iommu_ops);
> +
> +	printk(KERN_INFO "Attached IOMMU controller to %s device.\n",
> dev_name(dev));
> +	return 0;
> +
> +err4:
> +	iommu_domain_free(mapping->domain);
> +err3:
> +	kfree(mapping->bitmap);
> +err2:
> +	kfree(mapping);
> +err:
> +	return -ENOMEM;
> +}
> +EXPORT_SYMBOL(arm_iommu_attach_device);
> +
> +#endif
Attach makes the assumption that each iommu device will exist in a
separate domain. What if multiple devices want to use the same iommu
domain? The msm iommu implementation has many different iommu devices but
many of these will need the same buffer to be mapped in each context so
currently many devices share the same domain. Without this, the same map
call would need to happen for each device, which creates extra map calls
and overhead.
>
> _______________________________________________
> Linaro-mm-sig mailing list
> Linaro-mm-sig at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-mm-sig
>

Laura
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
