From: horms@verge.net.au (Simon Horman)
Date: Tue, 8 Jan 2013 17:20:00 +0900
Subject: [PATCH 01/10] ARM: shmobile: Add support OF for INTC of shmobile
In-Reply-To: <20121218095853.GA29231@e106331-lin.cambridge.arm.com>
References: <1355562224-29448-1-git-send-email-horms+renesas@verge.net.au>
 <1355562224-29448-2-git-send-email-horms+renesas@verge.net.au>
 <20121218095853.GA29231@e106331-lin.cambridge.arm.com>
Message-ID: <20130108082000.GB8565@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 18, 2012 at 10:00:01AM +0000, Mark Rutland wrote:
> Hi,
> 
> I have some comments on the devicetree binding.
> 
> On Sat, Dec 15, 2012 at 09:03:35AM +0000, Simon Horman wrote:
> > From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> >
> > This provides OF support of SH/INTC.
> >
> > The SH/INTC driver is used by SuperH and ARM/SH-MOBILE.
> > At the moment, SuperH does not have the plan corresponding to DT.
> > DT of SH/INTC has taken the form where the table data of the C
> > is managed by DT, in order to maintain compatibility.
> >
> > Cc: Magnus Damm <damm@opensource.se>
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  Documentation/devicetree/bindings/sh/intc.txt |  163 +++++++
> >  drivers/sh/intc/Makefile                      |    1 +
> >  drivers/sh/intc/of_intc.c                     |  647 +++++++++++++++++++++++++
> >  include/linux/sh_intc.h                       |   83 ++++
> >  4 files changed, 894 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sh/intc.txt
> >  create mode 100644 drivers/sh/intc/of_intc.c
> >
> > diff --git a/Documentation/devicetree/bindings/sh/intc.txt b/Documentation/devicetree/bindings/sh/intc.txt
> > new file mode 100644
> > index 0000000..ebb2398
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sh/intc.txt
> > @@ -0,0 +1,163 @@
> > +* Renesas SuperH / SH-MOBILE Interrupt Controller
> > +
> > +The SH/INTC driver is used by SuperH and ARM/SH-MOBILE.
> > +At the moment, SuperH does not have the plan corresponding to DT.
> > +DT of SH/INTC has taken the form where the table data of the C
> > +is managed by DT, in order to maintain compatibility.
> > +
> > +Main node required properties:
> > +
> > +- compatible : should be one of:
> > +       "renesas,sh_intca"
> > +       "renesas,sh_intcs"
> > +       "renesas,sh_intca_irq_pins"
> 
> Typically compatible strings use '-' rather than '_'.

Thanks, I will fix that.

> > +
> > +- interrupt-controller : Identifies the node as an interrupt controller
> > +- #interrupt-cells     : Set already 1.
> > +- #address-cells       : Set already 1.
> > +- #size-cells  : Set already 1.
> 
> I'm not quite sure what "Set already 1" means. Perhaps these should say "Must be 1" ?

Thanks, I will up date it to "Must be 1"

> > +- ranges        : Non value.
> 
> This confused me, but I see it's a standard property. It's probably worth
> noting why it's required, e.g. "ranges	: empty as we have a 1-1 mapping to
> parent's address space".

Thanks, I will update it as you suggest.

> > +- reg                  : Specifies base physical address(s) and size of the INTC
> > +                                 registers.
> 
> Presumably these registers are not identical, and the order is important. This
> order should be specified.

I believe that this is to allow discontinuous register ranges and the order
is not important.

> > +- intsrc*              : This sets up the vector for every device.
> 
> I'm not sure what this means. If this has a well-defined meaning for the
> device, it may be worth having a link to some additional documentation from the
> binding doc.

The way I understand this is that intsrc* is used to register the
vectors associated with an interrupt source and in doing so allow
a phandle to be associated with the interrupt source.

So perhaps the following would be better?

- intsrc*               : Interrupt source.
                          Associate an interrupt source with its vector.


> > +- *_registers  : There are vector table, mask, priority, ack, and sense
> > +                                 register in INTC.  In order to hold these data, it is
> > +                                 necessary to set up the following contents.

- *_registers           : These describe the vector table, mask, priority, ack,
                          and sense registers. It must contain the following:

> > + -- intc_vectors: This requires needs to have vector_table.
> > +                                 This specifies phandle which intsrc* defined.

 -- intc_vectors: This requires the vector_table property which is a list of
                  interrupt sources.

> > + -- intc_mask_registers        : This specifies the contents of the mask register.
> > +    This node required properties:
> > +       * address-cells : Set already 1.
> > +       * size-cells    : Set already 1.

 -- intc_mask_registers        : This specifies the contents of the mask register.
    This node requires the following properties:
      * address-cells : Must be 1.
      * size-cells    : Must be 1.

> Are #address-cells and #size-cells not inherited from the parent node?

This seems to result in much unhappiness.

For example:

