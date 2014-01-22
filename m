From: will.deacon@arm.com (Will Deacon)
Date: Wed, 22 Jan 2014 15:33:52 +0000
Subject: [PATCH v3 02/11] iommu/arm-smmu: Introduce iommu_group notifier
 block
In-Reply-To: <aeebc7cf4084486790a5166cf83cb332@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
 <1389876263-25759-3-git-send-email-andreas.herrmann@calxeda.com>
 <20140120222814.GI3471@alberich>
 <e92c5fd617fb4068b4ec5de696527ee3@BL2PR03MB468.namprd03.prod.outlook.com>
 <20140122122550.GA14108@mudshark.cambridge.arm.com>
 <a73ef0128a0141eabf0a3b899f3afdae@DM2PR03MB479.namprd03.prod.outlook.com>
 <20140122134028.GB14108@mudshark.cambridge.arm.com>
 <aeebc7cf4084486790a5166cf83cb332@BL2PR03MB468.namprd03.prod.outlook.com>
Message-ID: <20140122153352.GE14108@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 01:54:11PM +0000, Varun Sethi wrote:
> > > > Ok, so are you suggesting that we perform the isolation mapping in
> > > > arm_smmu_add_device and drop the notifier altogether?
> > > I think that should be fine, until we want to delay mapping creation
> > > till driver bind time.
> > 
> > Is there a hard dependency on that?
> > 
> Not sure, may be Andreas can answer that.

Ok. Andreas? I would have thought doing this *earlier* shouldn't be a
problem (the DMA ops must be swizzled before the driver is probed).

> > > But the "isolate device" property should dictate iommu group creation.
> > 
> > The reason we added automatic group creation (per-device) is for VFIO,
> > which expects all devices to be in a group regardless of the device
> > isolation configuration.
> > 
> IIUC, with the "isolate devices" property we ensure that there would be
> independent SMR and S2CR per device. Is that correct?

Yes, as part of giving them independent sets of page tables. Initially these
tables don't have any valid mappings, but the dma-mapping API will populate
them in response to dma_map_*/dma_alloc/etc.

Not sure what this has to do with us putting devices into their own
groups...

Will
