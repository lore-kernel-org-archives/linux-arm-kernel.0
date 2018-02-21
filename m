From: broonie@kernel.org (Mark Brown)
Date: Wed, 21 Feb 2018 12:26:39 +0000
Subject: [PATCH 2/2] ASoC: support ROHM BD28623 codec
In-Reply-To: <20180221043311.25840-3-suzuki.katsuhiro@socionext.com>
References: <20180221043311.25840-1-suzuki.katsuhiro@socionext.com>
 <20180221043311.25840-3-suzuki.katsuhiro@socionext.com>
Message-ID: <20180221122639.GH8334@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 21, 2018 at 01:33:11PM +0900, Katsuhiro Suzuki wrote:

> +++ b/sound/soc/codecs/bd28623.c
> @@ -0,0 +1,258 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ROHM BD28623MUV class D speaker amplifier codec driver.
> + *

Please make the entire comment C++ so this looks intentional.

> +		dev_err(dev, "Failed to enable supplies: %d\n", ret);
> +		return ret;
> +	}
> +
> +	gpiod_set_value(bd->reset_gpio, 0);

Since this GPIO is not needed in atomic contexts you should use the
_cansleep() versions of the GPIO functions - it doesn't cost you
anything and means that if for some reason someone wired this up to a
GPIO that can't be used in atomic context the driver will just work.

> +	bd->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> +						 GPIOD_OUT_HIGH);

> +	bd->mute_gpio = devm_gpiod_get_optional(dev, "mute",
> +						GPIOD_OUT_HIGH);

These properties were documented as mandatory in the binding but are
optional here.  It's fine that they're optional but I'd expect the
binding to be consistent with this.

> +static int bd28623_remove(struct platform_device *pdev)
> +{
> +	struct bd28623_priv *bd = platform_get_drvdata(pdev);
> +
> +	regulator_bulk_disable(ARRAY_SIZE(bd->supplies), bd->supplies);
> +
> +	return 0;
> +}

We don't enable the supplies explicitly as part of the probe function so
it feels wrong to disable on remove() - I'm sure it is fine in practice
as-is but I'd have to think too hard to confirm that.  I'd put this in a
component level remove function instead so that it's consistent.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180221/7a80277a/attachment.sig>
