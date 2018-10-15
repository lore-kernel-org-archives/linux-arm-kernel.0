From: honghui.zhang@mediatek.com (Honghui Zhang)
Date: Mon, 15 Oct 2018 10:42:23 +0800
Subject: [PATCH v6 2/9] PCI: mediatek: Fixup class ID for MT7622 as
 PCI_CLASS_BRIDGE_PCI
In-Reply-To: <20181012141202.GV5906@bhelgaas-glaptop.roam.corp.google.com>
References: <1538969088-7136-1-git-send-email-honghui.zhang@mediatek.com>
 <1538969088-7136-3-git-send-email-honghui.zhang@mediatek.com>
 <20181008172337.GA13538@e107981-ln.cambridge.arm.com>
 <1539054495.6246.31.camel@mhfsdcap03>
 <20181011113748.GA3574@e107981-ln.cambridge.arm.com>
 <1539331289.6246.61.camel@mhfsdcap03>
 <20181012102230.GA23257@e107981-ln.cambridge.arm.com>
 <20181012141202.GV5906@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <1539571343.6246.74.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-10-12 at 09:12 -0500, Bjorn Helgaas wrote:
> On Fri, Oct 12, 2018 at 11:22:30AM +0100, Lorenzo Pieralisi wrote:
> > On Fri, Oct 12, 2018 at 04:01:29PM +0800, Honghui Zhang wrote:
> >> On Thu, 2018-10-11 at 12:38 +0100, Lorenzo Pieralisi wrote:
> >>> On Tue, Oct 09, 2018 at 11:08:15AM +0800, Honghui Zhang wrote:
> >>>> On Mon, 2018-10-08 at 18:23 +0100, Lorenzo Pieralisi wrote:
> >>>>> On Mon, Oct 08, 2018 at 11:24:41AM +0800, honghui.zhang at mediatek.com wrote:
> >>>>>> From: Honghui Zhang <honghui.zhang@mediatek.com>
> >>>>>> 
> >>>>>> The PCIe controller of MT7622 has TYPE 1 configuration
> >>>>>> space type, but the HW default class type values is
> >>>>>> invalid.
> >>>>>> 
> >>>>>> The commit 101c92dc80c8 ("PCI: mediatek: Set up vendor ID
> >>>>>> and class type for MT7622") have set the class ID for
> >>>>>> MT7622 as PCI_CLASS_BRIDGE_HOSTe, but it's not workable
> >>>>>> for MT7622:
> >>>>>> 
> >>>>>> In __pci_bus_assign_resources, the framework only setup
> >>>>>> bridge's resource window only if class type is
> >>>>>> PCI_CLASS_BRIDGE_PCI. Or it will leave the subordinary PCIe
> >>>>>> device's MMIO window un-touched.
> 
> I think __pci_bus_assign_resources() should be testing dev->hdr_type
> instead of dev->class.  The connection between "Header Type" and the
> layout of the rest of the header is very explicit (PCI r3.0 sec 6.1,
> PCIe r4.0 sec 7.5.1.1.9), and the reason for the switch statement in
> __pci_bus_assign_resources() is precisely to determine which layout to
> use.
> 
> There are several other uses of dev->class in setup-bus.c that I think
> should also be changed to use dev->hdr_type.
> 
> If we make these changes in setup-bus.c, I suspect the class code you
> assign won't matter too much.  There are a few other tests of the
> class code to figure out whether to leave certain things untouched.
> These seem a little hacky to me, but we're probably stuck with them
> for now, so you should look and see whether they apply to your
> situation.

If these change could be made in the PCI core, then the class code is no
matter what will be workable for MT7622.

As Lorenzo point it out, it's more reasonable for MT7622 to defined as a
PCI-to-PCI class code since the IP is defined as that. I intend to
following Lorenzo's suggest to update the commit message and re-send
this patch set for current solution.

> 
> >>>> And for MT7622, it integrated with block of internal control
> >>>> registers, type 1 configuration space, and is considered as a
> >>>> root complex.
> >>> 
> >>> I assume you mean a type 1 config header here. I do not think it
> >>> is mandatory for a host bridge to have a type 1 config header (and
> >>> related bridge windows + primary/secondary/subordinate bus
> >>> numbers) but I do not know how the IP you are programming is
> >>> designed.
> 
> It is definitely not mandatory for a host bridge to have a type 1
> header.  I'm not even sure that would make sense: the "Primary Bus
> Number" would not apply to a host bridge (since a host bridge's
> primary bus is some sort of CPU bus, not a PCI bus), and a type 1
> device cannot perform address translation between its primary and
> secondary buses, while a host bridge can.
> 
> A Root Port is a type 1 device where the primary bus is logically
> internal to the Root Complex.  A host bridge bridges from the CPU bus
> to that internal bus and might perform address translation.  The Root
> Port must be a PCI device.  A host bridge, being a bridge *to* the PCI
> domain, is not itself generally programmed via PCI config space and
> might not even be visible as a device in PCI config space.
> 
Thanks for the explain. Per my understanding, MT7622 is more like a
complex of Root Port and PCI-to-PCI bridge. It has type 1 header and has
the ability to translate address between its primary and secondary
buses. I guess apply the class type as PCI_CLASS_BRIDGE_PCI is
reasonable way to make its integrated internal bridge workable.

Thanks.
> Bjorn
