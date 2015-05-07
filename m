From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Thu, 7 May 2015 16:08:54 +0200
Subject: dma_alloc_coherent versus streaming DMA,
 neither works satisfactory
In-Reply-To: <554B6917.40705@topic.nl>
References: <5538DD02.6050401@topic.nl>	<3382997.5hgfVKmNXP@wuerfel>	<5540D356.50708@topic.nl>	<9622793.RaVBbeJMCx@wuerfel>	<554B49F0.1090100@topic.nl>
 <CAD8Lp45w6_ck13sG3PQ549AxsgTi96XQAkUEd9DQqt-i=ZXxUQ@mail.gmail.com>
 <554B6917.40705@topic.nl>
Message-ID: <554B71F6.5000106@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?On 07-05-15 15:31, Mike Looijmans wrote:
> On 07-05-15 15:21, Daniel Drake wrote:
>> On Thu, May 7, 2015 at 5:18 AM, Mike Looijmans <mike.looijmans@topic.nl> wrote:
>>> I reverted all my patches and workarounds. Indeed, the kernel needs a
>>> "coherent" version of the dma_mmap routine, as the current version will map
>>> it as non-cachable, resulting in a big performance hit (and nullifying the
>>> whole idea behind it).
>>>
>>> I'll test it further on my 'hardware' and cook up a patch that correctly
>>> maps the coherent pages.
>>
>> Sorry that I have only read this thread briefly, but I wonder if this
>> is what you are looking for:
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/325489.html
>
> It's related, but targets another use case. This one does the same in case the
> driver requested non-consistent memory.
>
> My use case was that I have hardware implemented coherency (through ACP) so
> the CPU's and device's view on memory is already consistent, regardless of the
> status of the cache.
>
> The patches are complimentary, not overlapping.
>
> Thanks for the link though, it's something I was also looking into, as I don't
> always need coherency.

I read the rest of the thread, apparently it was never integrated.

The patch for "non-consistent" is a BUG FIX, not some feature request or so. I 
was already wondering why my driver had to kalloc pages to get proper caching 
on it.

 From https://www.kernel.org/doc/Documentation/DMA-attributes.txt:
"""
DMA_ATTR_NON_CONSISTENT ... lets the platform to choose to return either
consistent or non-consistent memory as it sees fit.  By using this API,
you are guaranteeing to the platform that you have all the correct and
necessary sync points for this memory in the driver.
"""

The current ARM implementation is to *always* return memory that is 
non-cachable, even if the driver promises to do all the right things.
If the intention was that every implementation could get away with just 
ignoring the flag, the flag would not have existed. So the implementation 
should do the best it can do here, and the patch shows that it's just a simple 
one-liner to make it implement the flag as intended.

As for use cases, IIO is a candidate for this too, as it has explicit 
interfaces to move buffers to/from userspace without having to remap them over 
and over again. My usecase here is Dyplo, which uses a similar interface. If 
you do something as simple as "for (i=0;i<size;++i) sum += (char*)buffer[i]; 
in userspace on such a buffer, performance will collapse to about 1/20th 
because of the memory being non-cachable. The whole point of IIO is to prevent 
having to copy these buffers around.

(I'd rather add this plea to the that thread, but I'd have to figure out how 
to reply to a thread from the web...)

Mike.


Kind regards,

Mike Looijmans
System Expert

TOPIC Embedded Products
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
Telefax: +31 (0) 499 33 69 70
E-mail: mike.looijmans@topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
