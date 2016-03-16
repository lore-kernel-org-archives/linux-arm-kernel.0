From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Wed, 16 Mar 2016 09:56:33 +0800
Subject: [PATCH 1/1] arm64/dma-mapping: remove an unnecessary conversion
In-Reply-To: <20160315153757.GF12311@e104818-lin.cambridge.arm.com>
References: <1458007931-14432-1-git-send-email-thunder.leizhen@huawei.com>
 <20160315153757.GF12311@e104818-lin.cambridge.arm.com>
Message-ID: <56E8BD51.6010008@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/3/15 23:37, Catalin Marinas wrote:
> On Tue, Mar 15, 2016 at 10:12:11AM +0800, Zhen Lei wrote:
>> 1. In swiotlb_alloc_coherent, the branch of __get_free_pages. Directly
>>    return vaddr on success, and pass vaddr to free_pages on failure.
>> 2. So, we can directly transparent pass vaddr from __dma_free to
>>    swiotlb_free_coherent, keep consistent with swiotlb_alloc_coherent.
>>
>> This patch have no functional change,
> 
> I don't think so.
> 
>> but can obtain a bit performance improvement.
> 
> Have you actually measured it?
I have not run any performance testing, but reduced a line of code. So I said "a bit".

> 
>> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
>> index a6e757c..b2f2834 100644
>> --- a/arch/arm64/mm/dma-mapping.c
>> +++ b/arch/arm64/mm/dma-mapping.c
>> @@ -187,8 +187,6 @@ static void __dma_free(struct device *dev, size_t size,
>>  		       void *vaddr, dma_addr_t dma_handle,
>>  		       struct dma_attrs *attrs)
>>  {
>> -	void *swiotlb_addr = phys_to_virt(dma_to_phys(dev, dma_handle));
>> -
>>  	size = PAGE_ALIGN(size);
>>
>>  	if (!is_device_dma_coherent(dev)) {
>> @@ -196,7 +194,7 @@ static void __dma_free(struct device *dev, size_t size,
>>  			return;
>>  		vunmap(vaddr);
>>  	}
>> -	__dma_free_coherent(dev, size, swiotlb_addr, dma_handle, attrs);
>> +	__dma_free_coherent(dev, size, vaddr, dma_handle, attrs);
>>  }
> 
> What happens when !is_device_dma_coherent(dev)? (hint: read two lines
> above __dma_free_coherent).
> 
The whole function of __dma_free as below: (nobody use swiotlb_addr except __dma_free_coherent)
static void __dma_free(struct device *dev, size_t size,
                       void *vaddr, dma_addr_t dma_handle,
                       struct dma_attrs *attrs)
{
        void *swiotlb_addr = phys_to_virt(dma_to_phys(dev, dma_handle));

        size = PAGE_ALIGN(size);

        if (!is_device_dma_coherent(dev)) {
                if (__free_from_pool(vaddr, size))
                        return;
                vunmap(vaddr);
        }
        __dma_free_coherent(dev, size, swiotlb_addr, dma_handle, attrs);
}
