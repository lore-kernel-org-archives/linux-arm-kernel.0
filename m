From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 21 Sep 2017 12:11:23 +0100
Subject: [PATCH 2/4] numa, iommu/io-pgtable-arm: Use NUMA aware memory
 allocation for smmu translation tables
In-Reply-To: <20170921085922.11659-3-ganapatrao.kulkarni@cavium.com>
References: <20170921085922.11659-1-ganapatrao.kulkarni@cavium.com>
 <20170921085922.11659-3-ganapatrao.kulkarni@cavium.com>
Message-ID: <37e3ce0e-717d-156d-fef3-27559aff980e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/09/17 09:59, Ganapatrao Kulkarni wrote:
> function __arm_lpae_alloc_pages is used to allcoated memory for smmu
> translation tables. updating function to allocate memory/pages
> from the proximity domain of SMMU device.

AFAICS, data->pgd_size always works out to a power-of-two number of
pages, so I'm not sure why we've ever needed alloc_pages_exact() here. I
think we could simply use alloc_pages_node() and drop patch #1.

Robin.

> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index e8018a3..f6d01f6 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -215,8 +215,10 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
>  {
>  	struct device *dev = cfg->iommu_dev;
>  	dma_addr_t dma;
> -	void *pages = alloc_pages_exact(size, gfp | __GFP_ZERO);
> +	void *pages;
>  
> +	pages = alloc_pages_exact_nid(dev_to_node(dev), size,
> +			gfp | __GFP_ZERO);
>  	if (!pages)
>  		return NULL;
>  
> 
