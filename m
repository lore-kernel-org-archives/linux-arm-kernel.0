From: broonie@kernel.org (Mark Brown)
Date: Tue, 18 Feb 2014 09:14:20 +0900
Subject: [PATCH] regulator: core bugfix: Use normal enable for always_on
 regulators
In-Reply-To: <1392577256-20475-1-git-send-email-mpa@pengutronix.de>
References: <1392577256-20475-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20140218001420.GF2669@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 16, 2014 at 08:00:56PM +0100, Markus Pargmann wrote:

Please use more standard subject lines, don't do things like "core
bugfix", just write a normal changelog.

> +static int _regulator_do_enable_no_delay(struct regulator_dev *rdev)
> +{
> +	int ret;
> +
> +	if (rdev->ena_pin) {
> +		ret = regulator_ena_gpio_ctrl(rdev, true);
> +		if (ret < 0)
> +			return ret;
> +		rdev->ena_gpio_state = 1;
> +	} else if (rdev->desc->ops->enable) {
> +		ret = rdev->desc->ops->enable(rdev);
> +	} else {
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}

I don't understand this.  Why is this called _no_delay() and why don't
we want to delay when applying constraints?  We don't want to ever be in
a position where we think a supply is enabled but it has in fact not
finished ramping, and of course enable() may in fact be blocking anyway.

The use of the common code to do enable is good fix but this just seems
odd.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140218/8af22c6e/attachment.sig>
