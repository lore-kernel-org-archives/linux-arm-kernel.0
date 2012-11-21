From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 21 Nov 2012 09:05:21 +0100
Subject: [PATCH V3 1/3] arm: dma mapping: Export dma ops functions
In-Reply-To: <50AC7D59.1020000@samsung.com>
References: <1353448587-2937-1-git-send-email-gregory.clement@free-electrons.com>
 <1353448587-2937-2-git-send-email-gregory.clement@free-electrons.com>
 <50AC7D59.1020000@samsung.com>
Message-ID: <50AC8B41.7080009@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2012 08:06 AM, Marek Szyprowski wrote:
> Hello,
Hello,

> 
> On 11/20/2012 10:56 PM, Gregory CLEMENT wrote:
>> Expose the DMA operations functions. Until now only the dma_ops
>> structs in a whole or some dma operation were exposed. This patch
>> exposes all the dma coherents operations. They can be reused when an
>> architecture or a driver need to create its own set of dma_operation.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 
> Besides arm_dma_set_mask() function I see no reason to export the other
> arm dma related functions.

The idea was to let other people use the arm dma related functions,
for their own dma ops. But for the mvebu machines we only need
arm_dma_set_mask() indeed.

So you prefer that I only expose arm_dma_set_mask() and let future
user expose other function if they need it, right?

