From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Aug 2015 13:11:01 +0200
Subject: [PATCH v4 2/4] gpio: brcmstb: Add interrupt and wakeup source
 support
In-Reply-To: <1438391865-7862-3-git-send-email-gregory.0xf0@gmail.com>
References: <1438391865-7862-1-git-send-email-gregory.0xf0@gmail.com>
 <1438391865-7862-3-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <CACRpkdaz3k_N1qS5M_jmprPz8fHXeLtTke_YT8i2gaehmme+OQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 1, 2015 at 3:17 AM, Gregory Fong <gregory.0xf0@gmail.com> wrote:

> Uses the gpiolib irqchip helpers.  For this to work, the irq setup
> function is called once per bank instead of once per device.  Note
> that all known uses of this block have a BCM7120 L2 interrupt
> controller as a parent.  Supports interrupts for all GPIOs.
>
> In the IRQ handler, we check for raised IRQs for invalid GPIOs and
> warn (ratelimited) if they're encountered.
>
> Also, several drivers (e.g. gpio-keys) allow for GPIOs to be
> configured as wakeup sources, and this GPIO controller supports that
> through a separate interrupt path.
>
> The de-facto standard DT property "wakeup-source" is checked, since
> that indicates whether the GPIO controller hardware can wake.  Uses
> the IRQCHIP_MASK_ON_SUSPEND irq_chip flag because UPG GIO doesn't have
> any of its own wakeup source configuration.
>
> Aside regarding gpiolib irqchip helpers: It wasn't obvious (to me)
> that you can have multiple chained irqchips and associated IRQ domains
> for a single parent IRQ, and as long as the xlate function is written
> correctly, a GPIO IRQ request end up checking the correct domain and
> will get associated with the correct IRQ.  What helps make this clear
> is to read
>   drivers/gpio/gpiolib-of.c:
>    - of_gpiochip_find_and_xlate()
>    - of_get_named_gpiod_flags()
>   drivers/gpio/gpiolib.c:
>    - gpiochip_find()
>
> Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
> ---
> v4:
> - when checking parent_irq, use <= 0 or > 0 since 0 is NO_IRQ.

Patch applied, but:


> +       if (of_property_read_bool(np, "interrupt-controller")) {
> +               priv->parent_irq = platform_get_irq(pdev, 0);
> +               if (priv->parent_irq <= 0) {
> +                       dev_err(dev, "Couldn't get IRQ");
> +                       return -ENOENT;
> +               }
> +       } else {
> +               priv->parent_irq = -ENOENT;
> +       }
> +
>         if (brcmstb_gpio_sanity_check_banks(dev, np, res))
>                 return -EINVAL;

This patch does not apply cleanly because the version in my
tree has INIT_LIST_HEAD(&priv->bank_list);
before the sanity check.

I applied it manually, but check that things are working right.

Yours,
Linus Walleij
