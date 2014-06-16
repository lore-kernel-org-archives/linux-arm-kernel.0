From: minchan@kernel.org (Minchan Kim)
Date: Mon, 16 Jun 2014 15:27:19 +0900
Subject: [PATCH v3 -next 1/9] DMA, CMA: fix possible memory leak
In-Reply-To: <1402897251-23639-2-git-send-email-iamjoonsoo.kim@lge.com>
References: <1402897251-23639-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402897251-23639-2-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <20140616062719.GA18790@bbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Joonsoo

On Mon, Jun 16, 2014 at 02:40:43PM +0900, Joonsoo Kim wrote:
> We should free memory for bitmap when we find zone mis-match,
> otherwise this memory will leak.
> 
> Additionally, I copy code comment from PPC KVM's CMA code to inform
> why we need to check zone mis-match.
> 
> * Note
> Minchan suggested to add a tag for the stable, but, I don't do it,
> because I found this possibility during code-review and, IMO,
> this patch isn't suitable for stable tree.

Nice idea to put the comment in here. Thanks Joonsoo.

It seems you obey "It must fix a real bug that bothers people"
on Documentation/stable_kernel_rules.txt but it's a really obvious
bug and hard to get a report from people because limited user and
hard to detect small such small memory leak.

In my experince, Andrew perfered stable marking for such a obvious
problem but simple fix like this but not sure so let's pass the decision
to him and will learn a lesson from him and will follow the decision
from now on.

Thanks.

Acked-by: Minchan Kim <minchan@kernel.org>

> 
> Acked-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> Reviewed-by: Michal Nazarewicz <mina86@mina86.com>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> index 83969f8..6467c91 100644
> --- a/drivers/base/dma-contiguous.c
> +++ b/drivers/base/dma-contiguous.c
> @@ -176,14 +176,24 @@ static int __init cma_activate_area(struct cma *cma)
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
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo at kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email at kvack.org </a>

-- 
Kind regards,
Minchan Kim
