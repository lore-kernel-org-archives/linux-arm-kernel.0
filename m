From: robh@kernel.org (Rob Herring)
Date: Tue, 10 May 2016 22:24:06 -0500
Subject: [PATCH v2 5/5] vf610-soc: Add Vybrid SoC device tree binding
 documentation
In-Reply-To: <cab9edb2184ec13341a1dae1de9c7ebc@agner.ch>
References: <cover.1462171989.git.maitysanchayan@gmail.com>
 <65f3a7bd7a9faf1b390644d7c599c69683c753c4.1462171990.git.maitysanchayan@gmail.com>
 <20160504023026.GB5382@rob-hp-laptop>
 <20160505082758.GB18151@Sanchayan-Arch.localdomain>
 <CAL_JsqL1qQu_u=6xosP8UmR3oXLawbVz=Hap0wDm7aN4mjK2GA@mail.gmail.com>
 <4ca82be6c1d434c612868b441e9f6e1f@agner.ch>
 <CAL_JsqL7sjdONYad6sXM1KXFCjooANuN7WYg-paV9LnKnuMTnA@mail.gmail.com>
 <cab9edb2184ec13341a1dae1de9c7ebc@agner.ch>
Message-ID: <CAL_JsqLpdu1jpSkU5G0An4_7N3f-DOAF34zSmx2DmB_X7KTMUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 9, 2016 at 8:13 PM, Stefan Agner <stefan@agner.ch> wrote:
> On 2016-05-09 15:58, Rob Herring wrote:
>> On Mon, May 9, 2016 at 1:25 PM, Stefan Agner <stefan@agner.ch> wrote:
>>> On 2016-05-09 10:14, Rob Herring wrote:
>>>> On Thu, May 5, 2016 at 3:27 AM,  <maitysanchayan@gmail.com> wrote:
>>>>> Hello Rob,
>>>>>
>>>>> On 16-05-03 21:30:26, Rob Herring wrote:
>>>>>> On Mon, May 02, 2016 at 12:35:04PM +0530, Sanchayan Maity wrote:
>>>>>> > Add device tree binding documentation for Vybrid SoC.

[...]

>>>>> Basically being a standalone platform driver, there was need of a compatible
>>>>> property to bind on. Introducing a separate device tree node for it's sake
>>>>> didn't seem appropriate so the alteration to SoC node's compatible.
>>>>
>>>> Ah, so you are designing a node around the needs of a Linux specific
>>>> driver. Don't do that. DT describes the h/w and this node is not a h/w
>>>> block.
>>>>
>>>> Create a platform device based on a matching SOC compatible string
>>>> instead and make your driver find the information it needs directly
>>>> from the relevant nodes like the ROM node.
>>>
>>> That reads like my words a year ago:
>>> https://lkml.org/lkml/2015/5/22/408
>>>
>>> Initially pretty much everything was hard-coded in the driver.
>>>
>>> Arnd then pushed to use more descriptive in the device tree.
>>>
>>> Of course, we should not end up making up relations which are not there
>>> in hardware. We need to find the right balance.
>>>
>>> Here is my suggestion:
>>> 1. Add "fsl,vf610-soc-bus" as compatible string to the soc node, use it
>>> to bind the "soc bus driver" as a platform driver located in driver/soc/
>>
>> I'm not convinced this is a h/w block. This keeps coming up and I
>> think this is a kernel problem, not a DT problem. Let's face it that
>> there are drivers at the SOC level which don't fit into a DT node.
>> They may be the exception, but they are a common exception. My
>> proposal for how to deal with these cases is here[1].
>
> Probably "fsl,vf610-soc" would be better than "fsl,vf610-soc-bus".

But the node in question is just the bus part of the SoC. Things like
cpus are not included.

> But the SoC is definitely a h/w block! Despite all the individual
> silicon in there, I can even touch the SoC ;-)

Can't argue with that...

> But yeah, I understand what you are saying... We model it as a
> container, and do not attribute any specific thing directly to it. But
> aren't there other containers where we bind to? Is it wrong to bind a
> driver to a container, if that driver implements issues concerning that
> level..?

It is supposed to be a bus, not just a container. However, we probably
don't generally fully and accurately model the buses in SoCs so DT
ends up being just a container frequently. If the bus is more than
simple-bus, then it should have some resource that needs to be
controlled to enable the bus.

>
> The two drivers under drivers/soc/ which implement the SoC bus API and
> both use a compatible string on a container level (e.g.
> arm,realview-pb11mp-soc in arch/arm/boot/dts/arm-realview-pb11mp.dts).

I'm not sure Realview and Integrator are models to follow. They are a
bit unique in their h/w design.

>
>>
>> I also think drivers/soc is a mess because it is randomly used or not.
>> IMO, using it should not be at the whim of whomever does SOC support.
>
> Are you talking about random drivers under drivers/soc/ or the ones
> which implement the SoC bus API? I think that is not the same...

The SoC bus API.

> If SoC bus, agreed, it is a mess. Not only its adoption is sparse, the
> specification is also interpreted differently across different SoC's,
> which I brought up in the past:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/333765.html
>
> But it exports really useful information to user space, and that has
> real value in practice.

Yes, but the information exported has nothing really to do with a bus.
The "bus" part of it is more sub-classing platform_bus_type for all
platform devices on an SOC. That container may or may not directly
correspond to the bus structure of the SOC as defined in DT. I guess
it is the mixing of really 2 independent things that I don't like and
has made its use sparse. We should perhaps mandate using the bus (for
what I described) and make the information part separate and be able
to populate it from any driver (e.g. an SoC syscon driver which reads
the SOC revision).

Rob
