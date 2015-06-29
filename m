From: s.munaut@whatever-company.com (Sylvain Munaut)
Date: Mon, 29 Jun 2015 12:05:09 +0200
Subject: dma-mapping: support for DMA_ATTR_NON_CONSISTENT DMA attribute
In-Reply-To: <5590E962.4020700@topic.nl>
References: <CAF6-1L5c-PbK_wfpvz1xdRkquXyuQDv4mvKfYp8fwA1LK9ZOyw@mail.gmail.com>
 <20150628224543.GW7557@n2100.arm.linux.org.uk>
 <CAF6-1L4g0W6kboZt52fHBUPxGYWYn9-9vmm=0-WQVv1-YdfOEA@mail.gmail.com>
 <5590E962.4020700@topic.nl>
Message-ID: <CAF6-1L584tp5o8U7S-w4-_XSjH4uXdMJSY89grLyFuwrJF3UyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> _How_ do I do it properly ?  From a driver module, how do I allocate a
>> large chunk ( > 4M so no alloc_pages and no kmalloc ) of contiguous
>> memory that's cacheable and that I can use with the streaming API ?
>
> To the best of my knowledge, and after asking around here, the only answer
> I've so far been able to get is that alloc_pages (and hence, kmalloc) is the
> method to call.

But as I mentioned that doesn't work for chunks larger than 4M due to
the MAX_ORDER.

I'd want that memory to come out of the CMA pool ideally (since afaict
it's the most reliable way to get large chunks of contiguous memory).
But the CMA stuff is not available directly and the only "visible"
interface to it I could find is the dma_alloc_xxx methods.


> It would be nice if there were a dma_alloc_streaming() interface, which
> might just translate to kalloc directly, but it would at least get rid of
> all the obscurities of allocating DMA memory.

+1


>> """ By using this API, you are guaranteeing to the platform that you
>> have all the correct and necessary sync points for this memory in the
>> driver should it choose to return non-consistent memory."""
>>
>> I had assumed it was the dma_sync_* calls, but apparently not.
>
>
> I think the answer is "the dma_sync_* calls plus whatever it is your DMA
> controller hardware needs to do"

Well that can't be since the dma_sync_* are part of streaming API and
the dma_alloc_attrs is part of the "coherent" API (even though you
have the NON_COHERENT flag in it ... that's a bit weird).

But I don't see the alternative, unless the doc is suggesting I
basically do all the cache invalidation myself manually and doing arch
specific stuff directly in the driver ?


Cheers,

   Sylvain
