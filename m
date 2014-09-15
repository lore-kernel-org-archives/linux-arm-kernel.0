From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Sep 2014 18:57:05 +0200
Subject: [RFC][PATCH] devicetree: Add master-id-bits property to the iommu
 device
In-Reply-To: <bfdff6494d7f46ab9a9f00f94159e9e1@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1410718646-9710-1-git-send-email-Varun.Sethi@freescale.com>
 <201409150438.29649.arnd@arndb.de>
 <bfdff6494d7f46ab9a9f00f94159e9e1@BL2PR03MB468.namprd03.prod.outlook.com>
Message-ID: <201409151857.05463.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 September 2014, Varun Sethi wrote:
> > 
> > This seems rather specific to MMU-500. I don't think that most IOMMUs would
> > use the term 'master ID', 'stream ID' or even the general concept, and you
> > don't expand the acronym 'TBU'. I've seen many IOMMUs and I don't even
> > know what that means.
> 
> TBU refers to the translation buffer unit, which is responsible for caching page translations. In case of translation miss in the cache, translation request is forwarded to the TCU (Translation control unit). The master id forwarded to TCU would also contain the TBU ID.  Using the master-id-bits property we can mask out the additional TBU bits at the TCU. This is a cause of concern when we want to share master id for devices which are connected to different TBUs. We have a hot pluggable bus architecture, where a device group can have multiple devices connected to different TBUs. So, we need a mechanism to mask out additional TBIU bits.

Ok, I think I understand now

> > Why do you think this is something that is needed to be known at the global
> > level, rather than a property for some individual drivers?
> > 
> In case of Freescale Layerscape SOCs, number of bits used for defining a stream id are specific to a given platform. 
> 
> Are you suggesting that this property should be added to the master device node, rather than the iommu node?

Most importantly, I think this needs to be part of the (iommu) device specific binding, not the
generic binding that is used for all iommus that may or may not have this concept.

I believe in case of the ARM SMMU, it should actually go into the master node as part of
the 'iommus' property, because the mask can be different for each master. If your IOMMU
has a fixed mask that is used for all devices, that's fine and you can put it into
the iommu node itself but document it in the binding for your IOMMU.

For hot-pluggable buses, you probably need to have the 'iommus' property in the node
that corresponds to the bus controller, and that will have a mask that is used for
all devices plugged into it.

	Arnd
