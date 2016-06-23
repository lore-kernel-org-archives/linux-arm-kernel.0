From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 Jun 2016 10:54:05 +0200
Subject: [PATCH 1/2 v2] gpio: omap: make gpio numbering deterministical by
 using of aliases
In-Reply-To: <1465930632-18941-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1465930632-18941-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1465930632-18941-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CACRpkdYHHLyBTJYPw_pMds0z-BtPPHf7mEcjE2ayTw7jRqNDdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looping in DT people.

Please send subsequent patches also to devicetree at vger.kernel.org

On Tue, Jun 14, 2016 at 8:57 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

> Traditionally the n-th gpio device probed by the omap gpio driver got
> the gpio number range [n*32 .. n*32+31].
> When order of the devices probed by the driver changes (which can happen
> already now when some devices have a pinctrl and so the first probe
> attempt returns -ENODEV) the numbering changes.
>
> To ensure a deterministical numbering use of_alias_get_id to determine
> the base for a given device. If no respective alias exists fall back to
> the traditional numbering.
>
> For the unusual case where only a part of the gpio devices have a
> matching alias some of them might fail to probe. But if none of them has
> an alias or all, there is no conflict which should be good enough to
> maintain backward compatibility.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/gpio/gpio-omap.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index b98ede78c9d8..4d91792e7266 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1053,9 +1053,26 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
>                         bank->chip.parent = &omap_mpuio_device.dev;
>                 bank->chip.base = OMAP_MPUIO(0);
>         } else {
> +               int gpio_alias_id __maybe_unused;
> +
>                 bank->chip.label = "gpio";
> -               bank->chip.base = gpio;
> +
> +#if defined(CONFIG_OF_GPIO)
> +               /*
> +                * Traditionally the base is given out in first-come-first-serve
> +                * order.  This might shuffle the numbering of gpios if the
> +                * probe order changes.  So make the base deterministical if the
> +                * device tree specifies alias ids.
> +                */
> +               gpio_alias_id = of_alias_get_id(bank->chip.of_node, "gpio");
> +               if (gpio_alias_id >= 0)
> +                       bank->chip.base = bank->width * gpio_alias_id;
> +               else
> +#endif
> +                       bank->chip.base = gpio;
>         }
> +
> +

I need:

- A hunk of the patch to hit
  Documentation/devicetree/bindings/gpio/gpio.txt
  and describe the alias usage there

-  an ACK from a DT bindings maintainer for this.

Yours,
Linus Walleij
