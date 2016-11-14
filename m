From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 14 Nov 2016 16:42:28 +0000
Subject: [PATCH v7 04/16] drivers: iommu: make of_iommu_set/get_ops() DT
 agnostic
In-Reply-To: <20161114155222.GZ2078@8bytes.org>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
 <20161109141948.19244-5-lorenzo.pieralisi@arm.com>
 <20161111152248.GS2078@8bytes.org>
 <552e674a-f434-f08f-8e16-a94544ce8e6e@arm.com>
 <20161111162736.GV2078@8bytes.org>
 <33769e3c-265f-6e89-adf9-6d35b1e03579@arm.com>
 <20161114102654.GA1677@red-moon>
 <41e3eff1-9ce6-bcfb-5716-c65ef38add63@arm.com>
 <20161114155222.GZ2078@8bytes.org>
Message-ID: <20161114164228.GA31339@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 14, 2016 at 04:52:23PM +0100, Joerg Roedel wrote:
> On Mon, Nov 14, 2016 at 12:00:47PM +0000, Robin Murphy wrote:
> > If we've already made the decision to move away from bus ops, I don't
> > see that it makes sense to deliberately introduce new dependencies on
> > them. Besides, as it stands, this patch literally implements "tell the
> > iommu-core which hardware-iommus exist in the system and a seperate
> > iommu_ops ptr for each of them" straight off.
> 
> Not sure which code you are looking at, but as I see it we have only
> per-device iommu-ops now (with this patch). That is different from
> having core-visible hardware-iommu instances where devices could link
> to.

This patch enables the IOMMU-OF-node<->device look-up on non-OF (ie
ACPI) systems by "converting" the of_node to a generic fwnode_handle,
that's all it does (and move the related look-up code from
drivers/iommu/of_iommu.c to drivers/iommu/iommu.c so that it does
not depend on OF_IOMMU any longer).

> Also the rest of iommu-core code still makes use of the per-bus ops. The
> per-device ops are only used for the of_xlate fn-ptr.

I can put this patch on the backburner and retrieve the iommu_ops
through the dev->bus path in the IORT xlate function (iort_iommu_xlate()
introduced in the last patch), the change is trivial and should work
just fine but it deserves a v8 to give everyone a chance to test it.

We would end-up handling the device->iommu_ops look-up differently in DT
and ACPI for streamid translations though, I am not sure I see a reason
why.

Thanks,
Lorenzo
