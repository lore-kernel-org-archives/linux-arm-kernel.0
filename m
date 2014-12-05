From: arend@broadcom.com (Arend van Spriel)
Date: Fri, 5 Dec 2014 20:22:05 +0100
Subject: using DMA-API on ARM
In-Reply-To: <20141205182851.GC31222@e104818-lin.cambridge.arm.com>
References: <5481794E.4050406@broadcom.com>
 <20141205094507.GP11285@n2100.arm.linux.org.uk>
 <20141205122423.GK1630@arm.com>
 <F51492713EF10846800D8C0ED37A7DCE019016E1@SJEXCHMB15.corp.ad.broadcom.com>
 <20141205132332.GS11285@n2100.arm.linux.org.uk>
 <20141205150648.GT11285@n2100.arm.linux.org.uk>
 <20141205182851.GC31222@e104818-lin.cambridge.arm.com>
Message-ID: <548205DD.4080101@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/14 19:28, Catalin Marinas wrote:
> On Fri, Dec 05, 2014 at 03:06:48PM +0000, Russell King - ARM Linux wrote:
>> I've been doing more digging into the current DMA code, and I'm dismayed
>> to see that there's new bugs in it...
>>
>> commit 513510ddba9650fc7da456eefeb0ead7632324f6
>> Author: Laura Abbott<lauraa@codeaurora.org>
>> Date:   Thu Oct 9 15:26:40 2014 -0700
>>
>>      common: dma-mapping: introduce common remapping functions
>>
>> This uses map_vm_area() to achieve the remapping of pages allocated inside
>> dma_alloc_coherent().  dma_alloc_coherent() is documented in a rather
>> round-about way in Documentation/DMA-API.txt:
>>
>> | Part Ia - Using large DMA-coherent buffers
>> | ------------------------------------------
>> |
>> | void *
>> | dma_alloc_coherent(struct device *dev, size_t size,
>> |                              dma_addr_t *dma_handle, gfp_t flag)
>> |
>> | void
>> | dma_free_coherent(struct device *dev, size_t size, void *cpu_addr,
>> |                            dma_addr_t dma_handle)
>> |
>> | Free a region of consistent memory you previously allocated.  dev,
>> | size and dma_handle must all be the same as those passed into
>> | dma_alloc_coherent().  cpu_addr must be the virtual address returned by
>> | the dma_alloc_coherent().
>> |
>> | Note that unlike their sibling allocation calls, these routines
>> | may only be called with IRQs enabled.
>>
>> Note that very last paragraph.  What this says is that it is explicitly
>> permitted to call dma_alloc_coherent() with IRQs disabled.
>
> This is solved by using a pre-allocated, pre-mapped atomic_pool which
> avoids any further mapping. __dma_alloc() calls __alloc_from_pool() when
> !__GFP_WAIT.

So we are actually calling dma_alloc_coherent() with GFP_KERNEL during 
device probe. That last paragraph Russell pointed out seems to suggest 
this is not allowed.

> This code got pretty complex and we may find bugs. It can be simplified
> by a pre-allocated non-cacheable region that is safe in atomic context
> (how big you allocate this is hard to say).
>
>> If the problem which you (Broadcom) are suffering from is down to the
>> issue I suspect (that being having mappings with different cache
>> attributes) then I'm not sure that there's anything we can realistically
>> do about that.  There's a number of issues which make it hard to see a
>> way forward.
>
> I'm still puzzled by this problem, so I don't have any suggestion yet. I
> wouldn't blame the mismatched attributes yet as I haven't seen such
> problem in practice (but you never know).
>
> How does the DT describe this device? Could it have some dma-coherent
> property in there that causes dma_alloc_coherent() to create a cacheable
> memory?

Ok. Will add it to our todo list: check DTS files for dma-coherent property.

Thanks,
Arend

> The reverse could also cause problems: the device is coherent but the
> CPU creates a non-cacheable mapping.
>
