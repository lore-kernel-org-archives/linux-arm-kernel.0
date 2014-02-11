From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Tue, 11 Feb 2014 22:23:06 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAxLzRdIHR0eS9zZXJpYWw6IEFkZCBHUElPTElCIGhl?=
 =?UTF-8?B?bHBlcnMgZm9yIGNvbnRyb2xsaW5nIG1vZGVtIGxpbmVz?=
In-Reply-To: <1392140715-15295-2-git-send-email-richard.genoud@gmail.com>
References: <1392140715-15295-1-git-send-email-richard.genoud@gmail.com>
 <1392140715-15295-2-git-send-email-richard.genoud@gmail.com>
Message-ID: <1392142986.607813065@f171.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

???????, 11 ??????? 2014, 18:45 +01:00 ?? Richard Genoud <richard.genoud@gmail.com>:
> This patch add some helpers to control modem lines (CTS/RTS/DSR...) via
> GPIO.
> This will be useful for many boards which have a serial controller that
> only handle CTS/RTS pins (or even just RX/TX).
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> ---

OK, a few comments below.

...
> +config SERIAL_MCTRL_GPIO
> +	def_bool y
> +	depends on GPIOLIB

I suggest to move GPIOLIB dependency to serial_mctrl_gpio.h header, so
unit can be used with or without GPIOLIB, so Kconfig will look something like this:

config SERIAL_MCTRL_GPIO
  tristate

Then, you can select this option for particular UART:
config SERIAL_ATMEL
  ...
  select SERIAL_MCTRL_GPIO

...
> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
...
> +static const char *mctrl_gpio_of_names[UART_GPIO_MAX] = {
> +	"cts", "dsr", "dcd", "ri", "rts", "dtr"
> +};

Make a combined array. This will use cycles for set/get operations.

static struct {
  const char *name;
  unsigned int mctrl;
} mctrl_gpios[] = {
  { "cts", TIOCM_CTS, },
  ...
};

...
> +int mctrl_gpio_init(struct device *dev, struct mctrl_gpios *gpios)
> +{

I'm not sure whether to make a non-DT support at all ...

> +	enum mctrl_gpio_idx i;
> +	int err = 0;
> +	int ret = 0;
> +
> +	for (i = UART_GPIO_MIN; i < UART_GPIO_MAX; i++) {
> +		gpios->gpio[i] = gpiod_get(dev, mctrl_gpio_of_names[i]);

What a reason to using gpiod_xxx() ?
Why we cannot use standart devm_gpio_request/get/set etc. ?

In addition, I recommend create this patch as separate,
because it will most likely still be comments later.
Thanks.

---
