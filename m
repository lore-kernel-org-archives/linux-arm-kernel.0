From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 18 Jul 2013 14:10:29 -0600
Subject: [PATCH v2 13/22] iommu/tegra: smmu: Create default IOVA maps
In-Reply-To: <1373021097-32420-14-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
 <1373021097-32420-14-git-send-email-hdoyu@nvidia.com>
Message-ID: <51E84BB5.9010303@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> Create default IOVA maps at boot-up which can be attached to devices.

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

>  static int tegra_smmu_probe(struct platform_device *pdev)
>  {
>  	struct smmu_device *smmu;

> @@ -1160,13 +1182,15 @@ static int tegra_smmu_probe(struct platform_device *pdev)
>  	if (of_property_read_u32(dev->of_node, "nvidia,#asids", &asids))
>  		return -ENODEV;
>  
> -	bytes = sizeof(*smmu) + asids * sizeof(*smmu->as);
> +	bytes = sizeof(*smmu) + asids * (sizeof(*smmu->as) +
> +					 sizeof(struct dma_iommu_mapping *));
>  	smmu = devm_kzalloc(dev, bytes, GFP_KERNEL);
>  	if (!smmu) {
>  		dev_err(dev, "failed to allocate smmu_device\n");
>  		return -ENOMEM;
>  	}
>  
> +	smmu->map = (struct dma_iommu_mapping **)(smmu->as + asids);

Shouldn't "+ asids" be "+ asids * sizeof(*smmu->as)" to match the
calculation of "bytes" above?
