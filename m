From: will.deacon@arm.com (Will Deacon)
Date: Mon, 6 Oct 2014 13:42:28 +0100
Subject: [PATCH 2/5] iommu/arm-smmu: add support for PCI master devices
In-Reply-To: <1404915184.4256.160.camel@ul30vt.home>
References: <1404125530-17984-1-git-send-email-will.deacon@arm.com>
 <1404125530-17984-3-git-send-email-will.deacon@arm.com>
 <a9de518782874b5c8ddd366e6617b8de@BL2PR03MB468.namprd03.prod.outlook.com>
 <20140709132653.GM9485@arm.com>
 <1404915184.4256.160.camel@ul30vt.home>
Message-ID: <20141006124228.GH12935@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

On Wed, Jul 09, 2014 at 03:13:04PM +0100, Alex Williamson wrote:
> On Wed, 2014-07-09 at 14:26 +0100, Will Deacon wrote:
> > pci_find_dma_isolation_root doesn't exist in any of the trees I have. Alex,
> > is this queued anywhere and do I actually need it?
> 
> That function was in the v3 DMA alias series, in v4 it got replaced.
> iommu_group_get_for_pci_dev() is the common function for finding or
> creating a group for a device and pci_for_each_dma_alias() is the
> interface to walk each alias in a PCI topology.  The pci_ interface is
> in 3.16-rc and the iommu_ pieces are current in next via the iommu tree.
> 
> > The purpose of this code is to find the requester ID of a device as it
> > appears at the host controller. At this point, we can map it (via firmware
> > tables that are TBD) to a Stream ID for the SMMU. It looks to me like
> > pci_for_each_dma_alias walks over non-transparent PCI bridges correctly, so
> > the callback I provide just updates the alias until the walk has completed.
> 
> Yep, that's the intended usage.  There are cases in VT-d where it wants
> to add context entries for every alias and cases elsewhere that we just
> want the final alias.  pci_for_each_dma_alias() is meant to fit both use
> cases.  Thanks,

I'm looking at moving the arm-smmu driver over to using
iommu_group_get_for_dev, but I've hit a slight snag. Once I have the group,
I actually need to get hold of the alias for that group, since that will be
converted into a StreamID used to program the SMMU. I can do this by
open-coding my own version of iommu_group_get_for_pci_dev, but that's pretty
horrible.

What's the best way to get hold of the alias for a given group?

Cheers,

Will
