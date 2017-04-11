From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 11 Apr 2017 16:43:03 +0100
Subject: [RFC PATCH 2/7] iommu/arm-smmu-v3: Do resource size checks based
 on smmu option PAGE0_REGS_ONLY
In-Reply-To: <1491921765-29475-3-git-send-email-linucherian@gmail.com>
References: <1491921765-29475-1-git-send-email-linucherian@gmail.com>
 <1491921765-29475-3-git-send-email-linucherian@gmail.com>
Message-ID: <802c0a38-f5a6-e584-5795-42d8d3fd7603@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/17 15:42, linucherian at gmail.com wrote:
> From: Linu Cherian <linu.cherian@cavium.com>
> 
> With implementations supporting only page 0 of register space,
> resource size can be 64k as well and hence perform size checks
> based on smmu option PAGE0_REGS_ONLY.

What harm comes of mapping page 1 if we don't access it?

Robin.

> For this, arm_smmu_device_dt_probe/acpi_probe has been moved before
> platform_get_resource call, so that smmu options are set beforehand.
> 
> Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index df9f27b..b326195 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2669,6 +2669,14 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>  	return ret;
>  }
>  
> +static unsigned long arm_smmu_resource_size(struct arm_smmu_device *smmu)
> +{
> +	if (ARM_SMMU_PAGE0_REGS_ONLY(smmu))
> +		return SZ_64K;
> +	else
> +		return SZ_128K;
> +}
> +
>  static int arm_smmu_device_probe(struct platform_device *pdev)
>  {
>  	int irq, ret;
> @@ -2685,9 +2693,17 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	}
>  	smmu->dev = dev;
>  
> +	if (dev->of_node) {
> +		ret = arm_smmu_device_dt_probe(pdev, smmu);
> +	} else {
> +		ret = arm_smmu_device_acpi_probe(pdev, smmu);
> +		if (ret == -ENODEV)
> +			return ret;
> +	}
> +
>  	/* Base address */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (resource_size(res) + 1 < SZ_128K) {
> +	if (resource_size(res) + 1 < arm_smmu_resource_size(smmu)) {
>  		dev_err(dev, "MMIO region too small (%pr)\n", res);
>  		return -EINVAL;
>  	}
> @@ -2714,14 +2730,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	if (irq > 0)
>  		smmu->gerr_irq = irq;
>  
> -	if (dev->of_node) {
> -		ret = arm_smmu_device_dt_probe(pdev, smmu);
> -	} else {
> -		ret = arm_smmu_device_acpi_probe(pdev, smmu);
> -		if (ret == -ENODEV)
> -			return ret;
> -	}
> -
>  	/* Set bypass mode according to firmware probing result */
>  	bypass = !!ret;
>  
> 
