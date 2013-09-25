From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Wed, 25 Sep 2013 12:50:10 +0200
Subject: [PATCH 4/7] iommu/arm-smmu: Check for num_context_irqs > 0 to
 avoid divide by zero exception
In-Reply-To: <20130924154048.GE20774@mudshark.cambridge.arm.com>
References: <1380035221-11576-1-git-send-email-andreas.herrmann@calxeda.com>
 <1380035221-11576-5-git-send-email-andreas.herrmann@calxeda.com>
 <20130924154048.GE20774@mudshark.cambridge.arm.com>
Message-ID: <20130925105010.GA4845@alberich>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 24, 2013 at 11:40:48AM -0400, Will Deacon wrote:
> On Tue, Sep 24, 2013 at 04:06:58PM +0100, Andreas Herrmann wrote:
> > With the right (or wrong;-) definition of v1 SMMU node in DTB it is
> > possible to trigger a division by zero in arm_smmu_init_domain_context
> > (if number of context irqs is 0):
> > 
> >        if (smmu->version == 1) {
> >                root_cfg->irptndx = atomic_inc_return(&smmu->irptndx);
> >  ?             root_cfg->irptndx %= smmu->num_context_irqs;
> >        } else {
> > 
> > Avoid this by checking for num_context_irqs > 0 before trying to
> > assign interrupts to contexts.
> > 
> > Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
> > ---
> >  drivers/iommu/arm-smmu.c |   31 +++++++++++++++++--------------
> >  1 file changed, 17 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index f5a856e..0dfd255 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -828,21 +828,24 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> >  		return ret;
> >  
> >  	root_cfg->cbndx = ret;
> > -	if (smmu->version == 1) {
> > -		root_cfg->irptndx = atomic_inc_return(&smmu->irptndx);
> > -		root_cfg->irptndx %= smmu->num_context_irqs;
> > -	} else {
> > -		root_cfg->irptndx = root_cfg->cbndx;
> > -	}
> >  
> > -	irq = smmu->irqs[smmu->num_global_irqs + root_cfg->irptndx];
> > -	ret = request_irq(irq, arm_smmu_context_fault, IRQF_SHARED,
> > -			  "arm-smmu-context-fault", domain);
> > -	if (IS_ERR_VALUE(ret)) {
> > -		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
> > -			root_cfg->irptndx, irq);
> > -		root_cfg->irptndx = -1;
> > -		goto out_free_context;
> > +	if (smmu->num_context_irqs) {
> 
> Can we move this check to probe time, to avoid re-evaluating it every time
> we initialise a new domain?

Yes, I'll move this check and issue an error message when there is not
at least one context interrupt available.

Andreas
