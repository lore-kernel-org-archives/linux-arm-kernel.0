From: tharvey@gateworks.com (Tim Harvey)
Date: Fri, 28 Feb 2014 16:52:05 -0800
Subject: [PATCH 3/3] PCI: imx6: ventana: fixup for IRQ mismapping
In-Reply-To: <20140228173957.GC7773@obsidianresearch.com>
References: <1393550394-11071-1-git-send-email-tharvey@gateworks.com>
 <1393550394-11071-4-git-send-email-tharvey@gateworks.com>
 <7755759.E1g1jlxbyc@wuerfel>
 <20140228173957.GC7773@obsidianresearch.com>
Message-ID: <CAJ+vNU0Ao4BJhL9kQL45_nGf7hFZWsBMXMs9Y_pr10Mamqtnxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 9:39 AM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Fri, Feb 28, 2014 at 10:27:13AM +0100, Arnd Bergmann wrote:
>> On Thursday 27 February 2014 17:19:54 Tim Harvey wrote:
>> > The TI XIO2001 PCIe-to-PCI bridge used on Ventana expansion boards
>> > has its slot-to-bridge IRQ mapping reversed from the PCI specification:
>> >
>> >   INTA->INTD
>> >   INTB->INTC
>> >   INTC->INTB
>> >   INTD->INTA
>> >
>> > Implement a custom swizzle function that does a fixup on the interrupt for
>> > devices on the first TI XIO2001 bridge in the tree.
>> >
>>
>> I'm pretty sure you can express that by using a more specific
>> 'interrupt-map' property that defines the correct mapping for
>> the PCIe-to-PCI bridge in the board file.
>
> Yes, the correct way to handle this is to define a stanza for the
> PCIe-PCI bridge and then place an interrupt map in that stanza that
> describes the downstream translation.
>
> Nobody should be messing with IRQ numbers in code on DT platforms.
>
> DTs using the mvebu driver have an example of this:
>
>                 pcie-controller {
>                         compatible = "marvell,kirkwood-pcie";
>                         status = "disabled";
>                         device_type = "pci";
>
>                         pcie at 1,0 {
>                                 device_type = "pci";
>                                 reg = <0x0800 0 0 0 0>;
>                                       ^^^^^^^ This is the PCI device
>                                       ID of the bridge
>                                 interrupt-map-mask = <0 0 0 0>;
>                                 interrupt-map = <0 0 0 0 &intc 9>;
>
> Which says 'INTA/B/C/D of devices downstream of bridge 00:01.0 map to
> &intc input 9'
>

Jason,

In our case, the IMX6 is on a basebaord and we have optional expansion
boards.  One such board has a PEX 8609 9-port PCIe switch, the other
has a TI XIO2001 PCIe-to-PCI bridge.  So, depending on how you connect
these expansion boards the bus numbers change.

For example, one use case of the baseboard+XIO2001-expansion is: IMX6
-> XIO2001 PCIe-to-PCI bridge:
The following shows one endpoint off the bridge (bus2 slot12):
$ lspci -n
00:00.0 0604: 16c3:abcd (rev 01)
01:00.0 0604: 104c:8240
02:0c.0 0280: 168c:0027 (rev 01)
$ lspci -tnv
-[0000:00]---00.0-[01-02]----00.0-[02]----0c.0  168c:0027

Another use case of the same baseboard + PEX8609-expansion +
XIO2001-expansion is:
$ lspci -n
00:00.0 0604: 16c3:abcd (rev 01)
01:00.0 0604: 10b5:8609 (rev ba)
01:00.1 0880: 10b5:8609 (rev ba)
02:01.0 0604: 10b5:8609 (rev ba)
02:04.0 0604: 10b5:8609 (rev ba)
02:05.0 0604: 10b5:8609 (rev ba)
02:06.0 0604: 10b5:8609 (rev ba)
02:07.0 0604: 10b5:8609 (rev ba)
02:08.0 0604: 10b5:8609 (rev ba)
02:09.0 0604: 10b5:8609 (rev ba)
04:00.0 0604: 104c:8240
05:0c.0 0280: 168c:0027 (rev 01)
$ lspci -tnv
-[0000:00]---00.0-[01-0a]--+-00.0-[02-0a]--+-01.0-[03]--
                           |
+-04.0-[04-05]----00.0-[05]----0c.0  168c:0027
                           |               +-05.0-[06]--
                           |               +-06.0-[07]--
                           |               +-07.0-[08]--
                           |               +-08.0-[09]--
                           |               \-09.0-[0a]--
                           \-00.1  10b5:8609

> In particular, this is probably not a TI XIO2001 problem, but a board
> design problem - the swizzle rules were not properly followed when
> wiring up the PCI ISDEL and INTx pins on the downstream PCI bus.

Correct - its not a TI XIO2001 problem, its that the interrupts from
the slots to the XIO2001 don't follow the interrupt mapping called out
in the spec correctly (board problem on the 'add-in' board, not the
'baseboard').

Regardless of the issue of not knowing the bus topology before-hand,
I'm still trying to understand how to describe the bridge in
devicetree using your example above.  If I were able to define a DT
node for the XIO2001 bridge and apply an interrupt-map there, how does
that map get encorporated into the swizzle in the case the the bridge
is in the middle of the chain of devices?   In looking at the
of_irq_parse_map_pci() function that will likely be called from
map_irq() it would end up calling of_irq_parse_raw to map the irq and
I'm not understanding how that will take into account the fact that a
bridge possibly in the middle of the bus-tree had invalid mapping.

Thanks,

Tim


>
> Jason
