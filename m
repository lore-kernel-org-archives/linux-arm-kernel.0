From: robh@kernel.org (Rob Herring)
Date: Mon, 9 May 2016 12:14:27 -0500
Subject: [PATCH v2 5/5] vf610-soc: Add Vybrid SoC device tree binding
 documentation
In-Reply-To: <20160505082758.GB18151@Sanchayan-Arch.localdomain>
References: <cover.1462171989.git.maitysanchayan@gmail.com>
 <65f3a7bd7a9faf1b390644d7c599c69683c753c4.1462171990.git.maitysanchayan@gmail.com>
 <20160504023026.GB5382@rob-hp-laptop>
 <20160505082758.GB18151@Sanchayan-Arch.localdomain>
Message-ID: <CAL_JsqL1qQu_u=6xosP8UmR3oXLawbVz=Hap0wDm7aN4mjK2GA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 5, 2016 at 3:27 AM,  <maitysanchayan@gmail.com> wrote:
> Hello Rob,
>
> On 16-05-03 21:30:26, Rob Herring wrote:
>> On Mon, May 02, 2016 at 12:35:04PM +0530, Sanchayan Maity wrote:
>> > Add device tree binding documentation for Vybrid SoC.
>> >
>> > Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
>> > ---
>> >  .../bindings/arm/freescale/fsl,vf610-soc.txt       | 35 ++++++++++++++++++++++
>> >  1 file changed, 35 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,vf610-soc.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-soc.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-soc.txt
>> > new file mode 100644
>> > index 0000000..bdd95e8
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-soc.txt
>> > @@ -0,0 +1,35 @@
>> > +Vybrid System-on-Chip
>> > +---------------------
>> > +
>> > +Required properties:
>> > +
>> > +- #address-cells: must be 1
>> > +- #size-cells: must be 1
>> > +- compatible: "fsl,vf610-soc-bus", "simple-bus"
>>
>> If this is a bus, put the file in bindings/bus/...
>
> The fsl,vf610-soc-bus binding is used to bind the driver in question with
> an appropriate compatible node.
>
> Basically being a standalone platform driver, there was need of a compatible
> property to bind on. Introducing a separate device tree node for it's sake
> didn't seem appropriate so the alteration to SoC node's compatible.

Ah, so you are designing a node around the needs of a Linux specific
driver. Don't do that. DT describes the h/w and this node is not a h/w
block.

Create a platform device based on a matching SOC compatible string
instead and make your driver find the information it needs directly
from the relevant nodes like the ROM node.

>> > +- interrupt-parent: phandle to the MSCM interrupt router node
>> > +- ranges
>> > +- fsl,rom-revision: phandle to the on-chip ROM node and address of rom
>> > +  revision register
>>
>> Why is this needed here? Can't you search the tree for the ROM node and
>> get this info.
>
> Strictly per say this and next two can be specified in their respective nodes
> of ocrom and mscm cpucfg, however they would then require the use of syscon_
> regmap_lookup_by_compatible and this seems clean along with the introduction
> of new syscon_regmap_read_from_offset function used with SoC node.

That does not make sense. You can find the ROM node by compatible
string, get the address, get an revision offset property, and read the
address. There's no need for syscon nor regmap here.

>> > +- fsl,cpu-count: phandle to the MSCM CPU configuration node and address of
>> > +  CPU count register
>> > +- fsl,l2-size: phandle to the MSCM CPU configuration node and address of
>> > +  L2 cache size register
>> > +- nvmem-cells: phandles to two OCOTP child nodes ocotp_cfg0 and ocotp_cfg1
>> > +- nvmem-cell-names: should contain string names "cfg0" and "cfg1"
>>
>> How are all these properties used?
>
> All the above five are used to get the relevant values from the registers and
> expose the information for SoC sysfs device.
> https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-devices-soc
>
> nvmem are consumer nodes which are accessed using the NVMEM consumer API's
> leveraging the NVMEM framework and NVMEM vf610 ocotp driver.

So, please describe in the binding doc what the values contain. cfg0
and cfg1 is meaningless. But based on the above, this whole binding
should go.

Rob
