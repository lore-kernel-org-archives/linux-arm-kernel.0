From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 15 Apr 2015 11:36:55 +0300
Subject: [PATCH v4 1/8] dmaengine: of_dma: Support for DMA routers
In-Reply-To: <20150410074058.GN26727@lukather>
References: <1428498892-28471-1-git-send-email-peter.ujfalusi@ti.com>
 <1428498892-28471-2-git-send-email-peter.ujfalusi@ti.com>
 <20150408154251.GE26727@lukather> <5526375A.7090708@ti.com>
 <20150410074058.GN26727@lukather>
Message-ID: <552E2327.4050203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2015 10:40 AM, Maxime Ripard wrote:
> On Thu, Apr 09, 2015 at 11:24:58AM +0300, Peter Ujfalusi wrote:
>> On 04/08/2015 06:42 PM, Maxime Ripard wrote:
>>>> ---
>>>>  Documentation/devicetree/bindings/dma/dma.txt | 28 +++++++++
>>>>  drivers/dma/dmaengine.c                       |  7 +++
>>>>  drivers/dma/of-dma.c                          | 86 +++++++++++++++++++++++++++
>>>>  include/linux/dmaengine.h                     | 17 ++++++
>>>>  include/linux/of_dma.h                        | 21 +++++++
>>>>  5 files changed, 159 insertions(+)
>>>
>>> Can that be moved to a header / C file of its own?
>>>
>>> There's a lot of various code already in dmaengine.h and dmaengine.c,
>>> it would be really great to avoid adding more random stuff in there.
>>
>> This patch adds the core support for DMA signal routers. It adds
>> fairly small amount of generic code to the core to achieve this. I
>> don't think it would be better to create let's say of-dma-router.c
>> and .h just for this and export functions from of-dma.c to be used
>> outside of the file.
> 
> A lot of "a fairly small amount of generic code" has been added over
> time, and we ended up in the current situation.

So that we have fairly good dmaengine core? If people using the code, they
will eventually fix things, add new features. When dmaengine came to existence
we did not had DMA routers, now that the SoCs are getting even more
complicated they are coming (in case of DRA7x, it is already here).

> It's a bit sad if we just end up moving this just after it got merged,
> especially if it doesn't have any kind of dependency on any of the
> core function.

This provides core functionality to handle DMA signal routers via DT. It does
depend on the DT DMA parsing core code as it integrates with it.

>> The signal router is not a DMA device, it is represented in the device tree
>> and the code will do the needed translation, which is transparent for the DMA
>> clients and also for the DMA controllers. Neither should know about the signal
>> router.
> 
> Yeah, I got that part, and we do agree on that.
> 
>> Similar translation can be done for ACPI.
> 
> But this argument is exactly why it shouldn't be tied to the device
> tree. We wouldn't like to re-do all this all over again for ACPI,
> while your code seems to just handle that very well, wouldn't we?

The data structures used by the DT and ACPI layers are different. Underneath
DT and ACPI we do not have enough information on how to handle the DMA signal
router. If you happen to have multiple DMA controllers in the system for
example how would you tell how the routers are connected?
In DRA7x we have sDMA and eDMA controllers. Both have similar DMA crossbar. It
is only possible to know the hierarchy of the components via DT. I'm sure this
is the same for ACPI. You take away the ACPI layer and you loose the topology
of the system.
Probably with huge architectural change in the dmaengine core (and thus with
all the drivers) this might be possible, but I don't think that is a valid
route to take.

-- 
P?ter
