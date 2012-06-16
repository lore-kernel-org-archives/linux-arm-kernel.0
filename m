From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 16 Jun 2012 17:23:23 +0000
Subject: [PATCH v2] mmc: mmci.c: Defer probe() in case of yet
 uninitialized GPIOs
In-Reply-To: <1339865375-22314-1-git-send-email-stigge@antcom.de>
References: <1339865375-22314-1-git-send-email-stigge@antcom.de>
Message-ID: <201206161723.23768.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 16 June 2012, Roland Stigge wrote:
> +       if (of_get_property(np, "wp-gpios", NULL)) {
> +               pdata->gpio_wp = of_get_named_gpio(np, "wp-gpios", 0);
> +               if (pdata->gpio_wp == -ENODEV)
> +                       pdata->gpio_wp = -EPROBE_DEFER;
> +       } else {
> +               pdata->gpio_wp = -ENODEV;
> +       }

This is still very ugly and there is a certain danfer that we might
have to duplicate this across more drivers. Can't we make
of_get_named_gpio_flags return -EPROBE_DEFER in cases where we can't
find the GPIO number yet but still have a chance of returning it at
a later point?

	Arnd
