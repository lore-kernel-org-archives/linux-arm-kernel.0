From: broonie@kernel.org (Mark Brown)
Date: Wed, 23 Sep 2015 09:45:32 -0700
Subject: [PATCH v4 2/5] soc: sunxi: Add driver for Allwinner Reduced
 Serial Bus
In-Reply-To: <1443024323-9115-3-git-send-email-wens@csie.org>
References: <1443024323-9115-1-git-send-email-wens@csie.org>
 <1443024323-9115-3-git-send-email-wens@csie.org>
Message-ID: <20150923164532.GT30445@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2015 at 12:05:18AM +0800, Chen-Yu Tsai wrote:

> +static int sunxi_rsb_device_probe(struct device *dev)
> +{
> +	const struct sunxi_rsb_driver *drv = to_sunxi_rsb_driver(dev->driver);
> +	struct sunxi_rsb_device *rdev = to_sunxi_rsb_device(dev);
> +	int ret;
> +
> +	if (dev->bus != &sunxi_rsb_bus)
> +		return 0;

That's a bit worrying...  why might this get called for something other
than a rsb device?

> +struct regmap *devm_regmap_init_sunxi_rsb(struct sunxi_rsb_device *rdev,
> +					  const struct regmap_config *config);

This should work most of the time but you might want to take a look at
the changes introduced in 3cfe7a74d42b (regmap: Use different lockdep
class for each regmap init call) and follow a similar pattern for RSB to
avoid spurious lockdep warnings in some configurations - see the commit
log for that change for a full explanation.

Otherwise the regmap bit of this looks good, I'll try to have another
look through at the rest of the code later.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150923/eee05b69/attachment.sig>
