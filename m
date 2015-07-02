From: human.hwang@samsung.com (Hyungwon Hwang)
Date: Thu, 02 Jul 2015 09:50:07 +0900
Subject: [PATCH v2] arm: dma-mapping: fix off-by-one error in bitmap size
 check
In-Reply-To: <1435758406-6989-1-git-send-email-m.szyprowski@samsung.com>
References: <1435754903-25108-1-git-send-email-m.szyprowski@samsung.com>
 <1435758406-6989-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20150702095007.1d20ed75@hwh-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Marek,

On Wed, 01 Jul 2015 15:46:38 +0200
Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> nr_bitmaps member of mapping structure stores the number of already
> allocated bitmaps and it is interpreted as loop iterator (it starts
> from 0 not from 1), so a comparison against number of possible bitmap
> extensions should include this fact. This patch fixes this by changing
> the extension failure condition. This issue has been introduced by
> commit 4d852ef8c2544ce21ae41414099a7504c61164a0 ("arm: dma-mapping:
> Add support to extend DMA IOMMU mappings").
> 
> Reported-by: Hyungwon Hwang <human.hwang@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> CC: stable at vger.kernel.org  # v3.15+
> ---
> V2 fixed build problem caused by a hurry in patch preparation. My
> fault. I'm really sorry for the noise.
> 
> Best regards
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> ---
>  arch/arm/mm/dma-mapping.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index a64b7f621067..05619542a1c0 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -2015,7 +2015,7 @@ static int extend_iommu_mapping(struct
> dma_iommu_mapping *mapping) {
>  	int next_bitmap;
>  
> -	if (mapping->nr_bitmaps > mapping->extensions)
> +	if (mapping->nr_bitmaps >= mapping->extensions)
>  		return -EINVAL;
>  
>  	next_bitmap = mapping->nr_bitmaps;

With this patch, the error disappeared on my private arm board. Also,
the fix is clearly reasonable.

Reviewed-by: Hyungwon Hwang <human.hwang@samsung.com>
