From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 30 Mar 2017 12:46:17 +0100
Subject: [PATCH] arm64/dma-mapping: fix DMA_ATTR_FORCE_CONTIGUOUS mmaping
 code
In-Reply-To: <bd77ea57-96a8-bbc4-8184-9ddfd443f3c6@samsung.com>
References: <CGME20170329100540eucas1p22d428e33aa678cbef0a24dd249820451@eucas1p2.samsung.com>
 <1490781926-6209-1-git-send-email-a.hajda@samsung.com>
 <15b1be13-625f-db74-d213-ad1df86f7eb5@arm.com>
 <073f1feb-d6da-c93f-8e67-0910befec27b@samsung.com>
 <c13f6475-f503-238f-c101-4f9cdf1b0ae2@arm.com>
 <45fde94b-9487-c28e-9d4e-3b36c4b4a934@samsung.com>
 <CAMuHMdWkOdAD=d0DAy7cJTHcQc7oq5HVDvTNtjfQETMynx1_+g@mail.gmail.com>
 <8dcbb0b3-dd13-d2b3-90f5-64b900d67778@samsung.com>
 <41097b2c-9bbc-31e4-d17d-8c3f638ec1a6@arm.com>
 <bd77ea57-96a8-bbc4-8184-9ddfd443f3c6@samsung.com>
Message-ID: <868d0c3c-6b85-0709-1686-66b484ede46d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/03/17 12:16, Andrzej Hajda wrote:
[...]
>>>>> I guess Geert's proposition to create pages permanently is also not
>>>>> acceptable[2]. So how to fix crashes which appeared after patch adding
>>>> If I'm not mistaken, creating the pages permanently is what the
>>>> !DMA_ATTR_FORCE_CONTIGUOUS does? The only difference is where
>>>> the underlying memory is allocated from.
>>>>
>>>> Am I missing something?
>>> Quoting Robin from his response:
>>>> in general is is not
>>>> safe to assume a coherent allocation is backed by struct pages at all
>>> As I said before I am not familiar with the subject, so it is possible I
>>> misunderstood something.
>> That's from the perspective of external callers of
>> dma_alloc_coherent()/dma_alloc_attrs(), wherein
>> dma_alloc_from_coherent() may have returned device-specific memory
>> without calling into the arch dma_map_ops implementation. Internal to
>> the arm64 implementation, however, everything *we* allocate comes from
>> either CMA or the normal page allocator, so should always be backed by
>> real kernel pages.
>>
>> Robin.
> 
> 
> OK, so what do you exactly mean by "The general point still stands", my
> patch fixes handling of allocations made internally?

That since FORCE_CONTIGUOUS allocations always come from CMA, you can
let the existing CMA-based implementations handle them just by fixing up
dma_addr appropriately.

> Anyway as I understand approach "creating the pages permanently" in
> __iommu_alloc_attrs is OK. Is it worth to create patch adding it? It
> should solve the issue as well and also looks saner (for me).

Sure, you *could* - there's nothing technically wrong with that other
than violating a strict interpretation of the iommu-dma API
documentation if you pass it into iommu_dma_mmap() - it's just that the
only point of using the pages array here in the first place is to cover
the general case where an allocation might not be physically contiguous.
If you have a guarantee that a given allocation definitely *is* both
physically and virtually contiguous, then that's a bunch of extra work
you simply have no need to do.

If you do want to go down that route, then I would much rather we fix
dma_common_contiguous_remap() to leave a valid array in area->pages in
the first place, than be temporarily faking them up around individual calls.

Robin.
