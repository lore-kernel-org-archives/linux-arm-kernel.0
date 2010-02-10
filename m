From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Wed, 10 Feb 2010 15:28:17 -0800
Subject: [RFC 0/2] fix dma_map_sg not to do barriers for each buffer
In-Reply-To: <20100210212156.GB30854@n2100.arm.linux.org.uk>
References: <1265834250-29170-1-git-send-email-adharmap@codeaurora.org>
	<20100210212156.GB30854@n2100.arm.linux.org.uk>
Message-ID: <4B734111.6070206@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Wed, Feb 10, 2010 at 12:37:28PM -0800, adharmap at codeaurora.org wrote:
>> From: Abhijeet Dharmapurikar <adharmap@quicinc.com>
>>
>> Please refer to the post here
>> http://lkml.org/lkml/2010/1/4/347
>>
>> These changes are to introduce barrierless dma_map_area and dma_unmap_area and
>> use them to map the buffers in the scatterlist. For the last buffer, call
>> the normal dma_map_area(aka with barriers) effectively executing the barrier
>> at the end of the operation.
> 
> What if we make dma_map_area and dma_unmap_area both be barrier-less,
> and instead have a separate dma_barrier method - eg, something like the
> attached?
> 
> This might allow for better I-cache usage by not having to duplicate the
> DMA cache coherence functions.

Agree, thanks for pointing this and for the patch.


> 
> @@ -369,6 +372,7 @@ static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
>  	BUG_ON(!valid_dma_direction(dir));
>  
>  	__dma_page_cpu_to_dev(page, offset, size, dir);
> +	__dma_barrier(dir);
>  
>  	return page_to_dma(dev, page) + offset;
>  }

dma_map_page is going to execute the barrier here.


>  /**
>   * dma_map_sg - map a set of SG buffers for streaming mode DMA
>   * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
> @@ -537,6 +544,9 @@ int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>  		if (dma_mapping_error(dev, s->dma_address))
>  			goto bad_mapping;
>  	}
> +
> +	__dma_barrier(dir);
> +
>  	return nents;

This would call the barrier in addition to the ones executed by 
dma_map_page.

We would need to call __dma_page_cpu_to_dev instead of dma_map_page and 
do the barrier before returning.
