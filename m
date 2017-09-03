From: andre.przywara@arm.com (=?UTF-8?Q?Andr=c3=a9_Przywara?=)
Date: Mon, 4 Sep 2017 00:14:22 +0100
Subject: [PATCH 3/3] dmaengine: sun6i: Add support for Allwinner A64
In-Reply-To: <2607878.Us0MSlEf6n@pebbles.site>
References: <20170830233609.13855-4-stefan.bruens@rwth-aachen.de>
 <1837534.s5pz9jWHnV@pebbles.site>
 <d397d87b-5004-c8af-e590-037befc9b2b6@arm.com>
 <2607878.Us0MSlEf6n@pebbles.site>
Message-ID: <de04a144-ba07-00df-c684-d7db8956a94f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/17 03:02, Stefan Bruens wrote:
> On Samstag, 2. September 2017 00:32:50 CEST Andr? Przywara wrote:
>> Hi,
>>
>> On 01/09/17 02:19, Stefan Bruens wrote:
>>> On Freitag, 1. September 2017 02:31:35 CEST Andre Przywara wrote:
>>>> Hi,
>>>>
>>>> On 31/08/17 00:36, Stefan Br?ns wrote:
>>>>> The A64 SoC has the same dma engine as the H3 (sun8i), with a
>>>>> reduced amount of physical channels. Add the proper config data
>>>>> and compatible string to support it.
>>>>
>>>> ...
>>>>
>>>>> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
>>>>> index 5f4eee4513e5..6a17c5d63582 100644
>>>>> --- a/drivers/dma/sun6i-dma.c
>>>>> +++ b/drivers/dma/sun6i-dma.c
>>>>> @@ -1068,6 +1068,12 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg =
>>>>> {
>>>>>
>>>>>  	.nr_max_vchans   = 34,
>>>>>  	.dmac_variant    = DMAC_VARIANT_H3,
>>>>>  
>>>>>  };
>>>>>
>>>>> +
>>>>> +static struct sun6i_dma_config sun50i_a64_dma_cfg = {
>>>>> +	.nr_max_channels = 8,
>>>>> +	.nr_max_requests = 27,
>>>>> +	.nr_max_vchans   = 38,
>>>>> +	.dmac_variant    = DMAC_VARIANT_H3,
>>>>>
>>>>>  };
>>>>>  
> [...]
>>> There are also the incompatibilities in the "DMA channel configuration
>>> register" (burst length; burst width; burst length field offset).
>>>
>>> We can either have 3 different compatible strings, or another property for
>>> the register model.
>>
>> The latter is usually frowned upon, using separate compatible strings
>> for each group of SoCs is the way to go here.
> 
> Just for clarification, I was not talking about a property in the devicetree, 
> but about a struct member in the config data, i.e. the .dmac_variant above.

Ah, I see. I was indeed talking about device tree nodes.

So in this case I would lean towards mapping the actual properties to
member names in struct sun6i_dma_config, in this case something like:
	.auto_clock_gate = 0x28;
	.max_burst_width = 16;

This looks more flexible to me and avoids hard to read code where
property A is used in SoC X and Y, but property B in SoC X and Z, for
instance.
In the auto clock gate case this would result in an easy-to-read:
	writel(SUN8I_DMA_GATE_ENABLE,
	       sdc->base + sdc->cfg->auto_clock_gate);
(possibly guarded somehow to catch that A31 case)

Sorry for the delay in this answer, I see that you kept the
DMAC_VARIANT_ style for your new post, and the end result doesn't look
too bad. But maybe still changing this is not too hard now that you have
more fine grained patches?

Cheers,
Andre.
