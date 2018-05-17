From: willy@infradead.org (Matthew Wilcox)
Date: Thu, 17 May 2018 11:18:15 -0700
Subject: [PATCH] mm/dmapool: localize page allocations
In-Reply-To: <1526578581-7658-1-git-send-email-okaya@codeaurora.org>
References: <1526578581-7658-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20180517181815.GC26718@bombadil.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 01:36:19PM -0400, Sinan Kaya wrote:
> Try to keep the pool closer to the device's NUMA node by changing kmalloc()
> to kmalloc_node() and devres_alloc() to devres_alloc_node().

Have you measured any performance gains by doing this?  The thing is that
these allocations are for the metadata about the page, and the page is
going to be used by CPUs in every node.  So it's not clear to me that
allocating it on the node nearest to the device is going to be any sort
of a win.

> @@ -504,7 +504,8 @@ struct dma_pool *dmam_pool_create(const char *name, struct device *dev,
>  {
>  	struct dma_pool **ptr, *pool;
>  
> -	ptr = devres_alloc(dmam_pool_release, sizeof(*ptr), GFP_KERNEL);
> +	ptr = devres_alloc_node(dmam_pool_release, sizeof(*ptr), GFP_KERNEL,
> +				dev_to_node(dev));
>  	if (!ptr)
>  		return NULL;

... are we really calling devres_alloc() for sizeof(void *)?  That's sad.
