From: js1304@gmail.com (Joonsoo Kim)
Date: Thu, 5 Nov 2015 20:45:08 +0900
Subject: [PATCH] arm64: Increase the max granular size
In-Reply-To: <20151105103214.GP7637@e104818-lin.cambridge.arm.com>
References: <1442944788-17254-1-git-send-email-rric@kernel.org>
 <20151105044014.GB20374@js1304-P5Q-DELUXE>
 <20151105103214.GP7637@e104818-lin.cambridge.arm.com>
Message-ID: <CAAmzW4MR_+0K5JbMMiRu_wVq736zVbz82ugvDYP=x6p=9JuELg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-11-05 19:32 GMT+09:00 Catalin Marinas <catalin.marinas@arm.com>:
> On Thu, Nov 05, 2015 at 01:40:14PM +0900, Joonsoo Kim wrote:
>> On Tue, Sep 22, 2015 at 07:59:48PM +0200, Robert Richter wrote:
>> > From: Tirumalesh Chalamarla <tchalamarla@cavium.com>
>> >
>> > Increase the standard cacheline size to avoid having locks in the same
>> > cacheline.
>> >
>> > Cavium's ThunderX core implements cache lines of 128 byte size. With
>> > current granulare size of 64 bytes (L1_CACHE_SHIFT=6) two locks could
>> > share the same cache line leading a performance degradation.
>> > Increasing the size fixes that.
>>
>> Beside, slab-side bug, I don't think this argument is valid.
>> Even if this change is applied, statically allocated spinlock could
>> share the same cache line.
>
> The benchmarks didn't show any difference with or without this patch
> applied. What convinced me to apply it was this email:
>
> http://lkml.kernel.org/g/CAOZdJXUiRMAguDV+HEJqPg57MyBNqEcTyaH+ya=U93NHb-pdJA at mail.gmail.com

Okay.

> On ARM we have a notion of cache writeback granule (CWG) which tells us
> "the maximum size of memory that can be overwritten as a result of the
> eviction of a cache entry that has had a memory location in it
> modified". What we actually needed was ARCH_DMA_MINALIGN to be 128
> (currently defined to the L1_CACHE_BYTES value). However, this wouldn't
> have fixed the KMALLOC_MIN_SIZE, unless we somehow generate different
> kmalloc_caches[] and kmalloc_dma_caches[] and probably introduce a
> size_dma_index[].

If we create separate kmalloc caches for dma, can we apply this alignment
requirement only to dma caches? I guess some memory allocation request
that will be used for DMA operation doesn't specify GFP_DMA because
it doesn't want the memory from ZONE_DMA. In this case, we should apply
dma alignment requirement to all types of caches.

In fact, I know someone who try to implement this alignment separation like
as you mentioned to reduce memory waste. I first suggest this solution
to him but now I realize that it isn't possible because of above reason.

Am I missing?

If it isn't possible, is there another way to reduce memory waste due to
increase of dma alignment requirement in arm64?

Thanks.
