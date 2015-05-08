From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Fri, 8 May 2015 10:31:53 +0200
Subject: dma_alloc_coherent versus streaming DMA,
 neither works satisfactory
In-Reply-To: <8321046.lcCOUd7NLp@wuerfel>
References: <5538DD02.6050401@topic.nl>
 <20150507143010.GC2067@n2100.arm.linux.org.uk> <554C4FCE.6070802@topic.nl>
 <8321046.lcCOUd7NLp@wuerfel>
Message-ID: <554C7479.3050306@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?On 08-05-15 09:54, Arnd Bergmann wrote:
> On Friday 08 May 2015 07:55:26 Mike Looijmans wrote:
>> On 07-05-15 16:30, Russell King - ARM Linux wrote:
>>> On Thu, May 07, 2015 at 04:08:54PM +0200, Mike Looijmans wrote:
>>>> I read the rest of the thread, apparently it was never integrated.
>>>>
>>>> The patch for "non-consistent" is a BUG FIX, not some feature request or so.
>>>> I was already wondering why my driver had to kalloc pages to get proper
>>>> caching on it.
>>>
>>> I disagree.
>>>
>>>>   From https://www.kernel.org/doc/Documentation/DMA-attributes.txt:
>>>> """
>>>> DMA_ATTR_NON_CONSISTENT ... lets the platform to choose to return either
>>>> consistent or non-consistent memory as it sees fit.  By using this API,
>>>> you are guaranteeing to the platform that you have all the correct and
>>>> necessary sync points for this memory in the driver.
>>>> """
>>>
>>> DMA attributes are something that came in _after_ the DMA API had been
>>> around for many years.  It's a "new feature" that was added to an
>>> existing subsystem, and because there have been no need for it to be
>>> implemented on ARM, the new feature was never implemented.
>>>
>>> More than that, the vast majority of ARM hardware can't provide this
>>> kind of memory, and there are _no_ kernel APIs to ensure that if
>>
>> By "non-coherent" memory I thought it meant the same kind of memory that
>> kalloc would return. But from your answer it seems I am mistaken and
>> this is something different?
>
> It depends: on a device that is actually cache-coherent,
> dma_alloc_coherent() and dma_alloc_noncoherent() both return normal
> memory.
>
> On some architectures (not ARM) that are not fully coherent,
> dma_alloc_coherent() has to return uncached memory, while
> dma_alloc_noncoherent() is allowed to return cached memory but
> requires a dma_cache_sync() operation.
>
> dma_alloc_attrs() with DMA_ATTR_NON_CONSISTENT is a variant of that,
> but I assume the idea is that you use dma_sync_single_fo_{cpu,device}()
> on that memory, which can actually work on  ARM, unlike dma_cache_sync().

Ah, okay, I was misled by the names. I was under the impression that memory 
would be either "coherent" or "non-coherent". But what is called 
"non-coherent" here is actually something like "less-coherent", it isn't 
normal memory as alloc_pages would return, but it also isn't completely 
coherent. Is that a correct summary?

In that case, I stand corrected.

>>> cacheable memory were to be returned, they could issue the necessary
>>> cache flushes to ensure that the device could see the data.
>>
>> Then what do the dma_sync_... methods do?
>>
>> It has been my understanding that one can use dma_map... and dma_sync...
>> methods to make memory ranges visible to the device.
>
> That is correct, but the DMA_ATTR_NON_CONSISTENT flag is not meaningful
> with dma_map_...(), as that memory is not assumed to be consistent unless
> you call dma_sync_...() to start with.
>
>> Using dma_sync on coherent memory is just a waste of resources. So how
>> do i allocate memory that I'm supposed to use with dma_sync?
>
> The traditional API (before the various attributes is):
>
> dma_alloc_coherent()      --> never requires sync
> dma_alloc_writecombine()  --> never requires sync, arch specific
> dma_alloc_noncoherent()   --> dma_cache_sync(), arch specific
> alloc_pages + dma_map_*() --> dma_sync_*
>
> The dma_alloc_coherent() and dma_sync_*() interfaces are supposed to
> determine themselves whether they need to do any cache management
> based on whether the device is coherent already or not.

Okay, so in my case, I need to forget about the "non_coherent" stuff, it's 
something specific to a few platforms.

I was looking for an interface that would allocate memory for access by my 
device, but that would be just alloc_pages style memory. If my DMA controller 
is limited to say only the first GB of RAM, I'd set the DMA mask to "30 bits". 
If I just allocate memory using alloc_pages, the kernel doesn't know that I'd 
want it to be in the lower 1GB range, and could allocate it in a spot my 
device could not map.

Hence I'd expect there to be some "dma_alloc_pages(struct device* ...)" style 
of call to get memory that my device could access (and I was under the false 
impression that dma_alloc_noncoherent was the one I was looking for).

Currently I can get away with just using alloc_pages or kmalloc since my DMA 
controller happens to be able to access all memory. But I also want my device 
driver to work on 64-bit platforms (e.g. arm64 for the MPSOC and x86-64 for 
the PCIe version of the board).

M.


Kind regards,

Mike Looijmans
System Expert

TOPIC Embedded Products
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
Telefax: +31 (0) 499 33 69 70
E-mail: mike.looijmans at topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
