From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Apr 2015 13:08:02 +0100
Subject: [PATCH 5/6] drm/armada: gem: Use drm_clflush_*() functions
In-Reply-To: <1428590049-20357-5-git-send-email-thierry.reding@gmail.com>
References: <1428590049-20357-1-git-send-email-thierry.reding@gmail.com>
 <1428590049-20357-5-git-send-email-thierry.reding@gmail.com>
Message-ID: <20150410120802.GE12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 09, 2015 at 04:34:08PM +0200, Thierry Reding wrote:
> diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
> index 580e10acaa3a..c2d4414031ab 100644
> --- a/drivers/gpu/drm/armada/armada_gem.c
> +++ b/drivers/gpu/drm/armada/armada_gem.c
> @@ -453,19 +453,14 @@ armada_gem_prime_map_dma_buf(struct dma_buf_attachment *attach,
>  			sg_set_page(sg, page, PAGE_SIZE, 0);
>  		}
>  
> -		if (dma_map_sg(attach->dev, sgt->sgl, sgt->nents, dir) == 0) {
> -			num = sgt->nents;
> -			goto release;
> -		}
> +		drm_clflush_sg(sgt);
>  	} else if (dobj->page) {
>  		/* Single contiguous page */
>  		if (sg_alloc_table(sgt, 1, GFP_KERNEL))
>  			goto free_sgt;
>  
>  		sg_set_page(sgt->sgl, dobj->page, dobj->obj.size, 0);
> -
> -		if (dma_map_sg(attach->dev, sgt->sgl, sgt->nents, dir) == 0)
> -			goto free_table;
> +		drm_clflush_sg(sgt);
>  	} else if (dobj->linear) {
>  		/* Single contiguous physical region - no struct page */
>  		if (sg_alloc_table(sgt, 1, GFP_KERNEL))
> @@ -480,7 +475,6 @@ armada_gem_prime_map_dma_buf(struct dma_buf_attachment *attach,
>   release:
>  	for_each_sg(sgt->sgl, sg, num, i)
>  		page_cache_release(sg_page(sg));
> - free_table:
>  	sg_free_table(sgt);
>   free_sgt:
>  	kfree(sgt);
> @@ -494,9 +488,6 @@ static void armada_gem_prime_unmap_dma_buf(struct dma_buf_attachment *attach,
>  	struct armada_gem_object *dobj = drm_to_armada_gem(obj);
>  	int i;
>  
> -	if (!dobj->linear)
> -		dma_unmap_sg(attach->dev, sgt->sgl, sgt->nents, dir);
> -

I'm really wonder where this is the right thing to do.

DMA coherency on ARMv6 and ARMv7 CPUs is not just a case of "do something
just before DMA" - it's more complicated than that because of the
speculative prefetching.

What you must remember is this:

	Any memory which is readable to the CPU may be speculatively
	prefetched by the CPU, and cache lines allocated into the L1
	and L2 caches.

What this means is that if you're doing this:

	Flush caches
	Perform DMA to buffer
	Read buffer from CPU

You may or may not see the data you expect in the buffer - it's
indeterminant, depending on how aggressive the CPU has been at
prefetching data.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
