From: tharvey@gateworks.com (Tim Harvey)
Date: Mon, 3 Mar 2014 16:38:10 -0800
Subject: [PATCH 3/3] PCI: imx6: ventana: fixup for IRQ mismapping
In-Reply-To: <20140303233733.GA5603@obsidianresearch.com>
References: <1393550394-11071-1-git-send-email-tharvey@gateworks.com>
 <1393550394-11071-4-git-send-email-tharvey@gateworks.com>
 <7755759.E1g1jlxbyc@wuerfel>
 <20140228173957.GC7773@obsidianresearch.com>
 <CAJ+vNU0Ao4BJhL9kQL45_nGf7hFZWsBMXMs9Y_pr10Mamqtnxw@mail.gmail.com>
 <20140301012234.GA31062@obsidianresearch.com>
 <CAJ+vNU0CLO6GWpYGx6SG1sXrqkn=6BNoFGodBtWxeCYUTEQW5Q@mail.gmail.com>
 <20140303233733.GA5603@obsidianresearch.com>
Message-ID: <CAJ+vNU1+o=2+YF8W=QfBNUhyCoC1tm17KD=cwRnUJozbbsN8qQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 3, 2014 at 3:37 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Mon, Mar 03, 2014 at 11:59:51AM -0800, Tim Harvey wrote:
>
>> A pci fixup for the XIO2001 could at least be placed in
>> arch/arm/mach-imx/mach-imx6q.c with a check for
>> of_machine_is_compatible("gw, ventana").  This is currently done in
>> order to handle GPIO on the PEX890x bridge which is used as PERST# for
>> downstream slots (see
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/mach-imx/mach-imx6q.c#n87).
>
> That is an odd looking thing .. PERST# of a subordinate port should be
> tied to the PCI_BRIDGE_CTL_BUS_RESET bit in the port's bridge
> configuration space - is more configuration of the PLX chip required?

PCI_BRIDGE_CTL_BUS_RESET does cause a hot reset on the corresponding
downstream link however the minPCIe card slot has a PERST# pin that is
for a functional reset to the card.  The GPIO's I mention on the PLX
bridge are routed to that signal for the various slots.  Regardless of
what a device may do when it gets a hot-reset some devices still may
require a hard reset.  Think of MiniPCIe form-factor USB cellular
modems for example which don't even use the PCIe bus.

>
> Also, be aware that PCI specifies a minimum time after
> reset-deassertion before accessing the bus, and I don't see a sleep...

there is an msleep(100) there after the de-assertion.

>
>> I'm still not understanding what needs to go in the 'reg' property for
>> a DT node representing a PCI dev (what you are using PCI_ID() for).
>
> It is a 3 DW address in this format:
>
> phys.hi cell: npt000ss bbbbbbbb dddddfff rrrrrrrr
> phys.mid cell: hhhhhhhh hhhhhhhh hhhhhhhh hhhhhhhh
> phys.low cell: llllllll llllllll llllllll llllllll
>
> And in this context you use 'ss' = 0 for configuration:
>
> * npt000ss bbbbbbbb dddddfff rrrrrrrr
> = 00000000 00000000 dddddfff 00000000
>
> So devfn << 8 sounds right to me.
>
> I *think* you can use 0 for the bus in this context.

yes, it would appear bus can be 0 from my findings.  Thanks for
clarifying that verbiage!

>
>> #address-cells = <3> and #size-cells = <2> as the enw pcie dev nodes
>> kept defaulting to something else - I didn't realize those were not
>> inherited from the parent DT node.
>
> Right, sorry, I was making it terse..
>
>> In all, your examples here were extremely helpful to me.  I now know
>> how to properly describe my GigE PCI dev node so that the driver can
>> have a hope of getting its MAC from DT.  Thank you!
>
> Right!
>
>> > Also, bear in mind that every single explicitly declared stanza requires
>> > a correct interrupt-map.
>>
>> if not specified it wouldn't default to standard bridge mapping such
>> that I only need to provide interrupt-map for the node with the the TI
>> bridge?
>
> Nope, there are two distinct mechanisms - finding the closes DT node
> to the actual PCI device (of_irq_parse_pci) - this swizzles as it
> searches. The rational here is to support hot pluggable devices that
> were not discovered during initialization time.
>
> The second is the completely generic interrupt-map mechanism
> (of_irq_parse_raw), which takes the interrupt specification from the
> first phase and transates it into an actual interrupt. This isn't PCI
> aware and doesn't change the description in any way.
>
> So if you specify a node, you have to specify an interrupt-map that
> covers that node. I recommend placing the map in the node itself so
> the bus number is not required.
>
>> Ok - so this assumes that the host controller driver _is_ calling
>> something like of_irq_parse_and_map_pci() instead of returning based
>> on some static mapping (like pp->irq) right?
>
> Yes, absoultely. All DT based PCI drivers need to use this mechanism
> to get the expected interrupt-map behavior.
>
>> What confuses me is that swizzling is done to the pin before the call
>> to map_irq(dev, slot, pin).  It looks like that this common swizzling
>> is ignored when using of_irq_parse_and_map_pci() which instead would
>> perform what you describe above correct?
>
> Right, the pin # from the PCI core isn't used in the OF code:
>
>  * of_irq_parse_and_map_pci() - Decode a PCI irq from the device tree and map to a virq
>  * @slot and @pin are unused, but included in the function so that this
>  * function can be used directly as the map_irq callback to pci_fixup_irqs().
>
> It re-reads the device's pin number directly and feeds that through
> the standard swizzle and OF's UIS system.
>
> Jason

Ok - that all makes sense and hopefully when I get the legacy PCI
interrupt mapping via DT working for IMX6 I can prove it out.

What did you think of my two ideas above to resolve this issue on our
add-in card where the bus-topology isn't known ahead of time:

 1. bootloader builds out DT with proper interrupt-map's to handle the
mis-map after enumerating the bus to understand the toplogy.

or

 2. a pci fixup for xio2001 that further qualifies the DT machine and
the 'depth' of the xio2001 (ie make sure its the first xio2001 bridge
on the bus) that replaces the swizzle function.  This would be in
arch/arm/mach-imx/mach-imx6q.c

Thanks,

Tim
