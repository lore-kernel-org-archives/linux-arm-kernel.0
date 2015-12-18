From: dianders@chromium.org (Doug Anderson)
Date: Fri, 18 Dec 2015 10:55:08 -0800
Subject: [PATCH] ARM: dma-mapping: Just allocate one chunk at a time
In-Reply-To: <5673FEF0.1080504@arm.com>
References: <1450384253-1067-1-git-send-email-dianders@chromium.org>
 <CAD=FV=XP9zx2XEmo7vS0MdsROJ0JoRYFidnRaBLxR43GXnuqag@mail.gmail.com>
 <5673FEF0.1080504@arm.com>
Message-ID: <CAD=FV=XxSBe8=OJHpMqk9mPUnhNZ5pF5otJWr-2RedEkuMp+Kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robin,

On Fri, Dec 18, 2015 at 4:41 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> Hi Doug,
>
>
> On 17/12/15 22:31, Doug Anderson wrote:
>>
>> Hi,
>>
>> On Thu, Dec 17, 2015 at 12:30 PM, Douglas Anderson
>> <dianders@chromium.org> wrote:
>>>
>>> The __iommu_alloc_buffer() is expected to be called to allocate pretty
>>> sizeable buffers.  Upon simple tests of video I saw it trying to
>>> allocate 4,194,304 bytes.  The function tries to be efficient about this
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
>>> - The memory manager doesn't need to work so hard to give us big chunks.
>>> - We can save the big chunks for those that really need them and this
>>>    code can make great use of all the small chunks sitting around.
>>>
>>> Let's simplify by just allocating one page at a time.  We may make more
>>> total allocate calls but it works way better.  In real world tests that
>>> used to sometimes see a 24 second allocation call I can now see at most
>>> 250 ms.

One thing to note is that testing yesterday I actually managed to
reproduce an allocation taking 120 seconds (!) with the old code.


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
>
> I think sorting individually-allocated pages really isn't worth the effort -
> I'm not aware of anything that's going to be capable of using larger
> page/section mappings without also having the necessary physical alignment,
> and if you _can_ cobble together, say, 2MB worth of contiguous pages *at 2MB
> alignment*, then you would have been far better off just asking the slab
> allocator for that in the first place.
>
> That's the key point of the higher-order allocation - not that you get some
> contiguous pages, but that the region you get is also naturally aligned to
> its size physically. That we break up the CPU page tables for that region
> into individual pages is just an inconsequential implementation detail from
> the IOMMU side. When you _do_ have plenty of unfragmented free memory it can
> really be a big win - here's an instrumented example of what happens on my
> Juno with the ARM HDLCD/SMMU combo setting up a framebuffer at boot time:
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
> Since the IOVA region itself is aligned to 8MB (for the total size) and the
> physical regions come out in optimal decreasing order, we're able to map
> over 80% of the whole buffer with just 3 section entries, with a
> corresponding saving on TLB pressure, page table maintenance (cache
> flushing), etc.
>
> That said, unless you're in the middle of some crazy allocator-thrashing
> race, then it's probably safe to assume that once allocation fails at a
> given order that's going to remain the case in the near future - would you
> mind taking the following diff for a spin under your test conditions to see
> how it compares?
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
> @@ -1160,9 +1161,10 @@ static struct page **__iommu_alloc_buffer(struct
> device *dev, size_t size,
>         gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
>
>         while (count) {
> -               int j, order;
> +               int j;
>
> -               for (order = __fls(count); order > 0; --order) {
> +               for (order = min_t(unsigned int, order, __fls(count));
> +                    order > 0; --order) {

Yeah, I'd been playing with things like that, though not that exact patch.

I just tried it now.  As should be obvious, it certainly makes a
DRASTIC improvement in things but it still has some downsides as
compared to my patch.

1. It's still pretty easy for arm_iommu_alloc_attrs() to take many
seconds.  I can no longer reproduce the 24 second or 120 second
allocation call, but I still see things like "alloc 4194304 bytes:
3208093877 ns" (AKA an allocation taking > 3 seconds).  That's
compared with 250 ms max with my patch.

2. We still have the same problem that we're taking away all the
contiguous memory that other users may want.  I've got a dwc2 USB
controller in my system and it needs to allocate bounce buffers for
its DMA.  While looking at cat videos on Facebook and running a
program to simulate memory pressure (4 userspace programs each walking
through 350 Megs of memory over and over) I start seeing lots of order
3 allocation failures in dwc2.  It's true that the USB/network stack
is resilient against these allocation failures (other than spamming my
log), but performance will decrease.  When I switch to WiFi I suddenly
start seeing "mwifiex_sdio mmc2:0001:1: single skb allocated fail,
drop pkt port=28 len=33024".  Again, it's robust, but you're affecting
performance.



I also tried using "4" instead of "MAX_ORDER" (as per Marek) so that
we don't try for > 64K chunks.  This is might be a reasonable
compromise.  My cat video test still reproduces "alloc 4194304 bytes:
674318751 ns", but maybe ~700 ms is an OK?  Of course, this still eats
all the large chunks of memory that everyone else would like to have.


Oh, or how about this: we start allocating of order 4.  Upon the first
failure we jump to order 1.  AKA: if there's no memory pressure we're
golden.  The moment we have the first bit of memory pressure we fold.
That's basically just a slight optimization on Marek's suggestion.  I
still see 450 ms for an allocation, but that's not too bad.  It can
still take away large chunks from other users, but maybe that's OK?


Anyway, I'll plan to send that patch up.  I'll also do a quick test to
see if my "sort()" actually helps anything.

-Doug
