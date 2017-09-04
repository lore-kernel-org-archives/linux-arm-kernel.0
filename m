From: andre.przywara@arm.com (=?UTF-8?Q?Andr=c3=a9_Przywara?=)
Date: Mon, 4 Sep 2017 09:14:52 +0100
Subject: [PATCH 3/3] dmaengine: sun6i: Add support for Allwinner A64
In-Reply-To: <20170904070415.e6nclz5n23bo7f4v@flea>
References: <20170830233609.13855-4-stefan.bruens@rwth-aachen.de>
 <20170901003135.10058-1-andre.przywara@arm.com>
 <20170901060445.vboici7qxfkztp3s@flea>
 <743ae23a-372a-762b-c345-b914f09fd718@arm.com>
 <20170904070415.e6nclz5n23bo7f4v@flea>
Message-ID: <d3d32839-12a8-71fa-cfec-03055d64388d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Salut,

On 04/09/17 08:04, Maxime Ripard wrote:
> On Fri, Sep 01, 2017 at 11:35:40PM +0100, Andr? Przywara wrote:
>> On 01/09/17 07:04, Maxime Ripard wrote:
>>> On Fri, Sep 01, 2017 at 01:31:35AM +0100, Andre Przywara wrote:
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
>>>>> @@ -1068,6 +1068,12 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
>>>>>  	.nr_max_vchans   = 34,
>>>>>  	.dmac_variant    = DMAC_VARIANT_H3,
>>>>>  };
>>>>> +
>>>>> +static struct sun6i_dma_config sun50i_a64_dma_cfg = {
>>>>> +	.nr_max_channels = 8,
>>>>> +	.nr_max_requests = 27,
>>>>> +	.nr_max_vchans   = 38,
>>>>> +	.dmac_variant    = DMAC_VARIANT_H3,
>>>>>  };
>>>>>  
>>>>>  static const struct of_device_id sun6i_dma_match[] = {
>>>>> @@ -1075,6 +1081,7 @@ static const struct of_device_id sun6i_dma_match[] = {
>>>>>  	{ .compatible = "allwinner,sun8i-a23-dma", .data = &sun8i_a23_dma_cfg },
>>>>>  	{ .compatible = "allwinner,sun8i-a83t-dma", .data = &sun8i_a83t_dma_cfg },
>>>>>  	{ .compatible = "allwinner,sun8i-h3-dma", .data = &sun8i_h3_dma_cfg },
>>>>> +	{ .compatible = "allwinner,sun50i-a64-dma", .data = &sun50i_a64_dma_cfg },
>>>>>  	{ /* sentinel */ }
>>>>>  };
>>>>>  MODULE_DEVICE_TABLE(of, sun6i_dma_match);
>>>>
>>>> I was wondering if should use the opportunity to expose those values as
>>>> DT properties instead of hard-wiring them to a compatible string in the
>>>> driver every time we add support for a new SoC?
>>>> We could introduce a new compatible string (say: "allwinner,sunxi-dma"),
>>>> then describe properties for the number of channels and requests and
>>>> vchans and parse those from the DT at probe time.
>>>> With this we might be able to support future SoCs without Linux *driver*
>>>> changes, by just providing the right DT. This would have worked already
>>>> for instance for the A83T support, which just changed those values.
>>>>
>>>> For instance with this quick patch below (just compile tested, and without
>>>> your refactoring).
>>>> The DT node would then read something like:
>>>> 	dma: dma-controller at 01c02000 {
>>>> 		compatible = "allwinner,sun50i-a64-dma",
>>>> 			     "allwinner,sunxi-dma";
>>>> 		reg = <0x01c02000 0x1000>;
>>>> 		interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
>>>> 		clocks = <&ccu CLK_BUS_DMA>;
>>>> 		resets = <&ccu RST_BUS_DMA>;
>>>> 		#dma-cells = <1>;
>>>> 		allwinner,max_channels = <8>;
>>>> 		allwinner,max_requests = <27>;
>>>> 		allwinner,max_vchans = <38>;
>>>> 	};
>>>
>>> We're still going to need a different compatible anyway, so it's not
>>> really like it would change anything.
>>
>> Well, not for now, but possibly in the future. And we should start with
>> this at one point. If we would have had this type of binding already for
>> H3, we could have added the A64 support without driver changes just by a
>> DT change.
> 
> That's not true. As usual with these kinds of generic binding
> arguments (it's definitely not personal, you're far from the only one
> making them), it completely ignores the fact that the IP itself might
> change from one revision to another, and its behaviour might too.

Not arguing that, and I totally see that those cases indeed require a
new compatible string.

> The A64 for example moved at least one register off, and has a
> different set of burst size / width.

But that is only compared to the original A23/A31 model? AFAICT compared
to the H3 DMA it's really only the number of supported DMA channels that
has changed. For which we don't even need to invent a property name.
My point was that as the driver is *at the moment* all those different
compatible strings behaved the same (apart from the missing A23 clock
gating), see commits f008db8c00c1 and 3a03ea763a67. The differences we
coded in struct sun6i_dma_config were more or less artificial.
Now thanks to Stefan we learned that the H3 is more different than we
thought, so this argument doesn't hold anymore (but see below).

> It's something you can't account for when you initially define the
> binding, unless you describe all the registers, plus all their
> parameters and the way you interact with them, which isn't going to
> happen if you want to keep your sanity.

I agree on that.

> And obviously, while maintaining the stability of the binding of those
> hundreds properties.
> 
> Or, you can base all this on the compatible, and be done with it once
> and for all.

What I am after is to cover SoCs which *don't* have differences in their
register layout, for instance A83T, H3, A64, R40.
In an ideal world we could have reused the H3 compatible string,
adjusting the number of channels for each SoC in the DT.

So I see that having a generic compatible name will not fly, as we now
have differences which should not be modelled by DT properties.
But I still think we should try to cover those non-register differences
(number of channels) with a DT property, to allow reusing the existing
driver code whenever possible. As is stands with this series, the R40
support should just be a matter of:
	compatible = "allwinner,sun8i-r40-dma",
		     "allwinner,sun50i-a64-dma";

I am aware that future SoCs might require new compatibles (I actually
hope that they introduce 64-bit memory addresses at some point), but
having the "dma-channels" DT parsing code in should then reduce the
frequency of driver changes (for SoCs just copying existing DMA IP).

Cheers,
Andre.
