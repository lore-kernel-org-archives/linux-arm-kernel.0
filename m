From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 17 Feb 2014 22:37:11 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MyAxLzddIHR0eS9zZXJpYWw6IEFkZCBHUElPTElCIGhl?=
 =?UTF-8?B?bHBlcnMgZm9yIGNvbnRyb2xsaW5nIG1vZGVtIGxpbmVz?=
In-Reply-To: <1392656247-3351-2-git-send-email-richard.genoud@gmail.com>
References: <1392656247-3351-1-git-send-email-richard.genoud@gmail.com>
 <1392656247-3351-2-git-send-email-richard.genoud@gmail.com>
Message-ID: <1392662231.122430857@f359.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

A few comments below..

???????????, 17 ??????? 2014, 17:57 +01:00 ?? Richard Genoud <richard.genoud@gmail.com>:
> This patch add some helpers to control modem lines (CTS/RTS/DSR...) via
> GPIO.
> This will be useful for many boards which have a serial controller that
> only handle CTS/RTS pins (or even just RX/TX).
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> ---
...
> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
...
> +static const struct {
> +	const char *name;
> +	unsigned int mctrl;
> +	bool dir_out;
> +} mctrl_gpios_desc[] = {
> +	{ "cts", TIOCM_CTS, false, },
> +	{ "dsr", TIOCM_DSR, false, },
> +	{ "dcd", TIOCM_CD, false, },
> +	{ "ri", TIOCM_RI, false, },
> +	{ "rts", TIOCM_RTS, true, },
> +	{ "dtr", TIOCM_DTR, true, },
> +	{ "out1", TIOCM_OUT1, true, },
> +	{ "out2", TIOCM_OUT2, true, },
> +};
> +
> +void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
> +{
> +	enum mctrl_gpio_idx i;
> +
> +	for (i = 0; i < UART_GPIO_MAX; i++)

Use ARRAY_SIZE(mctrl_gpios_desc) here and elsewhere below.

> +		if (!IS_ERR_OR_NULL(gpios->gpio[i]) &&
> +		    mctrl_gpios_desc[i].dir_out)
> +			gpiod_set_value(gpios->gpio[i],
> +					!!(mctrl & mctrl_gpios_desc[i].mctrl));
> +}
> +EXPORT_SYMBOL_GPL(mctrl_gpio_set);
> +
> +unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios, unsigned int *mctrl)
> +{

Why you want to put mctrl as parameter here?
Let's return mctrl from GPIOs, then handle this value as you want int the driver.

> +	enum mctrl_gpio_idx i;
> +
> +	for (i = 0; i < UART_GPIO_MAX; i++) {
> +		if (!IS_ERR_OR_NULL(gpios->gpio[i]) &&
> +		    !mctrl_gpios_desc[i].dir_out) {
> +			if (gpiod_get_value(gpios->gpio[i]))
> +				*mctrl |= mctrl_gpios_desc[i].mctrl;
> +			else
> +				*mctrl &= ~mctrl_gpios_desc[i].mctrl;
> +		}
> +	}
> +
> +	return *mctrl;
> +}
> +EXPORT_SYMBOL_GPL(mctrl_gpio_get);
> +

> +int mctrl_gpio_init(struct device *dev, struct mctrl_gpios *gpios)
> +{

I suggest to allocate "gpios" here and return pointer to this structure
or ERR_PTR(). Additionally, as I mentioned before, add "index" variable
to specify port number.

> +	enum mctrl_gpio_idx i;
> +	int err = 0;
> +	int ret = 0;
> +
> +	for (i = 0; i < UART_GPIO_MAX; i++) {
> +		gpios->gpio[i] = devm_gpiod_get(dev, mctrl_gpios_desc[i].name);
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
> +			dev_err(dev, "Unable to set direction for %s GPIO",
> +				mctrl_gpios_desc[i].name);
> +			devm_gpiod_put(dev, gpios->gpio[i]);
> +			gpios->gpio[i] = NULL;
> +			ret--;
> +		}
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(mctrl_gpio_init);
...
> diff --git a/drivers/tty/serial/serial_mctrl_gpio.h b/drivers/tty/serial/serial_mctrl_gpio.h
...
> +enum mctrl_gpio_idx {
> +	UART_GPIO_CTS,
> +	UART_GPIO_DSR,
> +	UART_GPIO_DCD,
> +	UART_GPIO_RI,
> +	UART_GPIO_RTS,
> +	UART_GPIO_DTR,
> +	UART_GPIO_OUT1,
> +	UART_GPIO_OUT2,
> +	UART_GPIO_MAX,
> +};
> +
> +struct mctrl_gpios {
> +	struct gpio_desc *gpio[UART_GPIO_MAX];

struct gpio_desc *gpio;

...
> +static inline
> +int mctrl_gpio_init(struct device *dev, struct mctrl_gpios *gpios)
> +{
> +	return -UART_GPIO_MAX;

return -ENOSYS;

...

Thanks.
---
