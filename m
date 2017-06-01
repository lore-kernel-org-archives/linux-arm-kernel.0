From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 01 Jun 2017 19:33:27 +0200
Subject: [PATCH 3/6] gpio: dt-bindings: Add documentation for gpio
 controllers on Armada 7K/8K
In-Reply-To: <87fufltk76.fsf@free-electrons.com> (Gregory CLEMENT's message of
 "Wed, 31 May 2017 12:05:49 +0200")
References: <cover.e10718b9c0f9fdd07327ae14e213be8da5b1f7ef.1495210061.git-series.gregory.clement@free-electrons.com>
 <306395ff39de3d3d3c8f55e5da4de8def29ae8d1.1495210061.git-series.gregory.clement@free-electrons.com>
 <20170530222907.ysx53p3efyxudyqp@rob-hp-laptop>
 <87fufltk76.fsf@free-electrons.com>
Message-ID: <87zidrr4t4.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,
 
 On mer., mai 31 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi Rob,
>  
>  On mer., mai 31 2017, Rob Herring <robh@kernel.org> wrote:
>>>  
>>>  Required properties:
>>>  
>>> -- compatible : Should be "marvell,orion-gpio", "marvell,mv78200-gpio"
>>> -  or "marvell,armadaxp-gpio". "marvell,orion-gpio" should be used for
>>> -  Orion, Kirkwood, Dove, Discovery (except MV78200) and Armada
>>> -  370. "marvell,mv78200-gpio" should be used for the Discovery
>>> -  MV78200. "marvel,armadaxp-gpio" should be used for all Armada XP
>>> -  SoCs (MV78230, MV78260, MV78460).
>>> +- compatible : Should be "marvell,orion-gpio", "marvell,mv78200-gpio",
>>> +  "marvell,armadaxp-gpio" or "marvell,armada-8k-gpio".
>>> +
>>> +    "marvell,orion-gpio" should be used for Orion, Kirkwood, Dove,
>>> +    Discovery (except MV78200) and Armada 370. "marvell,mv78200-gpio"
>>> +    should be used for the Discovery MV78200.
>>> +
>>> +    "marvel,armadaxp-gpio" should be used for all Armada XP SoCs
>>> +    (MV78230, MV78260, MV78460).
>>> +
>>> +    "marvell,armada-8k-gpio" should be used for the Armada 7K and 8K
>>> +    SoCs (either from AP or CP), see
>>> +    Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt
>>> +    and
>>> +    Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
>>> +    for specific details about the offset property.
>>>  
>>>  - reg: Address and length of the register set for the device. Only one
>>>    entry is expected, except for the "marvell,armadaxp-gpio" variant
>>>    for which two entries are expected: one for the general registers,
>>> -  one for the per-cpu registers.
>>> +  one for the per-cpu registers. Not used for marvell,armada-8k-gpio.
>>
>> Why can't use you use reg instead of offset?
>
> I looked for how the other syscon user did, and I found the offset
> usage. So I assumed it was the way to do it. But if you wan I can use a
> reg property.

I had a closer looked to the binding when syscon is used with several
subnodes. And actually the reg usage is very uncommon, I only find it in
drivers/regulator/pbias-regulator.c but for legacy.

I am not sure that we have any benefit with this reg property: we won't
use the length of the register and we need to add a range property in
the parent node.

An other way to pass this information is to have a different compatible
string which will match the different offset available. In this case the
reg property won't be used in a syscon node. However, while it makes
sens for the difference between AP806 and CP110, it would be strange to
have a different compatible string for gpio bank 1 and gpio bank 2.

So, in the end I would prefer to use the offset. From my point of view
it is better to not use the reg property for two different purposes:
mmio address vs offset in a syscon.

But if you think that from the point of view of the device tree
compliance we have to use the reg property, of course I will change it.

Thanks,

Gregory

>
> Gregory
>
>>
>> Rob
>
> -- 
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
