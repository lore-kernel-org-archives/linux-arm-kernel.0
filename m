From: minchan@kernel.org (Minchan Kim)
Date: Thu, 12 Jun 2014 14:25:43 +0900
Subject: [PATCH v2 02/10] DMA, CMA: fix possible memory leak
In-Reply-To: <1402543307-29800-3-git-send-email-iamjoonsoo.kim@lge.com>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-3-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <20140612052543.GE12415@bbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 12:21:39PM +0900, Joonsoo Kim wrote:
> We should free memory for bitmap when we find zone mis-match,
> otherwise this memory will leak.

Then, -stable stuff?

> 
> Additionally, I copy code comment from ppc kvm's cma code to notify
> why we need to check zone mis-match.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> index bd0bb81..fb0cdce 100644
> --- a/drivers/base/dma-contiguous.c
> +++ b/drivers/base/dma-contiguous.c
> @@ -177,14 +177,24 @@ static int __init cma_activate_area(struct cma *cma)
>  		base_pfn = pfn;
>  		for (j = pageblock_nr_pages; j; --j, pfn++) {
>  			WARN_ON_ONCE(!pfn_valid(pfn));
> +			/*
> +			 * alloc_contig_range requires the pfn range
> +			 * specified to be in the same zone. Make this
> +			 * simple by forcing the entire CMA resv range
> +			 * to be in the same zone.
> +			 */
>  			if (page_zone(pfn_to_page(pfn)) != zone)
> -				return -EINVAL;
> +				goto err;

At a first glance, I thought it would be better to handle such error
before activating.
So when I see the registration code(ie, dma_contiguous_revere_area),
I realized it is impossible because we didn't set up zone yet. :(

If so, when we detect to fail here, it would be better to report more
meaningful error message like what was successful zone and what is
new zone and failed pfn number?

>  		}
>  		init_cma_reserved_pageblock(pfn_to_page(base_pfn));
>  	} while (--i);
>  
>  	mutex_init(&cma->lock);
>  	return 0;
> +
> +err:
> +	kfree(cma->bitmap);
> +	return -EINVAL;
>  }
>  
>  static struct cma cma_areas[MAX_CMA_AREAS];
> -- 
> 1.7.9.5

-- 
Kind regards,
Minchan Kim
