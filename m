From: broonie@kernel.org (Mark Brown)
Date: Wed, 23 Dec 2015 11:56:32 +0000
Subject: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
In-Reply-To: <1450868319-20513-5-git-send-email-contact@paulk.fr>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-5-git-send-email-contact@paulk.fr>
Message-ID: <20151223115632.GS16023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2015 at 11:58:37AM +0100, Paul Kocialkowski wrote:

> +	gpio = lp->pdata->enable_gpio;
> +	if (!gpio_is_valid(gpio))
> +		return 0;
> +
> +	/* Always set enable GPIO high. */
> +	ret = devm_gpio_request_one(lp->dev, gpio, GPIOF_OUT_INIT_HIGH, "LP872X EN");
> +	if (ret) {
> +		dev_err(lp->dev, "gpio request err: %d\n", ret);
> +		return ret;
> +	}

This isn't really adding support for the enable GPIO as the changelog
suggests, it's requesting but not managing the GPIO.  Since there is
core support for manging enable GPIOs this seems especially silly,
please tell the core about the GPIO and then it will work at runtime
too.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151223/625e4b1f/attachment.sig>
