From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 13 Mar 2013 22:33:44 +0100
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <5140E85A.3040900@firmworks.com>
References: <20130312070852.GA6727@avionic-0098.mockup.avionic-design.de>
 <20130312155749.GA1820@obsidianresearch.com>
 <20130312203819.GA23221@avionic-0098.mockup.avionic-design.de>
 <20130312210328.GA22702@obsidianresearch.com>
 <20130312213006.GA23717@avionic-0098.mockup.avionic-design.de>
 <20130312220854.GA23112@obsidianresearch.com>
 <20130313081815.GD25940@avionic-0098.mockup.avionic-design.de>
 <20130313170205.GB24042@obsidianresearch.com>
 <20130313192628.GA28714@avionic-0098.mockup.avionic-design.de>
 <5140E85A.3040900@firmworks.com>
Message-ID: <20130313213344.GA29402@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 10:58:02AM -1000, Mitch Bradley wrote:
[...]
> In this case, the answer to "what does pcie_controller do?" is "it
> implements a PCI bus" below.  So 'device_type = "pci"' is appropriate.

Alright, that's 2 against 1. I don't have much of a choice but to yield.

> Having just re-read the code in drivers/of/address.c, I think I have a
> deeper understanding of a few practical issues:
> 
> In order to translate a 3/2 PCI address via of_get_pci_address(), the
> parent device (i.e. root complex / pcie-controller) must have both
> 'device_type = "pci"' (else of_match_bus() won't find the pci version of
> "struct of_bus") and also 'name = "pci"' (else strcmp(bus->name, "pci")
> will fail).
> 
> So it would seem that, if you want to use address.c verbatim (for the
> interface between pcie-controller and its direct children), not only do
> you need device_type = pci, but you also need to rename
> "pcie-controller" to "pci".

bus->name refers to that of the of_bus structure, not the node name of
the controller.

> But then you run into the problem that the pci variant of struct of_bus
> uses "assigned-addresses" instead of "reg".  So it still doesn't work
> as-is.  To make it work, you would need to add an "assigned-addresses"
> property to each root port node.  That property value could be in
> non-relocatable memory space, translatable via normal rules, in which
> case the "map config space to MMIO via ranges" discussion is moot for
> Marvell.

At the risk of quoting the spec: it says (4.1.2) that the entries in the
"assigned-addresses" property correspond to the function's configuration
space BARs. In this case however that's no longer true. But if everybody
thinks that repurposing the "assigned-addresses" property is more
acceptable than leaving out the device_type = "pci" property from the
pcie-controller node, then so be it.

> Which re-raises a question for which I have not yet heard a compelling
> answer:  Why use 3/2 PCI addressing between Marvell pcie-controller and
> its root ports (with their unusual programming model)?  The Marvell
> hardware address structure between controller and root ports is
> definitely not 3/2.  Certainly you need 3/2 addressing below
> (implemented by) the root ports, but I just don't see the utility of
> pretending 3/2 addressing at the complex-to-port interface.  If the root
> port hardware used the common programming model, with real config
> headers and stuff, 3/2 would be good because you could use existing
> drivers.  But since you need a special root-port driver anyway, why go
> to the trouble of emulating non-existent addressing?

I think the reason is that reg needs to be in the standard format for
the device node matching code to work. There are various checks to make
sure the reg property has entries which are 3/2 each.

There's also the issue that the pcie-controller's ranges property
contains the mapping of the I/O and memory windows and therefore needs
the 3/2 addressing to encode the type.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130313/8bd653a8/attachment.sig>
