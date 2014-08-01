From: will.deacon@arm.com (Will Deacon)
Date: Fri, 1 Aug 2014 09:22:28 +0100
Subject: [PATCH v4 1/1] iommu-api: Add map_sg/unmap_sg functions
In-Reply-To: <1406854484-3848-2-git-send-email-ohaugan@codeaurora.org>
References: <1406854484-3848-1-git-send-email-ohaugan@codeaurora.org>
 <1406854484-3848-2-git-send-email-ohaugan@codeaurora.org>
Message-ID: <20140801082228.GC15733@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olav,

On Fri, Aug 01, 2014 at 01:54:44AM +0100, Olav Haugan wrote:
> Mapping and unmapping are more often than not in the critical path.
> map_sg and unmap_sg allows IOMMU driver implementations to optimize
> the process of mapping and unmapping buffers into the IOMMU page tables.
> 
> Instead of mapping a buffer one page at a time and requiring potentially
> expensive TLB operations for each page, this function allows the driver
> to map all pages in one go and defer TLB maintenance until after all
> pages have been mapped.
> 
> Additionally, the mapping operation would be faster in general since
> clients does not have to keep calling map API over and over again for
> each physically contiguous chunk of memory that needs to be mapped to a
> virtually contiguous region.

Just a couple of minor comments, but I think this is almost there now.

> Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
> ---
>  drivers/iommu/iommu.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iommu.h | 28 ++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 1698360..1d5dc2e 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1088,6 +1088,50 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
>  }
>  EXPORT_SYMBOL_GPL(iommu_unmap);
>  
> +int iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
> +			struct scatterlist *sg, unsigned int nents,
> +			int prot, unsigned long flags)
> +{

What do you anticipate passing in the flags parameter? I assume it's
something specific to the scatterlist, since we can't provide this to
iommu_map as it stands?

> +	int ret = 0;
> +	unsigned long offset = 0;
> +
> +	if (unlikely(domain->ops->map_sg == NULL)) {
> +		unsigned int i;
> +		struct scatterlist *s;
> +
> +		for_each_sg(sg, s, nents, i) {
> +			phys_addr_t phys = page_to_phys(sg_page(s));
> +			size_t page_len = s->offset + s->length;
> +
> +			ret = iommu_map(domain, iova + offset, phys, page_len,
> +					prot);
> +			if (ret)
> +				goto fail;
> +
> +			offset += page_len;
> +		}
> +	} else {
> +		ret = domain->ops->map_sg(domain, iova, sg, nents, prot, flags);
> +	}
> +	goto out;
> +
> +fail:
> +	/* undo mappings already done in case of error */
> +	iommu_unmap(domain, iova, offset);

I think this would be cleaner if you stuck it in the loop above and removed
all these labels:

  if (ret) {
	iommu_unmap(...);
	break;
  }

Will
