From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 12 Jul 2017 15:55:47 -0700
Subject: [PATCH V4 4/6] iommu/arm-smmu: Add the device_link between
 masters and smmu
In-Reply-To: <1499333825-7658-5-git-send-email-vivek.gautam@codeaurora.org>
References: <1499333825-7658-1-git-send-email-vivek.gautam@codeaurora.org>
 <1499333825-7658-5-git-send-email-vivek.gautam@codeaurora.org>
Message-ID: <20170712225547.GA22780@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06, Vivek Gautam wrote:
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index ddbfa8ab69e6..75567d9698ab 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1348,6 +1348,7 @@ static int arm_smmu_add_device(struct device *dev)
>  	struct arm_smmu_device *smmu;
>  	struct arm_smmu_master_cfg *cfg;
>  	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
> +	struct device_link *link = NULL;

Unnecessary initialization?

>  	int i, ret;
>  
>  	if (using_legacy_binding) {
> @@ -1403,6 +1404,16 @@ static int arm_smmu_add_device(struct device *dev)
>  
>  	pm_runtime_put_sync(smmu->dev);
>  
> +	/*
> +	 * Establish the link between smmu and master, so that the
> +	 * smmu gets runtime enabled/disabled as per the master's
> +	 * needs.
> +	 */
> +	link = device_link_add(dev, smmu->dev, DL_FLAG_PM_RUNTIME);
> +	if (!link)
> +		dev_warn(smmu->dev, "Unable to create device link between %s and %s\n",
> +			 dev_name(smmu->dev), dev_name(dev));
> +
>  	return 0;
>  

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
