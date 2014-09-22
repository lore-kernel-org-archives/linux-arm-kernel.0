From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 22 Sep 2014 11:23:23 +0200
Subject: [RFC][PATCH] devicetree: Add master-id-bits property to the
 iommu device
In-Reply-To: <febe4a288f2f438ca95988929ee71580@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1410718646-9710-1-git-send-email-Varun.Sethi@freescale.com>
 <201409150438.29649.arnd@arndb.de>
 <bfdff6494d7f46ab9a9f00f94159e9e1@BL2PR03MB468.namprd03.prod.outlook.com>
 <201409151857.05463.arnd@arndb.de>
 <febe4a288f2f438ca95988929ee71580@BL2PR03MB468.namprd03.prod.outlook.com>
Message-ID: <20140922092322.GI1470@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 16, 2014 at 06:04:48PM +0000, Varun Sethi wrote:
> Hi Arnd,
> 
> > -----Original Message-----
> > From: iommu-bounces at lists.linux-foundation.org [mailto:iommu-
> > bounces at lists.linux-foundation.org] On Behalf Of Arnd Bergmann
> > Sent: Monday, September 15, 2014 10:27 PM
> > To: Sethi Varun-B16395
> > Cc: Mark.Rutland at arm.com; devicetree at vger.kernel.org;
> > swarren at nvidia.com; will.deacon at arm.com; Yoder Stuart-B08248;
> > robh+dt at kernel.org; iommu at lists.linux-foundation.org;
> > thierry.reding at gmail.com; linux-arm-kernel at lists.infradead.org
> > Subject: Re: [RFC][PATCH] devicetree: Add master-id-bits property to the
> > iommu device
> > 
> > On Monday 15 September 2014, Varun Sethi wrote:
> > > >
> > > > This seems rather specific to MMU-500. I don't think that most
> > > > IOMMUs would use the term 'master ID', 'stream ID' or even the
> > > > general concept, and you don't expand the acronym 'TBU'. I've seen
> > > > many IOMMUs and I don't even know what that means.
> > >
> > > TBU refers to the translation buffer unit, which is responsible for caching
> > page translations. In case of translation miss in the cache, translation request is
> > forwarded to the TCU (Translation control unit). The master id forwarded to
> > TCU would also contain the TBU ID.  Using the master-id-bits property we can
> > mask out the additional TBU bits at the TCU. This is a cause of concern when we
> > want to share master id for devices which are connected to different TBUs. We
> > have a hot pluggable bus architecture, where a device group can have multiple
> > devices connected to different TBUs. So, we need a mechanism to mask out
> > additional TBIU bits.
> > 
> > Ok, I think I understand now
> > 
> > > > Why do you think this is something that is needed to be known at the
> > > > global level, rather than a property for some individual drivers?
> > > >
> > > In case of Freescale Layerscape SOCs, number of bits used for defining a
> > stream id are specific to a given platform.
> > >
> > > Are you suggesting that this property should be added to the master device
> > node, rather than the iommu node?
> > 
> > Most importantly, I think this needs to be part of the (iommu) device specific
> > binding, not the generic binding that is used for all iommus that may or may not
> > have this concept.
> > 
> > I believe in case of the ARM SMMU, it should actually go into the master node
> > as part of the 'iommus' property, because the mask can be different for each
> > master. If your IOMMU has a fixed mask that is used for all devices, that's fine
> > and you can put it into the iommu node itself but document it in the binding for
> > your IOMMU.
> > 
> > For hot-pluggable buses, you probably need to have the 'iommus' property in
> > the node that corresponds to the bus controller, and that will have a mask that
> > is used for all devices plugged into it.
> Can I add a note to the generic binding about representing the "mask"
> as a part of the "iommus" property. This would similar to the note
> about the "dma-ranges"

I think the concept of a mask is fairly device-specific. Adding a note
to it in the generic binding could be confusing to people working with
IOMMUs that don't know the concept.

dma-ranges on the other hand is a generic property, so referring to it
in the generic binding makes sense.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140922/edd47503/attachment-0001.sig>
