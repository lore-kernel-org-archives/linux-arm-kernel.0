From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Fri, 18 Mar 2016 09:17:08 +0800
Subject: [PATCH 1/1] arm64/dma-mapping: remove an unnecessary conversion
In-Reply-To: <20160317115950.GB11623@e104818-lin.cambridge.arm.com>
References: <1458007931-14432-1-git-send-email-thunder.leizhen@huawei.com>
 <20160315153757.GF12311@e104818-lin.cambridge.arm.com>
 <56E8BD51.6010008@huawei.com> <56EA8FB3.2050505@huawei.com>
 <20160317115950.GB11623@e104818-lin.cambridge.arm.com>
Message-ID: <56EB5714.3050202@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/3/17 19:59, Catalin Marinas wrote:
> On Thu, Mar 17, 2016 at 07:06:27PM +0800, Leizhen (ThunderTown) wrote:
>> On 2016/3/16 9:56, Leizhen (ThunderTown) wrote:
>>> On 2016/3/15 23:37, Catalin Marinas wrote:
>>>> On Tue, Mar 15, 2016 at 10:12:11AM +0800, Zhen Lei wrote:
>>>>> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
>>>>> index a6e757c..b2f2834 100644
>>>>> --- a/arch/arm64/mm/dma-mapping.c
>>>>> +++ b/arch/arm64/mm/dma-mapping.c
>>>>> @@ -187,8 +187,6 @@ static void __dma_free(struct device *dev, size_t size,
>>>>>  		       void *vaddr, dma_addr_t dma_handle,
>>>>>  		       struct dma_attrs *attrs)
>>>>>  {
>>>>> -	void *swiotlb_addr = phys_to_virt(dma_to_phys(dev, dma_handle));
>>>>> -
>>>>>  	size = PAGE_ALIGN(size);
>>>>>
>>>>>  	if (!is_device_dma_coherent(dev)) {
>>>>> @@ -196,7 +194,7 @@ static void __dma_free(struct device *dev, size_t size,
>>>>>  			return;
>>>>>  		vunmap(vaddr);
>>>>>  	}
>>>>> -	__dma_free_coherent(dev, size, swiotlb_addr, dma_handle, attrs);
>>>>> +	__dma_free_coherent(dev, size, vaddr, dma_handle, attrs);
>>>>>  }
>>>>
>>>> What happens when !is_device_dma_coherent(dev)? (hint: read two lines
>>>> above __dma_free_coherent).
>>
>> Do you afraid "vaddr" maybe modified by these statement?
>> First, it could not be __free_from_pool. Otherwise, the function
>> vunmap(which after it) can not work well. Then, it count not be vunmap
>> too, the parameter is defined as "const void *".
>>
>> In the call chain:
>> __dma_free_coherent-->__dma_free_coherent-->swiotlb_free_coherent,
>> only swiotlb_free_coherent finally use "vaddr".
> 
> Exactly. So you give swiotlb_free_coherent a vaddr which has been
> unmapped. It doesn't even matter whether it's still mapped since this
> address is passed further to free_pages() which performs a
> virt_to_page(). The latter is *only* valid on linear map addresses (and
> you would actually hit the VM_BUG_ON in free_pages; you can try running
> this with CONFIG_DEBUG_VM enabled and non-coherent DMA).
> 
> For non-coherent DMA, the vaddr is not part of the linear mapping as it
> has been remapped by __dma_alloc() via dma_common_contiguous_remap(),
> hence for swiotlb freeing we need the actual linear map address (the
> original "ptr" in __dma_alloc()). We can generate it by a
> phys_to_virt(dma_to_phys(dma_handle)).
> 

OK, I got it.

So actually I should move the statement into branch "if (!is_device_dma_coherent(dev))", I will prepare v2.
