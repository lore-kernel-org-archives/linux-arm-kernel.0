From: will.deacon@arm.com (Will Deacon)
Date: Wed, 9 Jul 2014 14:26:53 +0100
Subject: [PATCH 2/5] iommu/arm-smmu: add support for PCI master devices
In-Reply-To: <a9de518782874b5c8ddd366e6617b8de@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1404125530-17984-1-git-send-email-will.deacon@arm.com>
 <1404125530-17984-3-git-send-email-will.deacon@arm.com>
 <a9de518782874b5c8ddd366e6617b8de@BL2PR03MB468.namprd03.prod.outlook.com>
Message-ID: <20140709132653.GM9485@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Adding Alex; question below]

On Thu, Jul 03, 2014 at 03:22:37PM +0100, Varun Sethi wrote:
> > +static int __arm_smmu_get_pci_sid(struct pci_dev *pdev, u16 alias, void
> > +*data) {
> > +     *((u16 *)data) = alias;
> > +     return 0; /* Continue walking */
> > +}

[...]

> > @@ -1598,15 +1642,36 @@ static int arm_smmu_add_device(struct device
> > *dev)
> >               return PTR_ERR(group);
> >       }
> >
> > +     if (dev_is_pci(dev)) {
> > +             struct arm_smmu_master_cfg *cfg;
> > +             struct pci_dev *pdev = to_pci_dev(dev);
> > +
> > +             cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
> > +             if (!cfg) {
> > +                     ret = -ENOMEM;
> > +                     goto out_put_group;
> > +             }
> > +
> > +             cfg->num_streamids = 1;
> > +             pci_for_each_dma_alias(pdev, __arm_smmu_get_pci_sid,
> > +                                    &cfg->streamids[0]);
> [Sethi Varun-B16395] We need to look for upstream DMA device. We should be
> using pci_find_dma_isolation_root here. Also, this would also imply that
> there could be multiple devices sharing the same stream ID. So, we should
> check if a particular stream ID value has already been configured in the
> SMR registers.

pci_find_dma_isolation_root doesn't exist in any of the trees I have. Alex,
is this queued anywhere and do I actually need it?

The purpose of this code is to find the requester ID of a device as it
appears at the host controller. At this point, we can map it (via firmware
tables that are TBD) to a Stream ID for the SMMU. It looks to me like
pci_for_each_dma_alias walks over non-transparent PCI bridges correctly, so
the callback I provide just updates the alias until the walk has completed.

Will
