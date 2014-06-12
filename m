From: aneesh.kumar@linux.vnet.ibm.com (Aneesh Kumar K.V)
Date: Thu, 12 Jun 2014 10:13:04 +0530
Subject: [PATCH v2 02/10] DMA, CMA: fix possible memory leak
In-Reply-To: <1402543307-29800-3-git-send-email-iamjoonsoo.kim@lge.com>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-3-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <87vbs6pwkn.fsf@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joonsoo Kim <iamjoonsoo.kim@lge.com> writes:

> We should free memory for bitmap when we find zone mis-match,
> otherwise this memory will leak.
>
> Additionally, I copy code comment from ppc kvm's cma code to notify
> why we need to check zone mis-match.
>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

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
