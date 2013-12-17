From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Dec 2013 13:06:53 +0000
Subject: [PATCH 1/3 v2] regulator: act8865: add PMIC act8865 driver
In-Reply-To: <1387258597-21866-2-git-send-email-wenyou.yang@atmel.com>
References: <1387258597-21866-1-git-send-email-wenyou.yang@atmel.com>
 <1387258597-21866-2-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20131217130653.GA3185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 01:36:35PM +0800, Wenyou Yang wrote:
>  Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

Much better.  Still a few small issues though.

> +/* ACt8865 voltage table */
> +static const u32 act8865_voltages_table[] = {

This is the wrong type for a voltage table but it looks like it
shouldn't be a voltage table at all - this looks like it should be
mapped as linear ranges.

> +static struct regulator_ops act8865_ops = {
> +	.list_voltage		= regulator_list_voltage_table,
> +	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
> +	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
> +	.enable			= regulator_enable_regmap,
> +	.disable		= regulator_disable_regmap,
> +	.is_enabled		= regulator_is_enabled_regmap,
> +	.set_suspend_voltage	= act8865_set_suspend_voltage,
> +	.set_suspend_enable	= regulator_enable_regmap,
> +	.set_suspend_disable	= regulator_disable_regmap,
> +};

This is missing a map_voltage() operation.

> +#ifdef CONFIG_OF
> +static const struct of_device_id act8865_dt_ids[] = {
> +	{ .compatible = "active-semi,act8865" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, act8865_dt_ids);

active-semi needs adding to vendor-prefixes.txt.

> +	np = of_find_node_by_name(dev->of_node, "regulators");
> +	if (!np) {
> +		dev_err(dev, "missing 'regulators' subnode in DT\n");
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(rmatch); i++)
> +		rmatch[i].name = act8865_reg[i].name;
> +
> +	matched = of_regulator_match(dev, np, rmatch, ARRAY_SIZE(rmatch));
> +	if (matched <= 0)
> +		return matched;

You should register all regulators the device has regardless of how many
have parameters configured in the DT so that the settings can be read
back for diagnostic purposes.

> +	if (dev->of_node && !pdata) {
> +		const struct of_device_id *id;
> +		struct act8865_platform_data pdata_of;
> +
> +		id = of_match_device(of_match_ptr(act8865_dt_ids), dev);
> +		if (!id)
> +			return -ENODEV;
> +
> +		ret = act8865_pdata_from_dt(dev, of_node, &pdata_of);
> +		if (ret < 0)
> +			return ret;
> +
> +		pdata = &pdata_of;
> +	} else {
> +		memset(of_node, 0, sizeof(of_node));
> +	}

What's this memset() for?

> +		rdev[i] = devm_regulator_register(&client->dev,
> +						&act8865_reg[i], &config);

> +err_unregister:
> +	while (--i >= 0)
> +		regulator_unregister(rdev[i]);

The whole purpose of devm_ APIs is to avoid the need to explicitly
unregister, you shouldn't need to call regulator_unregister() at all.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131217/24609e30/attachment-0001.sig>
