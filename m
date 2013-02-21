From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Feb 2013 19:56:27 +0100
Subject: [PATCH v3 03/12] gpio: pxa: use platform data for gpio inverted
In-Reply-To: <1361164358-5845-4-git-send-email-haojian.zhuang@linaro.org>
References: <1361164358-5845-1-git-send-email-haojian.zhuang@linaro.org>
 <1361164358-5845-4-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdZsTZg7m1C3X9kD3Dd7+awN2eWM4M7PFD6RTSPkEOnMnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 18, 2013 at 6:12 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Avoid to judge whether gpio is inverted by identifying cpu in gpio
> driver. Move this into platform data of gpio driver.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
(...)
> -static inline int __gpio_is_inverted(int gpio)
> +static inline int __gpio_is_inverted(struct pxa_gpio_chip *chip, int gpio)

Take this opportunity to rename the function pxa_gpio_is_inverted().
__notation should be used for other things IMO.

Also, this function should return a bool.

>  {
> -       if ((gpio_type == PXA26X_GPIO) && (gpio > 85))
> +       if ((chip->inverted) && (gpio > 85))

Add a comment explaining why only GPIOs > 85 may be
inverted.

>                 return 1;
>         return 0;

return true or false.

> -static inline int __gpio_is_occupied(unsigned gpio)
> +static inline int __gpio_is_occupied(struct pxa_gpio_chip *chip, unsigned gpio)

pxa_gpio_is_occupied()

> -               if (__gpio_is_inverted(gpio))
> +               if (__gpio_is_inverted(chip, gpio))

So it is obviously used as a bool so make it a bool.

> +       chip = container_of(gc, struct pxa_gpio_chip, chip);
> +

Many drivers define a helper macro for this, something
like TO_PXA_GPIO(). But just a hint.

> +       /* It's only valid for PXA26x */
> +       if (of_find_property(np, "marvell,gpio-inverted", NULL))
> +               pdata->inverted = true;

of_property_read_bool()

And add it to the binding document, right?

Yours,
Linus Walleij
