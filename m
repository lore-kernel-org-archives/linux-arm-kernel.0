From: Varun.Sethi@freescale.com (Varun Sethi)
Date: Mon, 15 Sep 2014 10:37:45 +0000
Subject: [RFC][PATCH] devicetree: Add master-id-bits property to the iommu
 device
In-Reply-To: <201409150438.29649.arnd@arndb.de>
References: <1410718646-9710-1-git-send-email-Varun.Sethi@freescale.com>
 <201409150438.29649.arnd@arndb.de>
Message-ID: <bfdff6494d7f46ab9a9f00f94159e9e1@BL2PR03MB468.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Monday, September 15, 2014 8:08 AM
> To: Sethi Varun-B16395
> Cc: devicetree at vger.kernel.org; iommu at lists.linux-foundation.org;
> thierry.reding at gmail.com; Mark.Rutland at arm.com; will.deacon at arm.com;
> hdoyu at nvidia.com; swarren at nvidia.com; robh+dt at kernel.org; linux-arm-
> kernel at lists.infradead.org; Yoder Stuart-B08248
> Subject: Re: [RFC][PATCH] devicetree: Add master-id-bits property to the
> iommu device
> 
> On Sunday 14 September 2014, Varun Sethi wrote:
> > "master-id-bits" property added to the IOMMU device node. This
> > property can be used by the IOMMU driver to match relevan bits in the
> > master id expressed by a DMA master.
> >
> > This can be used to mask out certain bits that get added to the device
> > master id due to IOMMU topology. For example, in case of MMU-500 the
> > TBUID gets appended to the master id. This prevents sharing of a
> > stream ID, amongst devices which are connected to different TBUs.
> >
> > Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> 
> This seems rather specific to MMU-500. I don't think that most IOMMUs would
> use the term 'master ID', 'stream ID' or even the general concept, and you
> don't expand the acronym 'TBU'. I've seen many IOMMUs and I don't even
> know what that means.

TBU refers to the translation buffer unit, which is responsible for caching page translations. In case of translation miss in the cache, translation request is forwarded to the TCU (Translation control unit). The master id forwarded to TCU would also contain the TBU ID.  Using the master-id-bits property we can mask out the additional TBU bits at the TCU. This is a cause of concern when we want to share master id for devices which are connected to different TBUs. We have a hot pluggable bus architecture, where a device group can have multiple devices connected to different TBUs. So, we need a mechanism to mask out additional TBIU bits.

> 
> Why do you think this is something that is needed to be known at the global
> level, rather than a property for some individual drivers?
> 
In case of Freescale Layerscape SOCs, number of bits used for defining a stream id are specific to a given platform. 

Are you suggesting that this property should be added to the master device node, rather than the iommu node?

-Varun
