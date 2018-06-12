From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 12 Jun 2018 09:31:23 +0200
Subject: [PATCH] arm64: dma-mapping: clear buffers allocated with
 FORCE_CONTIGUOUS flag
In-Reply-To: <20180611123104.GD1050@arm.com>
References: <CGME20180611051352eucas1p1f256a2a303da85a1e0923f012d709e39@eucas1p1.samsung.com>
 <20180611051340.9024-1-m.szyprowski@samsung.com>
 <CAMuHMdV8PTBArnaoXMXsuTqxLcizAZe4YO59TkZ6Wj-F4M6Sbg@mail.gmail.com>
 <20180611123104.GD1050@arm.com>
Message-ID: <20180612073124eucas1p18fd911ee122fea0939df7ef1c88b127c~3WTVvPusx0398003980eucas1p1H@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2018-06-11 14:31, Will Deacon wrote:
> On Mon, Jun 11, 2018 at 09:55:54AM +0200, Geert Uytterhoeven wrote:
>> Hi Marek,
>>
>> Thanks for your patch!
>>
>> On Mon, Jun 11, 2018 at 7:14 AM Marek Szyprowski
>> <m.szyprowski@samsung.com> wrote:
>>> dma_alloc_*() buffers might be exposed to userspace via mmap() call, so
>>> they should be cleared on allocation. In case of IOMMU-based dma-mapping
>>> implementation such buffer clearing was missing in the code path for
>>> DMA_ATTR_FORCE_CONTIGUOUS flag handling. This patch fixes this issue. For
>> Is it? The memory is allocated using dma_alloc_from_contiguous(..., gfp),
>> and __iommu_alloc_attrs() has
>>
>>          /*
>>           * Some drivers rely on this, and we probably don't want the
>>           * possibility of stale kernel data being read by devices anyway.
>>           */
>>          gfp |= __GFP_ZERO;
>>
>> at the top, before the allocation.
>>
>> If cma_alloc() (called from dma_alloc_from_contiguous()) doesn't honor
>> __GFP_ZERO, I think cma_alloc() should be fixed instead.
> Agreed. We tried to fix this in 7132813c3845 ("arm64: Honor __GFP_ZERO in
> dma allocations"). Has something broken that?

The code for handling DMA_ATTR_FORCE_CONTIGUOUS flag in arm64 
dma-mapping/iommu
implementation has been added later and assumed that __GFP_ZERO flag is
handled by dma_alloc_from_contiguous(). This is sadly not true, so the 
buffer
allocated this way is not cleared.

In case of ARM (32bit) the newly allocated buffer is always cleared directly
after calling dma_alloc_from_contiguous() function.

I agree that adding handling of __GFP_ZERO flag to 
dma_alloc_from_contiguous()
or rather cma_alloc() is a better idea, but might have some side effects, so
such change is not a good candidate for -rc cycle. I will prepare such 
patch,
but for now this one is imho a bit less invasive approach.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
