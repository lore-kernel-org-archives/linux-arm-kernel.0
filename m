From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 16 Jul 2012 18:06:49 -0700
Subject: [Linaro-mm-sig] [PATCH][RFC] arm: dma-mapping: Add support for
 allocating/mapping cached buffers
In-Reply-To: <CAO8GWq=TdUerZp72yiheF3_AfjHUtsypQD-3xajudwodApWM0Q@mail.gmail.com>
References: <1342202506-12449-1-git-send-email-lauraa@codeaurora.org>
 <1342202506-12449-2-git-send-email-lauraa@codeaurora.org>
 <CAO8GWq=TdUerZp72yiheF3_AfjHUtsypQD-3xajudwodApWM0Q@mail.gmail.com>
Message-ID: <5004BAA9.5070903@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/14/2012 6:53 AM, Clark, Rob wrote:
> On Fri, Jul 13, 2012 at 1:01 PM, Laura Abbott <lauraa@codeaurora.org> wrote:
>> There are currently no dma allocation APIs that support cached
>> buffers. For some use cases, caching provides a signficiant
>> performance boost that beats write-combining regions. Add
>> apis to allocate and map a cached DMA region.
>
> btw, there were recent patches for allocating dma memory without a
> virtual mapping.  With this you could map however you want to
> userspace (for example, cached)
>
> I'm assuming that you are not needing it to be mapped cached to kernel?
>

Thanks for reminding me about those patches. They don't quite solve the 
problem as is for two reasons: 1) I'm looking at regular CMA 
allocations, not iommu allocations which is what the patches covered 2) 
I do actually need a kernel cached mapping in addition to the userspace 
mappings.

I've obviously missed the last DMA rework patches, and I should 
rebase/rework against those. Is another DMA attribute (DMA_ATTR_CACHED) 
an acceptable option?

> BR,
> -R
>

Thanks,
Laura

>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
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
>>                  gfp_t);
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
>> +               gfp_t);
>> +
>>   #define dma_free_writecombine(dev,size,cpu_addr,handle) \
>>          dma_free_coherent(dev,size,cpu_addr,handle)
>>
>> +#define dma_free_cached(dev,size,cpu_addr,handle) \
>> +       dma_free_coherent(dev,size,cpu_addr,handle)
>> +
>>   int dma_mmap_writecombine(struct device *, struct vm_area_struct *,
>>                  void *, dma_addr_t, size_t);
>>
>> +
>> +int dma_mmap_cached(struct device *, struct vm_area_struct *,
>> +               void *, dma_addr_t, size_t);
>> +
>>   /*
>>    * This can be called during boot to increase the size of the consistent
>>    * DMA region above it's default value of 2MB. It must be called before the
>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> index b1911c4..f396ddc 100644
>> --- a/arch/arm/mm/dma-mapping.c
>> +++ b/arch/arm/mm/dma-mapping.c
>> @@ -633,6 +633,20 @@ dma_alloc_writecombine(struct device *dev, size_t size, dma_addr_t *handle, gfp_
>>   }
>>   EXPORT_SYMBOL(dma_alloc_writecombine);
>>
>> +/*
>> + * Allocate a cached DMA region
>> + */
>> +void *
>> +dma_alloc_cached(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp)
>> +{
>> +       return __dma_alloc(dev, size, handle, gfp,
>> +                          pgprot_kernel,
>> +                          __builtin_return_address(0));
>> +}
>> +EXPORT_SYMBOL(dma_alloc_cached);
>> +
>> +
>> +
>>   static int dma_mmap(struct device *dev, struct vm_area_struct *vma,
>>                      void *cpu_addr, dma_addr_t dma_addr, size_t size)
>>   {
>> @@ -664,6 +678,13 @@ int dma_mmap_writecombine(struct device *dev, struct vm_area_struct *vma,
>>   }
>>   EXPORT_SYMBOL(dma_mmap_writecombine);
>>
>> +int dma_mmap_cached(struct device *dev, struct vm_area_struct *vma,
>> +                         void *cpu_addr, dma_addr_t dma_addr, size_t size)
>> +{
>> +       return dma_mmap(dev, vma, cpu_addr, dma_addr, size);
>> +}
>> +EXPORT_SYMBOL(dma_mmap_cached);
>> +
>>
>>   /*
>>    * Free a buffer as defined by the above mapping.
>> --
>> 1.7.8.3
>>
>>
>> _______________________________________________
>> Linaro-mm-sig mailing list
>> Linaro-mm-sig at lists.linaro.org
>> http://lists.linaro.org/mailman/listinfo/linaro-mm-sig


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
