From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 29 Jan 2013 13:47:26 +0100
Subject: [v2 1/1] ARM: dma-mapping: Call arm_dma_set_mask() if no
 ->set_dma_mask()
In-Reply-To: <1359462438-21006-1-git-send-email-hdoyu@nvidia.com>
References: <5107B301.2060802@samsung.com>
 <1359462438-21006-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <5107C4DE.7060607@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 1/29/2013 1:27 PM, Hiroshi Doyu wrote:
> struct dma_map_ops iommu_ops doesn't have ->set_dma_mask, which causes
> crash when dma_set_mask() is called from some driver.
>
> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> ---
>   arch/arm/include/asm/dma-mapping.h |   11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> index 5b579b9..63cc49c 100644
> --- a/arch/arm/include/asm/dma-mapping.h
> +++ b/arch/arm/include/asm/dma-mapping.h
> @@ -14,6 +14,7 @@
>   #define DMA_ERROR_CODE	(~0)
>   extern struct dma_map_ops arm_dma_ops;
>   extern struct dma_map_ops arm_coherent_dma_ops;
> +extern int arm_dma_set_mask(struct device *dev, u64 dma_mask);
>   
>   static inline struct dma_map_ops *get_dma_ops(struct device *dev)
>   {
> @@ -32,7 +33,13 @@ static inline void set_dma_ops(struct device *dev, struct dma_map_ops *ops)
>   
>   static inline int dma_set_mask(struct device *dev, u64 mask)
>   {
> -	return get_dma_ops(dev)->set_dma_mask(dev, mask);
> +	struct dma_map_ops *ops = get_dma_ops(dev);
> +	BUG_ON(!ops);
> +
> +	if (ops->set_dma_mask)
> +		return ops->set_dma_mask(dev, mask);
> +
> +	return arm_dma_set_mask(dev, mask);
>   }
>   
>   #ifdef __arch_page_to_dma
> @@ -112,8 +119,6 @@ static inline void dma_free_noncoherent(struct device *dev, size_t size,
>   
>   extern int dma_supported(struct device *dev, u64 mask);
>   
> -extern int arm_dma_set_mask(struct device *dev, u64 dma_mask);
> -
>   /**
>    * arm_dma_alloc - allocate consistent memory for DMA
>    * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices

It can be done much simpler, please just add '.set_dma_mask = 
arm_dma_set_mask,'
to iommu_ops declaration. There is no point complicating the header files.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
