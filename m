From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 29 May 2014 09:34:43 +0200
Subject: [PATCH] CMA: correct unlock target
In-Reply-To: <1401344958-3790-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1401344958-3790-1-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <5386E313.6070705@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-05-29 08:29, Joonsoo Kim wrote:
> 'cma: Remove potential deadlock situation' introduces per cma area mutex
> for bitmap management. It is good, but there is one mistake. When we
> can't find appropriate area in bitmap, we release cma_mutex global lock
> rather than cma->lock and this is a bug. So fix it.
>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Thanks for spotting this issue. I've added it to my tree.

> diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> index 6f6bffc..83969f8 100644
> --- a/drivers/base/dma-contiguous.c
> +++ b/drivers/base/dma-contiguous.c
> @@ -331,7 +331,7 @@ struct page *dma_alloc_from_contiguous(struct device *dev, int count,
>   		pageno = bitmap_find_next_zero_area(cma->bitmap, cma->count,
>   						    start, count, mask);
>   		if (pageno >= cma->count) {
> -			mutex_unlock(&cma_mutex);
> +			mutex_unlock(&cma->lock);
>   			break;
>   		}
>   		bitmap_set(cma->bitmap, pageno, count);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
