From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 18 Dec 2015 15:38:10 +0100
Subject: [PATCH] ARM: dma-mapping: Just allocate one chunk at a time
In-Reply-To: <5673FEF0.1080504@arm.com>
References: <1450384253-1067-1-git-send-email-dianders@chromium.org>
 <CAD=FV=XP9zx2XEmo7vS0MdsROJ0JoRYFidnRaBLxR43GXnuqag@mail.gmail.com>
 <5673FEF0.1080504@arm.com>
Message-ID: <56741A52.3020100@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2015-12-18 13:41, Robin Murphy wrote:
> Hi Doug,
>
> On 17/12/15 22:31, Doug Anderson wrote:
>> Hi,
>>
>> On Thu, Dec 17, 2015 at 12:30 PM, Douglas Anderson
>> <dianders@chromium.org> wrote:
>>> The __iommu_alloc_buffer() is expected to be called to allocate pretty
>>> sizeable buffers.  Upon simple tests of video I saw it trying to
>>> allocate 4,194,304 bytes.  The function tries to be efficient about 
>>> this
>>> by starting out allocating large chunks and then moving to smaller and
>>> smaller chunk sizes until it succeeds.
>>>
>>> The current function is very, very slow.
>>>
>>> One problem is the way it keeps trying and trying to allocate big
>>> chunks.  Imagine a very fragmented memory that has 4M free but no
>>> contiguous pages at all.  Further imagine allocating 4M (1024 pages).
>>> We'll do the following memory allocations:
>>> - For page 1:
>>>    - Try to allocate order 10 (no retry)
>>>    - Try to allocate order 9 (no retry)
>>>    - ...
>>>    - Try to allocate order 0 (with retry, but not needed)
>>> - For page 2:
>>>    - Try to allocate order 9 (no retry)
>>>    - Try to allocate order 8 (no retry)
>>>    - ...
>>>    - Try to allocate order 0 (with retry, but not needed)
>>> - ...
>>> - ...
>>>
>>> Total number of calls to alloc() calls for this case is:
>>>    sum(int(math.log(i, 2)) + 1 for i in range(1, 1025))
>>>    => 9228
>>>
>>> The above is obviously worse case, but given how slow alloc can be we
>>> really want to try to avoid even somewhat bad cases.  I timed the old
>>> code with a device under memory pressure and it wasn't hard to see it
>>> take more than 24 seconds to allocate 4 megs of memory (!!).
>>>
>>> A second problem (and maybe even more important) is that allocating big
>>> chunks when we don't need them is just not a good idea anyway.  The
>>> first thing we do with these big chunks is break them into smaller
>>> chunks!  If we allocate small chunks:
>>> - The memory manager doesn't need to work so hard to give us big 
>>> chunks.
>>> - We can save the big chunks for those that really need them and this
>>>    code can make great use of all the small chunks sitting around.
>>>
>>> Let's simplify by just allocating one page at a time.  We may make more
>>> total allocate calls but it works way better.  In real world tests that
>>> used to sometimes see a 24 second allocation call I can now see at most
>>> 250 ms.
>>
>> Off-list I talked to Dmitry about this a little bit and he pointed out
>> that contiguous chunks actually give a benefit to the IOMMU.  I don't
>> think the benefit outweighs the cost in this case, but I'm happy to
>> hear what others have to say.  I did some quick printouts and it turns
>> out that even when requesting page at a time the memory manager
>> (unsurprisingly) can in many cases still give us pages that are
>> contiguous.
>>
>> Also I'm happy to post up
>> <https://chromium-review.googlesource.com/#/c/319210/> which sorts the
>> array and could possibly give us larger chunks of contiguous memory.
>
> I think sorting individually-allocated pages really isn't worth the 
> effort - I'm not aware of anything that's going to be capable of using 
> larger page/section mappings without also having the necessary 
> physical alignment, and if you _can_ cobble together, say, 2MB worth 
> of contiguous pages *at 2MB alignment*, then you would have been far 
> better off just asking the slab allocator for that in the first place.
>
> That's the key point of the higher-order allocation - not that you get 
> some contiguous pages, but that the region you get is also naturally 
> aligned to its size physically. That we break up the CPU page tables 
> for that region into individual pages is just an inconsequential 
> implementation detail from the IOMMU side. When you _do_ have plenty 
> of unfragmented free memory it can really be a big win - here's an 
> instrumented example of what happens on my Juno with the ARM 
> HDLCD/SMMU combo setting up a framebuffer at boot time:
>
>
>   iommu_dma_alloc: alloc size 0x753000, 1875 pages
>   __iommu_dma_alloc_pages: allocated at order 10
>   __iommu_dma_alloc_pages: allocated at order 9
>   __iommu_dma_alloc_pages: allocated at order 8
>   __iommu_dma_alloc_pages: allocated at order 6
>   __iommu_dma_alloc_pages: allocated at order 4
>   __iommu_dma_alloc_pages: allocated at order 1
>   __iommu_dma_alloc_pages: allocated at order 0
>   iommu: map: iova 0xff800000 pa 0x00000009f5400000 size 0x400000
>   iommu: mapping: iova 0xff800000 pa 0x00000009f5400000 pgsize 0x200000
>   iommu: mapping: iova 0xffa00000 pa 0x00000009f5600000 pgsize 0x200000
>   iommu: map: iova 0xffc00000 pa 0x00000000fa200000 size 0x200000
>   iommu: mapping: iova 0xffc00000 pa 0x00000000fa200000 pgsize 0x200000
>   iommu: map: iova 0xffe00000 pa 0x00000009f5a00000 size 0x100000
>   iommu: mapping: iova 0xffe00000 pa 0x00000009f5a00000 pgsize 0x1000
>   iommu: mapping: iova 0xffe01000 pa 0x00000009f5a01000 pgsize 0x1000
>   iommu: mapping: iova 0xffe02000 pa 0x00000009f5a02000 pgsize 0x1000
>   iommu: mapping: iova 0xffe03000 pa 0x00000009f5a03000 pgsize 0x1000
>   ...
>
> Since the IOVA region itself is aligned to 8MB (for the total size) 
> and the physical regions come out in optimal decreasing order, we're 
> able to map over 80% of the whole buffer with just 3 section entries, 
> with a corresponding saving on TLB pressure, page table maintenance 
> (cache flushing), etc.
>
> That said, unless you're in the middle of some crazy 
> allocator-thrashing race, then it's probably safe to assume that once 
> allocation fails at a given order that's going to remain the case in 
> the near future

