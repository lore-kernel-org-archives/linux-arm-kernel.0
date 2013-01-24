From: highguy@gmail.com (Stijn Devriendt)
Date: Thu, 24 Jan 2013 13:02:38 +0100
Subject: [PATCH 6/6 v14] gpio: Add block gpio to several gpio drivers
In-Reply-To: <1358856404-8975-7-git-send-email-stigge@antcom.de>
References: <1358856404-8975-1-git-send-email-stigge@antcom.de>
 <1358856404-8975-7-git-send-email-stigge@antcom.de>
Message-ID: <CAOY=C6H5xETt5UNXUfRkGW9q+bj0y2R3sXNvW87XXvQcYoL_-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 1:06 PM, Roland Stigge <stigge@antcom.de> wrote:
> This patch adds block GPIO support to several gpio drivers.
>
> This implements block GPIO only for some selected drivers since block GPIO is
> an optional feature which may not be suitable for every GPIO hardware. (With
> automatic fallback to the single GPIO functions if not available in a driver.)
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>
>
> For pinctrl-at91.c:
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>
> ---
>
> +static void lpc32xx_gpio_set_block_p3(struct gpio_chip *chip,
> +                                     unsigned long mask,
> +                                     unsigned long values)
> +{
> +       struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
> +       u32 set_bits = values & mask;
> +       u32 clr_bits = ~values & mask;
> +
> +       /* States of GPIO 0-5 start at bit 25 */
> +       set_bits <<= 25;
> +       clr_bits <<= 25;
> +
> +       /* Note: On LPC32xx, GPOs can only be set at once or cleared at once,
> +        *       but not set and cleared at once
> +        */
> +       if (set_bits)
> +               __raw_writel(set_bits, group->gpio_grp->outp_set);
> +       if (clr_bits)
> +               __raw_writel(clr_bits, group->gpio_grp->outp_clr);
> +}
> +

In my patch, I go out of the way of this kind of thing for a simple reason:
You may generate incorrect timing by doing this.

As a fictive example, consider the i2c-bitbang driver, which you could optimize
by using block-gpio with sda/scl in a single block. By offering the
block-gpio API
even when you cannot set all bits at once, you could cause timing issues.
You might be toggling the clock line before pushing out data, for example.

The same holds below, for a driver that has separate hi/lo bits.

Regards,
Stijn
