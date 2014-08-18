From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 18 Aug 2014 23:55:54 +0200
Subject: [PATCH v5 1/1] iommu-api: Add map_sg/unmap_sg functions
In-Reply-To: <1407797150-515-2-git-send-email-ohaugan@codeaurora.org>
References: <1407797150-515-1-git-send-email-ohaugan@codeaurora.org>
 <1407797150-515-2-git-send-email-ohaugan@codeaurora.org>
Message-ID: <20140818215553.GJ9809@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 11, 2014 at 03:45:50PM -0700, Olav Haugan wrote:
> +int default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
> +			 struct scatterlist *sg, unsigned int nents,
> +			 int prot, unsigned long flags)
> +{
> +	int ret = 0;
> +	unsigned long offset = 0;
> +	unsigned int i;
> +	struct scatterlist *s;
> +
> +	for_each_sg(sg, s, nents, i) {
> +		phys_addr_t phys = page_to_phys(sg_page(s));
> +		size_t page_len = s->offset + s->length;
> +
> +		ret = iommu_map(domain, iova + offset, phys, page_len,
> +				prot);

This isn't going to work, iova + offset, phys and page_len need to be
aligned to the minimum page-size the given IOMMU implementation
supports. See the iommu_map implementation for details.

> +int default_iommu_unmap_sg(struct iommu_domain *domain, unsigned long iova,
> +			       size_t size, unsigned long flags)

Another asymmentry here, why don't you just pass a scatterlist and nents
like in the map_sg function? if you implement it like this it is just a
duplication of iommu_unmap().

> +static inline int iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
> +			       struct scatterlist *sg, unsigned int nents,
> +			       int prot, unsigned long flags)
> +{
> +	return domain->ops->map_sg(domain, iova, sg, nents, prot, flags);
> +}
> +
> +static inline int iommu_unmap_sg(struct iommu_domain *domain,
> +				 unsigned long iova, size_t size,
> +				 unsigned long flags)
> +{
> +	return domain->ops->unmap_sg(domain, iova, size, flags);
> +}

These function pointers need to be checked for != NULL before calling
them.


	Joerg
