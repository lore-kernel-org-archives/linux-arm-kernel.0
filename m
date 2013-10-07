From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Mon, 7 Oct 2013 17:42:27 +0200
Subject: [PATCH 7/9] iommu/arm-smmu: Add function that conditionally
 isolates all masters of all SMMUs
In-Reply-To: <20130927130001.GF9520@mudshark.cambridge.arm.com>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
 <1380234982-1677-8-git-send-email-andreas.herrmann@calxeda.com>
 <20130927130001.GF9520@mudshark.cambridge.arm.com>
Message-ID: <20131007154227.GC2935@alberich>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 09:00:01AM -0400, Will Deacon wrote:
> Hi Andreas,
> 
> On Thu, Sep 26, 2013 at 11:36:19PM +0100, Andreas Herrmann wrote:
> > (Depending on DT information and module parameters) each device is put
> > into its own protection domain (if possible).  For configuration with
> > one or just a few masters per SMMU that is easy to achieve.
> > 
> > In case of many devices per SMMU (e.g. MMU-500 with it's distributed
> > translation support) isolation of each device might not be possible --
> > depending on number of available SMR groups and/or context banks.
> > 
> > Default is that device isolation is contolled per SMMU with SMMU node
> > property "linux,arm-smmu-isolate-devices" in a DT. If the property is
> > set for an SMMU node device isolation is performed.
> > 
> > Also introduce a module parameter:
> 
> Actually, I think I'd rather do away with the module paramater / command
> line option altogether in favour of DT.
> 
> > +extern struct platform_device *of_find_device_by_node(struct device_node *np);
> > +
> > +static int arm_smmu_isolate_devices(void)
> > +{
> > +	struct dma_iommu_mapping *mapping;
> > +	struct arm_smmu_device *smmu;
> > +	struct rb_node *rbn;
> > +	struct arm_smmu_master *master;
> > +	struct platform_device *pdev;
> > +	struct device *dev;
> > +	void __iomem *gr0_base;
> > +	u32 cr0;
> > +	int ret = 0;
> > +	size_t size;
> > +
> > +	list_for_each_entry(smmu, &arm_smmu_devices, list) {
> > +		if (arm_smmu_disable_isolation ||
> > +			(!(smmu->features & ARM_SMMU_FEAT_ISOLATE_DEVICES)
> > +				&& !arm_smmu_force_isolation))
> > +			continue;
> > +		rbn = rb_first(&smmu->masters);
> > +		while (rbn) {
> > +			master = container_of(rbn, struct arm_smmu_master, node);
> > +			pdev = of_find_device_by_node(master->of_node);
> > +			if (!pdev)
> > +				break;
> > +			dev = &pdev->dev;
> > +
> > +			size = (size_t) dev->coherent_dma_mask;
> > +			size = size ? : (unsigned long) dev->dma_mask;
> 
> Hmm, this could be *huge* with 64-bit capable DMA controllers (think LPAE).

Yes, agreed.
(And even for 32-bit DMA this requires a large bitmap_size for the
mapping.)

> Russell also has some pending dma mask cleanup, which might break some
> assumptions here:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-September/199397.html
> 
> (namely that we're offsetting everything from zero).

What do you think is a reasonable general value for the size of a
mapping? (Do we need a DT property to specify this?)

What about a size of 128 MB -- if I'm not mistaken this requires a
bitmap_size of 4K.


Andreas
