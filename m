From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 13 Nov 2013 09:45:17 +0200
Subject: [PATCHv4 5/7] iommu/tegra: smmu: Support "mmu-masters" binding
In-Reply-To: <5282C512.5090900@wwwdotorg.org>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com>
 <1384158718-4756-6-git-send-email-hdoyu@nvidia.com>
 <5282C512.5090900@wwwdotorg.org>
Message-ID: <20131113094517.4608edf4302b61e3c4402a25@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Nov 2013 01:17:22 +0100
Stephen Warren <swarren@wwwdotorg.org> wrote:

> > +		mmu-masters = <&host1x TEGRA_SWGROUP_HC>,
> > +			      <&mpe TEGRA_SWGROUP_MPE>,
> > +			      <&vi TEGRA_SWGROUP_VI>,
> > +			      <&epp TEGRA_SWGROUP_EPP>,
> > +			      <&isp TEGRA_SWGROUP_ISP>,
> > +			      <&gr2d TEGRA_SWGROUP_G2>,
> > +			      <&gr3d TEGRA_SWGROUP_NV TEGRA_SWGROUP_NV2>,
> 
> So right now, the driver is statically assigning clients to a couple of
> specific ASIDs. What if we want to configure that mapping from DT; does
> that make sense? Instead of mmu-masters being a list of <phandle
> streamid*>, should it be <phandle ASID streamid*> or <phandle (streamid
> ASID)*>?

That's possible.

Here, swgroup ID == stream ID, and a device is statically bind to a
specific swgroup ID(hard coded). ASID is dynamically assigned to
swgroup(devices). So assigning ASID belongs to a policy, but we can
consider this assigning as board specifc policy since it's hard to
change after kernel boots up in general. So assigning ASID in a board
DT makes sense. The format would be:

  <phandle "swgroup ID" "asid">,

ex:
  <&host1x TEGRA_SWGROUP_HC 0>,

The above depends on the discussion of the standard IOMMU bindings,
but the number of argument can be set by each IOMMU driver.

If we take the the other way,

 smmu: iommu at xxxxxx {
       #iommu-cells = <3>;
       ^^^^^^^^^^^^^^^^^^
   };

   host1x {
           compatible = "nvidia,tegra30-host1x", "simple-bus";
           iommu = <&smmu 0x??????? 0x??????? "asid">;
	   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^#######
           gr3d {
                   compatible = "nvidia,tegra30-gr3d";
                   iommu = <&smmu 0x??????? 0x???????>;
           }

I think that this "asid" part can be set 0 in tegra??.dtsi and the
actual value can be overwritten in tegra??-<boardname>.dts file.
