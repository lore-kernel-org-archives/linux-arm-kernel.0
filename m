From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Thu, 7 Oct 2010 21:22:20 +0300
Subject: [RFC] tidspbridge: use a parameter to allocate shared memory
In-Reply-To: <4CADFCEB.4030008@ti.com>
References: <1286430336-20204-1-git-send-email-omar.ramirez@ti.com>
	<201010070940.14208.laurent.pinchart@ideasonboard.com>
	<4CADFCEB.4030008@ti.com>
Message-ID: <AANLkTim8H0ibSucP3Nq=q19t0QY0pvijim1kOZSbygY1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 7, 2010 at 8:01 PM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> On 10/7/2010 2:40 AM, Laurent Pinchart wrote:
>> On Thursday 07 October 2010 07:45:36 Omar Ramirez Luna wrote:
>>>
>>> tidspbridge driver uses a block of memory denominated SHared Memory
>>> to store info& ?communicate with DSP, this SHM needs to be physically
>>> contiguous and non-cacheable,
>>
>> There are non-cacheable mappings, but there's no such thing as
>> non-cacheable
>> memory. Does the MPU mapping for that SHM block really needs to be non-
>> cacheable,
>
> yes
>
>> your could you instead flush the cache after writing to it
>> (performance issues might be involved, I don't know the details about that
>> SHM
>> usage) ?
>
> You can do that too, but it will involve more changes to dsp side, and yes
> performance might be an issue too.

I think it's worth experimenting, otherwise it will be difficult for
people to compile and use the driver.

> The so called "shared memory" is used between arm tidspbridge and the DSP,
> they exchange communication structures/streams/messages/parameters needed on
> both sides for its correct functionality (this is an eagle-eye view of the
> SHM, for more info if interested check page 32 of the overview pdf[1]).
>
> tidspbridge could have the changes made for flushing the SHM every time it
> writes into it, a flag could be used to prevent both of them (ARM & DSP)
> flushing at the same time if needed, but I don't know how feasible would be
> making those changes in the dsp code.

The synchronization should be already be in place, otherwise you would
be overriding data regardless of the cacheability of that data.

Note that the "shared memory" described in the document you share has
nothing to do with the SHM pool. AFAIK that memory is used for other
things, like MMU PTEs, and storing the base image and socket-nodes,
thus it needs to be contiguous.

Right now allocating contiguous memory can only be done with memblock
(bootmem), but in the future it could be done with CMA/VCMM. But the
cacheability is a separate issue.

I don't see any problem flushing the SHM area when needed, which
probably has performance implications when mmaping/unmapping buffers,
at which point you need to flush bigger memory areas anyway, so that's
not an issue.

Anyway, we will not know for sure until we try... Right?

Cheers.

-- 
Felipe Contreras
