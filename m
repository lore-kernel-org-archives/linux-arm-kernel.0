From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 21 Nov 2012 11:00:19 +0100
Subject: [PATCH V4 1/3] arm: dma mapping: Export a dma ops function
 arm_dma_set_mask
In-Reply-To: <1353490783-23101-2-git-send-email-gregory.clement@free-electrons.com>
References: <1353490783-23101-1-git-send-email-gregory.clement@free-electrons.com>
 <1353490783-23101-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <50ACA633.7020207@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 11/21/2012 10:39 AM, Gregory CLEMENT wrote:
> Expose another DMA operations function: arm_dma_set_mask. This
> function will be added to a custom DMA ops for Armada 370/XP.
> Depending of its configuration Armada 370/XP can be set as a "nearly"
> coherent architecture. In this case the DMA ops is made of:
> - specific functions for this architecture
> - already exposed arm DMA related functions
> - the arm_dma_set_mask which was not exposed yet.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   arch/arm/include/asm/dma-mapping.h |    2 ++
>   arch/arm/mm/dma-mapping.c          |    4 +---
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> index 2300484..98d4dab 100644
> --- a/arch/arm/include/asm/dma-mapping.h
> +++ b/arch/arm/include/asm/dma-mapping.h
> @@ -111,6 +111,8 @@ static inline void dma_free_noncoherent(struct device *dev, size_t size,
>   
>   extern int dma_supported(struct device *dev, u64 mask);
>   
> +extern int arm_dma_set_mask(struct device *dev, u64 dma_mask);
> +
>   /**
>    * arm_dma_alloc - allocate consistent memory for DMA
>    * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 58bc3e4..5383bc0 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -124,8 +124,6 @@ static void arm_dma_sync_single_for_device(struct device *dev,
>   	__dma_page_cpu_to_dev(page, offset, size, dir);
>   }
>   
> -static int arm_dma_set_mask(struct device *dev, u64 dma_mask);
> -
>   struct dma_map_ops arm_dma_ops = {
>   	.alloc			= arm_dma_alloc,
>   	.free			= arm_dma_free,
> @@ -971,7 +969,7 @@ int dma_supported(struct device *dev, u64 mask)
>   }
>   EXPORT_SYMBOL(dma_supported);
>   
> -static int arm_dma_set_mask(struct device *dev, u64 dma_mask)
> +int arm_dma_set_mask(struct device *dev, u64 dma_mask)
>   {
>   	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
>   		return -EIO;

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
