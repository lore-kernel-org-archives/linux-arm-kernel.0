From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 Feb 2013 16:23:00 +0100
Subject: [PATCH v8 04/12] pinctrl: verify whether gpio chip overlapps range
In-Reply-To: <1360602659-4774-5-git-send-email-haojian.zhuang@linaro.org>
References: <1360602659-4774-1-git-send-email-haojian.zhuang@linaro.org>
 <1360602659-4774-5-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdaU2mWQa3qMmLKmxF5zxTq40zD30KyxdotagjjWUvopzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 11, 2013 at 6:10 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

>  /**
> + * pinctrl_overlapped_gpio_range() - check if the GPIO chip of a certain GPIO
> + * pin is overlapped with gpio range.
> + * @gpio: gpio pin to check taken from the global GPIO pin space
> + *
> + * This function is complement of pinctrl_match_gpio_range(). If the return
> + * value of pinctrl_match_gpio_range() is NULL, this function could be used
> + * to check whether pinctrl device is ready or not. Maybe some GPIO pins
> + * don't have back-end pinctrl interface.
> + * If the return value is true, it means that pinctrl device is ready & the
> + * certain GPIO pin doesn't have back-end pinctrl device. If the return value
> + * is false, it means that pinctrl device may not be ready.
> + */
> +static bool pinctrl_overlapped_gpio_range(unsigned gpio)

The name of this function confuses me, can we name it something
like:

pinctrl_gpio_is_in_some_chip_but_no_range()

Which is actually what you test, right?

> +{
> +       struct pinctrl_dev *pctldev;
> +       struct pinctrl_gpio_range *range = NULL;
> +       struct gpio_chip *chip = gpio_to_chip(gpio);

Handle if chip happens to become NULL here.

> +       /* Loop over the pin controllers */
> +       list_for_each_entry(pctldev, &pinctrldev_list, node) {
> +               /* Loop over the ranges */
> +               list_for_each_entry(range, &pctldev->gpio_ranges, node) {
> +                       /* Check if any gpio range overlapped with gpio chip */
> +                       if (range->base + range->npins - 1 < chip->base ||
> +                           range->base > chip->base + chip->ngpio - 1)
> +                               continue;
> +                       return true;
> +               }
> +       }
> +       return false;
> +}
> +
> +/**
>   * pinctrl_get_device_gpio_range() - find device for GPIO range
>   * @gpio: the pin to locate the pin controller for
>   * @outdev: the pin control device if found
> @@ -459,6 +493,8 @@ int pinctrl_request_gpio(unsigned gpio)
>
>         ret = pinctrl_get_device_gpio_range(gpio, &pctldev, &range);
>         if (ret) {
> +               if (pinctrl_overlapped_gpio_range(gpio))
> +                       ret = 0;

If you change the name of the function like above this call can be understood,
but maybe also add a comment above this call explaining the situation.

Yours,
Linus Walleij
