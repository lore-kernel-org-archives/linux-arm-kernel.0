From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 23 Nov 2015 16:29:08 +0100
Subject: [PATCH 2/3] ARM: imx6: rework GPC to support mutiple power domains
In-Reply-To: <1448291223-9938-3-git-send-email-l.stach@pengutronix.de>
References: <1448291223-9938-1-git-send-email-l.stach@pengutronix.de>
 <1448291223-9938-3-git-send-email-l.stach@pengutronix.de>
Message-ID: <1448292548.4008.53.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 23.11.2015, 16:07 +0100 schrieb Lucas Stach:
> This largely reworks the GPC driver to better accomodate mutiple

accommodate multiple

> power domains. This allows to extend the driver to support more domains
> (like present on i.MX6SX) easily later on.
> 
> Compatibility to the old DT bindings is provided to keep the currently
> supported i.MX6 devices working with the same feature level as before.
> New DTs and SoC support should only use the new binding from now on.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm/mach-imx/gpc.c | 435 ++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 329 insertions(+), 106 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
> index 8e7976a4c3e7..a3272b62d0b9 100644
> --- a/arch/arm/mach-imx/gpc.c
> +++ b/arch/arm/mach-imx/gpc.c
[...]
>  static int imx_gpc_probe(struct platform_device *pdev)
>  {
> -	struct regulator *pu_reg;
> +	const struct of_device_id *of_id =
> +			of_match_device(imx_gpc_dt_ids, &pdev->dev);
> +	const struct imx_gpc_dt_data *of_id_data = of_id->data;
> +	struct device_node *pgc_node;
> +	struct regmap *regmap;
> +	struct resource *res;
> +	void __iomem *base;
>  	int ret;
>  
> +	pgc_node = of_get_child_by_name(pdev->dev.of_node, "pgc");
> +
>  	/* bail out if DT too old and doesn't provide the necessary info */
> -	if (!of_property_read_bool(pdev->dev.of_node, "#power-domain-cells"))
> +	if (!of_property_read_bool(pdev->dev.of_node, "#power-domain-cells") &&
> +	    !pgc_node)
>  		return 0;
>  
> -	pu_reg = devm_regulator_get_optional(&pdev->dev, "pu");
> -	if (PTR_ERR(pu_reg) == -ENODEV)
> -		pu_reg = NULL;
> -	if (IS_ERR(pu_reg)) {
> -		ret = PTR_ERR(pu_reg);
> -		dev_err(&pdev->dev, "failed to get pu regulator: %d\n", ret);
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	regmap = devm_regmap_init_mmio_clk(&pdev->dev, NULL, base,
> +					   &imx_gpc_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		ret = PTR_ERR(regmap);
> +		dev_err(&pdev->dev, "failed to init regmap: %d\n",
> +			ret);
>  		return ret;
>  	}
>  
> -	return imx_gpc_genpd_init(&pdev->dev, pu_reg);
> -}
> +	if (!pgc_node) {
> +		/* old DT layout is only supported for mx6q aka 2 domains */
> +		if (of_id_data->num_domains != 2) {
> +			dev_err(&pdev->dev, "could not find pgc DT node\n");
> +			return -ENODEV;
> +		}
>  
> -static const struct of_device_id imx_gpc_dt_ids[] = {
> -	{ .compatible = "fsl,imx6q-gpc" },
> -	{ .compatible = "fsl,imx6sl-gpc" },
> -	{ }
> -};
> +		ret = imx_gpc_old_dt_init(&pdev->dev, regmap);
> +		if (ret)
> +			return ret;
> +	} else {
> +		struct imx_pm_domain *domain;
> +		struct platform_device *pd_pdev;
> +		struct device_node *np;
> +		struct clk *ipg_clk;
> +		unsigned int ipg_rate_mhz;
> +		int domain_index;
> +
> +		ipg_clk = devm_clk_get(&pdev->dev, "ipg");

This is just a single clock, why not just devm_clk_get(&pdev->dev,
NULL) ?

regards
Philipp
