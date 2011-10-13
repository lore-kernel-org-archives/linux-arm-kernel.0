From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Oct 2011 12:04:10 +0200
Subject: [PATCH 1/2] drivers: create a pin control subsystem v9
In-Reply-To: <CAPTzV16bKaHxoyWEv1H8HGyY_CZhY9orXAuWA-wa0yb2NZ5UcA@mail.gmail.com>
References: <1317629862-13549-1-git-send-email-linus.walleij@stericsson.com>
	<CAPTzV16bKaHxoyWEv1H8HGyY_CZhY9orXAuWA-wa0yb2NZ5UcA@mail.gmail.com>
Message-ID: <CACRpkdY3scxhAw8dKENq=u0GNpSrkdpe5vKCemG7EWGvmFYxQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 2:55 AM, Chanho Park <parkch98@gmail.com> wrote:

> Some gpio-ranges doesn't match with pin numbers.
> For example, gpio_range_b starts gpio 48.
> However, a pin base number of gpio_range_b is 96. It isn't same with gpio base.
> A pinctrl driver must know this pin_space-gpio_range mappings.

The GPIO pin space is one global space, and the only thing
the struct pinctrl_gpio_range does is to say that this pin range
is handled by this chip. You can register several ranges to the
same pin controller.

Then the pin control driver gets called like this:

pin_request(pctldev, pin, gpiostr, true, range);
ops->gpio_request_enable(pctldev, gpio_range, pin);

In this case you know that pin is an index into the range
supplied, note that we always get the range into the driver.

These ranges are defined by the driver as well, and it has
an .id field. Thus the driver shall add/subtract whatever offset
it needs to map that GPIO pin into a proper pin number,
there can be so many strange ways of doing this that the
pin control framework is not dealing with it.

So I think this should be done by the driver, and a clever
way is to use the .id field of the range as index to offset
arrays etc.

> +int pinctrl_get_device_gpio_range(unsigned gpio,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct pinctrl_dev **outdev,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct pinctrl_gpio_range **outrange)
> +{
> + ? ? ? struct pinctrl_dev *pctldev = NULL;
> +
> + ? ? ? /* Loop over the pin controllers */
> + ? ? ? mutex_lock(&pinctrldev_list_mutex);
> + ? ? ? list_for_each_entry(pctldev, &pinctrldev_list, node) {
> + ? ? ? ? ? ? ? struct pinctrl_gpio_range *range;
> +
> + ? ? ? ? ? ? ? range = pinctrl_match_gpio_range(pctldev, gpio);
> + ? ? ? ? ? ? ? if (range != NULL) {
> + ? ? ? ? ? ? ? ? ? ? ? *outdev = pctldev;
> + ? ? ? ? ? ? ? ? ? ? ? *outrange = range;
>
> missing mutex_unlock

Argh!

Thanks, fixed it.

Yours,
Linus Walleij
