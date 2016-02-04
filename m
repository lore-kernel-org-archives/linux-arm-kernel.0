From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 04 Feb 2016 17:54:26 +0100
Subject: [PATCH v3 1/3] reset: Make [of_]reset_control_get[_foo]
 functions wrappers
In-Reply-To: <1453918516-3078-2-git-send-email-hdegoede@redhat.com>
References: <1453918516-3078-1-git-send-email-hdegoede@redhat.com>
 <1453918516-3078-2-git-send-email-hdegoede@redhat.com>
Message-ID: <1454604866.3356.78.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

Am Mittwoch, den 27.01.2016, 19:15 +0100 schrieb Hans de Goede:
[...]
> +/**
> + * reset_control_get - Lookup and obtain a reference to a reset controller.
> + * @dev: device to be reset by the controller
> + * @id: reset line name
> + *
> + * Returns a struct reset_control or IS_ERR() condition containing errno.
> + *
> + * Use of id names is optional.
> + */
> +static inline struct reset_control *__must_check reset_control_get(
>  					struct device *dev, const char *id)
>  {
> -	return ERR_PTR(-ENOTSUPP);
> +#ifndef CONFIG_RESET_CONTROLLER
> +	WARN_ON(1);
> +#endif
> +	return __of_reset_control_get(dev ? dev->of_node : NULL, id, 0);

Even though we are device tree only at this point, I'd prefer to keep an
exported function that takes a struct device argument, for example:

	return __reset_control_get(dev, id, 0);

regards
Philipp
