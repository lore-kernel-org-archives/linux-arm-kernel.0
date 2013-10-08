From: will.deacon@arm.com (Will Deacon)
Date: Tue, 8 Oct 2013 11:43:04 +0100
Subject: [PATCH 7/9] iommu/arm-smmu: Add function that conditionally
 isolates all masters of all SMMUs
In-Reply-To: <20131007154227.GC2935@alberich>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
 <1380234982-1677-8-git-send-email-andreas.herrmann@calxeda.com>
 <20130927130001.GF9520@mudshark.cambridge.arm.com>
 <20131007154227.GC2935@alberich>
Message-ID: <20131008104304.GH17148@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 04:42:27PM +0100, Andreas Herrmann wrote:
> On Fri, Sep 27, 2013 at 09:00:01AM -0400, Will Deacon wrote:
> > On Thu, Sep 26, 2013 at 11:36:19PM +0100, Andreas Herrmann wrote:
> > > +	list_for_each_entry(smmu, &arm_smmu_devices, list) {
> > > +		if (arm_smmu_disable_isolation ||
> > > +			(!(smmu->features & ARM_SMMU_FEAT_ISOLATE_DEVICES)
> > > +				&& !arm_smmu_force_isolation))
> > > +			continue;
> > > +		rbn = rb_first(&smmu->masters);
> > > +		while (rbn) {
> > > +			master = container_of(rbn, struct arm_smmu_master, node);
> > > +			pdev = of_find_device_by_node(master->of_node);
> > > +			if (!pdev)
> > > +				break;
> > > +			dev = &pdev->dev;
> > > +
> > > +			size = (size_t) dev->coherent_dma_mask;
> > > +			size = size ? : (unsigned long) dev->dma_mask;
> > 
> > Hmm, this could be *huge* with 64-bit capable DMA controllers (think LPAE).
> 
> Yes, agreed.
> (And even for 32-bit DMA this requires a large bitmap_size for the
> mapping.)
> 
> > Russell also has some pending dma mask cleanup, which might break some
> > assumptions here:
> >
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2013-September/199397.html
> > 
> > (namely that we're offsetting everything from zero).
> 
> What do you think is a reasonable general value for the size of a
> mapping? (Do we need a DT property to specify this?)
> 
> What about a size of 128 MB -- if I'm not mistaken this requires a
> bitmap_size of 4K.

I don't think we can reasonably pick a sane number for this. We *could* try
doing it lazily (i.e. driving the mapping off a fault handler) but that's
pretty scary and probably doesn't interact well with endpoints incompatible
with the stall model (e.g. PCIe).

So the right solution is probably to get this information from the device
drivers, but I don't know what the interaction is with the dma_mask...
You'll need to do some digging.

Will
