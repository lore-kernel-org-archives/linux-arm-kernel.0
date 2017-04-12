From: rric@kernel.org (Robert Richter)
Date: Wed, 12 Apr 2017 10:43:36 +0200
Subject: [RFC PATCH 5/7] iommu/arm-smmu-v3: For ACPI based device
 probing, set relevant options for different SMMUv3 implementations.
In-Reply-To: <1491921765-29475-6-git-send-email-linucherian@gmail.com>
References: <1491921765-29475-1-git-send-email-linucherian@gmail.com>
 <1491921765-29475-6-git-send-email-linucherian@gmail.com>
Message-ID: <20170412084336.GM4906@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linu,

On 11.04.17 20:12:43, linucherian at gmail.com wrote:
> From: Linu Cherian <linu.cherian@cavium.com>
> 
> Enable SKIP_PREFETCH option for HiSilicon SMMUv3 model.
> Enable PAGE0_REGS_ONLY and USE_SHARED_IRQS options for
> Cavium 99xx SMMUv3 model.
> 
> Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 1475ad8..00b48b4 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2634,18 +2634,45 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  }
>  
>  #ifdef CONFIG_ACPI
> +static int acpi_smmu_get_options(u32 model, struct arm_smmu_device *smmu)
> +{
> +	int ret = 0;
> +
> +	switch (model) {
> +	case ACPI_IORT_SMMU_V3:
> +	case ACPI_IORT_SMMU_CORELINK_MMU600:
> +		break;
> +	case ACPI_IORT_SMMU_V3_HISILICON:
> +		smmu->options |= ARM_SMMU_OPT_SKIP_PREFETCH;
> +		break;
> +	case ACPI_IORT_SMMU_V3_CAVIUM_CN99XX:
> +		smmu->options |= (ARM_SMMU_OPT_PAGE0_REGS_ONLY |
> +				  ARM_SMMU_OPT_USE_SHARED_IRQS);
> +		break;
> +	default:
> +		ret = -ENODEV;
> +	}
> +
> +	return ret;
> +}
> +
>  static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
>  				      struct arm_smmu_device *smmu)
>  {
>  	struct acpi_iort_smmu_v3 *iort_smmu;
>  	struct device *dev = smmu->dev;
>  	struct acpi_iort_node *node;
> +	int ret;
>  
>  	node = *(struct acpi_iort_node **)dev_get_platdata(dev);
>  
>  	/* Retrieve SMMUv3 specific data */
>  	iort_smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
>  
> +	ret = acpi_smmu_get_options(iort_smmu->model, smmu);
> +	if (ret < 0)
> +		return ret;
> +

could we add at least:

	dev_notice(smmu->dev, "option mask 0x%x\n", smmu->options);

We need a note to see which options have been enabled.

It could be even more fancy and maybe unified with DT code to see the
same messages for DT and ACPI.

Thanks,

-Robert

>  	if (iort_smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE)
>  		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
