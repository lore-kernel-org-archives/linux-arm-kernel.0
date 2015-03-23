From: broonie@kernel.org (Mark Brown)
Date: Mon, 23 Mar 2015 14:09:18 -0700
Subject: [PATCH v2 1/7] eeprom: Add a simple EEPROM framework for eeprom
 providers
In-Reply-To: <1426240214-2434-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1426240157-2383-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1426240214-2434-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20150323210918.GS14954@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 09:50:14AM +0000, Srinivas Kandagatla wrote:

A couple of *very* minor points below, otherwise this looks OK to me.

> +struct eeprom_device *eeprom_register(struct eeprom_config *config)
> +{
> +	struct eeprom_device *eeprom;
> +	int rval;
> +
> +	if (!config->regmap || !config->size) {
> +		dev_err(config->dev, "Regmap not found\n");
> +		return ERR_PTR(-EINVAL);
> +	}

You have a struct device in the config and the regmap API has
dev_get_regmap() which for most devices that don't have multiple regmaps
will give the right regmap.  It would be nice to support this as a
convenience for users.

> +	eeprom = kzalloc(sizeof(*eeprom), GFP_KERNEL);
> +	if (!eeprom)
> +		return ERR_PTR(-ENOMEM);

...

> +	rval = device_add(&eeprom->dev);
> +	if (rval)
> +		return ERR_PTR(rval);

Don't you need a kfree() if device_add() fails?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150323/e28dc16c/attachment.sig>
