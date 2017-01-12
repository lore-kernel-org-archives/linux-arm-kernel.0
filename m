From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 12 Jan 2017 13:43:13 +0000
Subject: [PATCH 1/2] dma-mapping: let arch know origin of dma range passed
 to arch_setup_dma_ops()
In-Reply-To: <3273119.LjYLKcrNcz@wuerfel>
References: <dca35acf-1adf-aa85-7a0b-d0c6ec702fa1@arm.com>
 <764334db-3400-58c6-cc4b-3f7ce66daa27@cogentembedded.com>
 <20170112121623.GH1771@arm.com> <3273119.LjYLKcrNcz@wuerfel>
Message-ID: <f3fcd74b-7264-7ff2-4f70-7bf4235302de@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/01/17 13:25, Arnd Bergmann wrote:
> On Thursday, January 12, 2017 12:16:24 PM CET Will Deacon wrote:
>> On Thu, Jan 12, 2017 at 08:52:51AM +0300, Nikita Yushchenko wrote:
>>>>> diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
>>>>> index 5ac373c..480b644 100644
>>>>> --- a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
>>>>> +++ b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
>>>>> @@ -540,7 +540,7 @@ int fsl_mc_device_add(struct dprc_obj_desc *obj_desc,
>>>>>  
>>>>>    /* Objects are coherent, unless 'no shareability' flag set. */
>>>>>    if (!(obj_desc->flags & DPRC_OBJ_FLAG_NO_MEM_SHAREABILITY))
>>>>> -          arch_setup_dma_ops(&mc_dev->dev, 0, 0, NULL, true);
>>>>> +          arch_setup_dma_ops(&mc_dev->dev, 0, 0, false, NULL, true);
>>>>>  
>>>>>    /*
>>>>>     * The device-specific probe callback will get invoked by device_add()
>>>>
>>>> Why are these actually calling arch_setup_dma_ops() here in the first
>>>> place? Are these all devices that are DMA masters without an OF node?
>>>
>>> I don't know, but that's a different topic. This patch just adds
>>> argument and sets it to false everywhere but in the location when range
>>> should be definitely enforced.
>>
>> I also wouldn't lose any sleep over a staging driver.
> 
> I think this is in the process of being moved out of staging, and
> my question was about the other two as well:

The fsl-mc is actually a sort-of-bus-controller probing and configuring
its (directly DMA-capable) child devices, so is in fact legitimate here.

> drivers/net/ethernet/freescale/dpaa/dpaa_eth.c

That one is completely bogus, and should just go away.

> drivers/iommu/rockchip-iommu.c

That one is part of some ugly trickery involving creating a fake device
to represent multiple separate IOMMU devices. The driver could probably
be reworked to not need it (the Exynos IOMMU handles a similar situation
without such tricks), but it's non-trivial.

Robin.

> 
> 	Arnd
> 
