From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 11 Jan 2017 14:24:34 +0000
Subject: [PATCH] arm64: Add support for DMA_ATTR_SKIP_CPU_SYNC attribute
 to swiotlb
In-Reply-To: <1484129477-24121-1-git-send-email-geert+renesas@glider.be>
References: <1484129477-24121-1-git-send-email-geert+renesas@glider.be>
Message-ID: <5f4cda9e-9f23-afe1-b191-fbed208b04d0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/17 10:11, Geert Uytterhoeven wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> This patch adds support for DMA_ATTR_SKIP_CPU_SYNC attribute for
> dma_{un}map_{page,sg} functions family to swiotlb.
> 
> DMA_ATTR_SKIP_CPU_SYNC allows platform code to skip synchronization of
> the CPU cache for the given buffer assuming that it has been already
> transferred to 'device' domain.
> 
> Ported from IOMMU .{un}map_{sg,page} ops.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Add Acked-by.
> 
> Support for DMA_ATTR_SKIP_CPU_SYNC was included when porting the IOMMU
> ops from arm to arm64 in commit 13b8629f651164d7 ("arm64: Add IOMMU
> dma_ops").
> 
> Presumably it was an oversight that the existing swiotlb based
> implementation didn't have support for DMA_ATTR_SKIP_CPU_SYNC yet?

Less an oversight, more that nobody's wanted to use it until now ;)

Personally I'd prefer flag tests to be "!(x)" rather than "(x) == 0",
but the latter is already in place, so I'll leave the final word on
style/consistency nitpicks to Catalin and Will.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> ---
>  arch/arm64/mm/dma-mapping.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index e04082700bb16c35..1d7d5d2881db7c19 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -211,7 +211,8 @@ static dma_addr_t __swiotlb_map_page(struct device *dev, struct page *page,
>  	dma_addr_t dev_addr;
>  
>  	dev_addr = swiotlb_map_page(dev, page, offset, size, dir, attrs);
> -	if (!is_device_dma_coherent(dev))
> +	if (!is_device_dma_coherent(dev) &&
> +	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
>  		__dma_map_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
>  
>  	return dev_addr;
> @@ -222,7 +223,8 @@ static void __swiotlb_unmap_page(struct device *dev, dma_addr_t dev_addr,
>  				 size_t size, enum dma_data_direction dir,
>  				 unsigned long attrs)
>  {
> -	if (!is_device_dma_coherent(dev))
> +	if (!is_device_dma_coherent(dev) &&
> +	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
>  		__dma_unmap_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
>  	swiotlb_unmap_page(dev, dev_addr, size, dir, attrs);
>  }
> @@ -235,7 +237,8 @@ static int __swiotlb_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
>  	int i, ret;
>  
>  	ret = swiotlb_map_sg_attrs(dev, sgl, nelems, dir, attrs);
> -	if (!is_device_dma_coherent(dev))
> +	if (!is_device_dma_coherent(dev) &&
> +	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
>  		for_each_sg(sgl, sg, ret, i)
>  			__dma_map_area(phys_to_virt(dma_to_phys(dev, sg->dma_address)),
>  				       sg->length, dir);
> @@ -251,7 +254,8 @@ static void __swiotlb_unmap_sg_attrs(struct device *dev,
>  	struct scatterlist *sg;
>  	int i;
>  
> -	if (!is_device_dma_coherent(dev))
> +	if (!is_device_dma_coherent(dev) &&
> +	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
>  		for_each_sg(sgl, sg, nelems, i)
>  			__dma_unmap_area(phys_to_virt(dma_to_phys(dev, sg->dma_address)),
>  					 sg->length, dir);
> 
