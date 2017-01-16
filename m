From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 16 Jan 2017 11:58:04 +0000
Subject: [RFC PATCH v4 0/5] ARM: Fix dma_alloc_coherent() and friends for
 NOMMU
In-Reply-To: <6dfa7f5a-712e-3457-305b-7e1b7f6a9b3c@arm.com>
References: <1484057925-23586-1-git-send-email-vladimir.murzin@arm.com>
 <CA+M3ks5JP14SzprzE90-ST8b3URJECgpJ=dxw5XKvaxYEF3UCw@mail.gmail.com>
 <f4d17374-eb46-79f7-e394-cb2739f71ef4@arm.com>
 <CA+M3ks5jTNSLLOetvOUZP=B=a2wPNjXadbw6Zcn475Okc4QEPw@mail.gmail.com>
 <CA+M3ks6abvJV1RJtZhD1ixrnVhC5V3PL1+7DdwB+_tVg+vTkaw@mail.gmail.com>
 <1908ef72-beb0-1855-3c49-d5a37f014c17@arm.com>
 <c9bb8baa-ae3d-27cd-8c9f-2d77e1f5c62b@arm.com>
 <78458e5f-6b30-ab9b-1226-83fe3a844e3a@arm.com>
 <8a428278-fe0f-ca1f-2b6a-96fdbb363db4@arm.com>
 <5c3476e2-fae4-677c-3ed9-7a4eb4263ecb@arm.com>
 <6dfa7f5a-712e-3457-305b-7e1b7f6a9b3c@arm.com>
