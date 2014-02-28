From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 28 Feb 2014 10:39:57 -0700
Subject: [PATCH 3/3] PCI: imx6: ventana: fixup for IRQ mismapping
In-Reply-To: <7755759.E1g1jlxbyc@wuerfel>
References: <1393550394-11071-1-git-send-email-tharvey@gateworks.com>
 <1393550394-11071-4-git-send-email-tharvey@gateworks.com>
 <7755759.E1g1jlxbyc@wuerfel>
Message-ID: <20140228173957.GC7773@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 10:27:13AM +0100, Arnd Bergmann wrote:
> On Thursday 27 February 2014 17:19:54 Tim Harvey wrote:
> > The TI XIO2001 PCIe-to-PCI bridge used on Ventana expansion boards
> > has its slot-to-bridge IRQ mapping reversed from the PCI specification:
> > 
> >   INTA->INTD
> >   INTB->INTC
> >   INTC->INTB
> >   INTD->INTA
> > 
> > Implement a custom swizzle function that does a fixup on the interrupt for
> > devices on the first TI XIO2001 bridge in the tree.
> > 
> 
> I'm pretty sure you can express that by using a more specific
> 'interrupt-map' property that defines the correct mapping for
> the PCIe-to-PCI bridge in the board file.

Yes, the correct way to handle this is to define a stanza for the
PCIe-PCI bridge and then place an interrupt map in that stanza that
describes the downstream translation.

Nobody should be messing with IRQ numbers in code on DT platforms.

DTs using the mvebu driver have an example of this:

                pcie-controller {
                        compatible = "marvell,kirkwood-pcie";
                        status = "disabled";
                        device_type = "pci";

                        pcie at 1,0 {
                                device_type = "pci";
                                reg = <0x0800 0 0 0 0>;
                                      ^^^^^^^ This is the PCI device
				      ID of the bridge
                                interrupt-map-mask = <0 0 0 0>;
                                interrupt-map = <0 0 0 0 &intc 9>;

Which says 'INTA/B/C/D of devices downstream of bridge 00:01.0 map to
&intc input 9'

In particular, this is probably not a TI XIO2001 problem, but a board
design problem - the swizzle rules were not properly followed when
wiring up the PCI ISDEL and INTx pins on the downstream PCI bus.

Jason
