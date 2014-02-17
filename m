From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Feb 2014 09:55:08 +0800
Subject: [PATCH v2 2/7] ARM: imx6: gpc: Add PU power domain for GPU/VPU
In-Reply-To: <1392302350-11729-3-git-send-email-p.zabel@pengutronix.de>
References: <1392302350-11729-1-git-send-email-p.zabel@pengutronix.de>
 <1392302350-11729-3-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20140217015506.GB9879@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 13, 2014 at 03:39:05PM +0100, Philipp Zabel wrote:
> +static int imx_gpc_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np;
> +	int ret;
> +
> +	np = of_get_child_by_name(pdev->dev.of_node, "pu-power-domain");
> +	if (!np) {
> +		dev_err(&pdev->dev, "missing pu-power-domain node\n");
> +		return -EINVAL;
> +	}
> +	imx6q_pu_domain.of_node = np;

Once ...

> +
> +	pu_reg = devm_regulator_get(&pdev->dev, "pu");
> +	if (IS_ERR(pu_reg)) {
> +		ret = PTR_ERR(pu_reg);
> +		dev_err(&pdev->dev, "failed to get pu regulator: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* The regulator is initially enabled */
> +	ret = regulator_enable(pu_reg);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to enable pu regulator: %d\n", ret);
> +		return ret;
> +	}
> +
> +	imx6q_pu_domain.of_node = np;

Twice.

Shawn

> +	imx6q_pm_pu_power_off(&imx6q_pu_domain);
> +	pm_genpd_init(&imx6q_pu_domain, NULL, true);
> +	bus_register_notifier(&platform_bus_type, &imx6q_platform_nb);
> +
> +	return 0;
> +}
> +
> +static struct of_device_id imx_gpc_dt_ids[] = {
> +	{ .compatible = "fsl,imx6q-gpc" },
> +	{ }
> +};
> +
> +static struct platform_driver imx_gpc_driver = {
> +	.driver = {
> +		.name = "imx-gpc",
> +		.owner = THIS_MODULE,
> +		.of_match_table = imx_gpc_dt_ids,
> +	},
> +	.probe = imx_gpc_probe,
> +};
> +
> +static int __init imx_pgc_init(void)
> +{
> +	return platform_driver_register(&imx_gpc_driver);
> +}
> +subsys_initcall(imx_pgc_init);
> -- 
> 1.8.5.3
> 