Right, this is reasonable improvement. It should reduce the tries of higher
order.

Please note that mapping memory with larger pages significantly improves
performance, especially when IOMMU has a little TLB cache. This can be 
easily
observed when multimedia devices do processing of RGB data with 90/270 
degree
rotation. However I didn't notice much improvement between 2MiB and 64KiB
mappings.

Maybe it will be enough start trying from 64KiB instead of MAX_ORDER?


> - would you mind taking the following diff for a spin under your test 
> conditions to see how it compares?
>
> Robin.
>
> ----->8-----
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index dfb5001..95e75c4 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1129,6 +1129,7 @@ static struct page **__iommu_alloc_buffer(struct 
> device *dev, size_t size,
>         int count = size >> PAGE_SHIFT;
>         int array_size = count * sizeof(struct page *);
>         int i = 0;
> +       unsigned int order = MAX_ORDER;
>
>         if (array_size <= PAGE_SIZE)
>                 pages = kzalloc(array_size, GFP_KERNEL);
> @@ -1160,9 +1161,10 @@ static struct page 
> **__iommu_alloc_buffer(struct device *dev, size_t size,
>         gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
>
>         while (count) {
> -               int j, order;
> +               int j;
>
> -               for (order = __fls(count); order > 0; --order) {
> +               for (order = min_t(unsigned int, order, __fls(count));
> +                    order > 0; --order) {
>                         /*
>                          * We do not want OOM killer to be invoked as 
> long
>                          * as we can fall back to single pages, so we 
> force
>
>
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
