From: tharvey@gateworks.com (Tim Harvey)
Date: Mon, 3 Mar 2014 11:59:51 -0800
Subject: [PATCH 3/3] PCI: imx6: ventana: fixup for IRQ mismapping
In-Reply-To: <20140301012234.GA31062@obsidianresearch.com>
References: <1393550394-11071-1-git-send-email-tharvey@gateworks.com>
 <1393550394-11071-4-git-send-email-tharvey@gateworks.com>
 <7755759.E1g1jlxbyc@wuerfel>
 <20140228173957.GC7773@obsidianresearch.com>
 <CAJ+vNU0Ao4BJhL9kQL45_nGf7hFZWsBMXMs9Y_pr10Mamqtnxw@mail.gmail.com>
 <20140301012234.GA31062@obsidianresearch.com>
Message-ID: <CAJ+vNU0CLO6GWpYGx6SG1sXrqkn=6BNoFGodBtWxeCYUTEQW5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 5:22 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Fri, Feb 28, 2014 at 04:52:05PM -0800, Tim Harvey wrote:
>
>> > In particular, this is probably not a TI XIO2001 problem, but a board
>> > design problem - the swizzle rules were not properly followed when
>> > wiring up the PCI ISDEL and INTx pins on the downstream PCI bus.
>>
>> Correct - its not a TI XIO2001 problem, its that the interrupts from
>> the slots to the XIO2001 don't follow the interrupt mapping called out
>> in the spec correctly (board problem on the 'add-in' board, not the
>> 'baseboard').
>
> So broken hardware requires explicit DT representation, the
> auto-probing mechanism only work for compliant hardware.

ok - makes sense

>
>> Regardless of the issue of not knowing the bus topology before-hand,
>
> To solve this problem, you reall need to know the bus topology before
> hand, so any systems that include a borken TI XIO2001 board need a
> special DT.

I suppose I could go about this from the bootloader as well.  The
bootloader could enumerate the bus and build the DT with the nodes
required to handle the broken TI XIO2001 add-in cards.

>
> Including stuff like this in code means you hobble every one who might
> use the TI chip correctly. It is certainly inappropriate to include a
> host driver, or generic PCI fixup.

Understood - trust me... I'm not happy about this situation.

A pci fixup for the XIO2001 could at least be placed in
arch/arm/mach-imx/mach-imx6q.c with a check for
of_machine_is_compatible("gw, ventana").  This is currently done in
order to handle GPIO on the PEX890x bridge which is used as PERST# for
downstream slots (see
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/mach-imx/mach-imx6q.c#n87).

This of course, assumes that I can come up with a way for a pci fixup
to replace the swizzle function of the host controller before
enumeration.

>
>> I'm still trying to understand how to describe the bridge in
>> devicetree using your example above.  If I were able to define a DT
>> node for the XIO2001 bridge and apply an interrupt-map there, how does
>> that map get encorporated into the swizzle in the case the the bridge
>> is in the middle of the chain of devices?
>
> You keep nesting the PCI-PCI bridges until you get to the bottom,
> basically following along the lspci -t output, cast into DT notation:
>
> Your first example:
>                 pcie-controller {
>                         compatible = "marvell,kirkwood-pcie";
>                         status = "disabled";
>                         device_type = "pci";
>
>                         pcie at 0,0 {
>                                 device_type = "pci";
>                                 // Presumably this is the root port bridge?
>                                 // 00:00.0 0604: 16c3:abcd
>                                 reg = <PCI_ID(0,0,0) 0 0 0 0>;

I'm still not understanding what needs to go in the 'reg' property for
a DT node representing a PCI dev (what you are using PCI_ID() for).
I've looked at the PCI Bus Binding to Open Firmware doc and still
don't understand (its very terse, and lacks examples).  By looking
through the drivers/of code it seemed that this should be devfn but
after some digging through examples in
Documentation/devicetree/bindings/pci it seems that it really needs to
be devfn<<8.  I'm not clear why the <<8 is needed.

I also determined that for fsl.imx6q-pcie I needed to define
#address-cells = <3> and #size-cells = <2> as the enw pcie dev nodes
kept defaulting to something else - I didn't realize those were not
inherited from the parent DT node.

In all, your examples here were extremely helpful to me.  I now know
how to properly describe my GigE PCI dev node so that the driver can
have a hope of getting its MAC from DT.  Thank you!

>                                 pcie at 0,0 {
>                                          // This is the broken TI board:
>                                          // 01:00.0 0604: 104c:8240
>                                          reg = <PCI_ID(1,0,0) 0 0 0 0>;
>
<snip>
>
> Also, bear in mind that every single explicitly declared stanza requires
> a correct interrupt-map.

if not specified it wouldn't default to standard bridge mapping such
that I only need to provide interrupt-map for the node with the the TI
bridge?

>
>> of_irq_parse_map_pci() function that will likely be called from
>> map_irq() it would end up calling of_irq_parse_raw to map the irq and
>> I'm not understanding how that will take into account the fact that a
>> bridge possibly in the middle of the bus-tree had invalid mapping.
>
> First the PCI core matches the DT nodes to the discovered topology.
>
> Then the interrupt mapper starts from a probed PCI node and traces up
> the tree to the root. Each time it goes up it swizzles.
>
> When it finds a node with a DT mapping it immediately switches to DT
> to resolve the interrupt, which uses the first interrupt map found by
> traversing up from the match'd DT node. Once it switches to DT mode
> there is no swizzling, the DT must exactly describe the
> interconnection.

Ok - so this assumes that the host controller driver _is_ calling
something like of_irq_parse_and_map_pci() instead of returning based
on some static mapping (like pp->irq) right?

What confuses me is that swizzling is done to the pin before the call
to map_irq(dev, slot, pin).  It looks like that this common swizzling
is ignored when using of_irq_parse_and_map_pci() which instead would
perform what you describe above correct?

Thanks for all the help here!

Tim

>
> Jason
