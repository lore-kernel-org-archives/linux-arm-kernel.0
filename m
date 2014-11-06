From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 6 Nov 2014 15:52:50 +0530
Subject: Unconditional registering EMDA platform devices
In-Reply-To: <2034542.1PWfBB7aBW@wuerfel>
References: <20141024142904.GC3142@lunn.ch> <2124815.5oBngWtcFV@wuerfel>
 <20141025184854.GA10780@kleine-koenig.org> <2034542.1PWfBB7aBW@wuerfel>
Message-ID: <545B4BFA.5000203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Peter, Vinod

On Sunday 26 October 2014 12:27 AM, Arnd Bergmann wrote:
> On Saturday 25 October 2014 20:48:54 Uwe Kleine-K?nig wrote:
>> On Fri, Oct 24, 2014 at 06:14:01PM +0200, Arnd Bergmann wrote:
>>> On Friday 24 October 2014 16:29:04 Andrew Lunn wrote:
>>>> giving warnings:
>>>>
>>>> [    0.114771] edma-dma-engine edma-dma-engine.0: Can't allocate PaRAM dummy slot
>>>> [    0.114794] edma-dma-engine: probe of edma-dma-engine.0 failed with error -5
>>>>
>>>> These seem to be coming from drivers/dma/emda.c
>>>>
>>>> That driver has a subsys_initcall(edma_init);
>>>>
>>>> and the edma_init function is unconditionally registering a driver and
>>>> a platform device. For a multiarch kernel, this is not a good idea.
>>>>
>>>> Please could you make this conditionally. Maybe look into the DT and
>>>> see if the DMA is needed on the platform?
>>>  
>>> I just looked at that code an I'm completely confused about how that
>>> even works today. I do see that the driver is used on ATAGS based
>>> davinci machines, which means we can't just look into the DT.
>>>
>>> The main problem seems to stem from arch/arm/common/edma.c being
>>> half the driver that provides interfaces to both drivers/dma/edma.c
>>> and to sound/soc/davinci/davinci-pcm.c, while drivers/dma/edma.c
>>> is not really a driver by itself. My preferred solution to this would
>>> be to move arch/arm/common/edma.c into drivers/dma/edma.c and still
>>> have it export its private API, but I assume that the dmaengine
>>> maintainers have already NAKed that approach.
>> Isn't the preferred solution that sound/soc/davinci/davinci-pcm.c only
>> uses dmaengine stuff and the private API goes away?
> 
> Absolutely, yes. I believe all other drivers have been converted
> already, and it's on somebody's TODO list.

Yes, Peter was looking at removing the usage of private DMA API from
davinci-pcm.

https://lkml.org/lkml/2014/8/11/85

It is still on his TODO.

> 
>>> 8<-------
>>> Subject: dma: edma: move device registration to platform code
>>>
>>> The horrible split between the low-level part of the edma support
>>> and the dmaengine front-end driver causes problems on multiplatform
>>> kernels. This is an attempt to improve the situation slightly
>>> by only registering the dmaengine devices that are actually
>>> present.
>>>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I tested this patch on DA850 using MMC/SD as EDMA client and it worked
fine. I think it will serve well as intermediate solution while Peter
works on folding in arch/arm/common/edma.c into drivers/dma/edma.c

I had to add the following patch on top to get DMA_BIT_MASK defined in
edma.c

---8<---
diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index f6cffee3c6ee..66725eb143ce 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -31,6 +31,7 @@
 #include <linux/of_dma.h>
 #include <linux/of_irq.h>
 #include <linux/pm_runtime.h>
+#include <linux/dma-mapping.h>

 #include <linux/platform_data/edma.h>
 ---8<---

In the same patch you can probably get rid of EDMA_CTLRS definition
too as you noted below.

If you decide to post it formally for Vinod to pick, you can add:

Acked-by: Sekhar Nori <nsekhar@ti.com>

>>> [...]
>>> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
>>> index 123f578d6dd3..4cfaaa5a49be 100644
>>> --- a/drivers/dma/edma.c
>>> +++ b/drivers/dma/edma.c
>> There is a comment in drivers/dma/edma.c reading:
>>
>> /*
>>  * This will go away when the private EDMA API is folded
>>  * into this driver and the platform device(s) are
>>  * instantiated in the arch code. We can only get away
>>  * with this simplification because DA8XX may not be built
>>  * in the same kernel image with other DaVinci parts. This
>>  * avoids having to sprinkle dmaengine driver platform devices
>>  * and data throughout all the existing board files.
>>  */
>>
>> Just looking into arch/arm/mach-davinci/Kconfig it seems wrong that
>> DA8XX may not be enabled with other DaVinci parts. So probably there is
>> really more broken here ...

This was true when the comment was written. We have since moved to
AUTO_ZRELADDR and a single config builds all DaVinci boards now.

Thanks,
Sekhar
