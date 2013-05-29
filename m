From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 29 May 2013 17:19:20 -0600
Subject: [PATCH v7] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <1369753575-9818-1-git-send-email-p.zabel@pengutronix.de>
References: <1369753575-9818-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <51A68CF8.7000303@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2013 09:06 AM, Philipp Zabel wrote:
> This driver implements a reset controller device that toggle a gpio
> connected to a reset pin of a peripheral IC. The delay between assertion
> and de-assertion of the reset signal can be configured via device tree.

> diff --git a/drivers/reset/gpio-reset.c b/drivers/reset/gpio-reset.c

> +static void __gpio_reset_set(struct reset_controller_dev *rcdev, int asserted)

Nit: Technically I think __ is a reserved name-space, so you shouldn't
prefix "user-level" (rather than libc/similar) symbols with it, but it's
not a big deal.

> +static int gpio_reset_probe(struct platform_device *pdev)

> +	if (of_gpio_named_count(np, "reset-gpios") != 1)
> +		return -EINVAL;

Should that error-path (and the path for of_property_read_u32() failure)
include a dev_err() like some already do, so it's obvious what the
failure is?

> +	reset_controller_register(&drvdata->rcdev);
> +
> +	platform_set_drvdata(pdev, drvdata);

It might be better to set the drvdata right after it's been allocated.
It perhaps doesn't matter much here, but if the reset controller core
ever starts calling into the registered device inside the call to
reset_controller_register(), then there might be a problem.

Aside from those minor issues,
Reviewed-by: Stephen Warren <swarren@nvidia.com>
