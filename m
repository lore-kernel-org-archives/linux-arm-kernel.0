From: cyndis@kapsi.fi (Mikko Perttunen)
Date: Wed, 2 Aug 2017 11:12:54 +0300
Subject: [PATCH 2/4] iommu/tegra-smmu: Add iommu_group support
In-Reply-To: <7a6819a5a71c4b85db536169f71a4c087afb60f4.1500637633.git.robin.murphy@arm.com>
References: <cover.1500637633.git.robin.murphy@arm.com>
 <7a6819a5a71c4b85db536169f71a4c087afb60f4.1500637633.git.robin.murphy@arm.com>
Message-ID: <bdaaf96b-e6cd-fd4a-91e4-3212d94afb57@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested-by: Mikko Perttunen <mperttunen@nvidia.com>

(Jetson TX1 / Tegra210 with Host1x/VIC behind IOMMU)

On 21.07.2017 15:12, Robin Murphy wrote:
> As the last step to making groups mandatory, clean up the remaining
> drivers by adding basic support. Whilst it may not perfectly reflect
> the isolation capabilities of the hardware (tegra_smmu_swgroup sounds
> suspiciously like something that might warrant representing at the
> iommu_group level), using generic_device_group() should at least
> maintain existing behaviour with respect to the API.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/tegra-smmu.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index eeb19f560a05..faa9c1e70482 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -704,6 +704,7 @@ static struct tegra_smmu *tegra_smmu_find(struct device_node *np)
>  static int tegra_smmu_add_device(struct device *dev)
>  {
>  	struct device_node *np = dev->of_node;
> +	struct iommu_group *group;
>  	struct of_phandle_args args;
>  	unsigned int index = 0;
>
> @@ -725,12 +726,19 @@ static int tegra_smmu_add_device(struct device *dev)
>  		index++;
>  	}
>
> +	group = iommu_group_get_for_dev(dev);
> +	if (IS_ERR(group))
> +		return PTR_ERR(group);
> +
> +	iommu_group_put(group);
> +
>  	return 0;
>  }
>
>  static void tegra_smmu_remove_device(struct device *dev)
>  {
>  	dev->archdata.iommu = NULL;
> +	iommu_group_remove_device(dev);
>  }
>
>  static const struct iommu_ops tegra_smmu_ops = {
> @@ -741,6 +749,7 @@ static const struct iommu_ops tegra_smmu_ops = {
>  	.detach_dev = tegra_smmu_detach_dev,
>  	.add_device = tegra_smmu_add_device,
>  	.remove_device = tegra_smmu_remove_device,
> +	.device_group = generic_device_group,
>  	.map = tegra_smmu_map,
>  	.unmap = tegra_smmu_unmap,
>  	.map_sg = default_iommu_map_sg,
>
