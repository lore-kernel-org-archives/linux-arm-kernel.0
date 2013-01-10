From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 10 Jan 2013 13:42:28 -0700
Subject: [PATCH v2] drivers/pinctrl: grab default handles from device core
In-Reply-To: <1355343907-11535-1-git-send-email-linus.walleij@stericsson.com>
References: <1355343907-11535-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <50EF27B4.60608@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2012 01:25 PM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This makes the device core auto-grab the pinctrl handle and set
> the "default" (PINCTRL_STATE_DEFAULT) state for every device
> that is present in the device model right before probe. This will
> account for the lion's share of embedded silicon devcies.

There are quite a few problems with this patch, and they end up
completely breaking at least Tegra in next-20130110.

> diff --git a/drivers/base/pinctrl.c b/drivers/base/pinctrl.c

> +int pinctrl_bind_pins(struct device *dev)
> +{
> +	struct dev_pin_info *dpi;
> +	int ret;
> +
> +	/* Allocate a pin state container on-the-fly */
> +	if (!dev->pins) {
> +		dpi = devm_kzalloc(dev, sizeof(*dpi), GFP_KERNEL);

This is allocated using a devm_ function. If -EPROBE_DEFER is returned
below after the assignment to dev->pins or if the driver's own probe()
returns -EPROBE_DEFER, this allocation will be freed by the driver core.
This can leave dev->pins pointing to something non-NULL, yet invalid.

I haven't fully verified this, but I believe this issue is causing
crashes on Tegra. Certainly if I force this code to follow the path that
always allocates new structs or performs new gets, then the crashes go away.

> +		if (!dpi)
> +			return -ENOMEM;
> +	} else
> +		dpi = dev->pins;
> +
> +	/*
> +	 * Check if we already have a pinctrl handle, as we may arrive here
> +	 * after a deferral in the state selection below
> +	 */
> +	if (!dpi->p) {
> +		dpi->p = devm_pinctrl_get(dev);

That won't succeed for a pinctrl device that has a default state in
order to implement hogs. This will then cause the pin controller device
to always defer probe and never activate. This will leave HW
unconfigured and/or prevent other devices from successfully calling
pinctrl_get().

This issue also happens on Tegra.

> diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c

> @@ -734,9 +734,16 @@ static struct pinctrl *pinctrl_get_locked(struct device *dev)
>  	if (WARN_ON(!dev))
>  		return ERR_PTR(-EINVAL);
>  
> +	/*
> +	 * See if somebody else (such as the device core) has already
> +	 * obtained a handle to the pinctrl for this device. In that case,
> +	 * return another pointer to it.
> +	 */
>  	p = find_pinctrl(dev);
> -	if (p != NULL)
> -		return ERR_PTR(-EBUSY);

I deliberately returned an error here, because there's no reference
counting on the struct pinctrl objects. If a driver calls pinctrl_get(),
with the new code below, it will retrieve the same struct. If it later
calls pinctrl_put(), the put will immediately free the structure. This
will invalidate the pointers that reference it in struct device's pins
field.

This issue will probably trigger on Tegra, since we at least have a
pinctrl-based I2C mux that calls pinctrl_get().

> +	if (p != NULL) {
> +		dev_dbg(dev, "obtain a copy of previously claimed pinctrl\n");
> +		return p;
> +	}
>  
>  	return create_pinctrl(dev);
>  }

Perhaps we could remove this patch from linux-next, and have a V3?
