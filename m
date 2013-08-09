From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 09 Aug 2013 14:50:44 +0200
Subject: [PATCHv2 1/5] drm/exynos: add device tree support for rotator
In-Reply-To: <1376034053-31910-2-git-send-email-chanho61.park@samsung.com>
References: <1376034053-31910-1-git-send-email-chanho61.park@samsung.com>
 <1376034053-31910-2-git-send-email-chanho61.park@samsung.com>
Message-ID: <7210617.268rmnOmdK@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanho,

On Friday 09 of August 2013 16:40:49 Chanho Park wrote:
> The exynos4 platform is only dt-based since 3.10, we should convert
> driver data and ids to dt-based parsing methods. The rotator driver has
> a limit table to get size limit of input picture. Each SoCs has slightly
> different limit value compared with any others.
> For example, exynos4210's max_size of RGB888 is 16k x 16k. But, others
> have 8k x 8k. Another example the exynos5250 should have multiple of 2
> pixel size for its X/Y axis. Thus, we should keep different tables for
> each of them.
> 
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_rotator.c |  109
> ++++++++++++++++++++------- 1 file changed, 81 insertions(+), 28
> deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_rotator.c
> b/drivers/gpu/drm/exynos/exynos_drm_rotator.c index 427640a..39b09e0
> 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_rotator.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_rotator.c
> @@ -632,6 +632,73 @@ static int rotator_ippdrv_start(struct device *dev,
> enum drm_exynos_ipp_cmd cmd) return 0;
>  }
> 
> +static struct rot_limit_table rot_limit_tbl_4210 = {
> +	.ycbcr420_2p = {
> +		.min_w = 32,
> +		.min_h = 32,
> +		.max_w = SZ_64K,
> +		.max_h = SZ_64K,
> +		.align = 3,
> +	},
> +	.rgb888 = {
> +		.min_w = 8,
> +		.min_h = 8,
> +		.max_w = SZ_16K,
> +		.max_h = SZ_16K,
> +		.align = 2,
> +	},
> +};
> +
> +static struct rot_limit_table rot_limit_tbl_4x12 = {
> +	.ycbcr420_2p = {
> +		.min_w = 32,
> +		.min_h = 32,
> +		.max_w = SZ_32K,
> +		.max_h = SZ_32K,
> +		.align = 3,
> +	},
> +	.rgb888 = {
> +		.min_w = 8,
> +		.min_h = 8,
> +		.max_w = SZ_8K,
> +		.max_h = SZ_8K,
> +		.align = 2,
> +	},
> +};
> +
> +static struct rot_limit_table rot_limit_tbl_5250 = {
> +	.ycbcr420_2p = {
> +		.min_w = 32,
> +		.min_h = 32,
> +		.max_w = SZ_32K,
> +		.max_h = SZ_32K,
> +		.align = 3,
> +	},
> +	.rgb888 = {
> +		.min_w = 8,
> +		.min_h = 8,
> +		.max_w = SZ_8K,
> +		.max_h = SZ_8K,
> +		.align = 1,
> +	},
> +};
> +
> +static const struct of_device_id exynos_rotator_match[] = {
> +	{
> +		.compatible = "samsung,exynos4210-rotator",
> +		.data = &rot_limit_tbl_4210,
> +	},
> +	{
> +		.compatible = "samsung,exynos4212-rotator",
> +		.data = &rot_limit_tbl_4x12,
> +	},
> +	{
> +		.compatible = "samsung,exynos5250-rotator",
> +		.data = &rot_limit_tbl_5250,
> +	},
> +	{},
> +};
> +
>  static int rotator_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -645,8 +712,19 @@ static int rotator_probe(struct platform_device
> *pdev) return -ENOMEM;
>  	}
> 
> -	rot->limit_tbl = (struct rot_limit_table *)
> -				platform_get_device_id(pdev)->driver_data;
> +	if (dev->of_node) {
> +		const struct of_device_id *match;
> +		match = of_match_node(of_match_ptr(exynos_rotator_match),
> +					dev->of_node);
> +		if (match == NULL) {
> +			dev_err(dev, "failed to match node\n");
> +			return -ENODEV;
> +		}
> +		rot->limit_tbl = (struct rot_limit_table *)match->data;
> +	} else {
> +		dev_err(dev, "cannot find binding\n");

What about having a check for !dev->of_node at the beginning of probe, to 
not complicate further code?

Also the error message is confusing. It should be something closer to 
"device does not have of_node".

> +		return -ENODEV;
> +	}
> 
>  	rot->regs_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	rot->regs = devm_ioremap_resource(dev, rot->regs_res);
> @@ -718,31 +796,6 @@ static int rotator_remove(struct platform_device
> *pdev) return 0;
>  }
> 
> -static struct rot_limit_table rot_limit_tbl = {
> -	.ycbcr420_2p = {
> -		.min_w = 32,
> -		.min_h = 32,
> -		.max_w = SZ_32K,
> -		.max_h = SZ_32K,
> -		.align = 3,
> -	},
> -	.rgb888 = {
> -		.min_w = 8,
> -		.min_h = 8,
> -		.max_w = SZ_8K,
> -		.max_h = SZ_8K,
> -		.align = 2,
> -	},
> -};
> -
> -static struct platform_device_id rotator_driver_ids[] = {
> -	{
> -		.name		= "exynos-rot",
> -		.driver_data	= (unsigned long)&rot_limit_tbl,
> -	},
> -	{},
> -};
> -
>  static int rotator_clk_crtl(struct rot_context *rot, bool enable)
>  {
>  	if (enable) {
> @@ -804,10 +857,10 @@ static const struct dev_pm_ops rotator_pm_ops = {
>  struct platform_driver rotator_driver = {
>  	.probe		= rotator_probe,
>  	.remove		= rotator_remove,
> -	.id_table	= rotator_driver_ids,
>  	.driver		= {
>  		.name	= "exynos-rot",
>  		.owner	= THIS_MODULE,
>  		.pm	= &rotator_pm_ops,
> +		.of_match_table = of_match_ptr(exynos_rotator_match),
>  	},
>  };

Otherwise looks fine.

One more thing is that IMHO patch 5/5 could be squashed with this one, so 
documentation for the binding would be available at the same it is 
introduced.

Best regards,
Tomasz
