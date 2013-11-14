From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 14 Nov 2013 07:41:45 +0100
Subject: [PATCHv4 5/7] iommu/tegra: smmu: Support "mmu-masters" binding
In-Reply-To: <5283BDBF.9020509@wwwdotorg.org>
References: <5282C512.5090900@wwwdotorg.org><20131113094517.4608edf4302b61e3c4402a25@nvidia.com><5283BDBF.9020509@wwwdotorg.org>
Message-ID: <20131114.084145.998129499909471378.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> wrote @ Wed, 13 Nov 2013 18:58:23 +0100:

> >  smmu: iommu at xxxxxx {
> >        #iommu-cells = <3>;
> >        ^^^^^^^^^^^^^^^^^^
> >    };
> > 
> >    host1x {
> >            compatible = "nvidia,tegra30-host1x", "simple-bus";
> >            iommu = <&smmu 0x??????? 0x??????? "asid">;
> > 	   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^#######
> >            gr3d {
> >                    compatible = "nvidia,tegra30-gr3d";
> >                    iommu = <&smmu 0x??????? 0x???????>;
> >            }
> > 
> > I think that this "asid" part can be set 0 in tegra??.dtsi and the
> > actual value can be overwritten in tegra??-<boardname>.dts file.
> 
> The one issue here is that we can only override entire properties, so
> it's not possible for a board file to *just* replace the ASID, it'd have
> to duplicate the entire property, just to change the one value.
> 
> Is the ASID mapping really likely to be board-specific though? To my
> naive thinking, it seems that the chip design (e.g. number of
> peripherals, number of available ASIDs) would tend to imply the
> device->ASID mapping, since it would have been considered as part of
> chip design. Hence, wouldn't soc.dtsi typically specify the expected
> ASID mapping, and boards rarely if ever override it?
> 
> If the ASID mapping really is likely to vary per board, perhaps it makes
> sense to put it into a separate property somehow so it's easier to override?

  Older Tegra like T30: swgroups > asid(==4)
  Newer Tegra         : swgroups < asid

At newer Tegra, each swgroup should have one asid. In older Tegra,
there aren't many options how to assign ASID since # of AS is 4, and
we know which one should be isolated/protected first. Even we can fix
this assignment for a SoC, not for a board.

Also I think that a newer tegra won't care this mapping since all will
have an own AS. So maybe the binding between "swgroup" and "asid"
should be another one, since this info is only needed for the older
Tegra. For example:

  smmu: iommu@xxxxxx {
        #iommu-cells = <2>;

	/*
	 * This as <-> swgroups mapping is only needed for older tegra.
	 */
	as-swgroups = <0x??????? 0x???????,  /* AS[0]: assigned swgroups bits */
		       0x??????? 0x???????,  /* AS[1]: assigned swgroups bits */
		       0x??????? 0x???????,  /* AS[2]: assigned swgroups bits */
		       0x??????? 0x???????>; /* AS[3]: assigned swgroups bits */
    };
 
    host1x {
            compatible = "nvidia,tegra30-host1x", "simple-bus";
            iommus = <&smmu 0x??????? 0x???????>;
            gr3d {
                    compatible = "nvidia,tegra30-gr3d";
                    iommus = <&smmu 0x??????? 0x???????>;
            }
   };

Then we would push this mapping info into DT only for older
Tegra. Newer Tegra won't care where each swgroup will get its own.