Message-ID: <1c47a9f3-5167-9605-9878-aa539af75445@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/01/17 12:40, Robin Murphy wrote:
> On 13/01/17 09:12, Vladimir Murzin wrote:
>> On 12/01/17 18:07, Robin Murphy wrote:
>>> On 12/01/17 17:15, Vladimir Murzin wrote:
>>>> On 12/01/17 17:04, Robin Murphy wrote:
>>>>> On 12/01/17 16:52, Vladimir Murzin wrote:
>>>>>> On 12/01/17 10:55, Benjamin Gaignard wrote:
>>>>>>> 2017-01-12 11:35 GMT+01:00 Benjamin Gaignard <benjamin.gaignard@linaro.org>:
>>>>>>>> 2017-01-11 15:34 GMT+01:00 Vladimir Murzin <vladimir.murzin@arm.com>:
>>>>>>>>> On 11/01/17 13:17, Benjamin Gaignard wrote:
>>>>>>>>>> 2017-01-10 15:18 GMT+01:00 Vladimir Murzin <vladimir.murzin@arm.com>:
>>>>>>>>>>> Hi,
>>>>>>>>>>>
>>>>>>>>>>> It seem that addition of cache support for M-class cpus uncovered
>>>>>>>>>>> latent bug in DMA usage. NOMMU memory model has been treated as being
>>>>>>>>>>> always consistent; however, for R/M classes of cpu memory can be
>>>>>>>>>>> covered by MPU which in turn might configure RAM as Normal
>>>>>>>>>>> i.e. bufferable and cacheable. It breaks dma_alloc_coherent() and
>>>>>>>>>>> friends, since data can stuck in caches now or be buffered.
>>>>>>>>>>>
>>>>>>>>>>> This patch set is trying to address the issue by providing region of
>>>>>>>>>>> memory suitable for consistent DMA operations. It is supposed that
>>>>>>>>>>> such region is marked by MPU as non-cacheable. Robin suggested to
>>>>>>>>>>> advertise such memory as reserved shared-dma-pool, rather then using
>>>>>>>>>>> homebrew command line option, and extend dma-coherent to provide
>>>>>>>>>>> default DMA area in the similar way as it is done for CMA (PATCH
>>>>>>>>>>> 2/5). It allows us to offload all bookkeeping on generic coherent DMA
>>>>>>>>>>> framework, and it is seems that it might be reused by other
>>>>>>>>>>> architectures like c6x and blackfin.
>>>>>>>>>>>
>>>>>>>>>>> Dedicated DMA region is required for cases other than:
>>>>>>>>>>>  - MMU/MPU is off
>>>>>>>>>>>  - cpu is v7m w/o cache support
>>>>>>>>>>>  - device is coherent
>>>>>>>>>>>
>>>>>>>>>>> In case one of the above conditions is true dma operations are forced
>>>>>>>>>>> to be coherent and wired with dma_noop_ops.
>>>>>>>>>>>
>>>>>>>>>>> To make life easier NOMMU dma operations are kept in separate
>>>>>>>>>>> compilation unit.
>>>>>>>>>>>
>>>>>>>>>>> Since the issue was reported in the same time as Benjamin sent his
>>>>>>>>>>> patch [1] to allow mmap for NOMMU, his case is also addressed in this
>>>>>>>>>>> series (PATCH 1/5 and PATCH 3/5).
>>>>>>>>>>>
>>>>>>>>>>> Thanks!
>>>>>>>>>>
>>>>>>>>>> I have tested this v4 on my setup (stm32f4, no cache, no MPU) and unfortunately
>>>>>>>>>> it doesn't work with my drm/kms driver.
>>>>>>>>>
>>>>>>>>> I guess the same is for fbmem, but would be better to have confirmation since
>>>>>>>>> amba-clcd I use has not been ported to drm/kms (yet), so I can't test.
>>>>>>>>>
>>>>>>>>>> I haven't any errors but nothing is displayed unlike what I have when
>>>>>>>>>> using current dma-mapping
>>>>>>>>>> code.
>>>>>>>>>> I guess the issue is coming from dma-noop where __get_free_pages() is
>>>>>>>>>> used instead of alloc_pages()
>>>>>>>>>> in dma-mapping.
>>>>>>>>>
>>>>>>>>> Unless I've missed something bellow is a call stack for both
>>>>>>>>>
>>>>>>>>> #1
>>>>>>>>> __alloc_simple_buffer
>>>>>>>>>         __dma_alloc_buffer
>>>>>>>>>                 alloc_pages
>>>>>>>>>                 split_page
>>>>>>>>>                 __dma_clear_buffer
>>>>>>>>>                         memset
>>>>>>>>>         page_address
>>>>>>>>>
>>>>>>>>> #2
>>>>>>>>> __get_free_pages
>>>>>>>>>         alloc_pages
>>>>>>>>>         page_address
>>>>>>>>>
>>>>>>>>> So the difference is that nommu case in dma-mapping.c memzeros memory, handles
>>>>>>>>> DMA_ATTR_NO_KERNEL_MAPPING and does optimisation of memory usage.
>>>>>>>>>
>>>>>>>>> Is something from above critical for your driver?
>>>>>>>>
>>>>>>>> I have removed all the diff (split_page,  __dma_clear_buffer, memset)
>>>>>>>> from #1 and it is still working.
>>>>>>>> DMA_ATTR_NO_KERNEL_MAPPING flag is not set when allocating the buffer.
>>>>>>>>
>>>>>>>> I have investigated more and found that dma-noop doesn't take care of
>>>>>>>> "dma-ranges" property which is set in DT.
>>>>>>>> I believed that is the root cause of my problem with your patches.
>>>>>>>
>>>>>>> After testing changing virt_to_phys to virt_to_dma in dma-noop.c fix the issue
>>>>>>> modetest and fbdemo are now still functional.
>>>>>>>
>>>>>>
>>>>>> Thanks for narrowing it down! I did not noticed that stm32f4 remap its memory,
>>>>>> so dma-ranges property is in use.
>>>>>>
>>>>>> It looks like virt_to_dma is ARM specific, so I probably have to discard idea
>>>>>> of reusing dma-noop-ops and switch logic into dma-mapping-nommu.c based on
>>>>>> is_device_dma_coherent(dev) check.
>>>>>
>>>>> dma_pfn_offset is a member of struct device, so it should be OK for
>>>>> dma_noop_ops to also make reference to it (and assume it's zero if not
>>>>> explicitly set).
>>>>>
>>>>>> Meanwhile, I'm quite puzzled on how such memory remaping should work together
>>>>>> with reserved memory. It seem it doesn't account dma-ranges while reserving
>>>>>> memory (it is too early) nor while allocating/mapping/etc.
>>>>>
>>>>> The reserved memory is described in terms of CPU physical addresses, so
>>>>> a device offset shouldn't matter from that perspective. It only comes
>>>>> into play at the point you generate the dma_addr_t to hand off to the
>>>>> device - only then do you need to transform the CPU physical address of
>>>>> the allocated/mapped page into the device's view of that page (i.e.
>>>>> subtract the offset).
>>>>
>>>> Thanks for explanation! So dma-coherent.c should be modified, right? I see
>>>> that some architectures provide phys_to_dma/dma_to_phys helpers primary for
>>>> swiotlb, is it safe to reuse them given that default implementation is
>>>> provided? Nothing under Documentation explains how they supposed to be used,
>>>> sorry if asking stupid question.
>>>
>>> Those are essentially SWIOTLB-specific, so can't be universally relied
>>> upon. I think something like this ought to suffice:
>>
>> Yup, but what about dma-coherent.c? Currently it has 
>>
>> int dma_alloc_from_coherent(struct device *dev, ssize_t size,
>> 				       dma_addr_t *dma_handle, void **ret)
>> {
>> ...
>> 	*dma_handle = mem->device_base + (pageno << PAGE_SHIFT);
>> 	*ret = mem->virt_base + (pageno << PAGE_SHIFT);
>> ...
>> }
>>
>> In case reserved memory is described in terms of CPU phys addresses, would not
>> we need to take into account dma_pfn_offset? What I'm missing?
> 
> Ah yes, I overlooked that one. AFAICS, that's intended to be accounted
> for when calling dma_init_coherent_memory (i.e. phys_addr vs.
> device_addr), but that's a bit awkward for a global pool.
> 
> How utterly disgusting do you think this (or some variant thereof) looks?
> 
> 	/* Apply device-specific offset for the global pool */
> 	if (mem == dma_coherent_default_memory)
> 		*handle += dev->dma_pfn_offset << PAGE_SHIFT;

