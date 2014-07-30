From: will.deacon@arm.com (Will Deacon)
Date: Wed, 30 Jul 2014 17:57:21 +0100
Subject: [PATCH v3] iommu/arm-smmu: avoid calling request_irq in atomic
 context
In-Reply-To: <vnkwd2cmbxi3.fsf@mitchelh-linux.qualcomm.com>
References: <1406657475-1232-1-git-send-email-mitchelh@codeaurora.org>
 <20140730153114.GG8989@arm.com>
 <vnkwd2cmbxi3.fsf@mitchelh-linux.qualcomm.com>
Message-ID: <20140730165721.GJ8989@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 30, 2014 at 05:51:48PM +0100, Mitchel Humpherys wrote:
> On Wed, Jul 30 2014 at 08:31:14 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Jul 29, 2014 at 07:11:15PM +0100, Mitchel Humpherys wrote:
> >> Changelog:
> >> 
> >>   - v3: rework irq request code to avoid requesting the irq every
> >>         time a master is added to the domain
> >>   - v2: return error code from request_irq on failure
> >> ---
> >>  drivers/iommu/arm-smmu.c | 73 +++++++++++++++++++++++++++---------------------
> >>  1 file changed, 41 insertions(+), 32 deletions(-)
> >
> > I think this is correct, but we can do some cleanup now that you've moved
> > all the locking into the conditional. Messy diff below, which would be much
> > nicer sqaushed into your patch.
> >
> > What do you reckon?
> 
> Much cleaner, thanks. Just one question below.

[...]

> > @@ -902,7 +907,22 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> >  
> >  	ACCESS_ONCE(smmu_domain->smmu) = smmu;
> >  	arm_smmu_init_context_bank(smmu_domain);
> > +	spin_unlock_irqrestore(&smmu_domain->lock, flags);
> > +
> > +	irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
> > +	ret = request_irq(irq, arm_smmu_context_fault, IRQF_SHARED,
> > +			  "arm-smmu-context-fault", smmu_domain);
> > +	if (IS_ERR_VALUE(ret)) {
> > +		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
> > +			cfg->irptndx, irq);
> > +		cfg->irptndx = INVALID_IRPTNDX;
> 
> We want to return ret here due to the request_irq failure, right?

Actually, no, and it's a subtle change introduced by this fix. Before, we
would partially tear-down the domain here by freeing the cbndx but actually,
that's racy as hell. The moment we drop the lock another device can attach
successfully to the domain we've set, so we can't safely tear things down at
that point. The best bet is to continue with the warning -- you end up with
a domain without a context interrupt, but that's not fatal to the driver.

If we returned an error, I can't think of a safe way to reset the domain.

Will
