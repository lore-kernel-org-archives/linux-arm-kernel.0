From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 03 Mar 2014 15:27:10 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2NSAxLzNdIHR0eS9zZXJpYWw6IEFkZCBHUElPTElCIGhl?=
 =?UTF-8?B?bHBlcnMgZm9yIGNvbnRyb2xsaW5nIG1vZGVtIGxpbmVz?=
In-Reply-To: <1393845120-6340-2-git-send-email-richard.genoud@gmail.com>
References: <1393845120-6340-1-git-send-email-richard.genoud@gmail.com>
 <1393845120-6340-2-git-send-email-richard.genoud@gmail.com>
Message-ID: <1393846030.273217958@f113.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

???????????,  3 ????? 2014, 12:11 +01:00 ?? Richard Genoud <noreply.rgenoud@gmail.com>:
> This patch add some helpers to control modem lines (CTS/RTS/DSR...) via
> GPIO.
> This will be useful for many boards which have a serial controller that
> only handle CTS/RTS pins (or even just RX/TX).
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
...
> +struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int idx)
> +{
> +	struct mctrl_gpios *gpios;
> +	enum mctrl_gpio_idx i;
> +	int err;
> +
> +	gpios = devm_kzalloc(dev, sizeof(*gpios), GFP_KERNEL);
> +	if (!gpios)
> +		goto out;

if (!gpios)
  return ERR_PTR(-ENOMEM);


> +	for (i = 0; i < UART_GPIO_MAX; i++) {
> +		gpios->gpio[i] = devm_gpiod_get_index(dev,
> +						      mctrl_gpios_desc[i].name,
> +						      idx);
> +
> +		/*
> +		 * The GPIOs are maybe not all filled,
> +		 * this is not an error.
> +		 */
> +		if (IS_ERR_OR_NULL(gpios->gpio[i]))
> +			continue;
> +
> +		if (mctrl_gpios_desc[i].dir_out)
> +			err = gpiod_direction_output(gpios->gpio[i], 0);
> +		else
> +			err = gpiod_direction_input(gpios->gpio[i]);
> +		if (err) {
> +			dev_warn(dev, "Unable to set direction for %s GPIO",
> +				 mctrl_gpios_desc[i].name);
> +			devm_gpiod_put(dev, gpios->gpio[i]);
> +			gpios->gpio[i] = NULL;
> +		}
> +	}
> +
> +out:
> +	return gpios;
> +}
> +EXPORT_SYMBOL_GPL(mctrl_gpio_init);
> +
> +void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios)
> +{
> +	enum mctrl_gpio_idx i;
> +
> +	if (!gpios)
> +		return;
> +
> +	for (i = 0; i < UART_GPIO_MAX; i++)
> +		if (!IS_ERR_OR_NULL(gpios->gpio[i])) {
> +			devm_gpiod_put(dev, gpios->gpio[i]);
> +			gpios->gpio[i] = NULL;

No need to NULL this variable. Instead, you should NULL
"gpios" entirely at the end of this function.

> +		}
> +	devm_kfree(dev, gpios);

gpios = NULL;
So this will indicate that its no more valid.

> +}
...

Thanks.
---
