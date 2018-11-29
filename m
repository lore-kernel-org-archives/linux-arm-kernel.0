From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 29 Nov 2018 10:11:45 +0000
Subject: [PATCH v2] ARM: dma-mapping: fix potential uninitialized return
In-Reply-To: <401b58b2-fb17-dc83-f898-c10cafdc5413@arm.com>
References: <20181128173929.3050-1-nathanj439@gmail.com>
 <20181128185910.5778-1-nathanj439@gmail.com>
 <401b58b2-fb17-dc83-f898-c10cafdc5413@arm.com>
Message-ID: <7b054176-aaef-cbdd-b2df-82eda94180e8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/18 9:50 AM, Vladimir Murzin wrote:
> On 11/28/18 6:59 PM, Nathan Jones wrote:
>> If neither of the if() statements fire then the return value is
>> uninitialized. In the worst case it returns 0 which means the caller
>> will think the function succeeded.
> 
> "ret" is updated indirectly via:
> 
>         if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
>                 return ret;

Ok. I've had a look how dma_mmap_from_dev_coherent() is implemented and it
looks like "ret" is not updated if dev doesn't have reserved memory.
It looks like arm64 also might be affected by this as well.

So, would it be better to update dma_mmap_from_dev_coherent() with

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 597d408..0273ec4 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -282,6 +282,8 @@ int dma_release_from_global_coherent(int order, void *vaddr)
 static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
                struct vm_area_struct *vma, void *vaddr, size_t size, int *ret)
 {
+       *ret = -ENXIO;
+
        if (mem && vaddr >= mem->virt_base && vaddr + size <=
                   (mem->virt_base + (mem->size << PAGE_SHIFT))) {
                unsigned long off = vma->vm_pgoff;
@@ -289,7 +291,6 @@ static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
                int user_count = vma_pages(vma);
                int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 
-               *ret = -ENXIO;
                if (off < count && user_count <= count - off) {
                        unsigned long pfn = mem->pfn_base + start + off;
                        *ret = remap_pfn_range(vma, vma->vm_start, pfn,


Cheers
Vladimir

> 
> I assume that it was found with static analyzer or like this, in such case
> please, provide output produced by the tool.
> 
>>
>> Fixes: 1655cf8829d8 ("ARM: dma-mapping: Remove traces of NOMMU code")
> 
> I'll leave it up to Russell.
> 
> Cheers
> Vladimir
> 
>> Signed-off-by: Nathan Jones <nathanj439@gmail.com>
>> ---
>>  arch/arm/mm/dma-mapping.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> index 661fe48ab78d..78de138aa66d 100644
>> --- a/arch/arm/mm/dma-mapping.c
>> +++ b/arch/arm/mm/dma-mapping.c
>> @@ -829,7 +829,7 @@ static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>>  		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
>>  		 unsigned long attrs)
>>  {
>> -	int ret;
>> +	int ret = -ENXIO;
>>  	unsigned long nr_vma_pages = vma_pages(vma);
>>  	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
>>  	unsigned long pfn = dma_to_pfn(dev, dma_addr);
>>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
