From: will.deacon@arm.com (Will Deacon)
Date: Tue, 19 Aug 2014 13:48:07 +0100
Subject: [PATCH 6/6] iommu/arm-smmu: add .domain_{set,get}_attr for
 coherent walk control
In-Reply-To: <1407891099-24641-7-git-send-email-mitchelh@codeaurora.org>
References: <1407891099-24641-1-git-send-email-mitchelh@codeaurora.org>
 <1407891099-24641-7-git-send-email-mitchelh@codeaurora.org>
Message-ID: <20140819124807.GM23128@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 01:51:39AM +0100, Mitchel Humpherys wrote:
> Under certain conditions coherent hardware translation table walks can
> result in degraded performance. Add a new domain attribute to
> disable/enable this feature in generic code along with the domain
> attribute setter and getter to handle it in the ARM SMMU driver.

Again, it would be nice to have some information about these cases and the
performance issues that you are seeing.

> @@ -1908,11 +1917,15 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>  				    enum iommu_attr attr, void *data)
>  {
>  	struct arm_smmu_domain *smmu_domain = domain->priv;
> +	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>  
>  	switch (attr) {
>  	case DOMAIN_ATTR_NESTING:
>  		*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
>  		return 0;
> +	case DOMAIN_ATTR_COHERENT_HTW_DISABLE:
> +		*((bool *)data) = cfg->htw_disable;
> +		return 0;

I think I'd be more comfortable using int instead of bool for this, as it
could well end up in the user ABI if vfio decides to make use of it. While
we're here, let's also add an attributes bitmap to the arm_smmu_domain
instead of having a bool in the arm_smmu_cfg.

>  	default:
>  		return -ENODEV;
>  	}
> @@ -1922,6 +1935,7 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
>  				    enum iommu_attr attr, void *data)
>  {
>  	struct arm_smmu_domain *smmu_domain = domain->priv;
> +	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>  
>  	switch (attr) {
>  	case DOMAIN_ATTR_NESTING:
> @@ -1933,6 +1947,9 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
>  			smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
>  
>  		return 0;
> +	case DOMAIN_ATTR_COHERENT_HTW_DISABLE:
> +		cfg->htw_disable = *((bool *)data);
> +		return 0;
>  	default:
>  		return -ENODEV;
>  	}
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 0550286df4..8a6449857a 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -81,6 +81,7 @@ enum iommu_attr {
>  	DOMAIN_ATTR_FSL_PAMU_ENABLE,
>  	DOMAIN_ATTR_FSL_PAMUV1,
>  	DOMAIN_ATTR_NESTING,	/* two stages of translation */
> +	DOMAIN_ATTR_COHERENT_HTW_DISABLE,

I wonder whether we should make this ARM-specific. Can you take a quick look
to see if any of the other IOMMUs can potentially benefit from this?

Will
