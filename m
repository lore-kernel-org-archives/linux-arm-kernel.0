From: lauraa@codeaurora.org (Laura Abbott)
Date: Fri, 20 Jul 2012 13:30:24 -0700
Subject: [PATCH][RFC] arm: dma-mapping: Add support for allocating/mapping
 cached buffers
In-Reply-To: <009901cd63e1$2d6445b0$882cd110$%szyprowski@samsung.com>
References: <1342202506-12449-1-git-send-email-lauraa@codeaurora.org>
 <1342202506-12449-2-git-send-email-lauraa@codeaurora.org>
 <009901cd63e1$2d6445b0$882cd110$%szyprowski@samsung.com>
Message-ID: <5009BFE0.5050501@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/16/2012 10:58 PM, Marek Szyprowski wrote:
> Hi Laura,
>
> On Friday, July 13, 2012 8:02 PM Laura Abbott wrote:
>
>> There are currently no dma allocation APIs that support cached
>> buffers. For some use cases, caching provides a signficiant
>> performance boost that beats write-combining regions. Add
>> apis to allocate and map a cached DMA region.
>>
>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>
> I agree that there is a need for cached contiguous memory blocks. I see that your patch
> is based on some older version of CMA/dma-mapping code. In v3.5-rc1 CMA has been merged
> to mainline kernel together with DMA-mapping redesign patches, so an attribute approach
> can be used instead of adding new functions to the API. My original idea was to utilize
> the dma_alloc_nonconsistent() call and DMA_ATTR_NONCONSISTENT for allocating/mapping
> cached contiguous buffers, but I didn't have enough time for completing this work.
>
> The main missing piece is the API for managing cache synchronization on such buffers.
> There is a dma_cache_synch() functions but it is broken from the API point of view. To
> replace it with something better, some additional work is needed for all drivers which
> already use it. Also some work in needed for cleanup dma_alloc_nonconsistent()
> implementations for all the architectures using dma_map_ops approach. All this is on my
> TODO list, but I currently I'm really busy with other tasks related to CMA (mainly
> bugfixes for some special use-cases).
>

In what is the dma_cache_sync API broken? Just curious at this point.

Thanks,
Laura

>> ---
>>   arch/arm/include/asm/dma-mapping.h |   21 +++++++++++++++++++++
>>   arch/arm/mm/dma-mapping.c          |   21 +++++++++++++++++++++
>>   2 files changed, 42 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
>> index dc988ff..1565403 100644
>> --- a/arch/arm/include/asm/dma-mapping.h
>> +++ b/arch/arm/include/asm/dma-mapping.h
>> @@ -239,12 +239,33 @@ int dma_mmap_coherent(struct device *, struct vm_area_struct *,
>>   extern void *dma_alloc_writecombine(struct device *, size_t, dma_addr_t *,
>>   		gfp_t);
>>
>> +/**
>> + * dma_alloc_cached - allocate cached memory for DMA
>> + * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
>> + * @size: required memory size
>> + * @handle: bus-specific DMA address
>> + *
>> + * Allocate some cached memory for a device for
>> + * performing DMA.  This function allocates pages, and will
>> + * return the CPU-viewed address, and sets @handle to be the
>> + * device-viewed address.
>> + */
>> +extern void *dma_alloc_cached(struct device *, size_t, dma_addr_t *,
>> +		gfp_t);
>> +
>>   #define dma_free_writecombine(dev,size,cpu_addr,handle) \
>>   	dma_free_coherent(dev,size,cpu_addr,handle)
>>
>> +#define dma_free_cached(dev,size,cpu_addr,handle) \
>> +	dma_free_coherent(dev,size,cpu_addr,handle)
>> +
>>   int dma_mmap_writecombine(struct device *, struct vm_area_struct *,
>>   		void *, dma_addr_t, size_t);
>>
>> +
>> +int dma_mmap_cached(struct device *, struct vm_area_struct *,
>> +		void *, dma_addr_t, size_t);
>> +
>>   /*
>>    * This can be called during boot to increase the size of the consistent
>>    * DMA region above it's default value of 2MB. It must be called before the
>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> index b1911c4..f396ddc 100644
>> --- a/arch/arm/mm/dma-mapping.c
>> +++ b/arch/arm/mm/dma-mapping.c
>> @@ -633,6 +633,20 @@ dma_alloc_writecombine(struct device *dev, size_t size, dma_addr_t
>> *handle, gfp_
>>   }
>>   EXPORT_SYMBOL(dma_alloc_writecombine);
>>
>> +/*
>> + * Allocate a cached DMA region
>> + */
>> +void *
>> +dma_alloc_cached(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp)
>> +{
>> +	return __dma_alloc(dev, size, handle, gfp,
>> +			   pgprot_kernel,
>> +			   __builtin_return_address(0));
>> +}
>> +EXPORT_SYMBOL(dma_alloc_cached);
>> +
>> +
>> +
>>   static int dma_mmap(struct device *dev, struct vm_area_struct *vma,
>>   		    void *cpu_addr, dma_addr_t dma_addr, size_t size)
>>   {
>> @@ -664,6 +678,13 @@ int dma_mmap_writecombine(struct device *dev, struct vm_area_struct *vma,
>>   }
>>   EXPORT_SYMBOL(dma_mmap_writecombine);
>>
>> +int dma_mmap_cached(struct device *dev, struct vm_area_struct *vma,
>> +			  void *cpu_addr, dma_addr_t dma_addr, size_t size)
>> +{
>> +	return dma_mmap(dev, vma, cpu_addr, dma_addr, size);
>> +}
>> +EXPORT_SYMBOL(dma_mmap_cached);
>> +
>>
>>   /*
>>    * Free a buffer as defined by the above mapping.
>> --
>> 1.7.8.3
>
> Best regards
>


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