# dtc -v
Version: DTC 1.3.0
# make dtbs
...
DTC     arch/arm/boot/dts/sh7372-mackerel-reference.dtb
Warning (reg_format): "reg" property in /soc/interrupt-controller at 0/intc_mask_registers/intc_mask0 has invalid length (16 bytes) (#address-cells == 2, #size-cells == 1)
...

> > +       * ranges                : Non value.
> > +       * intc_mask*    : This has regs and reginfo.

        * intc_mask*    : This must contain regs and reginfo.

> > +        ** reg : This specifies the address of mask register. First specifies
> > +                         mask register, and 2nd specifies mask clear register.
> > +                         First cell is address, and 2nd sell is address size. 1 is 8bit.
> > +                         2 is 16bit, 4 is 32bit.
> 
> Saying "address size" here is very confusing, as it sounds like you're
> re-inventing the #address-cells property. I assume you mean the register size? If so
> just say the size must be 1, 2, or 4 bytes.
> 
> Also, s/sell/cell/

How about this?

         ** reg         : This specifies the address of mask registers.
                          The first entry specifies the mask register and
                          the second entry specifies the mask clear
                          register.  The first cell is the register's
                          address, and the second cell is the register's size
                          which must be 1, 2 or 4 bytes.

> > +        ** reginfo: This specifies phandle of devices.
> 
> Which devices?

How about this?

         ** reginfo     : This specifies the interrupt sources controlled by
			  the mask. The list entries correspond to bits of
			  the mask from most to least significant.  A value
			  of 0 may be used for unused bits in the mask.
			  Trailing list entries may be omitted in which
			  case they will be treated as 0.

> > +
> > + -- intc_prio_registers        : This sets up the contents of the priority register.
> > +    This node required properties:
> > +       * address-cells : Set already 1.
> > +       * size-cells    : Set already 1.
> > +       * ranges                : Non value.
> > +       * intc_prio*: This has regs and reginfo.
> > +        ** reg : This specifies the address of priority register. First specifies
> > +                         priority set register, and 2nd specifies priority clear register.
> > +                         If there is not priority clear register, specifies 0x00.
> > +                         First cell is address, and 2nd sell is address size. 1 is 8bit.
> > +                         2 is 16bit, 4 is 32bit.
> 
> If there is not a priority clear register, why not only describe the priority
> set register?
> 
> The absence of a second set of reg cells will tell you it's not present, and
> will be easier to spot when reading the dts.

Thanks, actually, I believe that the code already treats any absent entries
as zero. Is this documentation along the lines of what you had in mind?

         ** reg         : This specifies the address of the priority register.
                          The first entry specifies the priority set
                          register and the second entry specifies priority
                          clear register.  The first cell is the register's
                          address, and the second cell is the register's
                          size which must be 1, 2 or 4 bytes.  If there is
                          not priority clear register then they entry may
                          be omitted or 0 used as the register's address.

> > +        ** field-width : Bit size is specified for every device.

	 ** field-width : Width of each group in the register in bits.
                          A group contains the priority for a single
                          interrupt vector. Thus a 16 bit register with
                          a field-width of 4 may control the priority for
                          4 (16 / 4) interrupt sources.

> > +        ** reginfo: This specifies phandle of devices.

         ** reginfo     : This specifies the interrupt sources controlled by
                          the priority register. The list entries
                          correspond to the groups of the priority register
                          from least to most significant.  A value of 0 may
                          be used for unused groups.  Trailing list entries
                          may be omitted in which case they will be treated
                          as 0.

> > +
> > + -- intc_sense_registers       : This sets up the contents of the sense register.
> > +    This node required properties:
> > +       * address-cells : Set already 1.
> > +       * size-cells    : Set already 1.
> > +       * ranges                : Non value.
> > +       * intc_sense*: This has regs and reginfo.
> > +        ** reg : This specifies the address of sense register.
> > +                         First cell is address, and 2nd sell is address size. 1 is 8bit.
> > +                         2 is 16bit, 4 is 32bit.

         ** reg         : This specifies the address of the sense register.
                          The first cell is the register's address, and the
                          second cell is the register's size which must be
                          1, 2 or 4 bytes.

> > +        ** field-width : Bit size is specified for every device.

         ** field-width : Width of each group in the register in bits.
                          A group contains the priority for a single
                          interrupt vector. Thus a 16 bit register with
                          a field-width of 4 may control the priority for
                          4 (16 / 4) interrupt sources.

> > +        ** reginfo: This specifies phandle of devices.

         ** reginfo     : This specifies the interrupt sources controlled by
                          the sense register. The list entries
                          correspond to the groups of the priority register
                          from least to most significant.  A value of 0 may
                          be used for unused groups.  Trailing list entries
                          may be omitted in which case they will be treated
                          as 0.

> > +-- intc_ack_registers  : This sets up the contents of the ACK register.
> > +   This node required properties:
> > +       * address-cells : Set already 1.
> > +       * size-cells    : Set already 1.
> > +       * ranges                : Non value.
> > +       * intc_ack*: This has regs and reginfo.
> > +        ** reg : This specifies the address of ack register.
> > +                         First cell is address, and 2nd sell is address size. 1 is 8bit.
> > +                         2 is 16bit, 4 is 32bit.

         ** reg         : This specifies the address of the ACK register.
                          The first cell is the register's address, and the
                          second cell is the register's size which must be
                          1, 2 or 4 bytes.

> > +        ** reginfo: This specifies phandle of devices.

         ** reginfo     : This specifies the interrupt sources controlled by
                          the ACK register. The list entries correspond to
                          bits of the ACK register from most to least
                          significant.  A value of 0 may be used for unused
                          bits in the mask.  Trailing list entries may be
                          omitted in which case they will be treated as 0.

> > +
> > +Optional:
> > +
> > +- group_size   : If this INTC register has Group, set up this value.
> 
> What does this specify? The number of intc_group nodes?
> 
> If so, can this not be omitted and calculated by counting intc_group nodes?

Yes, I believe so.

> > +- intc_group*  : This needs to have group, If INTC device have group.
> > +   This node required properties:
> > +    * group : This specifies the address phandle of group.
> > +         For example, when TMU1 of priority regisdter is sharing with TMU1_0,
> > +         TMU1_1 and TMU1_2, it describes like below.
> > +
> > +            TMU1:   intc_group2 { group = <&TMU1_0 &TMU1_1 &TMU1_2>; };
> > +
> > +         And the phandle is specified as priority regisdter.
> 
> s/regisdter/register/
> 
> > +
> > +         intc_prio11 {
> > +             reg = <0xffd50030 2>, <0x0 0>;
> > +             field-width = <4>;
> > +                        reginfo = <&TMU1 0 0 0>;
> 
> These 0s at the end of the reginfo property, why are they required? They were
> not described in the rest of the binding documentation.

They aren't required.

I have removed the example entirely as there is another example below.

- intc_group*           : Interrupt Source Group.
                          Interrupt sources may be grouped with a group
                          sharing the same bits of an interrupt priority
                          register.
  This node requires the following properties:
        * group         : This specifies the interrupt sources that
                          belong to the group.


> 
> > +                };
> > +
> > +- intc_intevtsa        : This set up the contents of INTEVTSA.
> > +       This node required properties:
> > +         * vector : This specifies the address phandle of INTCS.

- intc_intevtsa	: This sets up the contents of INTEVTSA.
	This node requires the following properties:
	  * vector : This specifies the interrupt source

> > +Note:
> > +- "renesas,sh_intca" needs group_size, intc_group*, intc_vectors,
> > +  intc_mask_registers and intc_prio_registers.
> > +- "renesas,sh_intcs" needs group_size, intc_group*, intc_vectors,
> > +  intc_mask_registers, intc_prio_registers and  intc_intevtsa.
> > +- "renesas,sh_intca_irq_pins" needs intc_vectors, intc_mask_registers,
> > +  intc_prio_registers, intc_sense_registers and intc_ack_registers.
> > +
> > +Example:
> > +
> > +       intca: interrupt-controller at 0 {
> > +               compatible = "renesas,sh_intca";
> > +               interrupt-controller;
> > +               #address-cells = <1>;
> > +               #size-cells = <1>;
> > +               #interrupt-cells = <1>;
> > +               ranges;
> > +
> > +               reg = <0xe6940000 0x200>, <0xe6950000 0x200>;
> > +               group_size = <19>;
> > +
> > +               DIRC: intsrc1 { vector = <0x0560>; };
> > +               ATAPI: intsrc2 { vector = <0x05E0>; };
> > +               ....
> > +
> > +               DMAC1_1: intc_group0 { group = <&DMAC1_1_DEI0 &DMAC1_1_DEI1
> > +                               &DMAC1_1_DEI2 &DMAC1_1_DEI3>; };
> > +               DMAC1_2: intc_group1 { group = <&DMAC1_2_DEI4 &DMAC1_2_DEI5
> > +                                                &DMAC1_2_DADERR>; };
> > +               ....
> > +               intc_vectors {
> > +                       vector_table = <&DIRC &ATAPI &IIC1_ALI &IIC1_TACKI &IIC1_WAITI,
> > +               ....
> > +               };
> > +
> > +               intc_mask_registers {
> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +                       ranges;
> > +
> > +                       intc_mask0 {
> > +                               reg = <0xe6940080 1>, <0xe69400c0 1>;
> > +                               reginfo = <&DMAC2_1_DEI3 &DMAC2_1_DEI2 &DMAC2_1_DEI1
> > +                                       &DMAC2_1_DEI0 0 0 &AP_ARM_COMMTX &AP_ARM_COMMRX>;
> > +                       };
> > +                       ....
> > +               };
> > +
> > +               intc_prio_registers {
> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +                       ranges;
> > +
> > +                       intc_prio0 {
> > +                               reg = <0xe6940000 2>, <0x0 0>;
> > +                               field-width = <4>;
> > +                               reginfo = <&DMAC3_1 &DMAC3_2 &CMT2 &ICBS0>;
> > +                       };
> > +                       ....
> > +               };
> > +       };
> 
> [...]
> 
> Thanks,
> Mark.
