From: acourbot@nvidia.com (Alexandre Courbot)
Date: Fri, 13 Feb 2015 14:13:31 +0900
Subject: [PATCH RESEND] ARM: DMA: Fix kzalloc flags in
 __iommu_alloc_buffer()
In-Reply-To: <20150213033243.GC961@arm.com>
References: <1423645301-709-1-git-send-email-acourbot@nvidia.com>
 <20150213033243.GC961@arm.com>
Message-ID: <54DD87FB.6070802@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2015 12:32 PM, Will Deacon wrote:
> On Wed, Feb 11, 2015 at 09:01:41AM +0000, Alexandre Courbot wrote:
>> There doesn't seem to be any valid reason to allocate the pages array
>> with the same flags as the buffer itself. Doing so can eventually lead
>> to the following safeguard in mm/slab.c to be hit:
>>
>> BUG_ON(flags & GFP_SLAB_BUG_MASK);
>
> nit: I can't actually spot this BUG_ON in the kernel.

I have been trying to push this patch for so long that the line in 
question changed in the meantime. :) It is now

         if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
                 pr_emerg("gfp: %u\n", flags & GFP_SLAB_BUG_MASK);
                 BUG();
         }

in cache_grow, line 2593 of mm/slab.c.

>
>> This happens when buffers are allocated with __GFP_DMA32 or
>> __GFP_HIGHMEM.
>>
>> Fix this by allocating the pages array with GFP_KERNEL to follow what is
>> done elsewhere in this file. Using GFP_KERNEL in __iommu_alloc_buffer()
>> is safe because atomic allocations are handled by __iommu_alloc_atomic().
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   arch/arm/mm/dma-mapping.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> index 903dba0..170a116 100644
>> --- a/arch/arm/mm/dma-mapping.c
>> +++ b/arch/arm/mm/dma-mapping.c
>> @@ -1106,7 +1106,7 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
>>   	int i = 0;
>>
>>   	if (array_size <= PAGE_SIZE)
>> -		pages = kzalloc(array_size, gfp);
>> +		pages = kzalloc(array_size, GFP_KERNEL);
>>   	else
>>   		pages = vzalloc(array_size);
>>   	if (!pages)
>> --
>> 2.3.0
>
> Looks sensible to me:
>
>    Acked-by: Will Deacon <will.deacon@arm.com>

Thanks! I will amend the commit message and resend.
