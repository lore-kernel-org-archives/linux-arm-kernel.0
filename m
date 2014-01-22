From: Varun.Sethi@freescale.com (Varun Sethi)
Date: Wed, 22 Jan 2014 13:14:13 +0000
Subject: [PATCH v3 02/11] iommu/arm-smmu: Introduce iommu_group notifier
 block
In-Reply-To: <20140122122550.GA14108@mudshark.cambridge.arm.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
 <1389876263-25759-3-git-send-email-andreas.herrmann@calxeda.com>
 <20140120222814.GI3471@alberich>
 <e92c5fd617fb4068b4ec5de696527ee3@BL2PR03MB468.namprd03.prod.outlook.com>
 <20140122122550.GA14108@mudshark.cambridge.arm.com>
Message-ID: <a73ef0128a0141eabf0a3b899f3afdae@DM2PR03MB479.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Will Deacon [mailto:will.deacon at arm.com]
> Sent: Wednesday, January 22, 2014 5:56 PM
> To: Sethi Varun-B16395
> Cc: Andreas Herrmann; iommu at lists.linux-foundation.org; linux-arm-
> kernel at lists.infradead.org; Andreas Herrmann
> Subject: Re: [PATCH v3 02/11] iommu/arm-smmu: Introduce iommu_group
> notifier block
> 
> Hi Varun, Andreas,
> 
> On Tue, Jan 21, 2014 at 05:48:02PM +0000, Varun Sethi wrote:
> > > +static int arm_smmu_group_notifier(struct notifier_block *nb,
> > > +				unsigned long action, void *data) {
> > > +	struct device *dev = data;
> > > +	struct dma_iommu_mapping *mapping;
> > > +	struct arm_smmu_device *smmu;
> > > +	int ret;
> > > +
> > > +	switch (action) {
> > > +	case IOMMU_GROUP_NOTIFY_BIND_DRIVER:
> > > +
> > > +		smmu = dev->archdata.iommu;
> > > +		if (!smmu || !(smmu->options & ARM_SMMU_OPT_ISOLATE_DEVICES))
> > > +			break;
> > [Sethi Varun-B16395] Should this check be really done here? The
> > "Isolate devices" property would allow us to set up iommu groups. My
> > understanding is that if we specify the isolate devices property, then
> > each device would have a separate iommu group otherwise all devices
> > connected to the SMMU would share the iommu group.
> 
> That's not what currently happens (at least, in the patch I have queued
> for groups). The code queued adds each device to its own group in
> arm_smmu_add_device, which I think is the right thing to do.
> 
> > With that logic, we should link the mapping to the iommu group.
> 
> Ok, so are you suggesting that we perform the isolation mapping in
> arm_smmu_add_device and drop the notifier altogether?
I think that should be fine, until we want to delay mapping creation till driver bind time. But the "isolate device" property should dictate iommu group creation.

-Varun
