From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Fri, 08 May 2015 07:55:26 +0200
Subject: dma_alloc_coherent versus streaming DMA,
 neither works satisfactory
In-Reply-To: <20150507143010.GC2067@n2100.arm.linux.org.uk>
References: <5538DD02.6050401@topic.nl> <3382997.5hgfVKmNXP@wuerfel>
 <5540D356.50708@topic.nl> <9622793.RaVBbeJMCx@wuerfel>
 <554B49F0.1090100@topic.nl>
 <CAD8Lp45w6_ck13sG3PQ549AxsgTi96XQAkUEd9DQqt-i=ZXxUQ@mail.gmail.com>
 <554B6917.40705@topic.nl> <554B71F6.5000106@topic.nl>
 <20150507143010.GC2067@n2100.arm.linux.org.uk>
Message-ID: <554C4FCE.6070802@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07-05-15 16:30, Russell King - ARM Linux wrote:
> On Thu, May 07, 2015 at 04:08:54PM +0200, Mike Looijmans wrote:
>> I read the rest of the thread, apparently it was never integrated.
>>
>> The patch for "non-consistent" is a BUG FIX, not some feature request or so.
>> I was already wondering why my driver had to kalloc pages to get proper
>> caching on it.
>
> I disagree.
>
>>  From https://www.kernel.org/doc/Documentation/DMA-attributes.txt:
>> """
>> DMA_ATTR_NON_CONSISTENT ... lets the platform to choose to return either
>> consistent or non-consistent memory as it sees fit.  By using this API,
>> you are guaranteeing to the platform that you have all the correct and
>> necessary sync points for this memory in the driver.
>> """
>
> DMA attributes are something that came in _after_ the DMA API had been
> around for many years.  It's a "new feature" that was added to an
> existing subsystem, and because there have been no need for it to be
> implemented on ARM, the new feature was never implemented.
>
> More than that, the vast majority of ARM hardware can't provide this
> kind of memory, and there are _no_ kernel APIs to ensure that if

By "non-coherent" memory I thought it meant the same kind of memory that 
kalloc would return. But from your answer it seems I am mistaken and 
this is something different?

> cacheable memory were to be returned, they could issue the necessary
> cache flushes to ensure that the device could see the data.

Then what do the dma_sync_... methods do?

It has been my understanding that one can use dma_map... and dma_sync... 
methods to make memory ranges visible to the device.

Using dma_sync on coherent memory is just a waste of resources. So how 
do i allocate memory that I'm supposed to use with dma_sync?

> So it's _not_ a bug fix, and there have been very good reasons not to
> implement it.


-- 
Mike Looijmans
