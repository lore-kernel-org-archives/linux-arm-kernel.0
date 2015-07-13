From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Jul 2015 14:58:22 +0200
Subject: [PATCH v3 3/4] gpio: brcmstb: Add interrupt and wakeup source
 support
In-Reply-To: <1434589243-502-4-git-send-email-gregory.0xf0@gmail.com>
References: <1434589243-502-1-git-send-email-gregory.0xf0@gmail.com>
 <1434589243-502-4-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <CACRpkdYNGdWHk1kqhFWHziLPy3mZXTcUjYFBCVo5dRCh60bQ_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 3:00 AM, Gregory Fong <gregory.0xf0@gmail.com> wrote:

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

Sorry for the unclarities, this is a bit hairy. Suggestions as to
how we can make it easier and/or bring code for this into gpiolib
are welcome. Right now I have a hard time seeing any way to
make this more generic and helpful :/

Overall this patch looks real nice. Some nitpicks below.

> @@ -164,6 +398,16 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
>         priv->reg_base = reg_base;
>         priv->pdev = pdev;
>
> +       if (of_property_read_bool(np, "interrupt-controller")) {
> +               priv->parent_irq = platform_get_irq(pdev, 0);
> +               if (priv->parent_irq < 0) {

This should be <= 0 since 0 is NO_IRQ

> +                       dev_err(dev, "Couldn't get IRQ");
> +                       return -ENOENT;
> +               }
> +       } else {
> +               priv->parent_irq = -ENOENT;
> +       }

Why should this code only execute if the node is marked
"interrupt-controller"? It makes it seem like IRQs cannot arrive
to it unless it is intended to serve other consumers.

Maybe in practice this is true, but...

> +               if (priv->parent_irq >= 0) {
> +                       err = brcmstb_gpio_irq_setup(pdev, bank);
> +                       if (err)
> +                               goto fail;
> +               }

Again 0 is NO_IRQ so this should be > 0 not >= 0.

Yours,
Linus Walleij
