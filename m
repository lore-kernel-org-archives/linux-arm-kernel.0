From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 9 Jan 2013 11:53:52 +0000
Subject: [PATCH 1/8] SH: intc: Add support OF for INTC
In-Reply-To: <1357713007-4005-2-git-send-email-horms+renesas@verge.net.au>
References: <1357713007-4005-1-git-send-email-horms+renesas@verge.net.au>
 <1357713007-4005-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130109115352.GB7337@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for updating the text, this is far easier to read than previously.

However, I'm still concerned by how complex the binding seems. As I don't have
any familiarity with the device, I don't know whether that's just an artifact
of the hardware or something that can be cleared up.

I think the approach used by the binding needs some serious review before this
should be merged. It seems far more complex than any existing interrupt
controller binding. Without a dts example for a complete board (complete with
devices wired up to the interrupt controller), it's difficult to judge how this
will work in practice.

I've added Arnd to Cc in case he has any thoughts on the matter.

On Wed, Jan 09, 2013 at 06:30:00AM +0000, Simon Horman wrote:
> From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> 
> This provides OF support of SH/INTC.
> 
> The SH/INTC driver is used by SuperH and ARM/SH-MOBILE.
> At the moment, SuperH does not have the plan corresponding to DT.
> DT of SH/INTC has taken the form where the table data of the C
> is managed by DT, in order to maintain compatibility.

This doesn't sound good. To me it looks like the C data structures have just
been converted to lists in dt, without any thought as to whether or not this is
a clean representation of the hardware.

