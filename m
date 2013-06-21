From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 21 Jun 2013 11:33:40 +0200
Subject: [PATCH] ARM: dma: Drop __GFP_COMP for iommu dma memory allocations
In-Reply-To: <51C2FDE0.4060206@cogentembedded.com>
References: <1371731460-15316-1-git-send-email-rizhao@nvidia.com>
 <51C2FDE0.4060206@cogentembedded.com>
Message-ID: <51C41DF4.4090802@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 6/20/2013 3:04 PM, Sergei Shtylyov wrote:
> Hello.
>
> On 20-06-2013 16:31, Richard Zhao wrote:
>
>> __iommu_alloc_buffer wants to split pages after allocation in order to
>> reduce the memory footprint. This does not work well with __GFP_COMP
>> pages, so drop this flag before allocation
>
>> One failure example is snd_malloc_dev_pages call dma_alloc_coherent with
>> __GFP_COMP.
>
>> Signed-off-by: Richard Zhao <rizhao@nvidia.com>
>> ---
>>   arch/arm/mm/dma-mapping.c |    9 +++++++++
>>   1 file changed, 9 insertions(+)
>
>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> index ef3e0f3..f7efffd 100644
>> --- a/arch/arm/mm/dma-mapping.c
>> +++ b/arch/arm/mm/dma-mapping.c
>> @@ -1314,6 +1314,15 @@ static void *arm_iommu_alloc_attrs(struct 
>> device *dev, size_t size,
>>       if (gfp & GFP_ATOMIC)
>>           return __iommu_alloc_atomic(dev, size, handle);
>>
>> +    /*
>> +     * Following is a work-around (a.k.a. hack) to prevent pages
>> +     * with __GFP_COMP being passed to split_page() which cannot
>> +     * handle them.  The real problem is that this flag probably
>> +     * should be 0 on ARM as it is not supported on this
>> +     * platform; see CONFIG_HUGETLBFS.
>> +     */
>> +    gfp &= ~(__GFP_COMP);
>
>    Hm, what exactly is the sense you meant in using ()?

I think that those parentheses come from the first patch, which disabled 
__GFP_COMP
in dma-mapping allocations: 3611553ef98 ("[AVR32] Drop GFP_COMP for DMA 
memory
allocations"). I would like to take this patch to the dma-mapping tree 
together with
other changes related to iommu integration code.

Best regards
-- 
Marek Szyprowski
Samsung R&D Institute Poland
