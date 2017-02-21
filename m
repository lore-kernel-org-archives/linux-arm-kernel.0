From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 21 Feb 2017 13:05:12 +0000
Subject: [PATCH 3/7] drivers: dma-coherent: Account dma_pfn_offset when
 used with device tree
In-Reply-To: <a565dd15-8447-c7c3-69d6-831bb5873cbe@arm.com>
References: <1487152792-34214-1-git-send-email-vladimir.murzin@arm.com>
 <1487152792-34214-4-git-send-email-vladimir.murzin@arm.com>
 <c7f1bc2f-6729-c01d-25a5-d07efd319828@arm.com>
 <a565dd15-8447-c7c3-69d6-831bb5873cbe@arm.com>
Message-ID: <a41c398f-1ad8-4f4f-c415-f32598795930@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/02/17 13:02, Vladimir Murzin wrote:
> On 21/02/17 12:37, Robin Murphy wrote:
>> On 15/02/17 09:59, Vladimir Murzin wrote:
>>> dma_declare_coherent_memory() and friends are designed to account
>>> difference in CPU and device addresses. However, when it is used with
>>> reserved memory regions there is assumption that CPU and device have
>>> the same view on address space. This assumption gets invalid when
>>> reserved memory for coherent DMA allocations is referenced by device
>>> with non-empty "dma-range" property.
>>>
>>> Simply feeding device address as rmem->base + dev->dma_pfn_offset
>>> would not work due to reserved memory region can be shared, so this
>>> patch turns device address to be expressed with help of CPU address
>>> and device's dma_pfn_offset.
>>>
>>> For the case where device tree is not used and device sees memory
>>> different to CPU we explicitly set device's dma_pfn_offset to
>>> accomplish such difference. The latter might look controversial, but
>>> it seems only a few drivers set device address different to CPU's:
>>> - drivers/usb/host/ohci-sm501.c
>>> - arch/sh/drivers/pci/fixups-dreamcast.c
>>> so they can be screwed only if dma_pfn_offset there is set and not in
>>> sync with device address range - we try to catch such cases with
>>> WARN_ON.
>>>
>>> Cc: Michal Nazarewicz <mina86@mina86.com>
>>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Cc: Alan Stern <stern@rowland.harvard.edu>
>>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>>> Cc: Rich Felker <dalias@libc.org>
>>> Cc: Roger Quadros <rogerq@ti.com>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Tested-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
>>> Tested-by: Andras Szemzo <sza@esh.hu>
>>> Tested-by: Alexandre TORGUE <alexandre.torgue@st.com>
>>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
>>> ---
>>>  drivers/base/dma-coherent.c | 17 +++++++++++++++--
>>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
>>> index 640a7e6..c59708c 100644
>>> --- a/drivers/base/dma-coherent.c
>>> +++ b/drivers/base/dma-coherent.c
>>> @@ -18,6 +18,12 @@ struct dma_coherent_mem {
>>>  	spinlock_t	spinlock;
>>>  };
>>>  
>>> +static inline dma_addr_t dma_get_device_base(struct device *dev,
>>> +					     struct dma_coherent_mem * mem)
>>> +{
>>> +	return (mem->pfn_base - dev->dma_pfn_offset) << PAGE_SHIFT;
>>> +}
>>> +
>>>  static bool dma_init_coherent_memory(
>>>  	phys_addr_t phys_addr, dma_addr_t device_addr, size_t size, int flags,
>>>  	struct dma_coherent_mem **mem)
>>> @@ -83,9 +89,16 @@ static void dma_release_coherent_memory(struct dma_coherent_mem *mem)
>>>  static int dma_assign_coherent_memory(struct device *dev,
>>>  				      struct dma_coherent_mem *mem)
>>>  {
>>> +	unsigned long dma_pfn_offset = mem->pfn_base - PFN_DOWN(mem->device_base);
>>> +
>>>  	if (dev->dma_mem)
>>>  		return -EBUSY;
>>>  
>>> +	if (dev->dma_pfn_offset)
>>> +		WARN_ON(dma_pfn_offset && (dev->dma_pfn_offset != dma_pfn_offset));
>>> +	else
>>> +		dev->dma_pfn_offset = dma_pfn_offset;
>>
>> This makes me rather uneasy - I can well imagine a device sharing the
>> CPU physical address map of external system memory, but having its own
>> view of its local coherent memory such that pfn_base != device_base
>> still. I know for a fact we've had internal FPGA tiles set up that way,
>> although whether it was entirely intentional is another matter... ;)
>>
>> In that situation, setting dev->dma_pfn_offset like this would break
>> streaming DMA for such devices. Could we not keep the pool-specific
>> offset and the device-specific offset independent, apply whichever is
>> non-zero, and scream if both are set?
> 
> Something like fixup bellow?
> 
> diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
> index 0c577ea..2060010 100644
> --- a/drivers/base/dma-coherent.c
> +++ b/drivers/base/dma-coherent.c
> @@ -30,7 +30,15 @@ static inline struct dma_coherent_mem *dev_get_coherent_memory(struct device *de
>  static inline dma_addr_t dma_get_device_base(struct device *dev,
>  					     struct dma_coherent_mem * mem)
>  {
> -	return (mem->pfn_base - dev->dma_pfn_offset) << PAGE_SHIFT;
> +	unsigned long dma_pfn_offset = mem->pfn_base - PFN_DOWN(mem->device_base);
> +
> +	if (dma_pfn_offset != dev->dma_pfn_offset )
> +		WARN_ON(device_pfn_offset && dev->dma_pfn_offset);
                        ^^^^^^^^^^^^^^^^^
	       should be dma_pfn_offset

> +
> +	if (dma_pfn_offset)
> +		return mem->device_base;
> +	else
> +		return (mem->pfn_base - dev->dma_pfn_offset) << PAGE_SHIFT;
>  }
>  
>  static bool dma_init_coherent_memory(
> @@ -98,19 +106,12 @@ static void dma_release_coherent_memory(struct dma_coherent_mem *mem)
>  static int dma_assign_coherent_memory(struct device *dev,
>  				      struct dma_coherent_mem *mem)
>  {
> -	unsigned long dma_pfn_offset = mem->pfn_base - PFN_DOWN(mem->device_base);
> -
>  	if (!dev)
>  		return -ENODEV;
>  
>  	if (dev->dma_mem)
>  		return -EBUSY;
>  
> -	if (dev->dma_pfn_offset)
> -		WARN_ON(dma_pfn_offset && (dev->dma_pfn_offset != dma_pfn_offset));
> -	else
> -		dev->dma_pfn_offset = dma_pfn_offset;
> -
>  	dev->dma_mem = mem;
>  	/* FIXME: this routine just ignores DMA_MEMORY_INCLUDES_CHILDREN */
> 
> 
> Cheers
> Vladimir
> 
>>
>> Robin.
>>
>>> +
>>>  	dev->dma_mem = mem;
>>>  	/* FIXME: this routine just ignores DMA_MEMORY_INCLUDES_CHILDREN */
>>>  
>>> @@ -133,7 +146,7 @@ void *dma_mark_declared_memory_occupied(struct device *dev,
>>>  		return ERR_PTR(-EINVAL);
>>>  
>>>  	spin_lock_irqsave(&mem->spinlock, flags);
>>> -	pos = (device_addr - mem->device_base) >> PAGE_SHIFT;
>>> +	pos = PFN_DOWN(device_addr - dma_get_device_base(dev, mem));
>>>  	err = bitmap_allocate_region(mem->bitmap, pos, get_order(size));
>>>  	spin_unlock_irqrestore(&mem->spinlock, flags);
>>>  
>>> @@ -186,7 +199,7 @@ int dma_alloc_from_coherent(struct device *dev, ssize_t size,
>>>  	/*
>>>  	 * Memory was found in the per-device area.
>>>  	 */
>>> -	*dma_handle = mem->device_base + (pageno << PAGE_SHIFT);
>>> +	*dma_handle = dma_get_device_base(dev, mem) + (pageno << PAGE_SHIFT);
>>>  	*ret = mem->virt_base + (pageno << PAGE_SHIFT);
>>>  	dma_memory_map = (mem->flags & DMA_MEMORY_MAP);
>>>  	spin_unlock_irqrestore(&mem->spinlock, flags);
>>>
>>
>>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
