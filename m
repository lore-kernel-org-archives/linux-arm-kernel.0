From: will.deacon@arm.com (Will Deacon)
Date: Mon, 28 Jul 2014 20:03:27 +0100
Subject: [PATCH v2] iommu/arm-smmu: avoid calling request_irq in atomic
 context
In-Reply-To: <1406572692-27460-1-git-send-email-mitchelh@codeaurora.org>
References: <1406572692-27460-1-git-send-email-mitchelh@codeaurora.org>
Message-ID: <20140728190327.GU15536@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mitchel,

Thanks for the quick v2, but now I spotted a problem :)

On Mon, Jul 28, 2014 at 07:38:12PM +0100, Mitchel Humpherys wrote:
>  static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
> @@ -1172,10 +1158,11 @@ static void arm_smmu_domain_remove_master(struct arm_smmu_domain *smmu_domain,
>  
>  static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  {
> -	int ret = -EINVAL;
> +	int irq, ret = -EINVAL;
>  	struct arm_smmu_domain *smmu_domain = domain->priv;
>  	struct arm_smmu_device *smmu;
> -	struct arm_smmu_master_cfg *cfg;
> +	struct arm_smmu_master_cfg *master_cfg;
> +	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>  	unsigned long flags;
>  
>  	smmu = dev_get_master_dev(dev)->archdata.iommu;
> @@ -1203,12 +1190,22 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	}
>  	spin_unlock_irqrestore(&smmu_domain->lock, flags);
>  
> +	irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
> +	ret = request_irq(irq, arm_smmu_context_fault, IRQF_SHARED,
> +			  "arm-smmu-context-fault", domain);
> +	if (IS_ERR_VALUE(ret)) {
> +		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
> +			cfg->irptndx, irq);
> +		cfg->irptndx = INVALID_IRPTNDX;
> +		return ret;
> +	}

This changes the driver behaviour, so we'll request an IRQ for the domain
*every* time a master is successfuly added to the domain, as opposed to
the first time a master is added (when we can do the lazy init).

Maybe we could rework the code so that it looks like:

  dom_smmu = ACCESS_ONCE(&smmu_domain->smmu);

  if (!dom_smmu) {
	/* Take spinlock and re-check the smmu */
	/* Initialise domain */
	/* Drop lock */
	/* Request IRQ */
  }

  if (dom_smmu != smmu) {
	/* Fail attach */
  }

  /* Add master to domain */

Do you think that would work?

Will
