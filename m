From: Varun.Sethi@freescale.com (Varun Sethi)
Date: Sat, 8 Aug 2015 15:06:12 +0000
Subject: [PATCH 2/3] Docs: dt: Add PCI MSI map bindings
In-Reply-To: <20150806173839.GC6437@leverpostej>
References: <1437670365-20704-1-git-send-email-mark.rutland@arm.com>
 <1437670365-20704-3-git-send-email-mark.rutland@arm.com>
 <BN1PR0301MB06277FDA6EB34E77B557CA75EA750@BN1PR0301MB0627.namprd03.prod.outlook.com>
 <20150806173839.GC6437@leverpostej>
Message-ID: <BN1PR0301MB0627EEEEBB0D30C391B421B0EA720@BN1PR0301MB0627.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,
Thanks for the response. Please find my comments inline.

Regards
Varun

> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Thursday, August 06, 2015 11:09 PM
> To: Sethi Varun-B16395
> Cc: devicetree at vger.kernel.org; Lorenzo Pieralisi; arnd at arndb.de; Marc
> Zyngier; Will Deacon; linux-kernel at vger.kernel.org;
> ddaney at caviumnetworks.com; iommu at lists.linux-foundation.org;
> tirumalesh.chalamarla at caviumnetworks.com;
> laurent.pinchart at ideasonboard.com; thunder.leizhen at huawei.com;
> treding at nvidia.com; linux-arm-kernel at lists.infradead.org;
> majun258 at huawei.com; Yoder Stuart-B08248
> Subject: Re: [PATCH 2/3] Docs: dt: Add PCI MSI map bindings
> 
> On Wed, Aug 05, 2015 at 05:39:33PM +0100, Varun Sethi wrote:
> > Hi Mark
> > Thanks for the patch. Please find my comment inline.
> >
> > Regards
> > Varun
> >
> > > -----Original Message-----
> > > From: iommu-bounces at lists.linux-foundation.org [mailto:iommu-
> > > bounces at lists.linux-foundation.org] On Behalf Of Mark Rutland
> > > Sent: Thursday, July 23, 2015 10:23 PM
> > > To: devicetree at vger.kernel.org
> > > Cc: Mark Rutland; lorenzo.pieralisi at arm.com; arnd at arndb.de;
> > > marc.zyngier at arm.com; will.deacon at arm.com; linux-
> > > kernel at vger.kernel.org; ddaney at caviumnetworks.com;
> > > iommu at lists.linux- foundation.org;
> > > tirumalesh.chalamarla at caviumnetworks.com;
> > > laurent.pinchart at ideasonboard.com; thunder.leizhen at huawei.com;
> > > treding at nvidia.com; linux-arm-kernel at lists.infradead.org;
> > > majun258 at huawei.com
> > > Subject: [PATCH 2/3] Docs: dt: Add PCI MSI map bindings
> > >
> > > Currently msi-parent is used by a few bindings to describe the
> > > relationship between a PCI root complex and a single MSI controller,
> > > but this property does not have a generic binding document.
> > >
> > > Additionally, msi-parent is insufficient to describe more complex
> > > relationships between MSI controllers and devices under a root
> > > complex, where devices may be able to target multiple MSI
> > > controllers, or where MSI controllers use (non-probeable) sideband
> information to distinguish devices.
> > >
> > > This patch adds a generic binding for mapping PCI devices to MSI
> controllers.
> > > This document covers msi-parent, and a new msi-map property
> > > (specific to
> > > PCI*) which may be used to map devices (identified by their
> > > Requester ID) to sideband data for each MSI controller that they may
> target.
> > >
> > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > ---
> > >  Documentation/devicetree/bindings/pci/pci-msi.txt | 220
> > > ++++++++++++++++++++++
> > >  1 file changed, 220 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/pci/pci-msi.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/pci-msi.txt
> > > b/Documentation/devicetree/bindings/pci/pci-msi.txt
> > > new file mode 100644
> > > index 0000000..9b3cc81
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/pci-msi.txt
> > > @@ -0,0 +1,220 @@
> > > +This document describes the generic device tree binding for
> > > +describing the relationship between PCI devices and MSI controllers.
> > > +
> > > +Each PCI device under a root complex is uniquely identified by its
> > > +Requester ID (AKA RID). A Requester ID is a triplet of a Bus
> > > +number, Device number, and Function number.
> > > +
> > > +For the purpose of this document, when treated as a numeric value,
> > > +a RID is formatted such that:
> > > +
> > > +* Bits [15:8] are the Bus number.
> > > +* Bits [7:3] are the Device number.
> > > +* Bits [2:0] are the Function number.
> > > +* Any other bits required for padding must be zero.
> > > +
> > > +MSIs may be distinguished in part through the use of sideband data
> > > +accompanying writes. In the case of PCI devices, this sideband data
> > > +may be derived from the Requester ID. A mechanism is required to
> > > +associate a device with both the MSI controllers it can address,
> > > +and the sideband data that will be associated with its writes to those
> controllers.
> > > +
> > > +For generic MSI bindings, see
> > > +Documentation/devicetree/bindings/interrupt-controller/msi.txt.
> > > +
> > > +
> > > +PCI root complex
> > > +================
> > > +
> > > +Optional properties
> > > +-------------------
> > > +
> > > +- msi-map: Maps a Requester ID to an MSI controller and associated
> > > +  msi-specifier data. The property is an arbitrary number of tuples
> > > +of
> > > +  (rid-base,msi-controller,msi-base,length), where:
> > [varun] How would we account for hot plug PCI devices and SR-IOV use
> cases, with the rid base and length?
> 
> For hotplug, you simply need the mapping from RID to msi-specifier to be
> defined in advance in the DT, for the set of RIDs that could possibly occur.
> 
> For SR-IOV, are you asking about ARI? I should update the description of the
> RID to describe that for ARI it has the format:
> 
> * Bits [15:8] are the Bus number
> * Bits [7:0] are the Identifier
> 
> Other than that, the handling would be identical to the non-ARI case.
> 
> What else am I missing?
> 
> > How do we take in to account for a PCIe bridge, while setting up the
> requestor ID base and length?
> 
> I'm not sure I follow the question. I don't see why this is any different to any
> other requester ID.
> 
> What do you see as being the problem for this case?


[varun]  Would the boot loader be responsible for the  PCI bus probe and setting up of the requestor id information in the device tree. Also, during bus probe the boot loader would understand the topology, and handle cases like non transparent host bridge and non standard devices (e.g. require special handling based on quirks). 

Also, the msi identifier would typically be the stream ID provided by the device.  So, this would be limited by the number of SMRs, right? Considering that the each device can have its specific IOMMU domain, which would also require mapping for MSI access, we may also be restricted by the number of context banks. So, we may be able to support a restricted number of msi identifiers.

We already have the PCI bus probe in Linux. If my assumption about the boot loader doing the probe is correct, why do we want to duplicate the work. Also, can we just provide a list of possible MSI identifiers to Linux for each PCIe controller. The IOMMU driver in the Linux kernel can interface with PCIe controller for setting up "requestor id"->"msi identifier" translation.
