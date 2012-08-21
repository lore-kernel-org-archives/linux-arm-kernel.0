From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 21 Aug 2012 13:41:46 +0100
Subject: [PATCH 1/4] mfd: smsc: Add support for smsc gpio io/keypad driver
In-Reply-To: <1345545940-2232-2-git-send-email-sourav.poddar@ti.com>
References: <1345545940-2232-1-git-send-email-sourav.poddar@ti.com>
 <1345545940-2232-2-git-send-email-sourav.poddar@ti.com>
Message-ID: <20120821124146.GA21557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 04:15:37PM +0530, Sourav Poddar wrote:

> +config MFD_SMSC
> +       bool "Support for the SMSC ECE1099 series chips"
> +       depends on I2C=y && MFD_CORE && REGMAP_I2C

This needs to select REGMAP_I2C not depend on it.  REGMAP_I2C will only
be enabled by being selected.

> +int smsc_read(struct device *child, unsigned int reg,
> +	unsigned int *dest)
> +{
> +	struct smsc     *smsc = dev_get_drvdata(child->parent);
> +
> +	return regmap_read(smsc->regmap, reg, dest);
> +}
> +EXPORT_SYMBOL_GPL(smsc_read);

I'd suggest making these static inlines in the header given that they're
so trivial.

> +static struct regmap_config smsc_regmap_config = {
> +		.reg_bits = 8,
> +		.val_bits = 8,
> +		.cache_type = REGCACHE_COMPRESSED,
> +};

Indentation is weird here.  For the cache we should have at least
.max_register defined and given the functionality there must surely be
some volatile registers (I'm surprised this works at all as it is, the
cache should break things).

> +	of_property_read_u32(node, "clock", &smsc->clk);
> +

This is all unconditional, there should be a dependency on this in
Kconfig.

> +	regmap_read(smsc->regmap, SMSC_DEV_ID, &ret);
> +	dev_dbg(&i2c->dev, "SMSC Device ID: %d\n", ret);

I'd make these log messages dev_info() or something.

> +err:
> +	kfree(smsc);

Use devm_kzalloc() for this.

> +static const struct i2c_device_id smsc_i2c_id[] = {
> +	{ "smsc", 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, smsc_i2c_id);

This should probably list the part name rather than "smsc" - that seems
far too generic a name to use, obviously smsc produce more than one
part!
