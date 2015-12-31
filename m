From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Thu, 31 Dec 2015 18:12:52 +0100
Subject: [Question about DMA] Consistent memory?
In-Reply-To: <CAK7LNAS3wXfJ_syOEMoi1aEt5_maNur05figQ472_9usGQagHQ@mail.gmail.com>
References: <CAK7LNASd1amcHinXzYy=8mtYbnHUY1G_v=fthpachAVSyjqPZA@mail.gmail.com>	<20151231102548.3ed389fb@lxorguk.ukuu.org.uk>
 <CAK7LNAS3wXfJ_syOEMoi1aEt5_maNur05figQ472_9usGQagHQ@mail.gmail.com>
Message-ID: <56856214.3050907@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31-12-2015 15:57, Masahiro Yamada wrote:
> Hi Alan, Mike,
>
> Thanks for your help!
>
>
> 2015-12-31 19:25 GMT+09:00 One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>:
>
>>>
>>> In a system like Fig.2, is the memory non-consistent?
>>
>> dma_alloc_coherent will always provide you with coherent memory. On a
>> machine with good cache interfaces it will provide you with normal
>> memory. On some systems it may be memory from a special window, in other
>> cases it will fall back to providing uncached memory for this.
>>
>> If the platform genuinely cannot support this (even by marking those areas
>> uncacheable) then it will fail the allocation.
>>
>> What it does mean is that you need to use non-coherent mappings when
>> accessing a lot of data. On hardware without proper cache coherency it
>> may be quite expensive to access coherent memory.
>
>
> Now, it is clearer to me.
> The following is what I understood.
> (Please point out if I am wrong.)
>
>
> I think, roughly, there are two ways for handling DMA:
> (At first, I was so confused that I was thinking about [1] and [2] mixed.)
>
>
>
> [1] DMA-coherent buffers
>
> Allocate buffers with dma_alloc_coherent()
> and just have access to the buffers without cache synchronization.
>
> There is no need to call dma_sync_single_for_*().
>
>
>
> [2] Streaming DMA
>
> Allocate buffers with kmalloc() or friends,
> and then map them for DMA with dma_map_single().
>
> The buffers are cached, so they are non-consitent
> unless there exists hardware assist such as
> Cache Coherency Interconnect.
>
> The drivers must invoke cache operations
> by calling dma_sync_single_for_*().
>
>
>
>
> Is there any guideline about which way should be used in drivers?
>
> I think, if the buffer size is small, [1] is more efficient
> because it need not invoke cache operations.
>
> If the buffer is large, [2] seems better because
> the cost of uncached memory access gets more expensive
> than that of cache operations.

There's no difference in choice for large or small blocks. The dma_sync 
functions take linear time (as function of block size) to do their 
thing, larger buffers take longer to flush.

On the Zynq (also ARM, with a choice of coherency connections) I 
measured that the dma_sync operations took only slightly less time than 
simply copying the data.

If the action taken on the buffer after the DMA completion is to copy it 
to (of from) a user buffer, you should use dma_coherent calls. That's 
what I meant by "bounce buffers".

If you plan to DMA data straight to/from userspace, you'll need the 
dma_sync methods. (On coherent systems, the dma_sync methods become no-ops).

> (If devices are connected to the memory controller
> via Cache Coherency Interconnect, [1] always works very well.
> But drivers should be written in a portable way, so
> such a hardware implementation should not be expected.)
>
> I am not sure about the border line between [1] and [2], though...
>
>
>
> BTW, I am studying the DMA APIs in order to write a new
> MMC host driver for my ARM SoC.
>
>
> I grepped under drivers/mmc/host, and
> I found many drivers call dma_alloc_coherent(),
> but there are also some drivers that use dma_map_single().

If I recall correctly, most MMC controllers have their own 
scatter-gather DMA controller and copy data straight to/from userspace 
buffers.

-- 
Mike Looijmans
