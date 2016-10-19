From: will.deacon@arm.com (Will Deacon)
Date: Wed, 19 Oct 2016 15:02:52 +0100
Subject: [PATCH 1/2] iommu/dma: Implement dma_{map,unmap}_resource()
In-Reply-To: <b6c78e6c18d98069b0fdfa219da51d2aed129aed.1476705500.git.robin.murphy@arm.com>
References: <b6c78e6c18d98069b0fdfa219da51d2aed129aed.1476705500.git.robin.murphy@arm.com>
Message-ID: <20161019140252.GR9193@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 01:05:29PM +0100, Robin Murphy wrote:
> With the new dma_{map,unmap}_resource() functions added to the DMA API
> for the benefit of cases like slave DMA, add suitable implementations to
> the arsenal of our generic layer. Since cache maintenance should not be
> a concern, these can both be standalone versions without the need for
> architecture-specific wrappers.
> 
> CC: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Since patch 2 has a build dependency on this one, they should probably
> go together through either the arm64 tree or the iommu tree, but I can't
> make up my mind which one seems more appropriate...

I can take it via the smmu tree, if you like. However, comment below.

>  drivers/iommu/dma-iommu.c | 13 +++++++++++++
>  include/linux/dma-iommu.h |  4 ++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index c5ab8667e6f2..50acd71915db 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -624,6 +624,19 @@ void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
>  	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), sg_dma_address(sg));
>  }
>  
> +dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	return iommu_dma_map_page(dev, phys_to_page(phys), offset_in_page(phys),
> +			size, dma_direction_to_prot(dir, false) | IOMMU_MMIO);
> +}
>
> +void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), handle);
> +}

I think it's better to call iommu_dma_unmap_page instead. That said, are
you sure it's safe to ignore the "size" parameter here? Is it permitted
to unmap part of a region? If not, why does that parameter exist?

Will
