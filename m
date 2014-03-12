From: tharvey@gateworks.com (Tim Harvey)
Date: Tue, 11 Mar 2014 20:37:35 -0700
Subject: [PATCH 1/2] of/irq: Fix irq-mapping in of_irq_parse_raw()
In-Reply-To: <20140311201533.GF31835@obsidianresearch.com>
References: <1393944864-28113-1-git-send-email-tharvey@gateworks.com>
 <20140311201533.GF31835@obsidianresearch.com>
Message-ID: <CAJ+vNU1-evvZuLEeKvdRnbt_kXm3-zsNEk9ACQ21UhYxJtWwFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 11, 2014 at 1:15 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Tue, Mar 04, 2014 at 06:54:24AM -0800, Tim Harvey wrote:
>> When an interrupt-map contains multiple entries an imap pointer arithmetic
>> bug can cause only the first entry to be properly evaluated and causes
>> the out_irq parameters to be incorrect depending on the #interrupt-cells
>> and #address-cells of the parent interrupt controller.
>
> Tim,
>
> I took a bit closer look at this for you, and I suspect the root fix
> is this:
>
> --- a/Documentation/devicetree/bindings/arm/gic.txt
> +++ b/Documentation/devicetree/bindings/arm/gic.txt
> @@ -55,7 +55,6 @@ Example:
>         intc: interrupt-controller at fff11000 {
>                 compatible = "arm,cortex-a9-gic";
>                 #interrupt-cells = <3>;
> -               #address-cells = <1>;
>                 interrupt-controller;
>                 reg = <0xfff11000 0x1000>,
>                       <0xfff10100 0x100>;
> (plus the corresponding purge from the .dt files)
>
> It looks like the implementation does follow the OF specification:
>
>  Each mapping entry consists of a 3-tuple of (child-interrupt,
>  interrupt-parent, parent-interrupt). The number of cells for the
>  child-interrupt specifier is determined by the "#address-cells" and
>  "#interrupt-cells"property of this node. The number of cells for the
>  parent-interrupt value is determined by the "#address-cells"and
>  "#interrupt-cells"property values of this node's
>  interrupt-parent.

Ok - I see I misunderstood the spec with regards to what the
address-cells related to.

>
> So by specifying interrupt-cells = 3, address-cells = 1, the GIC is
> requiring 4 DWs for its interrupt specifier.

Agreed, and the interrupt mapping for the imx6 pcie host controller:

interrupt-map = <0 0 0 1 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
                <0 0 0 2 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
                <0 0 0 3 &intc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
                <0 0 0 4 &intc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;

has only 3 cells for the parent interrupt, and only 3 are needed so I
suppose there is no 'address' necessary.

>
> I see no reason why it doesn't have an address-cells = 0 like other
> interrupt controllers..

I agree, and I see that as well for other cortex-a9 gic interrupt controllers.

>
> Setting #address-cells to 0 in the GIC node should be functionally
> equivalent to your patch below, since newaddrsize will == 0.

yes, it does.  I'll verify and post a followup patch tomorrow for the
invalid dtsi's.  Thanks for digging into this!

Tim
