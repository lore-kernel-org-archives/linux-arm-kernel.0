From: rientjes@google.com (David Rientjes)
Date: Mon, 16 Mar 2015 16:32:52 -0700 (PDT)
Subject: [PATCH] ARM: mm: Do not invoke OOM for higher order IOMMU DMA
 allocations
In-Reply-To: <1426493525-25502-1-git-send-email-tfiga@chromium.org>
References: <1426493525-25502-1-git-send-email-tfiga@chromium.org>
Message-ID: <alpine.DEB.2.10.1503161631290.20956@chino.kir.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Mar 2015, Tomasz Figa wrote:

> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 83cd5ac..f081e9e 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1145,18 +1145,31 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
>  	}
>  
>  	/*
> -	 * IOMMU can map any pages, so himem can also be used here
> +	 * IOMMU can map any pages, so himem can also be used here.
> +	 * We do not want OOM killer to be invoked as long as we can fall back
> +	 * to single pages, so we use __GFP_NORETRY for positive orders.
>  	 */
> -	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
> +	gfp |= __GFP_NOWARN | __GFP_HIGHMEM | __GFP_NORETRY;
>  
>  	while (count) {
> -		int j, order = __fls(count);
> +		int j, order;
>  
> -		pages[i] = alloc_pages(gfp, order);
> -		while (!pages[i] && order)
> -			pages[i] = alloc_pages(gfp, --order);
> -		if (!pages[i])
> -			goto error;
> +		for (order = __fls(count); order; --order) {
> +			/* Will not trigger OOM. */
> +			pages[i] = alloc_pages(gfp, order);
> +			if (pages[i])
> +				break;
> +		}
> +
> +		if (!pages[i]) {
> +			/*
> +			 * Fall back to single page allocation.
> +			 * Might invoke OOM killer as last resort.
> +			 */
> +			pages[i] = alloc_pages(gfp & ~__GFP_NORETRY, 0);
> +			if (!pages[i])
> +				goto error;
> +		}
>  
>  		if (order) {
>  			split_page(pages[i], order);

I think this makes sense, but the problem is the unconditional setting and 
clearing of __GFP_NORETRY.  Strictly speaking, gfp may already have 
__GFP_NORETRY set when calling this function so it would be better to do 
the loop with alloc_pages(gfp | __GFP_NORETRY, order) and then the 
fallback as alloc_page(gfp).
