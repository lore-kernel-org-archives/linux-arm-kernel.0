From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 12 Mar 2013 22:30:06 +0100
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <20130312210328.GA22702@obsidianresearch.com>
References: <20130310065539.GA14704@obsidianresearch.com>
 <513D6F9C.9000100@firmworks.com>
 <20130311181554.GA10992@obsidianresearch.com>
 <513E519B.6010503@firmworks.com>
 <20130311232516.GA13873@obsidianresearch.com>
 <513E6AFE.3090304@firmworks.com>
 <20130312070852.GA6727@avionic-0098.mockup.avionic-design.de>
 <20130312155749.GA1820@obsidianresearch.com>
 <20130312203819.GA23221@avionic-0098.mockup.avionic-design.de>
 <20130312210328.GA22702@obsidianresearch.com>
Message-ID: <20130312213006.GA23717@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 03:03:28PM -0600, Jason Gunthorpe wrote:
> On Tue, Mar 12, 2013 at 09:38:19PM +0100, Thierry Reding wrote:
> 
> > I've also verified that things actually do work with the binding that I
> > proposed for Tegra, even if I add device_type = "pci" to the root port
> > nodes. The reason is that the OF core looks up the type of the *parent*
> > node to find a matching bus. This happens to be the pcie-controller node
> > which is not a PCI device and therefore the address translation works
> > properly.
> 
> Mitch pointed out early on that the parent node needs a 'device_type =
> "pci"' as well.
> 
> The pcie-controller node would be classified as a 'bus node' according
> to the spec.
> 
> Not going down the of_pci_* code paths for address translation at the
> root port bridge nodes is certainly not right.

I'm not so sure. Why should the pcie-controller be a PCI device? It
really isn't. Instead it is a device on the processor/SoC/platform bus
that bridges to the PCI bus. As such its children should be PCI devices
to reflect that the translation happens within the pcie-controller node.

In the above it is logical to not set the pcie-controller's device_type
property to "pci".

> > ranges = <0x00000800 0 0 0x80000000 0 0x00001000   /* port 0 configuration space */
> >           0x00001000 0 0 0x80001000 0 0x00001000   /* port 1 configuration space */
> 
> Section 12 says that the 'b,d,f' bits are 0 in ranges, so the above is
> in conflict with that language:
> 
>  In particular, the phys.hi fields of the child address spaces in the
>  "ranges" property for PCI does not contain the same information as
>  "reg" property entries within PCI nodes. The only information that is
>  present in "ranges" phys.hi entries are the non-relocatable,
>  prefetchable and the PCI address space bits for which the entry
>  applies. I.e., only the n, p and ss bits are present; the bbbbbbbb,
>  ddddd, fff and rrrrrrrr fields are 0.
> 
> And the further requirement:
> 
>  When an address is to be mapped through a PCI bus bridge node, the
>  phys.hi value of the address to be mapped and the child field of a
>  "ranges" entry should be masked so that only the ss bits are compared.
> 
> Which is embodied by the code in of_bus_pci_map, meaning the OF core
> won't even look at the bits in the high DW when searching ranges.

Okay, so the problem with that is that we won't be able to include more
entries for configuration space within a ranges property because we
can't uniquely map them (they both have the same ss field values). One
possibility would be to differentiate using the phys.mid and phys.low
cells but they need to be 0 according to the spec.

The other alternative would be to amend the specification. Besides the
fact that the specification says so I don't see any reason why this
shouldn't be allowed.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130312/ca54ca56/attachment.sig>
