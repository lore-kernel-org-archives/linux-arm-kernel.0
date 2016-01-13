From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 13 Jan 2016 17:44:18 +0000
Subject: [PATCH v5 1/5] ARM: dma-mapping: Optimize allocation
In-Reply-To: <CAAFQd5C8asfo8wSa=jKvp4Vmg6A83R-vG7vQXtsHyOTADLo+9g@mail.gmail.com>
References: <1452294332-23415-1-git-send-email-dianders@chromium.org>
 <1452294332-23415-2-git-send-email-dianders@chromium.org>
 <56964070.1020303@arm.com>
 <CAAFQd5C8asfo8wSa=jKvp4Vmg6A83R-vG7vQXtsHyOTADLo+9g@mail.gmail.com>
Message-ID: <56968CF2.1020409@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/01/16 17:33, Tomasz Figa wrote:
> On Wed, Jan 13, 2016 at 9:17 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>> Hi Doug,
>>
>>
>> On 08/01/16 23:05, Douglas Anderson wrote:
>>>
>>> The __iommu_alloc_buffer() is expected to be called to allocate pretty
>>> sizeable buffers.  Upon simple tests of video I saw it trying to
>>> allocate 4,194,304 bytes.  The function tries to allocate large chunks
>>> in order to optimize IOMMU TLB usage.
>>>
>>> The current function is very, very slow.
>>>
>>> One problem is the way it keeps trying and trying to allocate big
>>> chunks.  Imagine a very fragmented memory that has 4M free but no
>>> contiguous pages at all.  Further imagine allocating 4M (1024 pages).
>>> We'll do the following memory allocations:
>>> - For page 1:
>>>     - Try to allocate order 10 (no retry)
>>>     - Try to allocate order 9 (no retry)
>>>     - ...
>>>     - Try to allocate order 0 (with retry, but not needed)
>>> - For page 2:
>>>     - Try to allocate order 9 (no retry)
>>>     - Try to allocate order 8 (no retry)
>>>     - ...
>>>     - Try to allocate order 0 (with retry, but not needed)
>>> - ...
>>> - ...
>>>
>>> Total number of calls to alloc() calls for this case is:
>>>     sum(int(math.log(i, 2)) + 1 for i in range(1, 1025))
>>>     => 9228
>>>
>>> The above is obviously worse case, but given how slow alloc can be we
>>> really want to try to avoid even somewhat bad cases.  I timed the old
>>> code with a device under memory pressure and it wasn't hard to see it
>>> take more than 120 seconds to allocate 4 megs of memory! (NOTE: testing
>>> was done on kernel 3.14, so possibly mainline would behave
>>> differently).
>>>
>>> A second problem is that allocating big chunks under memory pressure
>>> when we don't need them is just not a great idea anyway unless we really
>>> need them.  We can make due pretty well with smaller chunks so it's
>>> probably wise to leave bigger chunks for other users once memory
>>> pressure is on.
>>>
>>> Let's adjust the allocation like this:
>>>
>>> 1. If a big chunk fails, stop trying to hard and bump down to lower
>>>      order allocations.
>>> 2. Don't try useless orders.  The whole point of big chunks is to
>>>      optimize the TLB and it can really only make use of 2M, 1M, 64K and
>>>      4K sizes.
>>>
>>> We'll still tend to eat up a bunch of big chunks, but that might be the
>>> right answer for some users.  A future patch could possibly add a new
>>> DMA_ATTR that would let the caller decide that TLB optimization isn't
>>> important and that we should use smaller chunks.  Presumably this would
>>> be a sane strategy for some callers.
>>
>>
>> Now that I've had time to think about it properly:
>>
>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>>
>> I just had an absolutely disgusting idea of how to get the same progression
>> with just a single variable and no static array, but I'll keep that firmly
>> to myself as it's almost IOCCC-grade WTF :D
>
> Just out of curiosity, a bitmap and loop with fls() and clearing bit
> on failure or something more freaky? :)

Got a Python interpreter handy?

order = 9
for i in range(4):
     print order
     order = (order - 1) & 0xc

Like I said, disgusting :D

Robin.

>
> Anyway:
>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>
> Best regards,
> Tomasz
>