Thanks,
Gregory
> 
>> ---
>>   arch/arm/include/asm/dma-mapping.h |   48 ++++++++++++++++++++++++++++++++++++
>>   arch/arm/mm/dma-mapping.c          |   25 ++++---------------
>>   2 files changed, 53 insertions(+), 20 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
>> index 2300484..b12d7c0 100644
>> --- a/arch/arm/include/asm/dma-mapping.h
>> +++ b/arch/arm/include/asm/dma-mapping.h
>> @@ -112,6 +112,54 @@ static inline void dma_free_noncoherent(struct device *dev, size_t size,
>>   extern int dma_supported(struct device *dev, u64 mask);
>>   
>>   /**
>> + * arm_dma_map_page - map a portion of a page for streaming DMA
>> + * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
>> + * @page: page that buffer resides in
>> + * @offset: offset into page for start of buffer
>> + * @size: size of buffer to map
>> + * @dir: DMA transfer direction
>> + *
>> + * Ensure that any data held in the cache is appropriately discarded
>> + * or written back.
>> + *
>> + * The device owns this memory once this call has completed.  The CPU
>> + * can regain ownership by calling dma_unmap_page().
>> + */
>> +extern dma_addr_t arm_dma_map_page(struct device *dev, struct page *page,
>> +				    unsigned long offset, size_t size,
>> +				    enum dma_data_direction dir,
>> +				    struct dma_attrs *attrs);
>> +
>> +/**
>> + * arm_dma_unmap_page - unmap a buffer previously mapped through dma_map_page()
>> + * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
>> + * @handle: DMA address of buffer
>> + * @size: size of buffer (same as passed to dma_map_page)
>> + * @dir: DMA transfer direction (same as passed to dma_map_page)
>> + *
>> + * Unmap a page streaming mode DMA translation.  The handle and size
>> + * must match what was provided in the previous dma_map_page() call.
>> + * All other usages are undefined.
>> + *
>> + * After this call, reads by the CPU to the buffer are guaranteed to see
>> + * whatever the device wrote there.
>> + */
>> +extern void arm_dma_unmap_page(struct device *dev, dma_addr_t handle,
>> +				size_t size, enum dma_data_direction dir,
>> +				struct dma_attrs *attrs);
>> +
>> +extern void arm_dma_sync_single_for_cpu(struct device *dev,
>> +					dma_addr_t handle, size_t size,
>> +					enum dma_data_direction dir);
>> +
>> +extern void arm_dma_sync_single_for_device(struct device *dev,
>> +					dma_addr_t handle, size_t size,
>> +					enum dma_data_direction dir);
>> +
>> +extern int arm_dma_set_mask(struct device *dev, u64 dma_mask);
>> +
>> +
>> +/**
>>    * arm_dma_alloc - allocate consistent memory for DMA
>>    * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
>>    * @size: required memory size
>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> index 58bc3e4..dbb67ce 100644
>> --- a/arch/arm/mm/dma-mapping.c
>> +++ b/arch/arm/mm/dma-mapping.c
>> @@ -56,20 +56,13 @@ static void __dma_page_dev_to_cpu(struct page *, unsigned long,
>>   		size_t, enum dma_data_direction);
>>   
>>   /**
>> - * arm_dma_map_page - map a portion of a page for streaming DMA
>> - * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
>> - * @page: page that buffer resides in
>> - * @offset: offset into page for start of buffer
>> - * @size: size of buffer to map
>> - * @dir: DMA transfer direction
>> - *
>>    * Ensure that any data held in the cache is appropriately discarded
>>    * or written back.
>>    *
>>    * The device owns this memory once this call has completed.  The CPU
>>    * can regain ownership by calling dma_unmap_page().
>>    */
>> -static dma_addr_t arm_dma_map_page(struct device *dev, struct page *page,
>> +dma_addr_t arm_dma_map_page(struct device *dev, struct page *page,
>>   	     unsigned long offset, size_t size, enum dma_data_direction dir,
>>   	     struct dma_attrs *attrs)
>>   {
>> @@ -86,12 +79,6 @@ static dma_addr_t arm_coherent_dma_map_page(struct device *dev, struct page *pag
>>   }
>>   
>>   /**
>> - * arm_dma_unmap_page - unmap a buffer previously mapped through dma_map_page()
>> - * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
>> - * @handle: DMA address of buffer
>> - * @size: size of buffer (same as passed to dma_map_page)
>> - * @dir: DMA transfer direction (same as passed to dma_map_page)
>> - *
>>    * Unmap a page streaming mode DMA translation.  The handle and size
>>    * must match what was provided in the previous dma_map_page() call.
>>    * All other usages are undefined.
>> @@ -99,7 +86,7 @@ static dma_addr_t arm_coherent_dma_map_page(struct device *dev, struct page *pag
>>    * After this call, reads by the CPU to the buffer are guaranteed to see
>>    * whatever the device wrote there.
>>    */
>> -static void arm_dma_unmap_page(struct device *dev, dma_addr_t handle,
>> +void arm_dma_unmap_page(struct device *dev, dma_addr_t handle,
>>   		size_t size, enum dma_data_direction dir,
>>   		struct dma_attrs *attrs)
>>   {
>> @@ -108,7 +95,7 @@ static void arm_dma_unmap_page(struct device *dev, dma_addr_t handle,
>>   				      handle & ~PAGE_MASK, size, dir);
>>   }
>>   
>> -static void arm_dma_sync_single_for_cpu(struct device *dev,
>> +void arm_dma_sync_single_for_cpu(struct device *dev,
>>   		dma_addr_t handle, size_t size, enum dma_data_direction dir)
>>   {
>>   	unsigned int offset = handle & (PAGE_SIZE - 1);
>> @@ -116,7 +103,7 @@ static void arm_dma_sync_single_for_cpu(struct device *dev,
>>   	__dma_page_dev_to_cpu(page, offset, size, dir);
>>   }
>>   
>> -static void arm_dma_sync_single_for_device(struct device *dev,
>> +void arm_dma_sync_single_for_device(struct device *dev,
>>   		dma_addr_t handle, size_t size, enum dma_data_direction dir)
>>   {
>>   	unsigned int offset = handle & (PAGE_SIZE - 1);
>> @@ -124,8 +111,6 @@ static void arm_dma_sync_single_for_device(struct device *dev,
>>   	__dma_page_cpu_to_dev(page, offset, size, dir);
>>   }
>>   
>> -static int arm_dma_set_mask(struct device *dev, u64 dma_mask);
>> -
>>   struct dma_map_ops arm_dma_ops = {
>>   	.alloc			= arm_dma_alloc,
>>   	.free			= arm_dma_free,
>> @@ -971,7 +956,7 @@ int dma_supported(struct device *dev, u64 mask)
>>   }
>>   EXPORT_SYMBOL(dma_supported);
>>   
>> -static int arm_dma_set_mask(struct device *dev, u64 dma_mask)
>> +int arm_dma_set_mask(struct device *dev, u64 dma_mask)
>>   {
>>   	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
>>   		return -EIO;
> 
> Best regards
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
