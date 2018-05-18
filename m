From: tharvey@gateworks.com (Tim Harvey)
Date: Fri, 18 May 2018 09:43:34 -0700
Subject: AArch64 memory
In-Reply-To: <6f34d5bb-3581-93c3-583b-347e75acf3bf@arm.com>
References: <CAJ+vNU0RrmQMZ0P0LDWfLbryNSt02eDimKr4i6eWT7-ULMOUyg@mail.gmail.com>
 <6f34d5bb-3581-93c3-583b-347e75acf3bf@arm.com>
Message-ID: <CAJ+vNU2kK1rF-ozLSyV-ctY=ySfkkzqMoFiFgSk724mXJ_Wa-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2018 at 4:59 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> Hi Tim,
>
> On 17/05/18 16:58, Tim Harvey wrote:
>>
>> Greetings,
>>
>> I'm trying to understand some details of the AArch64 memory
>> configuration in the kernel.
>>
>> I've looked at Documentation/arm64/memory.txt which describes the
>> virtual memory layout used in terms of translation levels. This
>> relates to CONFIG_ARM64_{4K,16K,64K}_PAGES and CONFIG_ARM64_VA_BITS*.
>>
>> My first question has to do with virtual memory layout: What are the
>> advantages and disadvantages for a system with a fixed 2GB of DRAM
>> when using using 4KB pages + 3 levels (CONFIG_ARM64_4K_PAGES=y
>> CONFIG_ARM64_VA_BITS=39) resulting in 512GB user / 512GB kernel vs
>> using 64KB pages + 3 levels (CONFIG_ARM64_64K_PAGES=y
>> CONFIG_ARM64_VA_BITS=48)? The physical memory is far less than what
>> any of the combinations would offer but I'm not clear if the number of
>> levels affects any sort of performance or how fragmentation could play
>> into performance.
>
>
> There have been a number of discussions on the lists about the general topic
> in the contexts of several architectures, and I'm sure the last one I saw
> regarding arm64 actually had some measurements in it, although it's proving
> remarkably tricky to actually dig up again this morning :/
>
> I think the rough executive summary remains that for certain
> memory-intensive workloads on AArch64, 64K pages *can* give a notable
> performance benefit in terms of reduced TLB pressure (and potentially also
> some for TLB miss overhead with 42-bit VA and 2-level tables). The (major)
> tradeoff is that for most other workloads, including much of the kernel
> itself, the increased allocation granularity leads to a significant increase
> in wasted RAM.
>
> My gut feeling is that if you have relatively limited RAM and don't know
> otherwise, then 39-bit VA is probably the way to go - notably, there are
> also still drivers/filesystems/etc. which don't play too well with PAGE_SIZE
> != 4096 - but I'm by no means an expert in this area. If you're targeting a
> particular application area (e.g. networking) and can benchmark some
> representative workloads to look at performance vs. RAM usage for different
> configs, that would probably help inform your decision the most.

Robin,

Thanks for the explanation - this makes sense and I understand that
its not easy to determine what is best. I'll do some tests with the
boards I'm working with (which are Cavium Octeon-TX CN80XX quad-core
1.5GHz boards with 1MB L2 cache and 2GB 32bit DDR4 with up to 5x GbE).

>
>> My second question has to do with CMA and coherent_pool. I have
>> understood CMA as being a chunk of physical memory carved out by the
>> kernel for allocations from dma_alloc_coherent by drivers that need
>> chunks of contiguous memory for DMA buffers. I believe that before CMA
>> was introduced we had to do this by defining memory holes. I'm not
>> understanding the difference between CMA and the coherent pool. I've
>> noticed that if CONFIG_DMA_CMA=y then the coherent pool allocates from
>> CMA. Is there some disadvantage of CONFIG_DMA_CMA=y other than if
>> defined you need to make sure your CMA is larger than coherent_pool?
>> What drivers/calls use coherent_pool vs cma?
>
>
> coherent_pool is a special thing which exists for the sake of
> non-hardware-coherent devices - normally for those we satisfy DMA-coherent
> allocations by setting up a non-cacheable remap of the allocated buffer -
> see dma_common_contiguous_remap(). However, drivers may call
> dma_alloc_coherent(..., GFP_ATOMIC) from interrupt handlers, at which point
> we can't call get_vm_area() to remap on demand, since that might sleep, so
> we reserve a pool pre-mapped as non-cacheable to satisfy such atomic
> allocations from. I'm not sure why its user-visible name is "coherent pool"
> rather than the more descriptive "atomic pool" which it's named internally,
> but there's probably some history there. If you're lucky enough not to have
> any non-coherent DMA masters then you can safely ignore the whole thing;
> otherwise it's still generally rare that it should need adjusting.

is there an easy way to tell if I have non-coherent DMA masters? The
Cavium SDK uses a kernel cmdline param of coherent_pool=16M so I'm
guessing something in the CN80XX/CN81XX (BGX NIC's or CPT perhaps)
need atomic pool mem.

>
> CMA is, as you surmise, a much more general thing for providing large
> physically-contiguous areas, which the arch code correspondingly uses to get
> DMA-contiguous buffers. Unless all your DMA masters are behind IOMMUs (such
> that we can make any motley collection of pages look DMA-contiguous), you
> probably don't want to turn it off. None of these details should be relevant
> as far as drivers are concerned, since from their viewpoint it's all
> abstracted behind dma_alloc_coherent().
>

I don't want to turn off CONFIG_CMA but I'm still not clear if I
should turn off CONFIG_DMA_CMA. I noticed the Cavium SDK 4.9 kernel
has CONFIG_CMA=y but does not enable CONFIG_DMA_CMA which I believe
means that the atomic pool does not pull its chunks from the CMA pool.

Thanks,

Tim
