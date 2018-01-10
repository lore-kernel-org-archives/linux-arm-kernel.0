From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 10 Jan 2018 11:59:30 +0000
Subject: [PATCH 20/33] dma-mapping: clear harmful GFP_* flags in common
 code
In-Reply-To: <20180110080027.13879-21-hch@lst.de>
References: <20180110080027.13879-1-hch@lst.de>
 <20180110080027.13879-21-hch@lst.de>
Message-ID: <27b90341-f9d0-356f-0194-1c7203a3f93e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/18 08:00, Christoph Hellwig wrote:
[...]
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 9f28b2fa329e..88bcb1a8211d 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -518,6 +518,13 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
>   	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
>   		return cpu_addr;
>   
> +	/*
> +	 * Let the implementation decide on the zone to allocate from, and
> +	 * decide on the way of zeroing the memory given that the memory
> +	 * returned should always be zeroed.
> +	 */

Just a note that if we're all happy to enshrine the "allocations are 
always zeroed" behaviour in the API (I am too, for the record), we 
should remember to follow up once the dust settles to update the docs 
and I guess just #define dma_zalloc_coherent dma_alloc_coherent.

Robin.

> +	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM | __GFP_ZERO);
> +
>   	if (!arch_dma_alloc_attrs(&dev, &flag))
>   		return NULL;
>   	if (!ops->alloc)
> 