> 
> Cc: Magnus Damm <damm@opensource.se>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> ---
> 
> v9
> * As suggested by Mark Rutland
>   - Update compatible string to use '-' instead of '_'
>   - Enhance documentation
>   - Remove group_size, it can be calculated
>   - Allow missing traling reg
> * Add intc_groups and remove group_size.
>   The number of groups can be calculated by
>   containing them in a intc_groups node.
> 
> v8
> * Squash "SH: intc: Add support OF of IRQ" into this patch
> * Change patch title from "ARM: shmobile: Add support OF for INTC of shmobile"
>   to "SH: intc: Add support OF for INTC"
> 
> v7
> * Delete "renesas,sh_intcs" and "renesas,sh_intca_irq_pins" as compatible.
>   Update their documentation.
> * Remove of_sh_intc_get_meminfo() and of_sh_intc_get_pint and
>   of_sh_intc_get_intc(). They are not used.
> 
> v2 - v6
> * No change
> ---
>  Documentation/devicetree/bindings/sh/intc.txt |  191 ++++++++
>  drivers/sh/intc/Makefile                      |    1 +
>  drivers/sh/intc/core.c                        |    2 +-
>  drivers/sh/intc/internals.h                   |    3 +-
>  drivers/sh/intc/irqdomain.c                   |    6 +-
>  drivers/sh/intc/of_intc.c                     |  577 +++++++++++++++++++++++++
>  include/linux/sh_intc.h                       |   56 +++
>  7 files changed, 831 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sh/intc.txt
>  create mode 100644 drivers/sh/intc/of_intc.c
> 
> diff --git a/Documentation/devicetree/bindings/sh/intc.txt b/Documentation/devicetree/bindings/sh/intc.txt
> new file mode 100644
> index 0000000..eb605ce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sh/intc.txt
> @@ -0,0 +1,191 @@
> +* Renesas SuperH / SH-MOBILE Interrupt Controller
> +
> +The SH/INTC driver is used by SuperH and ARM/SH-MOBILE.
> +At the moment, SuperH does not have the plan corresponding to DT.
> +DT of SH/INTC has taken the form where the table data of the C
> +is managed by DT, in order to maintain compatibility.
> +
> +The main node requires the following properties:
> +
> +- compatible : "renesas,sh-intc"
> +
> +- interrupt-controller  : Identifies the node as an interrupt controller
> +- #interrupt-cells      : Must be 1
> +- #address-cells        : Must be 1
> +- #size-cells           : Must be 1
> +- ranges                : Empty as we have a 1-1 mapping to parent's
> +                          address space
> +- reg                   : Specifies base physical address(s) and size of
> +                          the INTC registers
> +- intsrc*               : Interrupt source
> +                          Associate an interrupt source with its vector
> +
> +- *_registers           : These describe the vector table, mask, priority, ack,
> +                          and sense registers. It must contain the following:
> +
> + -- intc_vectors       : This describes the interrupt sources
> +    This node requires the following property:
> +       *vector_table   : List of interrupt sources
> +
> + -- intc_mask_registers : This specifies the contents of the mask registers
> +    This node requires the following properties:
> +        * address-cells : Must be 1
> +        * size-cells    : Must be 1
> +        * ranges        : Empty as we have a 1-1 mapping to parent's
> +                          address space
> +        * intc_mask*    : A mask register
> +         This node requires the following properties:
> +          ** reg        : This specifies the address of mask registers.
> +                          The first entry specifies the mask register and
> +                          the second entry specifies the mask clear
> +                          register.  The first cell is the register's
> +                          address, and the second cell is the register's size
> +                          which must be 1, 2 or 4 bytes.
> +          ** reginfo    : This specifies the interrupt sources controlled by
> +                          the mask. The list entries correspond to bits of
> +                          the mask from most to least significant.  A value
> +                          of 0 may be used for unused bits in the mask.
> +                          Trailing list entries may be omitted in which
> +                          case they will be treated as 0.
> +
> + -- intc_prio_registers : This sets up the contents of the priority registers
> +    This node requires the following properties:
> +        * address-cells : Must be 1
> +        * size-cells    : Must be 1
> +        * ranges        : Empty as we have a 1-1 mapping to parent's
> +                          address space
> +        * intc_prio*   : A sense register
> +         This node requires the following properties:
> +          ** reg        : This specifies the address of the priority register.
> +                          The first entry specifies the priority set
> +                          register and the second entry specifies priority
> +                          clear register.  The first cell is the register's
> +                          address, and the second cell is the register's
> +                          size which must be 1, 2 or 4 bytes.  If there is
> +                          not priority clear register then they entry may
> +                          be omitted or 0 used as the register's address.
> +          ** field-width: Width of each group in the register in bits.
> +                          A group contains the priority for a single
> +                          interrupt vector. Thus a 16 bit register with
> +                          a field-width of 4 may control the priority for
> +                          4 (16 / 4) interrupt sources.
> +          ** reginfo    : This specifies the interrupt sources or interrupt
> +                          source groups controlled by the priority register.
> +                          The list entries correspond to the groups of the
> +                          priority register from least to most significant.
> +                          A value of 0 may be used for unused groups.
> +                          Trailing list entries may be omitted in which
> +                          case they will be treated as 0.
> +
> + -- intc_sense_registers : This sets up the contents of the sense registers
> +    This node requires the following properties:
> +        * address-cells : Must be 1
> +        * size-cells    : Must be 1
> +        * ranges        : Empty as we have a 1-1 mapping to parent's
> +                          address space
> +        * intc_prio*   : A sense register
> +         This node requires the following properties:
> +          ** reg        : This specifies the address of the sense register.
> +                          The first cell is the register's address, and the
> +                          second cell is the register's size which must be
> +                          1, 2 or 4 bytes.
> +          ** field-width: Width of each group in the register in bits.
> +                          A group contains the priority for a single
> +                          interrupt vector. Thus a 16 bit register with
> +                          a field-width of 4 may control the priority for
> +                          4 (16 / 4) interrupt sources.
> +          ** reginfo    : This specifies the interrupt sources controlled by
> +                          the sense register.  The list entries correspond
> +                          to the groups of the priority register from least
> +                          to most significant.  A value of 0 may be used
> +                          for unused groups.  Trailing list entries may be
> +                          omitted in which case they will be treated as 0.
> +
> + -- intc_ack_registers   : This sets up the contents of the ACK registers
> +    This node requires the following properties:
> +        * address-cells : Must be 1
> +        * size-cells    : Must be 1
> +        * ranges        : Empty as we have a 1-1 mapping to parent's
> +                          address space
> +        * intc_ack*    : An ACK registers
> +         This node requires the following properties:
> +          ** reg        : This specifies the address of the ACK register.
> +                          The first cell is the register's address, and the
> +                          second cell is the register's size which must be
> +                          1, 2 or 4 bytes.
> +          ** reginfo    : This specifies the interrupt sources controlled by
> +                          the ACK register. The list entries correspond to
> +                          bits of the ACK register from most to least
> +                          significant.  A value of 0 may be used for unused
> +                          bits in the mask.  Trailing list entries may be
> +                          omitted in which case they will be treated as 0.
> +
> +Optional:
> +
> +- intc_groups          : The interrupt source groups
> +                          Interrupt sources may be grouped with a group
> +                          sharing the same bits of an interrupt priority
> +                          register.
> +    This node requires the following property:
> +       * intc_group*   : An interrupt source group
> +         This node requires the following property:
> +          ** group      : The list of interrupt sources that
> +                          belong to the group.
> +
> +- intc_intevtsa        : This sets up the contents of INTEVTSA.
> +       This node requires the following properties:
> +         * vector : This specifies the interrupt source
> +
> +Example:
> +
> +       intca: interrupt-controller at 0 {
> +               compatible = "renesas,sh_intc";
> +               interrupt-controller;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               #interrupt-cells = <1>;
> +               ranges;
> +
> +               reg = <0xe6940000 0x200>, <0xe6950000 0x200>;
> +               group_size = <19>;
> +
> +               DIRC: intsrc1 { vector = <0x0560>; };
> +               ATAPI: intsrc2 { vector = <0x05E0>; };

This looks suspiciously like a way of encoding a device's interrupt information
into the interrupt controller's device node. That strikes me as being the wrong
way round.

> +               ....
> +
> +               DMAC1_1: intc_group0 { group = <&DMAC1_1_DEI0 &DMAC1_1_DEI1
> +                               &DMAC1_1_DEI2 &DMAC1_1_DEI3>; };
> +               DMAC1_2: intc_group1 { group = <&DMAC1_2_DEI4 &DMAC1_2_DEI5
> +                                                &DMAC1_2_DADERR>; };
> +               ....
> +               intc_vectors {
> +                       vector_table = <&DIRC &ATAPI &IIC1_ALI &IIC1_TACKI &IIC1_WAITI,
> +               ....
> +               };
> +
> +               intc_mask_registers {
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges;
> +
> +                       intc_mask0 {
> +                               reg = <0xe6940080 1>, <0xe69400c0 1>;
> +                               reginfo = <&DMAC2_1_DEI3 &DMAC2_1_DEI2 &DMAC2_1_DEI1
> +                                       &DMAC2_1_DEI0 0 0 &AP_ARM_COMMTX &AP_ARM_COMMRX>;
> +                       };
> +                       ....
> +               };
> +
> +               intc_prio_registers {
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges;
> +
> +                       intc_prio0 {
> +                               reg = <0xe6940000 2>;
> +                               field-width = <4>;
> +                               reginfo = <&DMAC3_1 &DMAC3_2 &CMT2 &ICBS0>;
> +                       };
> +                       ....
> +               };
> +       };

[...]

I've not reviewed the code in this patch. I think we should focus on ensuring
the binding make sense first; once it's in we're stuck with it.

Thanks,
Mark.
