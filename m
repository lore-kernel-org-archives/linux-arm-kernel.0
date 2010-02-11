From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Thu, 11 Feb 2010 13:36:27 -0800
Subject: [RFC 0/2] fix dma_map_sg not to do barriers for each buffer
In-Reply-To: <20100210235700.GD30854@n2100.arm.linux.org.uk>
References: <1265834250-29170-1-git-send-email-adharmap@codeaurora.org>	<20100210212156.GB30854@n2100.arm.linux.org.uk>	<4B734111.6070206@codeaurora.org>
	<20100210235700.GD30854@n2100.arm.linux.org.uk>
Message-ID: <4B74785B.8040809@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>  }
> @@ -363,7 +366,7 @@ static inline dma_addr_t dma_map_single(struct device *dev, void *cpu_addr,
>   * The device owns this memory once this call has completed.  The CPU
>   * can regain ownership by calling dma_unmap_page().
>   */
> -static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
> +static inline dma_addr_t __dma_map_page(struct device *dev, struct page *page,
>  	     unsigned long offset, size_t size, enum dma_data_direction dir)
>  {
>  	BUG_ON(!valid_dma_direction(dir));
> @@ -373,6 +376,14 @@ static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
>  	return page_to_dma(dev, page) + offset;
>  }
>  
> +static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
> +	     unsigned long offset, size_t size, enum dma_data_direction dir)
> +{
> +	dma_addr_t addr = __dma_map_page(page, offset, size, dir);
> +	__dma_barrier(dir);
> +	return addr;
> +}
> +
>  /**
.
.
.
.
>  /**
>   * dma_map_sg - map a set of SG buffers for streaming mode DMA
>   * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
> @@ -532,11 +539,14 @@ int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>  	int i, j;
>  
>  	for_each_sg(sg, s, nents, i) {
> -		s->dma_address = dma_map_page(dev, sg_page(s), s->offset,
> +		s->dma_address = __dma_map_page(dev, sg_page(s), s->offset,
>  						s->length, dir);
>  		if (dma_mapping_error(dev, s->dma_address))
>  			goto bad_mapping;
>  	}
> +
> +	__dma_barrier(dir);
> +
>  	return nents;
>  
>   bad_mapping:
> @@ -564,6 +574,8 @@ void dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
>  
>  	for_each_sg(sg, s, nents, i)
>  		dma_unmap_page(dev, sg_dma_address(s), sg_dma_len(s), dir);
> +
> +	__dma_barrier(dir);
>  }
>  EXPORT_SYMBOL(dma_unmap_sg);

dma_unmap_sg too could use indirection like dma_map_sg.

Thanks for the patch.
Abhijeet
