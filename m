From: tharvey@gateworks.com (Tim Harvey)
Date: Fri, 18 May 2018 11:49:05 -0700
Subject: AArch64 memory
In-Reply-To: <bb3353c7-1ef1-403a-cbf0-7e311e55c276@arm.com>
References: <CAJ+vNU0RrmQMZ0P0LDWfLbryNSt02eDimKr4i6eWT7-ULMOUyg@mail.gmail.com>
 <6f34d5bb-3581-93c3-583b-347e75acf3bf@arm.com>
 <CAJ+vNU2kK1rF-ozLSyV-ctY=ySfkkzqMoFiFgSk724mXJ_Wa-w@mail.gmail.com>
 <bb3353c7-1ef1-403a-cbf0-7e311e55c276@arm.com>
Message-ID: <CAJ+vNU3BM0BnB=owYz6iTLeqexL3=uu3+PeoN4zGOcqg3=HLaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2018 at 11:15 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 18/05/18 17:43, Tim Harvey wrote:
> [...]
>
>>>> My second question has to do with CMA and coherent_pool. I have
>>>> understood CMA as being a chunk of physical memory carved out by the
>>>> kernel for allocations from dma_alloc_coherent by drivers that need
>>>> chunks of contiguous memory for DMA buffers. I believe that before CMA
>>>> was introduced we had to do this by defining memory holes. I'm not
>>>> understanding the difference between CMA and the coherent pool. I've
>>>> noticed that if CONFIG_DMA_CMA=y then the coherent pool allocates from
>>>> CMA. Is there some disadvantage of CONFIG_DMA_CMA=y other than if
>>>> defined you need to make sure your CMA is larger than coherent_pool?
>>>> What drivers/calls use coherent_pool vs cma?
>>>
>>>
>>>
>>> coherent_pool is a special thing which exists for the sake of
>>> non-hardware-coherent devices - normally for those we satisfy
>>> DMA-coherent
>>> allocations by setting up a non-cacheable remap of the allocated buffer -
>>> see dma_common_contiguous_remap(). However, drivers may call
>>> dma_alloc_coherent(..., GFP_ATOMIC) from interrupt handlers, at which
>>> point
>>> we can't call get_vm_area() to remap on demand, since that might sleep,
>>> so
>>> we reserve a pool pre-mapped as non-cacheable to satisfy such atomic
>>> allocations from. I'm not sure why its user-visible name is "coherent
>>> pool"
>>> rather than the more descriptive "atomic pool" which it's named
>>> internally,
>>> but there's probably some history there. If you're lucky enough not to
>>> have
>>> any non-coherent DMA masters then you can safely ignore the whole thing;
>>> otherwise it's still generally rare that it should need adjusting.
>>
>>
>> is there an easy way to tell if I have non-coherent DMA masters? The
>> Cavium SDK uses a kernel cmdline param of coherent_pool=16M so I'm
>> guessing something in the CN80XX/CN81XX (BGX NIC's or CPT perhaps)
>> need atomic pool mem.
>
>
> AFAIK the big-boy CN88xx is fully coherent everywhere, but whether the
> peripherals and interconnect in the littler Octeon TX variants are different
> I have no idea. If the contents of your dts-newport repo on GitHub are the
> right thing to be looking at, then you do have the "dma-coherent" property
> on the PCI nodes, which should cover everything beneath (I'd expect that in
> reality the SMMU may actually be coherent as well, but fortunately that's
> irrelevant here). Thus everything which matters *should* be being picked up
> as coherent already, and if not it would be a Linux problem. I can't imagine
> what the SDK is up to there, but 16MB of coherent pool does sound like
> something being done wrong, like incorrectly compensating for bad firmware
> failing to describe the hardware properly in the first place.

Yes https://github.com/Gateworks/dts-newport/ is the board that I'm
working with :)

Ok, I think I understand now that the dma-coherent property on the PCI
host controller is saying that all allocations by PCI device drivers
will come from the atomic pool defined by coherent_pool=.

Why does coherent_pool=16M seem wrong to you?

>
>>> CMA is, as you surmise, a much more general thing for providing large
>>> physically-contiguous areas, which the arch code correspondingly uses to
>>> get
>>> DMA-contiguous buffers. Unless all your DMA masters are behind IOMMUs
>>> (such
>>> that we can make any motley collection of pages look DMA-contiguous), you
>>> probably don't want to turn it off. None of these details should be
>>> relevant
>>> as far as drivers are concerned, since from their viewpoint it's all
>>> abstracted behind dma_alloc_coherent().
>>>
>>
>> I don't want to turn off CONFIG_CMA but I'm still not clear if I
>> should turn off CONFIG_DMA_CMA. I noticed the Cavium SDK 4.9 kernel
>> has CONFIG_CMA=y but does not enable CONFIG_DMA_CMA which I believe
>> means that the atomic pool does not pull its chunks from the CMA pool.
>
>
> I wouldn't think there's much good reason to turn DMA_CMA off either, even
> if nothing actually needs huge DMA buffers. Where the atomic pool comes from
> shouldn't really matter, as it's a very early one-off allocation. To
> speculate wildly I suppose there *might* possibly be some performance
> difference between cma_alloc() and falling back to the regular page
> allocator - if that were the case it ought to be measurable by profiling
> something which calls dma_alloc_coherent() in process context a lot, under
> both configurations. Even then I'd imagine it's something that would matter
> most on the 2-socket 96-core systems, and not so much on the diddy ones.
>

If you enable DMA_CMA then you have to make sure to size CMA large
enough to handle coherent_pool (and any additional CMA you will need).
I made the mistake of setting CONFIG_CMA_SIZE_MBYTES=16 then passing
in a coherent_pool=64M which causes the coherent pool DMA allocation
to fail and I'm not clear if that even has an impact on the system. It
seems to me that the kernel should perhaps catch the case where CMA <
dma_coherent when CONFIG_CMA_DMA=y and either warn about that
condition or set cma to coherent_pool to resolve it.

Tim
