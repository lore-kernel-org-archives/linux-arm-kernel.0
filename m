From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 18 Jul 2013 14:01:36 -0600
Subject: [PATCH v2 11/22] iommu/tegra: smmu: Add Tegra 114 support
In-Reply-To: <1373021097-32420-12-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
 <1373021097-32420-12-git-send-email-hdoyu@nvidia.com>
Message-ID: <51E849A0.6040508@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> Tegra 114 SMMU uses the almost same logic as one in Tegra 30 except
> that they have different HaredWare Accelerators(HWA). Those difference
> is provided from DT.

> diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt

>  Required properties:
> -- compatible : "nvidia,tegra30-smmu"
> +- compatible : "nvidia,tegra114-smmu", "nvidia,tegra30-smmu"

So that we don't have to list every single chip in that list, we've
often written that as:

compatible : "nvidia,tegra<chip>-smmu".

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

>  static struct of_device_id tegra_smmu_of_match[] = {
> +	{ .compatible = "nvidia,tegra114-smmu", },
>  	{ .compatible = "nvidia,tegra30-smmu", },

So, there are no HW differences, and hence no driver changes required?
In that case, there's no point making the driver explicitly support
nvidia,tegra114-smmu, since the DT will always be:

compatible = "nvidia,tegra114-smmu", "nvidia,tegra30-smmu";

... and hence always match on the existing nvidia,tegra30-smmu entry in
that table.
