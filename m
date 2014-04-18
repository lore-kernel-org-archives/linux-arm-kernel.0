From: lars@metafoo.de (Lars-Peter Clausen)
Date: Fri, 18 Apr 2014 19:08:10 +0200
Subject: [PATCH v2 2/2] regmap: i2c: fallback to SMBus if the adapter
 does not support standard I2C
In-Reply-To: <1397727612-32103-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1397727612-32103-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397727612-32103-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <53515BFA.3060601@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +const struct regmap_bus *regmap_get_i2c_bus(struct i2c_client *i2c,
> +					    const struct regmap_config *config)
> +{
> +	if (i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C))
> +		return &regmap_i2c;
> +	else if (config->val_bits == 16 &&
> +		 i2c_check_functionality(i2c->adapter,
> +					 I2C_FUNC_SMBUS_WORD_DATA))
> +		return &regmap_smbus_word;
> +	else if (config->val_bits == 8 &&
> +		 i2c_check_functionality(i2c->adapter,
> +					 I2C_FUNC_SMBUS_BYTE_DATA))
> +		return &regmap_smbus_byte;

The fallback code should also check that reg_bits is 8.

> +
> +	return ERR_PTR(-ENOTSUPP);
> +}
> +
