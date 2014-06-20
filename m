From: Varun.Sethi@freescale.com (Varun Sethi)
Date: Fri, 20 Jun 2014 18:57:03 +0000
Subject: [PATCH RFC v1 1/2] documentation/iommu: Add description of
 Hisilicon System MMU binding
In-Reply-To: <20140620174952.GD30656@arm.com>
References: <1401975430-2648-1-git-send-email-thunder.leizhen@huawei.com>
 <5537408.I9tiuCA96J@wuerfel> <20140616164517.GY16758@arm.com>
 <8028011.DbLMpGku5b@wuerfel> <20140616182645.GD16758@arm.com>
 <836ade98fe6141f58476bf981ac5a6bf@BL2PR03MB468.namprd03.prod.outlook.com>
 <20140618123104.GI32699@arm.com>
 <d3c51c2360874a8b9deefaaa8beaf0d9@BL2PR03MB468.namprd03.prod.outlook.com>
 <20140620174952.GD30656@arm.com>
Message-ID: <a718d22a3ef3414fb6992bc54a0a893f@BL2PR03MB468.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Will Deacon [mailto:will.deacon at arm.com]
> Sent: Friday, June 20, 2014 11:20 PM
> To: Sethi Varun-B16395
> Cc: Arnd Bergmann; Kefeng Wang; Catalin Marinas; Tianhong Ding;
> huxinwei at huawei.com; Zefan Li; Zhen Lei; Dave P Martin; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH RFC v1 1/2] documentation/iommu: Add description of
> Hisilicon System MMU binding
> 
> On Fri, Jun 20, 2014 at 10:54:59AM +0100, Varun Sethi wrote:
> > Hi Will,
> 
> Hello,
> 
> > > Note that I *have* been playing with PCI on the ARM SMMU (see the
> > > patch
> > > below) but I currently just assume RequesterID == StreamID, which is
> > > true for the platform I'm using.
> 
> [...]
> 
> > > @@ -1596,15 +1634,35 @@ static int arm_smmu_add_device(struct device
> > > *dev)
> > >               return PTR_ERR(group);
> > >       }
> > >
> > > +     if (dev_is_pci(dev)) {
> > > +             struct arm_smmu_master_cfg *cfg;
> > > +             struct pci_dev *pdev = to_pci_dev(dev);
> > > +
> > > +             cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
> > > +             if (!cfg) {
> > > +                     ret = -ENOMEM;
> > > +                     goto out_put_group;
> > > +             }
> > > +
> > > +             cfg->num_streamids = 1;
> > > +             cfg->streamids[0] = PCI_DEVID(pdev->bus->number, pdev-
> > > >devfn);
> > [Sethi Varun-B16395] We should be considering the bus topology i.e.
> > what if the device is setting behind a bridge? It's possible the
> > requestor id for the DMA transaction belongs to the bridge. Also, the
> > iommu group creation should also take in to account the topology.
> 
> Yeah, as I mentioned above, this assumes that RequesterID == StreamID.
> Are you simply alluding to a non-transparent PCI bridge, or do you have
> something different? For non-transparent bridges, I guess we can re-use
> the code already in the kernel (VFIO handles this with its groups IIUC)?
Yes, we can use the API from patch posted by Alex Williamson.
https://lkml.org/lkml/2014/5/10/129

-Varun
