From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 10 Nov 2016 13:24:20 +0100
Subject: [PATCH v2 1/2] iommu/dma: Implement dma_{map,unmap}_resource()
In-Reply-To: <4e84146ae49a4edd5f1226d76617be9aa92a58ee.1477503578.git.robin.murphy@arm.com>
References: <4e84146ae49a4edd5f1226d76617be9aa92a58ee.1477503578.git.robin.murphy@arm.com>
Message-ID: <20161110122420.GH9996@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2016 at 06:43:56PM +0100, Robin Murphy wrote:
> With the new dma_{map,unmap}_resource() functions added to the DMA API
> for the benefit of cases like slave DMA, add suitable implementations to
> the arsenal of our generic layer. Since cache maintenance should not be
> a concern, these can both be standalone callback implementations without
> the need for arch code wrappers.
> 
> CC: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v2: Use iommu_dma_unmap_page for symmetry, instead of being sneaky.
> 
>  drivers/iommu/dma-iommu.c | 13 +++++++++++++
>  include/linux/dma-iommu.h |  4 ++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index c5ab8667e6f2..a2fd90a6a782 100644
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

Isn't the whole point of map_resource that we can map regions which have
no 'struct page' associated? The use phys_to_page() will certainly not
do the right thing here.


	Joerg
