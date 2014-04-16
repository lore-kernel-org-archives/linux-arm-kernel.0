From: broonie@kernel.org (Mark Brown)
Date: Wed, 16 Apr 2014 18:06:39 +0100
Subject: [PATCH] regmap: i2c: fallback to SMBus if the adapter does not
 support standard I2C
In-Reply-To: <1397636170-664-1-git-send-email-boris.brezillon@free-electrons.com>
References: <20140415223849.GJ12304@sirena.org.uk>
 <1397636170-664-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140416170638.GT12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 10:16:10AM +0200, Boris BREZILLON wrote:

> +	if (i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C)) {
> +		return &regmap_i2c;
> +	} else if (config->val_bits == 16 &&
> +		   i2c_check_functionality(i2c->adapter,
> +					   I2C_FUNC_SMBUS_WORD_DATA)) {
> +                config->reg_read = regmap_smbus_word_reg_read;
> +                config->reg_write = regmap_smbus_word_reg_write;
> +		return NULL;

This all looks good to me except we shouldn't be modifying the config
struct (it's supposed to be const).  We should instead add the ability
for the bus to set these ops - that'll also be useful for things like
AC'97.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140416/575bc83b/attachment.sig>
