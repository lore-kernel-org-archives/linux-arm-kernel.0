From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 5 Apr 2016 12:16:10 +0100
Subject: [PATCH 1/2] iommu/dma: Restore scatterlist offsets correctly
In-Reply-To: <c14a93373a34633f6db89214ca2ddf69b0eaa1c3.1457637385.git.robin.murphy@arm.com>
References: <c14a93373a34633f6db89214ca2ddf69b0eaa1c3.1457637385.git.robin.murphy@arm.com>
Message-ID: <57039E7A.3090709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/16 19:28, Robin Murphy wrote:
> With the change to stashing just the IOVA-page-aligned remainder of the
> CPU-page offset rather than the whole thing, the failure path in
> __invalidate_sg() also needs tweaking to account for that in the case of
> differing page sizes where the two offsets may not be equivalent.
> Similarly in __finalise_sg(), lest the architecture-specific wrappers
> later get the wrong address for cache maintenance on sync or unmap.
>
> Fixes: 164afb1d85b8 ("iommu/dma: Use correct offset in map_sg")
> Reported-by: Magnus Damm <damm+renesas@opensource.se>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/dma-iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 72d6182..58f2fe6 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -403,7 +403,7 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
>   		unsigned int s_length = sg_dma_len(s);
>   		unsigned int s_dma_len = s->length;
>
> -		s->offset = s_offset;
> +		s->offset += s_offset;
>   		s->length = s_length;
>   		sg_dma_address(s) = dma_addr + s_offset;
>   		dma_addr += s_dma_len;
> @@ -422,7 +422,7 @@ static void __invalidate_sg(struct scatterlist *sg, int nents)
>
>   	for_each_sg(sg, s, nents, i) {
>   		if (sg_dma_address(s) != DMA_ERROR_CODE)
> -			s->offset = sg_dma_address(s);
> +			s->offset += sg_dma_address(s);
>   		if (sg_dma_len(s))
>   			s->length = sg_dma_len(s);
>   		sg_dma_address(s) = DMA_ERROR_CODE;
>

Any comments on these patches? Now that the dust has settled this fix 
really wants to get into 4.6, and folks have been wanting patch 2 for 
ages so it would be nice to get it queued for 4.7.

Robin.
