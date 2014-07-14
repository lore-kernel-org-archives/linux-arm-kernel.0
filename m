From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 14 Jul 2014 15:02:48 +0200
Subject: [PATCH] ARM: mm: fix the boundary checking on bitmaps
In-Reply-To: <1404959313-15198-1-git-send-email-haojian.zhuang@linaro.org>
References: <1404959313-15198-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <53C3D4F8.9060001@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-07-10 04:28, Haojian Zhuang wrote:
> The issue of boundary checking on bitmaps is introduced by this commit
> in below.
>
> commit 4d852ef8c2544ce21ae41414099a7504c61164a0
> Author: Andreas Herrmann <andreas.herrmann@calxeda.com>
> Date:   Tue Feb 25 13:09:53 2014 +0100
>
>      arm: dma-mapping: Add support to extend DMA IOMMU mappings
>
> Multiple bitmaps were introduced as extension. If it needs to extend
> a bitmap, it still check whether the allocation exceeding the total
> size, not current bitmap size. So change the condition from
> mapping->bits to PAGE_SIZE.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

NACK, this patch is not correct. mapping->bits contains the correct size of
a single bitmap, see the beginning of arm_iommu_create_mapping() function.

> ---
>   arch/arm/mm/dma-mapping.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 4c88935..d7da5c3 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1089,9 +1089,9 @@ static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
>   	spin_lock_irqsave(&mapping->lock, flags);
>   	for (i = 0; i < mapping->nr_bitmaps; i++) {
>   		start = bitmap_find_next_zero_area(mapping->bitmaps[i],
> -				mapping->bits, 0, count, align);
> +				PAGE_SIZE, 0, count, align);
>   
> -		if (start > mapping->bits)
> +		if (start > PAGE_SIZE)
>   			continue;
>   
>   		bitmap_set(mapping->bitmaps[i], start, count);
> @@ -1110,9 +1110,9 @@ static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
>   		}
>   
>   		start = bitmap_find_next_zero_area(mapping->bitmaps[i],
> -				mapping->bits, 0, count, align);
> +				PAGE_SIZE, 0, count, align);
>   
> -		if (start > mapping->bits) {
> +		if (start > PAGE_SIZE) {
>   			spin_unlock_irqrestore(&mapping->lock, flags);
>   			return DMA_ERROR_CODE;
>   		}

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
