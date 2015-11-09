From: js1304@gmail.com (Joonsoo Kim)
Date: Mon, 9 Nov 2015 16:41:58 +0900
Subject: [PATCH] arm64: Increase the max granular size
In-Reply-To: <20151105121706.GQ7637@e104818-lin.cambridge.arm.com>
References: <1442944788-17254-1-git-send-email-rric@kernel.org>
 <20151105044014.GB20374@js1304-P5Q-DELUXE>
 <20151105103214.GP7637@e104818-lin.cambridge.arm.com>
 <CAAmzW4MR_+0K5JbMMiRu_wVq736zVbz82ugvDYP=x6p=9JuELg@mail.gmail.com>
 <20151105121706.GQ7637@e104818-lin.cambridge.arm.com>
Message-ID: <CAAmzW4POKyGCFETiR1gRtT0iK+iWH254PGivZDnpjU1CHizgUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-11-05 21:17 GMT+09:00 Catalin Marinas <catalin.marinas@arm.com>:
> On Thu, Nov 05, 2015 at 08:45:08PM +0900, Joonsoo Kim wrote:
>> 2015-11-05 19:32 GMT+09:00 Catalin Marinas <catalin.marinas@arm.com>:
>> > On ARM we have a notion of cache writeback granule (CWG) which tells us
>> > "the maximum size of memory that can be overwritten as a result of the
>> > eviction of a cache entry that has had a memory location in it
>> > modified". What we actually needed was ARCH_DMA_MINALIGN to be 128
>> > (currently defined to the L1_CACHE_BYTES value). However, this wouldn't
>> > have fixed the KMALLOC_MIN_SIZE, unless we somehow generate different
>> > kmalloc_caches[] and kmalloc_dma_caches[] and probably introduce a
>> > size_dma_index[].
>>
>> If we create separate kmalloc caches for dma, can we apply this alignment
>> requirement only to dma caches? I guess some memory allocation request
>> that will be used for DMA operation doesn't specify GFP_DMA because
>> it doesn't want the memory from ZONE_DMA. In this case, we should apply
>> dma alignment requirement to all types of caches.
>
> I think you are right. While something like swiotlb (through the
> streaming DMA API) could do bounce buffering and allocate one from
> ZONE_DMA, this is not guaranteed if the buffer physical address happens
> to match the dma_mask. Similarly with an IOMMU, no bouncing happens but
> the alignment is still required.
>
>> If it isn't possible, is there another way to reduce memory waste due to
>> increase of dma alignment requirement in arm64?
>
> I first need to see how significant the impact is (especially for
> embedded/mobiles platforms).

I don't have any ARM64 device. What I have just one report
about slab usage from our developer.

The report shows slab usage just after android boot is done
in ARM64.

Total slab usage: 90 MB
kmalloc usage: 25 MB
kmalloc (<=64) usage: 7 MB

This would be measured without slab_nomerge so there is
a possibility that some usages on kmem_cache is merged
into usage of kmalloc (<=64).

Anyway, if ARM64 increase L1_CACHE_BYTES to 128, roughly
7 MB would be wasted. I don't know how this picture is varied
in runtime, but, even boot time overhead, 7 MB looks large to me.

> An alternative is to leave L1_CACHE_BYTES to 64 by default but warn if
> the CWG is 128 on systems with non-coherent DMA (and hope that we won't
> have any). It's not really fix, rather an assumption. Anyway I would
> very much like the same kernel image for all platforms and no Kconfig
> entry for the cache line size but if the waste is significant, we may
> add one for some specific builds (like a mobile phone; or such vendors
> could patch the kernel themselves).

Okay. In fact, I'm not very familiar with android device so it'd be better
for you to ask some other android developer about how significant
the impact is in android or mobile device.

Thanks.
