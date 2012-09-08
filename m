From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 8 Sep 2012 04:12:38 +0100
Subject: [PATCHv2 1/4] mfd: smsc: Add support for smsc gpio io/keypad
 driver
In-Reply-To: <1346844964-24839-1-git-send-email-sourav.poddar@ti.com>
References: <1346844964-24839-1-git-send-email-sourav.poddar@ti.com>
Message-ID: <20120908031237.GA31018@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2012 at 05:06:04PM +0530, Sourav Poddar wrote:

> +static struct regmap_config smsc_regmap_config = {
> +		.reg_bits = 8,
> +		.val_bits = 8,
> +		.max_register = SMSC_MAX_REGISTER - 1;

That max_register setup looks very odd...

> +		.cache_type = REGCACHE_COMPRESSED,
> +};

Are you sure the compressed type is sensible?  It would normally only
make sense with a large number of closely packed registers but this
device has 8 bit register values.

> +#ifdef CONFIG_OF
> +	of_property_read_u32(node, "clock", &smsc->clk);
> +#endif

> +	ret = regmap_write(smsc->regmap, SMSC_CLK_CTRL, smsc->clk);
> +	if (ret)
> +		goto err;

What happens on non-DT systems?

> +static int smsc_i2c_remove(struct i2c_client *i2c)
> +{
> +	return 0;
> +}

Remove empty functions, though it's rather surprising that there's
nothing at all to do here..  Normally an MFD would at least remove its
children.
