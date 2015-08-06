From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 6 Aug 2015 18:38:39 +0100
Subject: [PATCH 2/3] Docs: dt: Add PCI MSI map bindings
In-Reply-To: <BN1PR0301MB06277FDA6EB34E77B557CA75EA750@BN1PR0301MB0627.namprd03.prod.outlook.com>
References: <1437670365-20704-1-git-send-email-mark.rutland@arm.com>
 <1437670365-20704-3-git-send-email-mark.rutland@arm.com>
 <BN1PR0301MB06277FDA6EB34E77B557CA75EA750@BN1PR0301MB0627.namprd03.prod.outlook.com>
Message-ID: <20150806173839.GC6437@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 05, 2015 at 05:39:33PM +0100, Varun Sethi wrote:
> Hi Mark
> Thanks for the patch. Please find my comment inline.
> 
> Regards
> Varun
> 
> > -----Original Message-----
> > From: iommu-bounces at lists.linux-foundation.org [mailto:iommu-
> > bounces at lists.linux-foundation.org] On Behalf Of Mark Rutland
> > Sent: Thursday, July 23, 2015 10:23 PM
> > To: devicetree at vger.kernel.org
> > Cc: Mark Rutland; lorenzo.pieralisi at arm.com; arnd at arndb.de;
> > marc.zyngier at arm.com; will.deacon at arm.com; linux-
> > kernel at vger.kernel.org; ddaney at caviumnetworks.com; iommu at lists.linux-
> > foundation.org; tirumalesh.chalamarla at caviumnetworks.com;
> > laurent.pinchart at ideasonboard.com; thunder.leizhen at huawei.com;
> > treding at nvidia.com; linux-arm-kernel at lists.infradead.org;
> > majun258 at huawei.com
> > Subject: [PATCH 2/3] Docs: dt: Add PCI MSI map bindings
> >
> > Currently msi-parent is used by a few bindings to describe the relationship
> > between a PCI root complex and a single MSI controller, but this property
> > does not have a generic binding document.
> >
> > Additionally, msi-parent is insufficient to describe more complex
> > relationships between MSI controllers and devices under a root complex,
> > where devices may be able to target multiple MSI controllers, or where MSI
> > controllers use (non-probeable) sideband information to distinguish devices.
> >
> > This patch adds a generic binding for mapping PCI devices to MSI controllers.
> > This document covers msi-parent, and a new msi-map property (specific to
> > PCI*) which may be used to map devices (identified by their Requester ID) to
> > sideband data for each MSI controller that they may target.
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > ---
> >  Documentation/devicetree/bindings/pci/pci-msi.txt | 220
> > ++++++++++++++++++++++
> >  1 file changed, 220 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/pci-msi.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pci/pci-msi.txt
> > b/Documentation/devicetree/bindings/pci/pci-msi.txt
> > new file mode 100644
> > index 0000000..9b3cc81
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/pci-msi.txt
> > @@ -0,0 +1,220 @@
> > +This document describes the generic device tree binding for describing
> > +the relationship between PCI devices and MSI controllers.
> > +
> > +Each PCI device under a root complex is uniquely identified by its
> > +Requester ID (AKA RID). A Requester ID is a triplet of a Bus number,
> > +Device number, and Function number.
> > +
> > +For the purpose of this document, when treated as a numeric value, a
> > +RID is formatted such that:
> > +
> > +* Bits [15:8] are the Bus number.
> > +* Bits [7:3] are the Device number.
> > +* Bits [2:0] are the Function number.
> > +* Any other bits required for padding must be zero.
> > +
> > +MSIs may be distinguished in part through the use of sideband data
> > +accompanying writes. In the case of PCI devices, this sideband data may
> > +be derived from the Requester ID. A mechanism is required to associate
> > +a device with both the MSI controllers it can address, and the sideband
> > +data that will be associated with its writes to those controllers.
> > +
> > +For generic MSI bindings, see
> > +Documentation/devicetree/bindings/interrupt-controller/msi.txt.
> > +
> > +
> > +PCI root complex
> > +================
> > +
> > +Optional properties
> > +-------------------
> > +
> > +- msi-map: Maps a Requester ID to an MSI controller and associated
> > +  msi-specifier data. The property is an arbitrary number of tuples of
> > +  (rid-base,msi-controller,msi-base,length), where:
> [varun] How would we account for hot plug PCI devices and SR-IOV use cases, with the rid base and length?

For hotplug, you simply need the mapping from RID to msi-specifier to be
defined in advance in the DT, for the set of RIDs that could possibly
occur.

For SR-IOV, are you asking about ARI? I should update the description of
the RID to describe that for ARI it has the format:

* Bits [15:8] are the Bus number
* Bits [7:0] are the Identifier

Other than that, the handling would be identical to the non-ARI case.

What else am I missing?

> How do we take in to account for a PCIe bridge, while setting up the requestor ID base and length?

I'm not sure I follow the question. I don't see why this is any
different to any other requester ID.

What do you see as being the problem for this case?

> > +
> > +  * rid-base is a single cell describing the first RID matched by the entry.
> > +
> > +  * msi-controller is a single phandle to an MSI controller
> > +
> > +  * msi-base is an msi-specifier describing the msi-specifier produced for the
> > +    first RID matched by the entry.
> > +
> > +  * length is a single cell describing how many consecutive RIDs are matched
> > +    following the rid-base.
> > +
> > +  Any RID r in the interval [rid-base, rid-base + length) is associated
> > + with  the listed msi-controller, with the msi-specifier (r - rid-base + msi-
> > base).
> > +
> > +- msi-map-mask: A mask to be applied to each Requester ID prior to
> > +being mapped
> > +  to an msi-specifier per the msi-map property.
> > +
> [varun] Can you please elaborate on a use case, where this would help.

It may be the case that at the MSI controller's ID space is smaller
than the RID space, and so only a subset of RID bits matter. For
example, it might be the case that only the Bus ID matters.

Using the msi-map-mask allows for a much smaller msi-map for this case,
e.g.

	msi-map-mask = <0xff00>;
	msi-map = <0x0000 &msi 0x00 1>,
		  <0x0100 &msi 0x01 1>,
		  <0x0200 &msi 0x01 1>,
		  <0x0300 &msi 0x01 1>,
		  ...
		  <0xff00 &msi 0xff 1>;

Rather than:

	msi-map = <0x0000 &msi 0x00 1>,
		  <0x0001 &msi 0x00 1>,
		  <0x0002 &msi 0x00 1>,
		  <0x0003 &msi 0x00 1>,
		  ...
		  <0x00ff &msi 0x00 1>,

		  <0x0100 &msi 0x00 1>,
		  <0x0101 &msi 0x00 1>,
		  <0x0102 &msi 0x00 1>,
		  <0x0103 &msi 0x00 1>,
		  ...
		  <0x01ff &msi 0x00 1>,
		  ...
		  <0xff00 &msi 0xff 1>,
		  <0xff01 &msi 0xff 1>,
		  <0xff02 &msi 0xff 1>,
		  <0xff03 &msi 0xff 1>,
		  ....
		  <0xffff &msi 0xff 1>;

Or for the case that everything maps to a single ID:

		msi-map-mask = <0x0000>;
		msi-map = <0x0000 &msi 0x0000 1>;

Thanks,
Mark.
