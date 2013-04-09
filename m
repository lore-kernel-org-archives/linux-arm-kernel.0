From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 9 Apr 2013 10:23:03 +0200
Subject: [PATCH 2/3] pinctrl: exynos5440: add gpio interrupt support
In-Reply-To: <1364310754-3692-3-git-send-email-kgene.kim@samsung.com>
References: <1364310754-3692-1-git-send-email-kgene.kim@samsung.com>
 <1364310754-3692-3-git-send-email-kgene.kim@samsung.com>
Message-ID: <CACRpkdbEUe1NkOY7wR2FU+0Y=D5Qd=Lu2Zvv=TPBBCbWja0HMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 26, 2013 at 4:12 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:

> From: Thomas Abraham <thomas.ab@samsung.com>
>
> Exynos5440 supports gpio interrupts on gpios 16 to 23. The eight interrupt lines
> originating from the pin-controller are connected to the gic. Add irq-chip support
> for these interrupts.
>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

Basically really nice. Patch has been applied, but some comments
for future reference:

> +/* gpiolib gpio_to_irq callback function */
> +static int exynos5440_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
> +{
> +       struct exynos5440_pinctrl_priv_data *priv = dev_get_drvdata(gc->dev);
> +       unsigned int virq;

I'm a bit annoyed by use of the abbreviation "virq" as if the IRQs were
"virtual", they are not - this implies that the Linux IRQ numbers are not
"real" or something.

I use the nomenclature:

irq = Linux IRQ
hwirq = whatever offset that IRQ has in the hardware IRQ controller.

virq I think is confusing...

> +static irqreturn_t exynos5440_gpio_irq(int irq, void *data)
> +{
> +       struct exynos5440_gpio_intr_data *intd = data;
> +       struct exynos5440_pinctrl_priv_data *d = intd->priv;
> +       int virq;
> +
> +       virq = irq_linear_revmap(d->irq_domain, intd->gpio_int);
> +       if (!virq)
> +               return IRQ_NONE;
> +       generic_handle_irq(virq);
> +       return IRQ_HANDLED;
> +}

Same here. Actually, I guess irq_linear_revmap works here,
but irq_find_mapping(domain, hwirq) is more archaic, could
you test if that works as well and make a follow-up patch to
change it?

Yours,
Linus Walleij
