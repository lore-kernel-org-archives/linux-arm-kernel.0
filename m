From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 2 Jun 2015 15:33:41 +0200
Subject: [PATCH v2 2/6] gpio: brcmstb: Add interrupt support
In-Reply-To: <1432865650-4062-3-git-send-email-gregory.0xf0@gmail.com>
References: <1432865650-4062-1-git-send-email-gregory.0xf0@gmail.com>
 <1432865650-4062-3-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <CACRpkdayrD59LyQH+W7-A1n3CF5yKRjggm2f0LmEgmc7+DEyVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 29, 2015 at 4:14 AM, Gregory Fong <gregory.0xf0@gmail.com> wrote:

> Create an irq_chip for each GIO block.  Uses chained IRQ handling since
> known uses of this block have a BCM7120 L2 interrupt controller as a
> parent.  Supports interrupts for all GPIOs.
>
> In the IRQ handler, we check for raised IRQs for invalid GPIOs and warn
> (ratelimited) if they're encountered.
>
> Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
> ---
> v2:
> - since imask member of bank struct was removed, just read and write from mask
>   reg and don't maintain a shadow
> - warn on invalid IRQs
> - move some irq setup to a separate function since probe is getting unwieldy

This patch basically painfully reimplements GPIOLIB_IRQCHIP.

Is there a reason for not using that generic mechanism?

> +static int brcmstb_gpio_to_irq(struct gpio_chip *gc, unsigned gc_offset)
> +{
> +       struct brcmstb_gpio_priv *priv = brcmstb_gpio_gc_to_priv(gc);
> +       /* gc_offset is relative to this gpio_chip; want real offset */
> +       int offset = gc_offset + (gc->base - priv->gpio_base);
> +
> +       if (offset >= priv->num_gpios)
> +               return -ENXIO;
> +       return irq_create_mapping(priv->irq_domain, offset);

It is a no-no to rely on .to_irq() to be called before using an IRQ
from a GPIO chip.

The gpiochip and irq_chip APIs are orthogonal, and a user may
request an interrupt from the irqchip without calling .to_irq() on any
GPIO line first.

This should only use irq_find_mapping().

irq_create_mapping() needs to be called on all available
offsets during probe.

If the module is removable or at error path it also needs
to call irq_dispose_mapping() on all lines. Also this is handled
by GPIOLIB_IRQCHIP, and that is why it should always be
used, if possible.

Yours,
Linus Walleij
