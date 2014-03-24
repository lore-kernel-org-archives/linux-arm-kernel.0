From: mina86@mina86.com (Michal Nazarewicz)
Date: Mon, 24 Mar 2014 15:11:41 +0100
Subject: [BUG] Circular locking dependency - DRM/CMA/MM/hotplug/...
In-Reply-To: <532C8941.4090104@codeaurora.org>
References: <20140211183543.GK26684@n2100.arm.linux.org.uk>
 <52FB9602.1000805@samsung.com>
 <20140212163317.GQ26684@n2100.arm.linux.org.uk>
 <53036D51.2070502@samsung.com> <xa1t8ut8wc2f.fsf@mina86.com>
 <532C8941.4090104@codeaurora.org>
Message-ID: <xa1tlhvzn0te.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21 2014, Laura Abbott wrote:
> From: Laura Abbott <lauraa@codeaurora.org>
> Date: Tue, 25 Feb 2014 11:01:19 -0800
> Subject: [PATCH] cma: Remove potential deadlock situation
>
> CMA locking is currently very coarse. The cma_mutex protects both
> the bitmap and avoids concurrency with alloc_contig_range. There
> are several situations which may result in a deadlock on the CMA
> mutex currently, mostly involving AB/BA situations with alloc and
> free. Fix this issue by protecting the bitmap with a mutex per CMA
> region and use the existing mutex for protecting against concurrency
> with alloc_contig_range.
>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

Furthermore, since CMA regions are always MAX_ORDER-page or pageblock
(whichever is bigger) aligned, we could use two mutexes per CMA region:
one protecting the bitmap and the other one protecting calls to
alloc_contig_range touching given region.

On the other hand, we could also go the other way and have two global
mutexes: one protecting all the bitmaps in all the regions and another
protecting calls to alloc_contig_range.

Either way, I think the below patch should work and fix the problem.

> ---
>  drivers/base/dma-contiguous.c | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> index 165c2c2..dfb48ef 100644
> --- a/drivers/base/dma-contiguous.c
> +++ b/drivers/base/dma-contiguous.c
> @@ -37,6 +37,7 @@ struct cma {
>  	unsigned long	base_pfn;
>  	unsigned long	count;
>  	unsigned long	*bitmap;
> +	struct mutex	lock;
>  };
>  
>  struct cma *dma_contiguous_default_area;
> @@ -161,6 +162,7 @@ static int __init cma_activate_area(struct cma *cma)
>  		init_cma_reserved_pageblock(pfn_to_page(base_pfn));
>  	} while (--i);
>  
> +	mutex_init(&cma->lock);
>  	return 0;
>  }
>  
> @@ -261,6 +263,13 @@ err:
>  	return ret;
>  }
>  
> +static void clear_cma_bitmap(struct cma *cma, unsigned long pfn, int count)
> +{
> +	mutex_lock(&cma->lock);
> +	bitmap_clear(cma->bitmap, pfn - cma->base_pfn, count);
> +	mutex_unlock(&cma->lock);
> +}
> +
>  /**
>   * dma_alloc_from_contiguous() - allocate pages from contiguous area
>   * @dev:   Pointer to device for which the allocation is performed.
> @@ -294,30 +303,41 @@ struct page *dma_alloc_from_contiguous(struct device *dev, int count,
>  
>  	mask = (1 << align) - 1;
>  
> -	mutex_lock(&cma_mutex);
>  
>  	for (;;) {
> +		mutex_lock(&cma->lock);
>  		pageno = bitmap_find_next_zero_area(cma->bitmap, cma->count,
>  						    start, count, mask);
> -		if (pageno >= cma->count)
> +		if (pageno >= cma->count) {
> +			mutex_unlock(&cma_mutex);
>  			break;
> +		}
> +		bitmap_set(cma->bitmap, pageno, count);
> +		/*
> +		 * It's safe to drop the lock here. We've marked this region for
> +		 * our exclusive use. If the migration fails we will take the
> +		 * lock again and unmark it.
> +		 */
> +		mutex_unlock(&cma->lock);
>  
>  		pfn = cma->base_pfn + pageno;
> +		mutex_lock(&cma_mutex);
>  		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA);
> +		mutex_unlock(&cma_mutex);
>  		if (ret == 0) {
> -			bitmap_set(cma->bitmap, pageno, count);
>  			page = pfn_to_page(pfn);
>  			break;
>  		} else if (ret != -EBUSY) {
> +			clear_cma_bitmap(cma, pfn, count);
>  			break;
>  		}
> +		clear_cma_bitmap(cma, pfn, count);
>  		pr_debug("%s(): memory range at %p is busy, retrying\n",
>  			 __func__, pfn_to_page(pfn));
>  		/* try again with a bit different memory target */
>  		start = pageno + mask + 1;
>  	}
>  
> -	mutex_unlock(&cma_mutex);
>  	pr_debug("%s(): returned %p\n", __func__, page);
>  	return page;
>  }
> @@ -350,10 +370,8 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
>  
>  	VM_BUG_ON(pfn + count > cma->base_pfn + cma->count);
>  
> -	mutex_lock(&cma_mutex);
> -	bitmap_clear(cma->bitmap, pfn - cma->base_pfn, count);
>  	free_contig_range(pfn, count);
> -	mutex_unlock(&cma_mutex);
> +	clear_cma_bitmap(cma, pfn, count);
>  
>  	return true;
>  }
> -- 
> Code Aurora Forum chooses to take this file under the GPL v 2 license only.
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 835 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140324/bfcfa73d/attachment.sig>
