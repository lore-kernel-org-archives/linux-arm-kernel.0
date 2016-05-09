From: robh@kernel.org (Rob Herring)
Date: Mon, 9 May 2016 17:58:42 -0500
Subject: [PATCH v2 5/5] vf610-soc: Add Vybrid SoC device tree binding
 documentation
In-Reply-To: <4ca82be6c1d434c612868b441e9f6e1f@agner.ch>
References: <cover.1462171989.git.maitysanchayan@gmail.com>
 <65f3a7bd7a9faf1b390644d7c599c69683c753c4.1462171990.git.maitysanchayan@gmail.com>
 <20160504023026.GB5382@rob-hp-laptop>
 <20160505082758.GB18151@Sanchayan-Arch.localdomain>
 <CAL_JsqL1qQu_u=6xosP8UmR3oXLawbVz=Hap0wDm7aN4mjK2GA@mail.gmail.com>
 <4ca82be6c1d434c612868b441e9f6e1f@agner.ch>
Message-ID: <CAL_JsqL7sjdONYad6sXM1KXFCjooANuN7WYg-paV9LnKnuMTnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 9, 2016 at 1:25 PM, Stefan Agner <stefan@agner.ch> wrote:
> On 2016-05-09 10:14, Rob Herring wrote:
>> On Thu, May 5, 2016 at 3:27 AM,  <maitysanchayan@gmail.com> wrote:
>>> Hello Rob,
>>>
>>> On 16-05-03 21:30:26, Rob Herring wrote:
>>>> On Mon, May 02, 2016 at 12:35:04PM +0530, Sanchayan Maity wrote:
>>>> > Add device tree binding documentation for Vybrid SoC.
>>>> >
>>>> > Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
>>>> > ---
>>>> >  .../bindings/arm/freescale/fsl,vf610-soc.txt       | 35 ++++++++++++++++++++++
>>>> >  1 file changed, 35 insertions(+)
>>>> >  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,vf610-soc.txt
>>>> >
>>>> > diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-soc.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-soc.txt
>>>> > new file mode 100644
>>>> > index 0000000..bdd95e8
>>>> > --- /dev/null
>>>> > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-soc.txt
>>>> > @@ -0,0 +1,35 @@
>>>> > +Vybrid System-on-Chip
>>>> > +---------------------
>>>> > +
>>>> > +Required properties:
>>>> > +
>>>> > +- #address-cells: must be 1
>>>> > +- #size-cells: must be 1
>>>> > +- compatible: "fsl,vf610-soc-bus", "simple-bus"
>>>>
>>>> If this is a bus, put the file in bindings/bus/...
>>>
>>> The fsl,vf610-soc-bus binding is used to bind the driver in question with
>>> an appropriate compatible node.
>>>
>>> Basically being a standalone platform driver, there was need of a compatible
>>> property to bind on. Introducing a separate device tree node for it's sake
>>> didn't seem appropriate so the alteration to SoC node's compatible.
>>
>> Ah, so you are designing a node around the needs of a Linux specific
>> driver. Don't do that. DT describes the h/w and this node is not a h/w
>> block.
>>
>> Create a platform device based on a matching SOC compatible string
>> instead and make your driver find the information it needs directly
>> from the relevant nodes like the ROM node.
>
> That reads like my words a year ago:
> https://lkml.org/lkml/2015/5/22/408
>
> Initially pretty much everything was hard-coded in the driver.
>
> Arnd then pushed to use more descriptive in the device tree.
>
> Of course, we should not end up making up relations which are not there
> in hardware. We need to find the right balance.
>
> Here is my suggestion:
> 1. Add "fsl,vf610-soc-bus" as compatible string to the soc node, use it
> to bind the "soc bus driver" as a platform driver located in driver/soc/

I'm not convinced this is a h/w block. This keeps coming up and I
think this is a kernel problem, not a DT problem. Let's face it that
there are drivers at the SOC level which don't fit into a DT node.
They may be the exception, but they are a common exception. My
proposal for how to deal with these cases is here[1].

I also think drivers/soc is a mess because it is randomly used or not.
IMO, using it should not be at the whim of whomever does SOC support.

> 2. Add ROM as syscon device (it is not erasable ROM memory, hence eeprom
> seems not to be appropriate)

It is not a syscon. It is just memory. nvmem covers read-only memory,
so I have no issue using that.

Rob

[1] https://lkml.org/lkml/2013/10/30/27
