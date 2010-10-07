From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Thu, 7 Oct 2010 12:01:31 -0500
Subject: [RFC] tidspbridge: use a parameter to allocate shared memory
In-Reply-To: <201010070940.14208.laurent.pinchart@ideasonboard.com>
References: <1286430336-20204-1-git-send-email-omar.ramirez@ti.com>
	<201010070940.14208.laurent.pinchart@ideasonboard.com>
Message-ID: <4CADFCEB.4030008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/7/2010 2:40 AM, Laurent Pinchart wrote:
> Hi Omar,
>
> On Thursday 07 October 2010 07:45:36 Omar Ramirez Luna wrote:
>> tidspbridge driver uses a block of memory denominated SHared Memory
>> to store info&  communicate with DSP, this SHM needs to be physically
>> contiguous and non-cacheable,
>
> There are non-cacheable mappings, but there's no such thing as non-cacheable
> memory. Does the MPU mapping for that SHM block really needs to be non-
> cacheable,

yes

> your could you instead flush the cache after writing to it
> (performance issues might be involved, I don't know the details about that SHM
> usage) ?

You can do that too, but it will involve more changes to dsp side, and 
yes performance might be an issue too.

The so called "shared memory" is used between arm tidspbridge and the 
DSP, they exchange communication structures/streams/messages/parameters 
needed on both sides for its correct functionality (this is an eagle-eye 
view of the SHM, for more info if interested check page 32 of the 
overview pdf[1]).

tidspbridge could have the changes made for flushing the SHM every time 
it writes into it, a flag could be used to prevent both of them (ARM & 
DSP) flushing at the same time if needed, but I don't know how feasible 
would be making those changes in the dsp code.

Regards,

Omar

---
[1] 
https://gforge.ti.com/gf/download/docmanfileversion/17/674/OMAP3430_Bridge_overview.pdf
