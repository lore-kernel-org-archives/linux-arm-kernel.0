From: will.deacon@arm.com (Will Deacon)
Date: Mon, 28 Jul 2014 17:56:21 +0100
Subject: [PATCH] iommu/arm-smmu: avoid calling request_irq in atomic
 context
In-Reply-To: <20140726091817.GA20396@n2100.arm.linux.org.uk>
References: <1406330819-25323-1-git-send-email-mitchelh@codeaurora.org>
 <20140726091817.GA20396@n2100.arm.linux.org.uk>
Message-ID: <20140728165620.GH15536@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 26, 2014 at 10:18:17AM +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 25, 2014 at 04:26:59PM -0700, Mitchel Humpherys wrote:
> > -	irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
> > -	ret = request_irq(irq, arm_smmu_context_fault, IRQF_SHARED,
> > -			  "arm-smmu-context-fault", domain);
> > -	if (IS_ERR_VALUE(ret)) {
> > -		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
> > -			cfg->irptndx, irq);
> > -		cfg->irptndx = INVALID_IRPTNDX;
> > -		goto out_free_context;
> > -	}
> > -
> >  	smmu_domain->smmu = smmu;
> >  	arm_smmu_init_context_bank(smmu_domain);
> >  	return 0;
> > -
> > -out_free_context:
> > -	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
> > -	return ret;
> 
> This returns 'ret' from request_irq.
> 
> > +	ret = request_irq(irq, arm_smmu_context_fault, IRQF_SHARED,
> > +			  "arm-smmu-context-fault", domain);
> > +	if (IS_ERR_VALUE(ret)) {
> > +		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
> > +			cfg->irptndx, irq);
> > +		cfg->irptndx = INVALID_IRPTNDX;
> > +		return -ENODEV;
> 
> This returns -ENODEV instead.

Indeed. Mitchel, can you preserve the existing behaviour here please?

> > +	}
> > +
> >  	/* Looks ok, so add the device to the domain */
> > -	cfg = find_smmu_master_cfg(smmu_domain->smmu, dev);
> > -	if (!cfg)
> > +	master_cfg = find_smmu_master_cfg(smmu_domain->smmu, dev);
> > +	if (!master_cfg)
> >  		return -ENODEV;
> 
> If this fails, we exit leaving the interrupt registered.  This is a
> bug introduced by this change.

In this case, I think that's actually ok. We lazily initialise the domain on
the first device attach (so that we know the SMMU instance), but if that
attach fails we don't bother to reset the domain. The caller might then see
subsequent attach calls fail if the SMMU is different, but that would've
happened regardless of whether the first attach failed or not.

The irq and context bank will be freed when the domain is destroyed via
iommu_domain_free.

Will
