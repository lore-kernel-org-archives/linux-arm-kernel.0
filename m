From: Jean-Philippe.Brucker@arm.com (Jean-Philippe Brucker)
Date: Thu, 10 Mar 2016 11:52:54 +0000
Subject: [RFC v5 06/17] dma-reserved-iommu: iommu_get/put_single_reserved
In-Reply-To: <1456856877-4817-7-git-send-email-eric.auger@linaro.org>
References: <1456856877-4817-1-git-send-email-eric.auger@linaro.org>
 <1456856877-4817-7-git-send-email-eric.auger@linaro.org>
Message-ID: <20160310115253.GA14609@e106794-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Tue, Mar 01, 2016 at 06:27:46PM +0000, Eric Auger wrote:
>[...]
> +
> +int iommu_get_single_reserved(struct iommu_domain *domain,
> +			      phys_addr_t addr, int prot,
> +			      dma_addr_t *iova)
> +{
> +	unsigned long order = __ffs(domain->ops->pgsize_bitmap);
> +	size_t page_size = 1 << order;
> +	phys_addr_t mask = page_size - 1;
> +	phys_addr_t aligned_addr = addr & ~mask;
> +	phys_addr_t offset  = addr - aligned_addr;
> +	struct iommu_reserved_binding *b;
> +	struct iova *p_iova;
> +	struct iova_domain *iovad =
> +		(struct iova_domain *)domain->reserved_iova_cookie;
> +	int ret;
> +
> +	if (!iovad)
> +		return -EINVAL;
> +
> +	mutex_lock(&domain->reserved_mutex);

I believe this function could get called from the chunk of __setup_irq
that is executed atomically:

    * request_threaded_irq
    * __setup_irq
    * irq_startup
    * irq_domain_activate_irq
    * msi_domain_activate
    * msi_compose
    * iommu_get_single_reserved

If this is the case, we should probably use a spinlock to protect the
iova_domain...

> +
> +	b = find_reserved_binding(domain, aligned_addr, page_size);
> +	if (b) {
> +		*iova = b->iova + offset;
> +		kref_get(&b->kref);
> +		ret = 0;
> +		goto unlock;
> +	}
> +
> +	/* there is no existing reserved iova for this pa */
> +	p_iova = alloc_iova(iovad, 1, iovad->dma_32bit_pfn, true);
> +	if (!p_iova) {
> +		ret = -ENOMEM;
> +		goto unlock;
> +	}
> +	*iova = p_iova->pfn_lo << order;
> +
> +	b = kzalloc(sizeof(*b), GFP_KERNEL);

... and GFP_ATOMIC here.

Thanks,
Jean-Philippe

> +	if (!b) {
> +		ret = -ENOMEM;
> +		goto free_iova_unlock;
> +	}
> +
> +	ret = iommu_map(domain, *iova, aligned_addr, page_size, prot);
> +	if (ret)
> +		goto free_binding_iova_unlock;
> +
> +	kref_init(&b->kref);
> +	kref_get(&b->kref);
> +	b->domain = domain;
> +	b->addr = aligned_addr;
> +	b->iova = *iova;
> +	b->size = page_size;
> +
> +	link_reserved_binding(domain, b);
> +
> +	*iova += offset;
> +	goto unlock;
> +
> +free_binding_iova_unlock:
> +	kfree(b);
> +free_iova_unlock:
> +	free_iova(iovad, *iova >> order);
> +unlock:
> +	mutex_unlock(&domain->reserved_mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_get_single_reserved);
