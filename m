From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 11 Jul 2014 12:20:53 +0200
Subject: [RFC/PATCH 2/7] iommu-api: Add map_range/unmap_range functions
In-Reply-To: <1404147116-4598-3-git-send-email-ohaugan@codeaurora.org>
References: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
 <1404147116-4598-3-git-send-email-ohaugan@codeaurora.org>
Message-ID: <20140711102053.GB1958@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 09:51:51AM -0700, Olav Haugan wrote:
> +int iommu_map_range(struct iommu_domain *domain, unsigned int iova,
> +		    struct scatterlist *sg, unsigned int len, int prot)
> +{
> +	if (unlikely(domain->ops->map_range == NULL))
> +		return -ENODEV;
> +
> +	BUG_ON(iova & (~PAGE_MASK));
> +
> +	return domain->ops->map_range(domain, iova, sg, len, prot);
> +}
> +EXPORT_SYMBOL_GPL(iommu_map_range);
> +
> +int iommu_unmap_range(struct iommu_domain *domain, unsigned int iova,
> +		      unsigned int len)
> +{
> +	if (unlikely(domain->ops->unmap_range == NULL))
> +		return -ENODEV;
> +
> +	BUG_ON(iova & (~PAGE_MASK));
> +
> +	return domain->ops->unmap_range(domain, iova, len);
> +}
> +EXPORT_SYMBOL_GPL(iommu_unmap_range);

Before introducing these new API functions there should be a fall-back
for IOMMU drivers that do (not yet) implement the map_range and
unmap_range call-backs.

The last thing we want is this kind of functional partitioning between
different IOMMU drivers.


	Joerg
