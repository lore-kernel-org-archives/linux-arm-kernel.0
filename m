From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 28 Feb 2014 18:22:34 -0700
Subject: [PATCH 3/3] PCI: imx6: ventana: fixup for IRQ mismapping
In-Reply-To: <CAJ+vNU0Ao4BJhL9kQL45_nGf7hFZWsBMXMs9Y_pr10Mamqtnxw@mail.gmail.com>
References: <1393550394-11071-1-git-send-email-tharvey@gateworks.com>
 <1393550394-11071-4-git-send-email-tharvey@gateworks.com>
 <7755759.E1g1jlxbyc@wuerfel>
 <20140228173957.GC7773@obsidianresearch.com>
 <CAJ+vNU0Ao4BJhL9kQL45_nGf7hFZWsBMXMs9Y_pr10Mamqtnxw@mail.gmail.com>
Message-ID: <20140301012234.GA31062@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 04:52:05PM -0800, Tim Harvey wrote:

> > In particular, this is probably not a TI XIO2001 problem, but a board
> > design problem - the swizzle rules were not properly followed when
> > wiring up the PCI ISDEL and INTx pins on the downstream PCI bus.
> 
> Correct - its not a TI XIO2001 problem, its that the interrupts from
> the slots to the XIO2001 don't follow the interrupt mapping called out
> in the spec correctly (board problem on the 'add-in' board, not the
> 'baseboard').

So broken hardware requires explicit DT representation, the
auto-probing mechanism only work for compliant hardware.

> Regardless of the issue of not knowing the bus topology before-hand,

To solve this problem, you reall need to know the bus topology before
hand, so any systems that include a borken TI XIO2001 board need a
special DT.

Including stuff like this in code means you hobble every one who might
use the TI chip correctly. It is certainly inappropriate to include a
host driver, or generic PCI fixup.

> I'm still trying to understand how to describe the bridge in
> devicetree using your example above.  If I were able to define a DT
> node for the XIO2001 bridge and apply an interrupt-map there, how does
> that map get encorporated into the swizzle in the case the the bridge
> is in the middle of the chain of devices?   

You keep nesting the PCI-PCI bridges until you get to the bottom,
basically following along the lspci -t output, cast into DT notation:

Your first example:
                pcie-controller {
                        compatible = "marvell,kirkwood-pcie";
                        status = "disabled";
                        device_type = "pci";

                        pcie at 0,0 {
                                device_type = "pci";
				// Presumably this is the root port bridge?
                                // 00:00.0 0604: 16c3:abcd
                                reg = <PCI_ID(0,0,0) 0 0 0 0>;
				pcie at 0,0 {
					 // This is the broken TI board:
					 // 01:00.0 0604: 104c:8240
                                	 reg = <PCI_ID(1,0,0) 0 0 0 0>;

Second example:
                pcie-controller {
                        compatible = "marvell,kirkwood-pcie";
                        status = "disabled";
                        device_type = "pci";

                        pcie at 0,0 {
                                device_type = "pci";
				// Presumably this is the root port bridge?
                                // 00:00.0 0604: 16c3:abcd
                                reg = <PCI_ID(0,0,0) 0 0 0 0>;
				pcie at 0,0 {
					 // This is the PEX switch bridge to internal
					 // 01:00.0 0604: 10b5:8609 (rev ba)
                                	 reg = <PCI_ID(1,0,0) 0 0 0 0>;
					 pcie at 4,0 {
					 	  // This is the PEX port bridge to
						  // To the TI part
						  // 02:04.0 0604: 10b5:8609 (rev ba)
						  reg = <PCI_ID(2,4,0) 0 0 0 0>;
					 	  pcie at 0,0 {
						  	   // This is the broken TI board:
							   // 04:00.0 0604: 104c:8240
                                	 		   reg =
							   <PCI_ID(4,0,0)
							   0 0 0 0>;


Also, bear in mind that every single explicitly declared stanza requires
a correct interrupt-map. 

> of_irq_parse_map_pci() function that will likely be called from
> map_irq() it would end up calling of_irq_parse_raw to map the irq and
> I'm not understanding how that will take into account the fact that a
> bridge possibly in the middle of the bus-tree had invalid mapping.

First the PCI core matches the DT nodes to the discovered topology.

Then the interrupt mapper starts from a probed PCI node and traces up
the tree to the root. Each time it goes up it swizzles.

When it finds a node with a DT mapping it immediately switches to DT
to resolve the interrupt, which uses the first interrupt map found by
traversing up from the match'd DT node. Once it switches to DT mode
there is no swizzling, the DT must exactly describe the
interconnection.

Jason
