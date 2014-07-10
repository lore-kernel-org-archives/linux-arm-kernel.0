From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 Jul 2014 12:12:59 +0100
Subject: [PATCH] ARM: mm: fix the boundary checking on bitmaps
In-Reply-To: <1404959313-15198-1-git-send-email-haojian.zhuang@linaro.org>
References: <1404959313-15198-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20140710111259.GL2449@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 03:28:33AM +0100, Haojian Zhuang wrote:
> The issue of boundary checking on bitmaps is introduced by this commit
> in below.
> 
> commit 4d852ef8c2544ce21ae41414099a7504c61164a0
> Author: Andreas Herrmann <andreas.herrmann@calxeda.com>
> Date:   Tue Feb 25 13:09:53 2014 +0100
> 
>     arm: dma-mapping: Add support to extend DMA IOMMU mappings
> 
> Multiple bitmaps were introduced as extension. If it needs to extend
> a bitmap, it still check whether the allocation exceeding the total
> size, not current bitmap size. So change the condition from
> mapping->bits to PAGE_SIZE.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  arch/arm/mm/dma-mapping.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 4c88935..d7da5c3 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1089,9 +1089,9 @@ static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
>  	spin_lock_irqsave(&mapping->lock, flags);
>  	for (i = 0; i < mapping->nr_bitmaps; i++) {
>  		start = bitmap_find_next_zero_area(mapping->bitmaps[i],
> -				mapping->bits, 0, count, align);
> +				PAGE_SIZE, 0, count, align);

I'm probably just missing something, but what guarantees that the bitmap is
PAGE_SIZE? It looks to me like we could easily go off the end of the bitmap
if arm_iommu_create_mapping is called with a small size parameter.

Will
