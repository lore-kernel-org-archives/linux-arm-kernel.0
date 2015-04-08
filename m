From: broonie@kernel.org (Mark Brown)
Date: Wed, 8 Apr 2015 10:50:05 +0100
Subject: [PATCH] ASoC: max98090: add shutdown callback for max98090
In-Reply-To: <1428483128-23498-2-git-send-email-wxt@rock-chips.com>
References: <1428483128-23498-1-git-send-email-wxt@rock-chips.com>
 <1428483128-23498-2-git-send-email-wxt@rock-chips.com>
Message-ID: <20150408095005.GS6023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 08, 2015 at 04:52:08PM +0800, Caesar Wang wrote:

> +static void max98090_i2c_shutdown(struct i2c_client *i2c)
> +{
> +	struct max98090_priv *max98090 = dev_get_drvdata(&i2c->dev);
> +
> +	dev_info(&i2c->dev, "shut down device\n");

Remove this, it's adding noise.

> +
> +	/* Enable volume smoothing, disable zero cross.  This will cause
> +	 * a quick 40ms ramp to mute on shutdown.
> +	 */
> +	regmap_write(max98090->regmap,
> +		M98090_REG_LEVEL_CONTROL, M98090_VSENN_MASK);
> +	regmap_write(max98090->regmap,
> +		M98090_REG_DEVICE_SHUTDOWN, 0x00);
> +	msleep(40);
> +}

This is OK but equivalent code should be being added to the driver
remove path as the same thing should be happening there.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150408/c43d88ca/attachment.sig>
