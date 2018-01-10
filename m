From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 10 Jan 2018 12:06:22 +0000
Subject: [PATCH 27/33] dma-direct: use node local allocations for coherent
 memory
In-Reply-To: <20180110080027.13879-28-hch@lst.de>
References: <20180110080027.13879-1-hch@lst.de>
 <20180110080027.13879-28-hch@lst.de>
Message-ID: <3672aa56-b85c-5d2c-0c0e-709031b0c0a0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/18 08:00, Christoph Hellwig wrote:
> To preserve the x86 behavior.

And combined with patch 10/22 of the SWIOTLB refactoring, this means 
SWIOTLB allocations will also end up NUMA-aware, right? Great, that's 
what we want on arm64 too :)

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   lib/dma-direct.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/dma-direct.c b/lib/dma-direct.c
> index a9ae98be7af3..f04a424f91fa 100644
> --- a/lib/dma-direct.c
> +++ b/lib/dma-direct.c
> @@ -38,7 +38,7 @@ static void *dma_direct_alloc(struct device *dev, size_t size,
>   	if (gfpflags_allow_blocking(gfp))
>   		page = dma_alloc_from_contiguous(dev, count, page_order, gfp);
>   	if (!page)
> -		page = alloc_pages(gfp, page_order);
> +		page = alloc_pages_node(dev_to_node(dev), gfp, page_order);
>   	if (!page)
>   		return NULL;
>   
> 
