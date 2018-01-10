From: hch@lst.de (Christoph Hellwig)
Date: Wed, 10 Jan 2018 16:32:26 +0100
Subject: [PATCH 31/33] dma-direct: reject too small dma masks
In-Reply-To: <0bcca030-a8da-c34a-a905-707986689f33@arm.com>
References: <20180110080027.13879-1-hch@lst.de>
 <20180110080027.13879-32-hch@lst.de>
 <0bcca030-a8da-c34a-a905-707986689f33@arm.com>
Message-ID: <20180110153226.GE17790@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 11:49:34AM +0000, Robin Murphy wrote:
>> +#ifdef CONFIG_ZONE_DMA
>> +	if (mask < DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
>> +		return 0;
>> +#else
>> +	/*
>> +	 * Because 32-bit DMA masks are so common we expect every architecture
>> +	 * to be able to satisfy them - either by not supporting more physical
>> +	 * memory, or by providing a ZONE_DMA32.  If neither is the case, the
>> +	 * architecture needs to use an IOMMU instead of the direct mapping.
>> +	 */
>> +	if (mask < DMA_BIT_MASK(32))
>> +		return 0;
>
> Do you think it's worth the effort to be a little more accommodating here? 
> i.e.:
>
> 		return dma_max_pfn(dev) >= max_pfn;
>
> We seem to have a fair few 28-31 bit masks for older hardware which 
> probably associates with host systems packing equivalently small amounts of 
> RAM.

And those devices don't have a ZONE_DMA?  I think we could do something
like that, but I'd rather have it as a separate commit with a good
explanation.  Maybe you can just send on on top of the series?
