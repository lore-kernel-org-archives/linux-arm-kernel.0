From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 24 Jan 2017 17:54:38 +0100
Subject: [PATCH 3/4] soc/imx: add new GPC driver
In-Reply-To: <20170124124954.GT5662@dragon>
References: <20170120155225.31905-1-l.stach@pengutronix.de>
 <20170120155225.31905-4-l.stach@pengutronix.de>
 <20170124124954.GT5662@dragon>
Message-ID: <1485276878.2894.24.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

thanks for the review.

Am Dienstag, den 24.01.2017, 20:49 +0800 schrieb Shawn Guo:
> On Fri, Jan 20, 2017 at 04:52:24PM +0100, Lucas Stach wrote:
> > This is an almost complete re-write of the previous GPC power gating control
> > code found in the IMX architecture code. It supports both the old and the new
> > DT binding, allowing more domains to be added later and generally makes the
> > driver easier to extend, while keeping compatibility with existing DTBs.
> 
> Shouldn't we generally wrap the commit log around column 72?
> 
I don't see why we should wrap commit messages earlier than the actual
code, but I think thats mostly an issue of personal preference.

> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  drivers/soc/Makefile     |   1 +
> >  drivers/soc/imx/Makefile |   1 +
> >  drivers/soc/imx/gpc.c    | 480 +++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 482 insertions(+)
> >  create mode 100644 drivers/soc/imx/Makefile
> >  create mode 100644 drivers/soc/imx/gpc.c

[...]
> > +static struct platform_driver imx_pgc_power_domain_driver = {
> > +	.driver = {
> > +		.name = "imx-pgc-pd",
> > +	},
> > +	.probe = imx_pgc_power_domain_probe,
> > +	.remove = imx_pgc_power_domain_remove,
> 
> Not sure how .remove hook is going to be useful for a
> builtin_platform_driver.
> 
There is nothing preventing a manual unbind/bind on a builtin driver.
But yes, this is mostly future proofing right now.

[...]
> > +static int imx_gpc_old_dt_init(struct device *dev, struct regmap *regmap)
> > +{
> > +	struct imx_pm_domain *domain;
> > +	int i, ret;
> > +
> > +	for (i = 0; i < 2; i++) {
> > +		domain = &imx_gpc_domains[i];
> > +		domain->regmap = regmap;
> > +		domain->ipg_rate_mhz = 33;
> 
> I see it's being 66MHz in the existing driver code.  What's the reason
> behind this change?
> 
Thanks for the catch. This should stay at 66MHz.

> > +
> > +		if (i == 1) {
> > +			domain->supply = devm_regulator_get(dev, "pu");
> > +			if (IS_ERR(domain->supply))
> > +				return PTR_ERR(domain->supply);;
> > +
> > +			ret = imx_pgc_get_clocks(dev, domain);
> > +			if (ret)
> > +				goto clk_err;
> > +
> > +			domain->base.power_on(&domain->base);
> > +		}
> > +	}
> > +
> > +	for (i = 0; i < 2; i++)
> > +		pm_genpd_init(&imx_gpc_domains[i].base, NULL, false);
> > +
> > +	if (IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS)) {
> > +		ret = of_genpd_add_provider_onecell(dev->of_node,
> > +						    &imx_gpc_onecell_data);
> > +		if (ret)
> > +			goto genpd_err;
> > +	}
> > +
> > +	return 0;
> > +
> > +genpd_err:
> > +	pm_genpd_remove(&imx_gpc_domains[1].base);
> > +	imx_pgc_put_clocks(&imx_gpc_domains[1]);
> > +clk_err:
> > +	pm_genpd_remove(&imx_gpc_domains[0].base);
> 
> I do not think that imx_gpc_domains[0].base is already registered on
> clk_err path.
> 
Um right, this seems to be a leftover from an earlier version.

> > +
> > +	return ret;
> > +}
> > +
> > +static int imx_gpc_probe(struct platform_device *pdev)
> > +{
> > +	const struct of_device_id *of_id =
> > +			of_match_device(imx_gpc_dt_ids, &pdev->dev);
> > +	const struct imx_gpc_dt_data *of_id_data = of_id->data;
> > +	struct device_node *pgc_node;
> > +	struct regmap *regmap;
> > +	struct resource *res;
> > +	void __iomem *base;
> > +	int ret;
> > +
> > +	pgc_node = of_get_child_by_name(pdev->dev.of_node, "pgc");
> > +
> > +	/* bail out if DT too old and doesn't provide the necessary info */
> > +	if (!of_property_read_bool(pdev->dev.of_node, "#power-domain-cells") &&
> > +	    !pgc_node)
> > +		return 0;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	base = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(base))
> > +		return PTR_ERR(base);
> > +
> > +	regmap = devm_regmap_init_mmio_clk(&pdev->dev, NULL, base,
> > +					   &imx_gpc_regmap_config);
> > +	if (IS_ERR(regmap)) {
> > +		ret = PTR_ERR(regmap);
> > +		dev_err(&pdev->dev, "failed to init regmap: %d\n",
> > +			ret);
> > +		return ret;
> > +	}
> > +
> > +	if (!pgc_node) {
> > +		/* old DT layout is only supported for mx6q aka 2 domains */
> > +		if (of_id_data->num_domains != 2) {
> > +			dev_err(&pdev->dev, "could not find pgc DT node\n");
> > +			return -ENODEV;
> > +		}
> > +
> > +		ret = imx_gpc_old_dt_init(&pdev->dev, regmap);
> > +		if (ret)
> > +			return ret;
> > +	} else {
> > +		struct imx_pm_domain *domain;
> > +		struct platform_device *pd_pdev;
> > +		struct device_node *np;
> > +		struct clk *ipg_clk;
> > +		unsigned int ipg_rate_mhz;
> > +		int domain_index;
> > +
> > +		ipg_clk = devm_clk_get(&pdev->dev, "ipg");
> > +		if (IS_ERR(ipg_clk))
> > +			return PTR_ERR(ipg_clk);
> > +		ipg_rate_mhz = clk_get_rate(ipg_clk) / 1000000;
> > +
> > +		for_each_child_of_node(pgc_node, np) {
> > +			ret = of_property_read_u32(np, "reg", &domain_index);
> > +			if (ret) {
> > +				of_node_put(np);
> > +				return ret;
> > +			}
> 
> Should we have a check here to ensure that domain_index doesn't exceed
> imx_gpc_domains[] array size?

Yes.

Regards,
Lucas
