From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 18 Apr 2014 18:57:00 -0700
Subject: [PATCH v3] regmap: i2c: fallback to SMBus if the adapter does
 not support standard I2C
In-Reply-To: <1397851901-16390-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1397727612-32103-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397851901-16390-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <5351D7EC.80902@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/2014 01:11 PM, Boris BREZILLON wrote:
> Some I2C adapters are only compatible with the SMBus protocol and do not
> support standard I2C transfers.
>
> Fallback to SMBus transfers if we encounter such kind of adapters.
> The transfer type is chosen according to the val_bits field in the regmap
> config.
>
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---

[ ... ]

>   /**
>    * regmap_init_i2c(): Initialise register map
>    *
> @@ -109,7 +199,12 @@ static struct regmap_bus regmap_i2c = {
>   struct regmap *regmap_init_i2c(struct i2c_client *i2c,
>   			       const struct regmap_config *config)
>   {
> -	return regmap_init(&i2c->dev, &regmap_i2c, &i2c->dev, config);
> +	const struct regmap_bus *bus = regmap_get_i2c_bus(i2c, config);
> +
> +	if (IS_ERR(bus))
> +		return ERR_PTR(PTR_ERR(bus));
> +
This seems clumsy. You should be able to use ERR_CAST() instead.
Also see Documentation/coccinelle.txt and scripts/coccinelle/api/err_cast.cocci.

> +	return regmap_init(&i2c->dev, bus, &i2c->dev, config);
>   }
>   EXPORT_SYMBOL_GPL(regmap_init_i2c);
>
> @@ -126,7 +221,12 @@ EXPORT_SYMBOL_GPL(regmap_init_i2c);
>   struct regmap *devm_regmap_init_i2c(struct i2c_client *i2c,
>   				    const struct regmap_config *config)
>   {
> -	return devm_regmap_init(&i2c->dev, &regmap_i2c, &i2c->dev, config);
> +	const struct regmap_bus *bus = regmap_get_i2c_bus(i2c, config);
> +
> +	if (IS_ERR(bus))
> +		return ERR_PTR(PTR_ERR(bus));
> +
Same here.

Guenter
