From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 26 Oct 2016 18:24:03 +0100
Subject: [PATCH 1/2] ARM: dma-mapping: Support cache sync after
 arm_dma_get_sgtable
In-Reply-To: <1477501448-30915-2-git-send-email-thierry.escande@collabora.com>
References: <1477501448-30915-1-git-send-email-thierry.escande@collabora.com>
 <1477501448-30915-2-git-send-email-thierry.escande@collabora.com>
Message-ID: <3c46b9df-7024-82bf-6360-01663a5edf43@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/10/16 18:04, Thierry Escande wrote:
> From: Heng-Ruey Hsu <henryhsu@chromium.org>
> 
> Currently arm_dma_sync_sg_* require dma_address to do cache sync. But
> dma address is set by map_sg(). We can't do cache sync after
> arm_dma_get_sgtable. The behavior is different from iommu_ops.
> 
> We don't have to get dma address in arm_dma_sync_sg_* and convert the
> address to physical address in arm_dma_sync_single_*. With this change
> sg_page() is used to get physical address and do sync directly.
> 
> Signed-off-by: Heng-Ruey Hsu <henryhsu@chromium.org>
> Tested-by: Heng-ruey Hsu <henryhsu@chromium.org>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> ---
>  arch/arm/mm/dma-mapping.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index ab4f745..dc42ca6 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1120,13 +1120,11 @@ void arm_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
>  void arm_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
>  			int nents, enum dma_data_direction dir)
>  {
> -	struct dma_map_ops *ops = get_dma_ops(dev);
>  	struct scatterlist *s;
>  	int i;
>  
>  	for_each_sg(sg, s, nents, i)
> -		ops->sync_single_for_cpu(dev, sg_dma_address(s), s->length,
> -					 dir);
> +		__dma_page_dev_to_cpu(sg_page(s), s->offset, s->length, dir);

This breaks dmabounce. The .sync_single_for_cpu implementation there is
non-trivial.

Robin.

>  }
>  
>  /**
> @@ -1139,13 +1137,11 @@ void arm_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
>  void arm_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
>  			int nents, enum dma_data_direction dir)
>  {
> -	struct dma_map_ops *ops = get_dma_ops(dev);
>  	struct scatterlist *s;
>  	int i;
>  
>  	for_each_sg(sg, s, nents, i)
> -		ops->sync_single_for_device(dev, sg_dma_address(s), s->length,
> -					    dir);
> +		__dma_page_cpu_to_dev(sg_page(s), s->offset, s->length, dir);
>  }
>  
>  /*
> 
