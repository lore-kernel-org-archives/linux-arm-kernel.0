From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Thu, 12 Jan 2017 09:33:32 +0300
Subject: [PATCH 1/2] dma-mapping: let arch know origin of dma range passed
 to arch_setup_dma_ops()
In-Reply-To: <764334db-3400-58c6-cc4b-3f7ce66daa27@cogentembedded.com>
References: <dca35acf-1adf-aa85-7a0b-d0c6ec702fa1@arm.com>
 <1484159512-28515-1-git-send-email-nikita.yoush@cogentembedded.com>
 <1484159512-28515-2-git-send-email-nikita.yoush@cogentembedded.com>
 <30025121.yS4lyZEDrk@wuerfel>
 <764334db-3400-58c6-cc4b-3f7ce66daa27@cogentembedded.com>
Message-ID: <7d7dc402-e527-c581-0b1c-37713759db31@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



12.01.2017 08:52, Nikita Yushchenko wrote:
>>> diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
>>> index 5ac373c..480b644 100644
>>> --- a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
>>> +++ b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
>>> @@ -540,7 +540,7 @@ int fsl_mc_device_add(struct dprc_obj_desc *obj_desc,
>>>  
>>>  	/* Objects are coherent, unless 'no shareability' flag set. */
>>>  	if (!(obj_desc->flags & DPRC_OBJ_FLAG_NO_MEM_SHAREABILITY))
>>> -		arch_setup_dma_ops(&mc_dev->dev, 0, 0, NULL, true);
>>> +		arch_setup_dma_ops(&mc_dev->dev, 0, 0, false, NULL, true);
>>>  
>>>  	/*
>>>  	 * The device-specific probe callback will get invoked by device_add()
>>
>> Why are these actually calling arch_setup_dma_ops() here in the first
>> place? Are these all devices that are DMA masters without an OF node?
> 
> I don't know, but that's a different topic. This patch just adds
> argument and sets it to false everywhere but in the location when range
> should be definitely enforced.
> 
>>> @@ -126,6 +127,8 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>>>  			return;
>>>  		}
>>>  		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
>>> +
>>> +		enforce_range = true;
>>>  	}
>>>  
>>>  	dev->dma_pfn_offset = offset;
>>
>> Hmm, I think when the dma-ranges are missing, we should either enforce
>> a 32-bit mask, or disallow DMA completely. It's probably too late for
>> the latter, I wish we had done this earlier in order to force everyone
>> on ARM64 to have a valid dma-ranges property for any DMA master.
> 
> This can be done over time.
> 
> However the very idea of this version of patch is - keep working pieces
> as-is, thus for now setting enforce_range to false in case of no defined
> dma-ranges is intentional.

What we can do is - check bus width (as it is defined in DT) and set
enforce_range to true if bus is 32-bit

> What I should re-check is - does rcar dtsi set dma-ranges, and add it if
> it does not.

It does not, will have to add.

In DT bus is defined as 64-bit. But looks like physically it is 32-bit.
Maybe DT needs fixing.
