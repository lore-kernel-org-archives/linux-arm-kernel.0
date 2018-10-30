From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 30 Oct 2018 10:10:46 -0700
Subject: Warnings in arch/arm64/mm/dma-mapping.c
In-Reply-To: <20181030101342.GC19955@arm.com>
References: <a771d5ce-28a2-609e-5fd7-338fadc20743@gmail.com>
 <20181030074344.GA24697@lst.de> <20181030101342.GC19955@arm.com>
Message-ID: <ba1447e7-5f64-5e65-b51b-72a2d2255afa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/18 3:13 AM, Will Deacon wrote:
> On Tue, Oct 30, 2018 at 08:43:44AM +0100, Christoph Hellwig wrote:
>> On Mon, Oct 29, 2018 at 04:51:47PM -0700, Florian Fainelli wrote:
>>> I have not a chance to run a bisection yet, but I suspect this is coming
>>> from Christoph's latest batch of DMA-API changes in ARM64 under the
>>> merge commit befa93633193e5327e4045d1e5fa29114580fa5d ("Merge tag
>>> 'dma-mapping-4.20-1' of git://git.infradead.org/users/hch/dma-mapping"),
>>> here are the warnings:
>>
>> This should fix it:
> 
> Tested-by: Will Deacon <will.deacon@arm.com>

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks for the quick fix!

> 
> I guess Catalin can pick this up for -rc1, since there's also the kprobes
> RO fix kicking around for arm64?
> 
> Will
> 
>> ---
>> From 773c5e097c5cf3868443ffb79ae64d79f70e3ccf Mon Sep 17 00:00:00 2001
>> From: Christoph Hellwig <hch@lst.de>
>> Date: Tue, 30 Oct 2018 09:41:29 +0200
>> Subject: arm64: fix warnings without CONFIG_IOMMU_DMA
>>
>> __swiotlb_get_sgtable_page and __swiotlb_mmap_pfn are not only misnamed
>> but also only used if CONFIG_IOMMU_DMA is set.  Just add a simple ifdef
>> for now, given that we plan to remove them entirely for the next merge
>> window.
>>
>> Reported-by: Florian Fainelli <f.fainelli@gmail.com>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  arch/arm64/mm/dma-mapping.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
>> index d190612b8f33..560756a7290e 100644
>> --- a/arch/arm64/mm/dma-mapping.c
>> +++ b/arch/arm64/mm/dma-mapping.c
>> @@ -160,6 +160,7 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
>>  	__dma_unmap_area(phys_to_virt(paddr), size, dir);
>>  }
>>  
>> +#ifdef CONFIG_IOMMU_DMA
>>  static int __swiotlb_get_sgtable_page(struct sg_table *sgt,
>>  				      struct page *page, size_t size)
>>  {
>> @@ -188,6 +189,7 @@ static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
>>  
>>  	return ret;
>>  }
>> +#endif /* CONFIG_IOMMU_DMA */
>>  
>>  static int __init atomic_pool_init(void)
>>  {
>> -- 
>> 2.19.1
>>


-- 
Florian