It'd work for default dma region, but IMO the issue is wider here... does
following look better?

diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
index b52ba27..22daa4c 100644
--- a/drivers/base/dma-coherent.c
+++ b/drivers/base/dma-coherent.c
@@ -27,6 +27,15 @@ static inline struct dma_coherent_mem *dev_get_coherent_memory(struct device *de
 	return dma_coherent_default_memory;
 }
 
+static inline dma_addr_t dma_get_device_base(struct device *dev,
+					     struct dma_coherent_mem * mem)
+{
+	if (!dev)
+		return mem->pfn_base << PAGE_SHIFT;
+
+	return (mem->pfn_base + dev->dma_pfn_offset) << PAGE_SHIFT;
+}
+
 static bool dma_init_coherent_memory(
 	phys_addr_t phys_addr, dma_addr_t device_addr, size_t size, int flags,
 	struct dma_coherent_mem **mem)
@@ -92,13 +101,19 @@ static void dma_release_coherent_memory(struct dma_coherent_mem *mem)
 static int dma_assign_coherent_memory(struct device *dev,
 				      struct dma_coherent_mem *mem)
 {
+	unsigned long dma_pfn_offset = mem->pfn_base - PFN_DOWN(mem->device_base);
+
 	if (!dev)
 		return -ENODEV;
 
 	if (dev->dma_mem)
 		return -EBUSY;
 
+	if (dev->dma_pfn_offset)
+		WARN_ON(dev->dma_pfn_offset != dma_pfn_offset);
+
 	dev->dma_mem = mem;
+	dev->dma_pfn_offset = dma_pfn_offset;
 	/* FIXME: this routine just ignores DMA_MEMORY_INCLUDES_CHILDREN */
 
 	return 0;
@@ -145,7 +160,7 @@ void *dma_mark_declared_memory_occupied(struct device *dev,
 		return ERR_PTR(-EINVAL);
 
 	spin_lock_irqsave(&mem->spinlock, flags);
-	pos = (device_addr - mem->device_base) >> PAGE_SHIFT;
+	pos = PFN_DOWN(device_addr - dma_get_device_base(dev, mem));
 	err = bitmap_allocate_region(mem->bitmap, pos, get_order(size));
 	spin_unlock_irqrestore(&mem->spinlock, flags);
 
@@ -195,8 +210,9 @@ int dma_alloc_from_coherent(struct device *dev, ssize_t size,
 	/*
 	 * Memory was found in the per-device area.
 	 */
-	*dma_handle = mem->device_base + (pageno << PAGE_SHIFT);
+	*dma_handle = dma_get_device_base(dev, mem) + (pageno << PAGE_SHIFT);
 	*ret = mem->virt_base + (pageno << PAGE_SHIFT);
+
 	dma_memory_map = (mem->flags & DMA_MEMORY_MAP);
 	spin_unlock_irqrestore(&mem->spinlock, flags);
 	if (dma_memory_map)

Cheers
Vladimir

> 
> Robin.
> 
>> Thanks
>> Vladimir
>>
>>>
>>> ---8<---
>>> diff --git a/lib/dma-noop.c b/lib/dma-noop.c
>>> index 3d766e78fbe2..fbb1b37750d5 100644
>>> --- a/lib/dma-noop.c
>>> +++ b/lib/dma-noop.c
>>> @@ -8,6 +8,11 @@
>>>  #include <linux/dma-mapping.h>
>>>  #include <linux/scatterlist.h>
>>>
>>> +static dma_addr_t dma_noop_dev_offset(struct device *dev)
>>> +{
>>> +       return (dma_addr_t)dev->dma_pfn_offset << PAGE_SHIFT;
>>> +}
>>> +
>>>  static void *dma_noop_alloc(struct device *dev, size_t size,
>>>                             dma_addr_t *dma_handle, gfp_t gfp,
>>>                             unsigned long attrs)
>>> @@ -16,7 +21,7 @@ static void *dma_noop_alloc(struct device *dev, size_t
>>> size,
>>>
>>>         ret = (void *)__get_free_pages(gfp, get_order(size));
>>>         if (ret)
>>> -               *dma_handle = virt_to_phys(ret);
>>> +               *dma_handle = virt_to_phys(ret) - dma_noop_dev_offset(dev);
>>>         return ret;
>>>  }
>>>
>>> @@ -32,7 +37,7 @@ static dma_addr_t dma_noop_map_page(struct device
>>> *dev, struct page *page,
>>>                                       enum dma_data_direction dir,
>>>                                       unsigned long attrs)
>>>  {
>>> -       return page_to_phys(page) + offset;
>>> +       return page_to_phys(page) + offset - dma_noop_dev_offset(dev);
>>>  }
>>>
>>>  static int dma_noop_map_sg(struct device *dev, struct scatterlist *sgl,
>>> int nents,
>>> @@ -47,7 +52,8 @@ static int dma_noop_map_sg(struct device *dev, struct
>>> scatterlist *sgl, int nent
>>>
>>>                 BUG_ON(!sg_page(sg));
>>>                 va = sg_virt(sg);
>>> -               sg_dma_address(sg) = (dma_addr_t)virt_to_phys(va);
>>> +               sg_dma_address(sg) = (dma_addr_t)virt_to_phys(va) -
>>> +                                       dma_noop_dev_offset(dev);
>>>                 sg_dma_len(sg) = sg->length;
>>>         }
>>> --->8---
>>>
>>> intentionally whitespace-damaged by copy-pasting off my terminal to
>>> emphasise how utterly untested it is ;)
>>>
>>> Robin.
>>>
>>
> 
> 
