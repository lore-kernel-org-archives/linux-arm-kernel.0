From: stuart.yoder@freescale.com (Stuart Yoder)
Date: Tue, 17 Jun 2014 14:50:25 +0000
Subject: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <32165315f0b84be9948f489fd87bf6a9@BL2PR03MB468.namprd03.prod.outlook.com>
References: <5288123.eXagyPAxNq@wuerfel>
 <20140602104104.GD3855@e103592.cambridge.arm.com>
 <20140604143509.GF28484@ulmo> <20140604164132.GF6644@arm.com>
 <07321368d15d4ad9928ebb83af87e401@DM2PR03MB479.namprd03.prod.outlook.com>
 <20140616152739.GS16758@arm.com>
 <8b0492b4697943a0b1f276ef42cc8223@DM2PR03MB352.namprd03.prod.outlook.com>
 <20140616170416.GA16758@arm.com>
 <419e67f783524d208ab3be16bcd94bd9@DM2PR03MB352.namprd03.prod.outlook.com>
 <0587e1f4894546398be0798d2bc2c84f@BL2PR03MB468.namprd03.prod.outlook.com>
 <20140617104304.GD13808@arm.com>
 <32165315f0b84be9948f489fd87bf6a9@BL2PR03MB468.namprd03.prod.outlook.com>
Message-ID: <7c03c5cffa174b20962bff3b09de0eb8@DM2PR03MB352.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Sethi Varun-B16395
> Sent: Tuesday, June 17, 2014 6:22 AM
> To: Will Deacon
> Cc: Mark Rutland; devicetree at vger.kernel.org; linux-samsung-
> soc at vger.kernel.org; Arnd Bergmann; Pawel Moll; Ian Campbell; Grant
> Grundler; Stephen Warren; Yoder Stuart-B08248; Rob Herring; linux-
> kernel at vger.kernel.org; Marc Zyngier; Linux IOMMU; Thierry Reding; Kumar
> Gala; linux-tegra at vger.kernel.org; Cho KyongHo; Dave P Martin; linux-arm-
> kernel at lists.infradead.org
> Subject: RE: [PATCH v2] devicetree: Add generic IOMMU device tree
> bindings
> 
> 
> 
> > -----Original Message-----
> > From: iommu-bounces at lists.linux-foundation.org [mailto:iommu-
> > bounces at lists.linux-foundation.org] On Behalf Of Will Deacon
> > Sent: Tuesday, June 17, 2014 4:13 PM
> > To: Sethi Varun-B16395
> > Cc: Mark Rutland; devicetree at vger.kernel.org; linux-samsung-
> > soc at vger.kernel.org; Arnd Bergmann; Pawel Moll; Ian Campbell; Grant
> > Grundler; Stephen Warren; Yoder Stuart-B08248; Rob Herring; linux-
> > kernel at vger.kernel.org; Marc Zyngier; Linux IOMMU; Thierry Reding;
> Kumar
> > Gala; linux-tegra at vger.kernel.org; Cho KyongHo; Dave P Martin; linux-
> arm-
> > kernel at lists.infradead.org
> > Subject: Re: [PATCH v2] devicetree: Add generic IOMMU device tree
> > bindings
> >
> > On Tue, Jun 17, 2014 at 11:26:48AM +0100, Varun Sethi wrote:
> > > > The way we generally thought it would work was something like
> > > > this:
> > > >    -u-boot/bootloader makes any static streamID allocation if
> needed,
> > > >     sets a default streamID  (e.g. 0x0) in device and expresses
> > > >     that in the device tree
> > > >    -device tree would express relationship between devices
> > > >     (including bus controllers) and the SMMU through mmu-masters
> > > >     property
> > > >    -u-boot would express the range of unused (or used) streamIDs
> via
> > > > a new
> > > >     device tree property so the kernel SMMU driver knows what
> > > > streamIDs are
> > > >     free
> > > >    -in the SMMU driver a different vendor specific 'add_device'
> > callback
> > > >     could be used to handle our special cases where we need to
> > set/change
> > > >     the stream ID for devices added to a domain
> > >
> > > Another possibility, could be to program the stream Id in the device
> > > registers (reference for the stream ID register can be obtained from
> > > the device tree) during device attach. This could be relevant in case
> > > of VFIO, when we are assigning multiple devices to a single VM. All
> > > the devices can share the same stream ID.
> >
> > I think for simple masters (i.e. those that have all their StreamIDs
> > under control of one driver), then setting something during attach (or
> > add?) based on the DT could work pretty well. The other case is when we
> > have masters behind a bridge (such as a PCI RC). In this case, it might
> > actually be better to ask the bridge for the IDs and let it sort out
> the
> > allocation itself. That would also move the RequesterID -> StreamID
> > mapping out of the SMMU code.
> >
> > What do you think?
> The PCI bus iommu group creation code would be part of the SMMU driver
> (it is handled by other IOMMU drivers as well). My understanding is that
> there would be one is to one correspondence between the requestor ID and
> the iommu group. May be, we can have an API provided by the PCI bridge
> (architecture specific) for setting the stream ID.

I think Will is suggesting something along those lines-- I think it's a
question of where the streamID allocation happens.  You could
either do something like the following in the SMMU driver when attaching
a PCI device:

    id = alloc_stream_id(...);
    pci_set_streamid(pci-dev, id);

    or

    id = pci_get_streamid(pci-dev);

...i.e the PCI RC could allocate (from some TBD
allocator) and set the stream ID itself.

Not sure how big a deal it is to extend PCI RC interfaces for 
something like that.

Stuart
