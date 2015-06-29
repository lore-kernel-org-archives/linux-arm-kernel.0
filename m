From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Mon, 29 Jun 2015 08:44:50 +0200
Subject: dma-mapping: support for DMA_ATTR_NON_CONSISTENT DMA attribute
In-Reply-To: <CAF6-1L4g0W6kboZt52fHBUPxGYWYn9-9vmm=0-WQVv1-YdfOEA@mail.gmail.com>
References: <CAF6-1L5c-PbK_wfpvz1xdRkquXyuQDv4mvKfYp8fwA1LK9ZOyw@mail.gmail.com>
 <20150628224543.GW7557@n2100.arm.linux.org.uk>
 <CAF6-1L4g0W6kboZt52fHBUPxGYWYn9-9vmm=0-WQVv1-YdfOEA@mail.gmail.com>
Message-ID: <5590E962.4020700@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?On 29-06-15 07:24, Sylvain Munaut wrote:
>> ... and then using the *streaming* API dma_sync_* calls on it.  That
>> is invalid, and will lead to undefined results on implementations of
>> dma_alloc_coherent() which return remapped memory (as for older ARMs.)
>> This is an abuse of the API.
>
> Ok, fine, but then
>
> _How_ do I do it properly ?  From a driver module, how do I allocate a
> large chunk ( > 4M so no alloc_pages and no kmalloc ) of contiguous
> memory that's cacheable and that I can use with the streaming API ?

To the best of my knowledge, and after asking around here, the only answer 
I've so far been able to get is that alloc_pages (and hence, kmalloc) is the 
method to call.

It would be nice if there were a dma_alloc_streaming() interface, which might 
just translate to kalloc directly, but it would at least get rid of all the 
obscurities of allocating DMA memory.

I fell into the same pit as Sylvain here, initially I was also allocating with 
dma_alloc_...

I submitted a patch to amend the dma documentation a while ago, but never got 
a response, so I probably sent it to the wrong group.

> Or alternatively, what are the correct "sync points" that the doc refers to ?
>
> """ By using this API, you are guaranteeing to the platform that you
> have all the correct and necessary sync points for this memory in the
> driver should it choose to return non-consistent memory."""
>
> I had assumed it was the dma_sync_* calls, but apparently not.

I think the answer is "the dma_sync_* calls plus whatever it is your DMA 
controller hardware needs to do"

If that's the case, where should I send the documentation patch?



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
