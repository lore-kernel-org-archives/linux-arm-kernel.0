From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Aug 2014 05:18:17 +0200
Subject: [PATCH 4/6] iommu/arm-smmu: implement generic DT bindings
In-Reply-To: <20140819125449.GN23128@arm.com>
References: <1407891099-24641-1-git-send-email-mitchelh@codeaurora.org>
 <1407891099-24641-5-git-send-email-mitchelh@codeaurora.org>
 <20140819125449.GN23128@arm.com>
Message-ID: <201408200518.18036.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 August 2014, Will Deacon wrote:
> > +static int arm_smmu_parse_iommus_properties(struct arm_smmu_device *smmu,
> > +                                     int *num_masters)
> > +{
> > +     struct of_phandle_args iommuspec;
> > +     struct device_node *dn;
> > +
> > +     for_each_node_with_property(dn, "iommus") {
> > +             int arg_ind = 0;
> > +             struct iommus_entry *entry, *n;
> > +             LIST_HEAD(iommus);
> > +
> > +             while (!of_parse_phandle_with_args(dn, "iommus", "#iommu-cells",
> > +                                                     arg_ind, &iommuspec)) {
> 
> We need to check that the phandle does indeed point at one of our SMMUs
> here, in case we have a system with multiple IOMMU types, all using the
> generic binding.

Why does the iommu driver do this at all? The of_parse_phandle_with_args()
call should really be part of the iommu common code when we probe the devices in
of_dma_configure() as far as I can tell.

The way I would have expected it to happen is to have some code that
ensures the iommu drivers are instantiated before we do call of_platform_populate,
and then of_dma_configure() looks for whether there is an iommu property or not
and calls into the respective iommu driver for doing the setup if there is.

	Arnd
