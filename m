From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 11 Oct 2018 12:38:00 +0100
Subject: [PATCH v6 2/9] PCI: mediatek: Fixup class ID for MT7622 as
 PCI_CLASS_BRIDGE_PCI
In-Reply-To: <1539054495.6246.31.camel@mhfsdcap03>
References: <1538969088-7136-1-git-send-email-honghui.zhang@mediatek.com>
 <1538969088-7136-3-git-send-email-honghui.zhang@mediatek.com>
 <20181008172337.GA13538@e107981-ln.cambridge.arm.com>
 <1539054495.6246.31.camel@mhfsdcap03>
Message-ID: <20181011113748.GA3574@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2018 at 11:08:15AM +0800, Honghui Zhang wrote:
> On Mon, 2018-10-08 at 18:23 +0100, Lorenzo Pieralisi wrote:
> > On Mon, Oct 08, 2018 at 11:24:41AM +0800, honghui.zhang at mediatek.com wrote:
> > > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > > 
> > > The PCIe controller of MT7622 has TYPE 1 configuration space type, but
> > > the HW default class type values is invalid.
> > > 
> > > The commit 101c92dc80c8 ("PCI: mediatek: Set up vendor ID and class
> > > type for MT7622") have set the class ID for MT7622 as
> > > PCI_CLASS_BRIDGE_HOSTe, but it's not workable for MT7622:
> > > 
> > > In __pci_bus_assign_resources, the framework only setup bridge's
> > > resource window only if class type is PCI_CLASS_BRIDGE_PCI. Or it
> > > will leave the subordinary PCIe device's MMIO window un-touched.

Can you please provide me with a full log of the issue ?

What is the bug this patch is actually fixing ?

> > > Fixup the class type to PCI_CLASS_BRIDGE_PCI as most of the controller
> > > driver do.
> > 
> > I think that this patch is correct but the commit log fails to pin point
> > the problem. The IP you are programming is a root port, that's why you
> > have to have the proper class code, the patch looks fine but I would
> > like to peek Bjorn's brain on this since it is a fundamental concept.
> > 
> 
> I'm a bit confused with the concepts of PCI_CLASS_BRIDGE_HOST and
> PCI_CLASS_BRIDGE_PCI, from PCI express spec,
> 4.0r1.0(PCI_Express_Base_4.0r1.0_September-27-2017-c), Host Bridge is
> "part of a Root Complex that connects a host CPU or CPUs to a
> Hierarchy". While Root Complex defines as "A defined System Element that
> includes at least one Host Bridge, Root port, or Root complex Integrated
> Endpoint".
> 
> But according to my understanding, most of the root port IPs integrated
> with a "PCI_CLASS_BRIDGE_PCI", which has type 1 configuration space and
> could be saw as a pci device when using lspci.
> 
> And for MT7622, it integrated with block of internal control registers,
> type 1 configuration space, and is considered as a root complex.

I assume you mean a type 1 config header here. I do not think it
is mandatory for a host bridge to have a type 1 config header
(and related bridge windows + primary/secondary/subordinate bus
numbers) but I do not know how the IP you are programming is
designed.

If the host bridge needs its memory window to be configured you can
easily do that in the driver (with driver specific code) without
requiring the generic PCI resource core to do that for you, the host
bridge is the root of the bus I do not see any reason why it should
be up to core PCI code to assign it, it is preprogrammed.

> I'm not sure which CLASS type it should have:
> From PCI_Code-ID_r_1_10__v8-Nov_2017, class type of
> 0x0604(PCI_CLASS_BRIDGE_PCI) is defined as a PCI-to-PCI bridge, not
> literally suitable for MT7622(which is a root complex)(In my personal
> opinion). But it is the only workable CLASS type for MT7622 in current
> kernel.
> 
> > If the kernel does not assign resources unless it detects a
> > PCI_CLASS_BRIDGE_PCI this means that for components that are
> > actually PCI_CLASS_BRIDGE_HOST their register set must come
> > preprogrammed unless I am missing something.
> > 
> 
> In the function pci_request_resource_alignment, it will by pass the
> resource assignment for PCI_CLASS_BRIDGE_HOST, though I'm not figured
> out why.
> 
> > I would like to get to the bottom of this since it is a fundamental
> > enumeration concept.
> > 
> 
> Do you like me to re-write the commit message for this patch and put the
> above information in? Or just not mention the PCI_CLASS_BRIDGE_HOST
> assign resource routine?

I want to understand where the problem is and whether it is right to
define the component as a PCI bridge rather than a host bridge.

Lorenzo
