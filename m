From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Dec 2013 12:09:55 -0700
Subject: [PATCHv7 09/12] iommu/tegra: smmu: get swgroups from DT "iommus="
In-Reply-To: <1386835033-4701-10-git-send-email-hdoyu@nvidia.com>
References: <1386835033-4701-1-git-send-email-hdoyu@nvidia.com>
 <1386835033-4701-10-git-send-email-hdoyu@nvidia.com>
Message-ID: <52AF5003.4040406@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2013 12:57 AM, Hiroshi Doyu wrote:
> This provides the info about which swgroups a device belongs to. This
> info is passed from DT. This is necessary for the unified SMMU driver
> among Tegra SoCs since each has different H/W accelerators.

> diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt

> -Required properties:
> +Required properties in the IOMMU node:
...
> +- iommus: phandle to an iommu device which a device is
> +  attached to and indicates which swgroups a device belongs to(SWGROUP ID).
> +  SWGROUP ID is from 0 to 63, and a device can belong to multiple SWGROUPS.

Shouldn't that property have been deleted from the "Required properties
in the IOMMU node" section, when it got move to the "Required properties
in device nodes affected by the IOMMU" section?

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

> +static int smmu_of_get_swgroups(struct device *dev, unsigned long *swgroups)

> +	of_property_for_each_phandle_with_args(dev->of_node, "iommus",
> +					       "#iommu-cells", 0, args, cur, end) {
> +		if (args.np != smmu_handle->dev->of_node)
> +			continue;
> +
> +		BUG_ON(args.args_count != 2);

Wouldn't it be better to WARN() and prevent the IOMMU from affecting
that given client device, i.e. simply return some error?

> @@ -719,21 +812,16 @@ static int smmu_iommu_attach_dev(struct iommu_domain *domain,

> -	client->dev = dev;
> -	client->as = as;
> -	map = (unsigned long *)dev->platform_data;
> -	if (!map)
> -		return -EINVAL;

OK good, so this does get deleted. Ignore my comment re: this on an
earlier patch then.
