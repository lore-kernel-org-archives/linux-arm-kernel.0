From: lorenx4@gmail.com (Lorenzo Nava)
Date: Sun, 28 Jun 2015 22:14:43 +0200
Subject: [RFC PATCH v3] arm DMA: Fix allocation from CMA for coherent DMA
In-Reply-To: <20150626162549.GK3078@e104818-lin.cambridge.arm.com>
References: <1434663862-17858-1-git-send-email-lorenx4@gmail.com>
 <20150626162549.GK3078@e104818-lin.cambridge.arm.com>
Message-ID: <CAE=W-e3YUjT=KbYTizBwg+3huvFLDqHvhzZN-oPqEnOKUXAtoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 26, 2015 at 6:25 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Thu, Jun 18, 2015 at 11:44:22PM +0200, Lorenzo Nava wrote:
>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> index 7e7583d..8e7f402 100644
>> --- a/arch/arm/mm/dma-mapping.c
>> +++ b/arch/arm/mm/dma-mapping.c
>> @@ -645,15 +645,29 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
>>       size = PAGE_ALIGN(size);
>>       want_vaddr = !dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs);
>>
>> -     if (is_coherent || nommu())
>> +     if (nommu()) {
>>               addr = __alloc_simple_buffer(dev, size, gfp, &page);
>> -     else if (!(gfp & __GFP_WAIT))
>> +             goto dma_alloc_done;
>> +     }
>> +
>> +     if (dev_get_cma_area(dev) && (gfp & __GFP_WAIT)) {
>> +             addr = __alloc_from_contiguous(dev, size, prot, &page,
>> +                                            caller, want_vaddr);
>> +             goto dma_alloc_done;
>> +     }
>> +
>> +     if (is_coherent) {
>> +             addr = __alloc_simple_buffer(dev, size, gfp, &page);
>> +             goto dma_alloc_done;
>> +     }
>> +
>> +     if (!(gfp & __GFP_WAIT))
>>               addr = __alloc_from_pool(size, &page);
>> -     else if (!dev_get_cma_area(dev))
>> -             addr = __alloc_remap_buffer(dev, size, gfp, prot, &page, caller, want_vaddr);
>>       else
>> -             addr = __alloc_from_contiguous(dev, size, prot, &page, caller, want_vaddr);
>> +             addr = __alloc_remap_buffer(dev, size, gfp, prot, &page,
>> +                                         caller, want_vaddr);
>>
>> +dma_alloc_done:
>>       if (page)
>>               *handle = pfn_to_dma(dev, page_to_pfn(page));
>
> The logic here looks alright but I would have preferred the original
> more concise "if ... else if" constructs than the gotos (just personal
> preference).
>
Ok, I can switch back to "if..else": I thought it was becoming too
difficult to read, but in the end the code looks good also with the
original style.

>> @@ -680,9 +694,14 @@ void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
>>  static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
>>       dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
>>  {
>> -     pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
>> +     pgprot_t prot;
>>       void *memory;
>>
>> +     if (attrs == NULL)
>> +              prot  = PAGE_KERNEL;
>> +     else
>> +              prot  = __get_dma_pgprot(attrs, PAGE_KERNEL);
>> +
>>       if (dma_alloc_from_coherent(dev, size, handle, &memory))
>>               return memory;
>
> I still think this is the wrong way to fix. It doesn't address the
> coherent dma mmap operation. I already replied on the previous version
> that we should rather have an extra argument "coherent" to
> __get_dma_pgprot().
>
I avoided touching the __get_dma_pgprot() function because it affects
a lot of different functions.
If you think that the implementation you suggested in previous reply
was ok and doesn't introduce problems on the other functions using the
__get_dma_pgprot(), for me it's of course ok as well. Do you see any
code that maybe need a double check: I'm thinking, for example, at the
function arm_iommu_alloc_attrs() and arm_iommu_mmap_attrs()? I agree
with you that the extra argument in the __get_dma_pgprot() function is
definitely the best solution, but I have to be sure that this doesn't
affect any other functions with unexpected behaviour.
For the dma mmap there is still the patch "[PATCH v3]
arm/mm/dma-mapping.c: Add arm_coherent_dma_mmap" which corrects the
behaviour of mapped attributes and makes this version of patch ok.

>> @@ -735,12 +754,12 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
>>
>>       size = PAGE_ALIGN(size);
>>
>> -     if (is_coherent || nommu()) {
>> +     if (nommu()) {
>>               __dma_free_buffer(page, size);
>>       } else if (__free_from_pool(cpu_addr, size)) {
>>               return;
>
> You have an unnecessary __free_from_pool() call here in the is_coherent
> case.
Ok, I'll fix it. Do you think that short-circuit evaluation can be
used here or it is better to use another solution?

>
>>       } else if (!dev_get_cma_area(dev)) {
>> -             if (want_vaddr)
>> +             if (want_vaddr && !is_coherent)
>>                       __dma_free_remap(cpu_addr, size);
>>               __dma_free_buffer(page, size);
>>       } else {
>
> --
> Catalin

Thanks.
Lorenzo
