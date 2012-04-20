From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 20 Apr 2012 10:20:08 +0100
Subject: [PATCH 1/2] mfd: Add Freescale's PMIC MC34708 support
In-Reply-To: <1334853521-23792-1-git-send-email-paul.liu@linaro.org>
References: <1334853521-23792-1-git-send-email-paul.liu@linaro.org>
Message-ID: <20120420092007.GA3892@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2012 at 12:38:40AM +0800, Ying-Chun Liu (PaulLiu) wrote:

> +Sub-nodes:
> +- regulators : Contain the regulator nodes.  The MC34708 regulators are
> +  bound using their names as listed below for enabling.
> +
> +    mc34708__sw1a    : regulator SW1A
> +    mc34708__sw1b    : regulator SW1B

There's no point in including the chip name in the properties - the
device has already been bound at the device level, this is just noise
at this level.

> +	int ret;
> +	int i;
> +
> +	memset(buf, 0, 3);
> +	for (i = 0; i < PMIC_I2C_RETRY_TIMES; i++) {
> +		ret = i2c_smbus_read_i2c_block_data(client, offset, 3, buf);

The I2C layer already has a retry mechanism, and obviously if I2C is
failing at all the board generally has serious problems.

In general I'm not 100% sure why you're not using the regmap API here -
it looks like the 24 bit I/O is just a block I/O.  Alternatively you
could use regmap for the register I/O and then open code the 24 bit
access if they really are different.  This would let you
make much more use of framework support.

> +	return mc34708_reg_write(mc_pmic, offmask, mask | irqbit);
> +}
> +EXPORT_SYMBOL(mc34708_irq_mask);

You shouldn't be open coding stuff like this, you should be implementing
it using genirq.  This again gives you better framework support.

> +static const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
> +						const struct i2c_client *client)
> +{
> +	while (id->name[0]) {
> +		if (strcmp(client->name, id->name) == 0)
> +			return id;
> +		id++;
> +	}
> +
> +	return NULL;
> +}
> +
> +static const struct i2c_device_id *i2c_get_device_id(const struct i2c_client
> +						     *idev)
> +{
> +	const struct i2c_driver *idrv = to_i2c_driver(idev->dev.driver);
> +
> +	return i2c_match_id(idrv->id_table, idev);
> +}

This stuff should be added as generic I2C helpers if it's useful.

> +	if (pdata && pdata->flags & MC34708_USE_REGULATOR) {
> +		struct mc34708_regulator_platform_data regulator_pdata = {
> +			.num_regulators = pdata->num_regulators,
> +			.regulators = pdata->regulators,
> +		};
> +
> +		mc34708_add_subdevice_pdata(mc_pmic, "%s-regulator",
> +					    &regulator_pdata,
> +					    sizeof(regulator_pdata));
> +	} else if (of_find_node_by_name(np, "regulators")) {
> +		mc34708_add_subdevice(mc_pmic, "%s-regulator");
> +	}

This shouldn't be conditional, the regulators are always physically
present and even if they're not actively managed we can look at their
setup.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120420/40e2b353/attachment.sig>
