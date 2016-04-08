From: yong.wu@mediatek.com (Yong Wu)
Date: Fri, 8 Apr 2016 13:32:48 +0800
Subject: [PATCH 4/5] iommu/dma: Finish optimising higher-order allocations
In-Reply-To: <89763f6b1ac684c3d8712e38760bec55b7885e3b.1460048991.git.robin.murphy@arm.com>
References: <cover.1460048991.git.robin.murphy@arm.com>
 <89763f6b1ac684c3d8712e38760bec55b7885e3b.1460048991.git.robin.murphy@arm.com>
Message-ID: <1460093568.18911.6.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-04-07 at 18:42 +0100, Robin Murphy wrote:
>  		/*
> @@ -215,8 +221,9 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
>  		 * than a necessity, hence using __GFP_NORETRY until
>  		 * falling back to single-page allocations.
>  		 */
> -		for (order = min_t(unsigned int, order, __fls(count));
> -		     order > 0; order--) {
> +		for (pgsize_orders &= (2U << __fls(count)) - 1;
> +		     (order = __fls(pgsize_orders)) > min_order;
> +		     pgsize_orders &= (1U << order) - 1) {
>  			page = alloc_pages(gfp | __GFP_NORETRY, order);
>  			if (!page)
>  				continue;
> @@ -230,7 +237,7 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
>  			}
>  		}
>  		if (!page)
> -			page = alloc_page(gfp);
> +			page = alloc_pages(gfp, order);

A small question: Do we need split it too if order != 0 here?


>  		if (!page) {
>  			__iommu_dma_free_pages(pages, i);
>  			return NULL;
[...]
