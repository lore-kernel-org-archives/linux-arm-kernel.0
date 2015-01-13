From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 13 Jan 2015 12:20:44 +0100
Subject: [PATCH] ARM: DMA: Fix kzalloc flags in __iommu_alloc_buffer()
In-Reply-To: <CAAVeFuL-x1-vmaViYou6ViRR+ipCnz5WdwbmKC4Cu5ViD+pVNA@mail.gmail.com>
References: <1418027967-12923-1-git-send-email-acourbot@nvidia.com>
 <54897C14.3040702@samsung.com>
 <CAAVeFuL-x1-vmaViYou6ViRR+ipCnz5WdwbmKC4Cu5ViD+pVNA@mail.gmail.com>
Message-ID: <54B4FF8C.50805@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2015-01-13 09:45, Alexandre Courbot wrote:
> Ping? This patch still seems to be needed as of today...

Arnd, could you take this patch together with your other pending 
dma-mapping.h changes?

> On Thu, Dec 11, 2014 at 8:12 PM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> On 2014-12-08 09:39, Alexandre Courbot wrote:
>>> There doesn't seem to be any valid reason to allocate the pages array
>>> with the same flags as the buffer itself. Doing so can eventually lead
>>> to the following safeguard in mm/slab.c to be hit:
>>>
>>> BUG_ON(flags & GFP_SLAB_BUG_MASK);
>>>
>>> This happens when buffers are allocated with __GFP_DMA32 or
>>> __GFP_HIGHMEM.
>>>
>>> Fix this by allocating the pages array with GFP_KERNEL to follow what is
>>> done elsewhere in this file. Using GFP_KERNEL in __iommu_alloc_buffer()
>>> is safe because atomic allocations are handled by __iommu_alloc_atomic().
>>>
>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>> Cc: Russell King <linux@arm.linux.org.uk>
>>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Thierry Reding <treding@nvidia.com>
>>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>
>>> ---
>>>    arch/arm/mm/dma-mapping.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>>> index e8907117861e..bc495354c802 100644
>>> --- a/arch/arm/mm/dma-mapping.c
>>> +++ b/arch/arm/mm/dma-mapping.c
>>> @@ -1106,7 +1106,7 @@ static struct page **__iommu_alloc_buffer(struct
>>> device *dev, size_t size,
>>>          int i = 0;
>>>          if (array_size <= PAGE_SIZE)
>>> -               pages = kzalloc(array_size, gfp);
>>> +               pages = kzalloc(array_size, GFP_KERNEL);
>>>          else
>>>                  pages = vzalloc(array_size);
>>>          if (!pages)
>>>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
