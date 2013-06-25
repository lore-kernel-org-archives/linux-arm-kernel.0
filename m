From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 25 Jun 2013 15:16:18 -0600
Subject: [PATCH] pinctrl: elaborate a bit on arrangements in doc
In-Reply-To: <1372169952-22439-1-git-send-email-linus.walleij@stericsson.com>
References: <1372169952-22439-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <51CA08A2.4030204@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2013 08:19 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This elaborates a bit on the pinctrl vs GPIO arangements
> in the hardware.
> 
> Inspired by some drawings in a mail from Christian
> Ruppert.

> diff --git a/Documentation/pinctrl.txt b/Documentation/pinctrl.txt

> +The GPIO portions of a pin and its relation to a certain pin controller
> +logic can be constructed in several ways. Here are three examples:
> +
> +(A)
> +
> +                                         +- SPI
> +     Physical pins --- GPIO --- pinctrl -+- I2C
> +                                         +- mmc
> +
> +(B)
> +                    +- GPIO
> +     Physical pins -+           +- SPI
> +                    +- pinctrl -+- I2C
> +                                +- mmc
> +
> +(C)
> +                                +- SPI
> +     Physical pins --- pinctrl -+- I2C
> +                                +- mmc
> +                                +- GPIO

I'm not really sure quite what these diagrams are attempting to convey
within the context of this document.

> +In (A) the GPIO-like functionality of the pin is *always* available.

Well, that can't really be true.

It may be possible that you can always read the physical pin's value via
a GPIO input register.

However, you obviously can't always write to a GPIO output register to
set the pin's value. If you could, the pin would simply be a GPIO, and
never serve any other function.

If you're saying that it's always possible to put the pin into a mode
where you can use the GPIO output register to driver the pin value, well
then that's just regular pin-muxing, so I'm not sure why it's worth
mentioning.

In (a) there are really two levels of pinmux configuration, one in the
GPIO HW block (GPIO-vs-whatever-pinctrl-selects).

In (b) there is another level of pinmux configuration; some block has to
exist between the physical pins and both GPIO/pinctrl HW modules; it
simply isn't drawn in the diagram

Diagram (c) appears complete.

In all cases though, this is just attempting to enumerate different HW
designs for pin-muxing I think. Isn't it better to just let each SoC's
datasheet specify exactly how things are hooked up?
