From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Dec 2013 11:34:12 -0700
Subject: [PATCHv7 03/12] iommu/of: check if dependee iommu is ready or not
In-Reply-To: <1386835033-4701-4-git-send-email-hdoyu@nvidia.com>
References: <1386835033-4701-1-git-send-email-hdoyu@nvidia.com>
 <1386835033-4701-4-git-send-email-hdoyu@nvidia.com>
Message-ID: <52AF47A4.6010501@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2013 12:57 AM, Hiroshi Doyu wrote:
> IOMMU devices on the bus need to be poplulated first, then iommu
> master devices are done later.
> 
> With CONFIG_OF_IOMMU, "iommus=" DT binding would be used to identify
> whether a device can be an iommu msater or not. If a device can, we'll
> defer to populate that device till an depending iommu device is
> populated.

> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c

> +int of_iommu_attach(struct device *dev)
> +{
> +	const __be32 *cur, *end;
> +	struct of_phandle_args args;
> +
> +	of_property_for_each_phandle_with_args(dev->of_node, "iommus",
> +				       "#iommu-cells", 0, args, cur, end) {
> +		if (!of_find_iommu_by_node(args.np))
> +			return -EPROBE_DEFER;

I think that since of_find_iommu_by_node() should be calling
iommu_get(iommu), the error-case here should loop over the IOMMUs that
have successfully been acquired, and call iommu_put().

You'd also want to implement of_iommu_detach() or iommu_detach() to undo
the iommu_get()s that happen within this function.
