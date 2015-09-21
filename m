From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 Sep 2015 16:42:09 -0700
Subject: [PATCH v2 3/3] gpiolib: Add GPIO initialization
In-Reply-To: <1440920686-6892-4-git-send-email-mpa@pengutronix.de>
References: <1440920686-6892-1-git-send-email-mpa@pengutronix.de>
 <1440920686-6892-4-git-send-email-mpa@pengutronix.de>
Message-ID: <CACRpkdZTN9_t=pUFQTWzaWoqhRBtn7XPEQjo6zUEMoJJBZmDzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 30, 2015 at 12:44 AM, Markus Pargmann <mpa@pengutronix.de> wrote:

> This functions adds a way to initialize a GPIO without hogging it.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

(...)

> -The GPIO chip may contain GPIO hog definitions. GPIO hogging is a mechanism
> -providing automatic GPIO request and configuration as part of the
> -gpio-controller's driver probe function.
> +The GPIO chip may contain GPIO definitions. These define properties for single
> +GPIOs of this controller.

Insert text like this:

There are two types of GPIO definitions:

- GPIO hogs are ...

- GPIO initializers are ...

This list form is easier to understand.

> -Each GPIO hog definition is represented as a child node of the GPIO controller.
> +GPIO hogging is a mechanism providing automatic GPIO request and configuration
> +as part of the gpio-controller's driver probe function.
> +
> +GPIO initialization provides an automatic initialization to known save values.
> +Instead of GPIO hogging the GPIO's value and direction can be modified by other
> +users after it was initialized.
> +
> +Each GPIO definition is represented as a child node of the GPIO controller.
>  Required properties:
> -- gpio-hog:   A property specifying that this child node represent a GPIO hog.
>  - gpios:      Store the GPIO information (id, flags, ...). Shall contain the
>               number of cells specified in its parent node (GPIO controller
>               node).
> -Only one of the following properties scanned in the order shown below.
> -This means that when multiple properties are present they will be searched
> -in the order presented below and the first match is taken as the intended
> -configuration.
> +
> +Optional properties:
> +- line-name:  The GPIO label name. If not present the node name is used.
> + Only one of gpio-hog and gpio-initval may be specified.

This is confusing. Instead write: "The two following options are
mutually exclusive. One of them must be specified, but not both."

> +- gpio-hog:   A property specifying that this child node represent a GPIO hog.
> +- gpio-initval: This GPIO should be initialized to the specified configuration.

> + Only one of input, output-low and output-high may be specified:

Insert "Of the following arguments, only one..." (etc)

>  - input:      A property specifying to set the GPIO direction as input.
>  - output-low  A property specifying to set the GPIO direction as output with
>               the value low.
>  - output-high A property specifying to set the GPIO direction as output with
>               the value high.
>
> -Optional properties:
> -- line-name:  The GPIO label name. If not present the node name is used.
> -
>  Example of two SOC GPIO banks defined as gpio-controller nodes:

(...)
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -234,6 +234,15 @@ static void of_gpiochip_scan_gpios(struct gpio_chip *chip)
>
>                         if (gpiod_hog(desc, lflags, dflags))
>                                 continue;
> +               } else if (of_property_read_bool(np, "gpio-initval")) {
> +                       if (!dflags) {
> +                               dev_warn(chip->dev, "GPIO line %d (%s): no initialization state specified, bailing out\n",
> +                                        desc_to_gpio(desc), np->name);
> +                               continue;
> +                       }
> +
> +                       if (gpiod_initialize(desc, lflags, dflags))
> +                               continue;

We usually do not mix implementations and bindings but it's OK with me.

>                 }

You need a terminating  else {} - clause to warn if neither of gpio-hog
or gpio-initval is specified.

> -int gpiod_hog(struct gpio_desc *desc, unsigned long lflags,
> -             enum gpiod_flags dflags)
> +static int _gpiod_initialize(struct gpio_desc *desc, unsigned long lflags,
> +                     enum gpiod_flags dflags)

I don't like _underscore functions. Try to find a name that is descriptive
and does not begin with underscore.

What about just gpiod_init()?

>         if (status < 0) {
>                 pr_err("setup of hog GPIO %s (chip %s, offset %d) failed\n",
> -                      name, gpiod_to_chip(desc)->label, gpio_chip_hwgpio(desc));
> +                      name, gpiod_to_chip(desc)->label,
> +                      gpio_chip_hwgpio(desc));

Looks like a random, unrelated code reshuffling. Don't do this.

Yours,
Linus Walleij
