From: linuxzsc@gmail.com (Richard Zhao)
Date: Thu, 20 Jun 2013 21:40:50 +0800
Subject: [PATCH] ARM: dma: Drop __GFP_COMP for iommu dma memory allocations
In-Reply-To: <51C2FDE0.4060206@cogentembedded.com>
References: <1371731460-15316-1-git-send-email-rizhao@nvidia.com>
 <51C2FDE0.4060206@cogentembedded.com>
Message-ID: <CANg6MZg3A7-oXfdUSarQ8n0PRsS0_BLjqfQ914KUoSzDDtShFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 9:04 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
>
> On 20-06-2013 16:31, Richard Zhao wrote:
>
>> __iommu_alloc_buffer wants to split pages after allocation in order to
>> reduce the memory footprint. This does not work well with __GFP_COMP
>> pages, so drop this flag before allocation
>
>
>> One failure example is snd_malloc_dev_pages call dma_alloc_coherent with
>> __GFP_COMP.
>
>
>> Signed-off-by: Richard Zhao <rizhao@nvidia.com>
>> ---
>>   arch/arm/mm/dma-mapping.c |    9 +++++++++
>>   1 file changed, 9 insertions(+)
>
>
>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> index ef3e0f3..f7efffd 100644
>> --- a/arch/arm/mm/dma-mapping.c
>> +++ b/arch/arm/mm/dma-mapping.c
>> @@ -1314,6 +1314,15 @@ static void *arm_iommu_alloc_attrs(struct device
>> *dev, size_t size,
>>         if (gfp & GFP_ATOMIC)
>>                 return __iommu_alloc_atomic(dev, size, handle);
>>
>> +       /*
>> +        * Following is a work-around (a.k.a. hack) to prevent pages
>> +        * with __GFP_COMP being passed to split_page() which cannot
>> +        * handle them.  The real problem is that this flag probably
>> +        * should be 0 on ARM as it is not supported on this
>> +        * platform; see CONFIG_HUGETLBFS.
>> +        */
>> +       gfp &= ~(__GFP_COMP);
>
>
>    Hm, what exactly is the sense you meant in using ()?

It's copy/paste from elsewhere in this file. At least it's consistent? :)
