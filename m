From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 19 Dec 2014 19:08:00 +0100
Subject: [PATCH v2 03/11] clk: sunxi: Add driver for A80 MMC config
 clocks/resets
In-Reply-To: <1418886058-8145-4-git-send-email-wens@csie.org>
References: <1418886058-8145-1-git-send-email-wens@csie.org>
 <1418886058-8145-4-git-send-email-wens@csie.org>
Message-ID: <20141219180759.GP4820@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 18, 2014 at 03:00:50PM +0800, Chen-Yu Tsai wrote:
> +static int sun9i_a80_mmc_config_clk_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct sun9i_mmc_clk_data *data;
> +	struct clk_onecell_data *clk_data;
> +	const char *clk_name = np->name;
> +	const char *clk_parent;
> +	struct resource *r;
> +	int count, i, ret;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&data->lock);
> +
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	/* one clock/reset pair per word */
> +	count = DIV_ROUND_UP((r->end - r->start + 1), SUN9I_MMC_WIDTH);
> +	data->membase = devm_ioremap_resource(&pdev->dev, r);
> +	if (IS_ERR(data->membase))
> +		return PTR_ERR(data->membase);
> +
> +	clk_data = &data->clk_data;
> +	clk_data->clk_num = count;
> +	clk_data->clks = devm_kcalloc(&pdev->dev, count, sizeof(struct clk *),

Hmmm, are you sure of that sizeof?

> +				      GFP_KERNEL);
> +	if (!clk_data->clks)
> +		return -ENOMEM;
> +
> +	clk_parent = of_clk_get_parent_name(np, 0);
> +	if (!clk_parent)
> +		return -EINVAL;
> +
> +	data->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(data->clk)) {
> +		dev_err(&pdev->dev, "Could not get clock\n");
> +		return PTR_ERR(data->clk);
> +	}
> +
> +	data->reset = devm_reset_control_get(&pdev->dev, NULL);
> +	if (IS_ERR(data->reset)) {
> +		dev_err(&pdev->dev, "Could not get reset control\n");
> +		return PTR_ERR(data->reset);
> +	}
> +
> +	ret = reset_control_deassert(data->reset);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Reset deassert err %d\n", ret);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < count; i++) {
> +		of_property_read_string_index(np, "clock-output-names",
> +					      i, &clk_name);
> +
> +		clk_data->clks[i] = clk_register_gate(&pdev->dev, clk_name,
> +						      clk_parent, 0,
> +						      data->membase + SUN9I_MMC_WIDTH * i,
> +						      SUN9I_MMC_GATE_BIT, 0,
> +						      &data->lock);
> +
> +		if (IS_ERR(clk_data->clks[i])) {
> +			ret = PTR_ERR(clk_data->clks[i]);
> +			goto err_clk_register;
> +		}
> +	}
> +
> +	ret = of_clk_add_provider(np, of_clk_src_onecell_get, clk_data);
> +	if (ret)
> +		goto err_clk_provider;
> +
> +	data->rcdev.owner = THIS_MODULE;
> +	data->rcdev.nr_resets = count;
> +	data->rcdev.ops = &sun9i_mmc_reset_ops;
> +	data->rcdev.of_node = pdev->dev.of_node;
> +
> +	ret = reset_controller_register(&data->rcdev);
> +	if (ret)
> +		goto err_rc_reg;
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	return 0;
> +
> +err_rc_reg:
> +	of_clk_del_provider(np);
> +
> +err_clk_provider:
> +	for (i = 0; i < count; i++)
> +		clk_unregister(clk_data->clks[i]);
> +
> +err_clk_register:
> +	reset_control_assert(data->reset);
> +
> +	return ret;
> +}
> +
> +static int sun9i_a80_mmc_config_clk_remove(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct sun9i_mmc_clk_data *data = platform_get_drvdata(pdev);
> +	struct clk_onecell_data *clk_data = &data->clk_data;
> +	int i;
> +
> +	reset_controller_unregister(&data->rcdev);
> +	of_clk_del_provider(np);
> +	for (i = 0; i < clk_data->clk_num; i++)
> +		clk_unregister(clk_data->clks[i]);
> +
> +	reset_control_assert(data->reset);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sun9i_a80_mmc_config_clk_dt_ids[] = {
> +	{ .compatible = "allwinner,sun9i-a80-mmc-config-clk" },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver sun9i_a80_mmc_config_clk_driver = {
> +	.driver = {
> +		.name = "sun9i-a80-mmc-config-clk",
> +		.of_match_table = sun9i_a80_mmc_config_clk_dt_ids,
> +	},
> +	.probe = sun9i_a80_mmc_config_clk_probe,
> +	.remove = sun9i_a80_mmc_config_clk_remove,
> +};
> +module_platform_driver(sun9i_a80_mmc_config_clk_driver);
> +
> +MODULE_AUTHOR("Chen-Yu Tsai <wens@csie.org>");
> +MODULE_DESCRIPTION("Allwinner A80 MMC clock/reset Driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.1.3
> 

It looks fine otherwise. Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141219/a4f3ce89/attachment.sig>
