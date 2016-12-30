From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Dec 2016 14:17:38 +0100
Subject: [PATCH 10/20] gpio: pca953x: Add optional reset gpio control
In-Reply-To: <1483050455-10683-11-git-send-email-steve_longerbeam@mentor.com>
References: <1483050455-10683-1-git-send-email-steve_longerbeam@mentor.com>
 <1483050455-10683-11-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <CACRpkdZG2j4_LwP8KUVBTOtXma75YvYtC6CW1QqYwOm-MOZgHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 29, 2016 at 11:27 PM, Steve Longerbeam
<slongerbeam@gmail.com> wrote:

> Add optional reset-gpios pin control. If present, de-assert the
> specified reset gpio pin to bring the chip out of reset.
>
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: linux-gpio at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org

This seems like a separate patch from the other 19 patches so please send it
separately so I can handle logistics easier in the future.


> @@ -133,6 +134,7 @@ struct pca953x_chip {
>         const char *const *names;
>         unsigned long driver_data;
>         struct regulator *regulator;
> +       struct gpio_desc *reset_gpio;

Why do you even keep this around in the device state container?

As you only use it in the probe() function, use a local variable.

The descriptor will be free():ed by the devm infrastructure anyways.

> +               /* see if we need to de-assert a reset pin */
> +               chip->reset_gpio = devm_gpiod_get_optional(&client->dev,
> +                                                          "reset",
> +                                                          GPIOD_OUT_LOW);
> +               if (IS_ERR(chip->reset_gpio)) {
> +                       dev_err(&client->dev, "request for reset pin failed\n");
> +                       return PTR_ERR(chip->reset_gpio);
> +               }

Nice.

> +               if (chip->reset_gpio) {
> +                       /* bring chip out of reset */
> +                       dev_info(&client->dev, "releasing reset\n");
> +                       gpiod_set_value(chip->reset_gpio, 0);
> +               }

Is this really needed given that you set it low in the
devm_gpiod_get_optional()?

Yours,
Linus Walleij
