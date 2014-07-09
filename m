From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 9 Jul 2014 16:21:27 +0200
Subject: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140709134050.GN9485@arm.com>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
 <20140709134050.GN9485@arm.com>
Message-ID: <20140709142125.GB3262@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 02:40:50PM +0100, Will Deacon wrote:
> On Fri, Jul 04, 2014 at 04:29:17PM +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > This commit introduces a generic device tree binding for IOMMU devices.
> > Only a very minimal subset is described here, but it is enough to cover
> > the requirements of both the Exynos System MMU and Tegra SMMU as
> > discussed here:
> > 
> >     https://lkml.org/lkml/2014/4/27/346
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> 
>   Acked-by: Will Deacon <will.deacon@arm.com>
> 
> I would like to move the ARM SMMU driver over to this for 3.18, if possible.
> One use-case there is the ability to describe groups of masters behind a
> multi-master IOMMU but which must be part of the same domain (i.e. an
> iommu_group). This is useful for presenting devices to a guest with a
> virtual SMMU, where the physical devices share a stage-2 context.
> 
> With your binding, does this simply mean determining the set of master IDs
> in the group, then describing the complete set for each master?

I'm not sure I properly understand what you're trying to do, but I don't
think the binding is designed to cover that. Rather the goal was to
describe the IDs belonging to each master, so that an IOMMU can be
properly configured.

Anything beyond that (e.g. logical grouping of masters) isn't directly
within the scope of the binding (it doesn't describe hardware but some
policy pertaining to some specific use-case).

That said, the IOMMU driver that I prototyped for Tegra did some similar
grouping of devices, although in a much more restricted way. The goal of
that was to add a known set of devices into one group, "peripherals", so
that they could share one IOMMU domain. This was meant to separate them
from devices with more advanced needs (such as a GPU driver). Devices in
the "peripherals" group would be using the DMA mapping API integration
whereas other devices would have to explicitly allocate an IOMMU domain.

I'm not sure how much that helps for the use-case that you have in mind.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140709/9d120816/attachment.sig>
