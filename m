From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Wed, 18 Dec 2013 03:11:12 +0000
Subject: [PATCH 1/3 v2] regulator: act8865: add PMIC act8865 driver
In-Reply-To: <20131217130653.GA3185@sirena.org.uk>
References: <1387258597-21866-1-git-send-email-wenyou.yang@atmel.com>
 <1387258597-21866-2-git-send-email-wenyou.yang@atmel.com>
 <20131217130653.GA3185@sirena.org.uk>
Message-ID: <B256D81BAE5131468A838E5D7A24364172F18381@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Thank you very much.

> -----Original Message-----
> From: Mark Brown [mailto:broonie at kernel.org]
> Sent: Tuesday, December 17, 2013 9:07 PM
> To: Yang, Wenyou
> Cc: lgirdwood at gmail.com; linux-kernel at vger.kernel.org;
> grant.likely at linaro.org; rob.herring at calxeda.com; linux-
> doc at vger.kernel.org; vpalatin at chromium.org; Ferre, Nicolas;
> plagnioj at jcrosoft.com; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org
> Subject: Re: [PATCH 1/3 v2] regulator: act8865: add PMIC act8865 driver
> 
> On Tue, Dec 17, 2013 at 01:36:35PM +0800, Wenyou Yang wrote:
> >  Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> 
> Much better.  Still a few small issues though.
> 
> > +/* ACt8865 voltage table */
> > +static const u32 act8865_voltages_table[] = {
> 
> This is the wrong type for a voltage table but it looks like it
> shouldn't be a voltage table at all - this looks like it should be
> mapped as linear ranges.
Change it, using unsigned int.

It is not linear, can't be mapped as linear range. so using voltage table.

> 
> > +static struct regulator_ops act8865_ops = {
> > +	.list_voltage		= regulator_list_voltage_table,
> > +	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
> > +	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
> > +	.enable			= regulator_enable_regmap,
> > +	.disable		= regulator_disable_regmap,
> > +	.is_enabled		= regulator_is_enabled_regmap,
> > +	.set_suspend_voltage	= act8865_set_suspend_voltage,
> > +	.set_suspend_enable	= regulator_enable_regmap,
> > +	.set_suspend_disable	= regulator_disable_regmap,
> > +};
> 
> This is missing a git di() operation.

Add it, 
.map_voltage            = regulator_map_voltage_ascend,

> 
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id act8865_dt_ids[] = {
> > +	{ .compatible = "active-semi,act8865" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, act8865_dt_ids);
> 
> active-semi needs adding to vendor-prefixes.txt.
> 
Add it,
active-semi    Active-Semi International Inc

> > +	np = of_find_node_by_name(dev->of_node, "regulators");
> > +	if (!np) {
> > +		dev_err(dev, "missing 'regulators' subnode in DT\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	for (i = 0; i < ARRAY_SIZE(rmatch); i++)
> > +		rmatch[i].name = act8865_reg[i].name;
> > +
> > +	matched = of_regulator_match(dev, np, rmatch, ARRAY_SIZE(rmatch));
> > +	if (matched <= 0)
> > +		return matched;
> 
> You should register all regulators the device has regardless of how many
> have parameters configured in the DT so that the settings can be read
> back for diagnostic purposes.
Change it.

> 
> > +	if (dev->of_node && !pdata) {
> > +		const struct of_device_id *id;
> > +		struct act8865_platform_data pdata_of;
> > +
> > +		id = of_match_device(of_match_ptr(act8865_dt_ids), dev);
> > +		if (!id)
> > +			return -ENODEV;
> > +
> > +		ret = act8865_pdata_from_dt(dev, of_node, &pdata_of);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		pdata = &pdata_of;
> > +	} else {
> > +		memset(of_node, 0, sizeof(of_node));
> > +	}
> 
> What's this memset() for?
No meaningful,  removed.

> 
> > +		rdev[i] = devm_regulator_register(&client->dev,
> > +						&act8865_reg[i], &config);
> 
> > +err_unregister:
> > +	while (--i >= 0)
> > +		regulator_unregister(rdev[i]);
> 
> The whole purpose of devm_ APIs is to avoid the need to explicitly
> unregister, you shouldn't need to call regulator_unregister() at all.

Remove regulator_unregister(rdev[i]) statement.

Best Regard,
Wenyou Yang
