From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 20 Jul 2017 22:35:46 +0200
Subject: [PATCH] iommu: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-29-robh@kernel.org>
References: <20170718214339.7774-29-robh@kernel.org>
Message-ID: <3567821.Si31GJ2fDW@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 18. Juli 2017, 16:43:09 CEST schrieb Rob Herring:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: iommu at lists.linux-foundation.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-rockchip at lists.infradead.org
> ---
>  drivers/iommu/rockchip-iommu.c  | 10 +++++-----

for the Rockchip-related part
Reviewed-by: Heiko Stuebner <heiko@sntech.de>


> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 4ba48a26b389..1b8155dada26 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -1008,20 +1008,20 @@ static int rk_iommu_group_set_iommudata(struct iommu_group *group,
>  	ret = of_parse_phandle_with_args(np, "iommus", "#iommu-cells", 0,
>  					 &args);
>  	if (ret) {
> -		dev_err(dev, "of_parse_phandle_with_args(%s) => %d\n",
> -			np->full_name, ret);
> +		dev_err(dev, "of_parse_phandle_with_args(%pOF) => %d\n",
> +			np, ret);
>  		return ret;
>  	}
>  	if (args.args_count != 0) {
> -		dev_err(dev, "incorrect number of iommu params found for %s (found %d, expected 0)\n",
> -			args.np->full_name, args.args_count);
> +		dev_err(dev, "incorrect number of iommu params found for %pOF (found %d, expected 0)\n",
> +			args.np, args.args_count);
>  		return -EINVAL;
>  	}
> 
>  	pd = of_find_device_by_node(args.np);
>  	of_node_put(args.np);
>  	if (!pd) {
> -		dev_err(dev, "iommu %s not found\n", args.np->full_name);
> +		dev_err(dev, "iommu %pOF not found\n", args.np);
>  		return -EPROBE_DEFER;
>  	}
> 
> --
> 2.11.0
> 
> 
> 
