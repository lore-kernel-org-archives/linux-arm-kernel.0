From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Jun 2018 10:38:11 +0200
Subject: [PATCH 3/3] pinctrl: actions: Add interrupt support for OWL S900
 SoC
In-Reply-To: <20180602165415.30956-4-manivannan.sadhasivam@linaro.org>
References: <20180602165415.30956-1-manivannan.sadhasivam@linaro.org>
 <20180602165415.30956-4-manivannan.sadhasivam@linaro.org>
Message-ID: <CACRpkdbRYQ7Wf48Ff-n-OiheW+Dv1yyJQ3NNzGdBx5dvM51YPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 2, 2018 at 6:54 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add interrupt support for Actions Semi OWL S900 SoC.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
(...)

> +++ b/drivers/pinctrl/actions/Kconfig
> @@ -5,6 +5,7 @@ config PINCTRL_OWL
>         select PINCONF
>         select GENERIC_PINCONF
>         select GPIOLIB
> +       select GPIOLIB_IRQCHIP

I don't think you're really using that (certain sign: you're implementing
.to_irq().)

GPIOLIB_IRQCHIP is nice, but can only be used when there is
a 1-1 correspondence betweem GPIO line offsets and
IRQ lines and they are numbered 0..n.

However I think you can use it! Look below for my reference
to the tegra186 and how you can probably cut out the custom
irqdomain with some manouvers.

> +       struct owl_pinctrl *pctrl = irq_data_get_irq_chip_data(data);
> +       const struct owl_gpio_port *port;
(...)
> +       unsigned int gpio = data->hwirq;
> +
> +       port = owl_gpio_get_port(pctrl, &gpio);
> +
> +       gpio_base = pctrl->base + port->offset;

It is all about this calculation really.

> +static int owl_gpio_irq_set_type(struct irq_data *data, unsigned int type)
> +{
> +       struct owl_pinctrl *pctrl = irq_data_get_irq_chip_data(data);
> +       const struct owl_gpio_port *port;
> +       void __iomem *gpio_base;
> +       unsigned long flags;
> +       unsigned int gpio = data->hwirq;
> +       unsigned int offset, value, irq_type = 0;
> +
> +       port = owl_gpio_get_port(pctrl, &gpio);
> +       if (WARN_ON(port == NULL))
> +               return -ENODEV;
> +
> +       gpio_base = pctrl->base + port->offset;
> +
> +       switch (type) {
> +       case IRQ_TYPE_EDGE_RISING:
> +               irq_type = OWL_GPIO_INT_EDGE_RISING;
> +               break;
> +
> +       case IRQ_TYPE_EDGE_FALLING:
> +               irq_type = OWL_GPIO_INT_EDGE_FALLING;
> +               break;

Very often things such as keys will request trigger on
both edges. This means IRQ_TYPE_EDGE_RISING
and IRQ_TYPE_EDGE_FALLING are both set, which
will cause you problems here, since it is unhandled.

I guess it is fine to set both?

> +       offset = gpio < 16 ? 4 : 0;

I think even the compiler should suggest putting he (gpio < 16)
expression in paranthesis.

> +       value = readl_relaxed(gpio_base + port->intc_type + offset);
> +       value &= ~(OWL_GPIO_INT_MASK << ((gpio % 16) * 2));
> +       value |= irq_type << ((gpio % 16) * 2);
> +       writel_relaxed(value, gpio_base + port->intc_type + offset);
> +
> +       raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> +
> +       if (type & IRQ_TYPE_EDGE_BOTH)
> +               irq_set_handler_locked(data, handle_edge_irq);
> +       else
> +               irq_set_handler_locked(data, handle_level_irq);

Here you handle both edges, but not in the switch clause.

> +static void owl_gpio_irq_handler(struct irq_desc *desc)

This looks fine.

> +static struct irq_chip owl_gpio_irq_chip = {
> +       .name           = "owlgpio",
> +       .irq_mask       = owl_gpio_irq_mask,
> +       .irq_unmask     = owl_gpio_irq_unmask,
> +       .irq_ack        = owl_gpio_irq_ack,
> +       .irq_set_type   = owl_gpio_irq_set_type,
> +};

If you implement your own irqchip you need to implement
.irq_request_resources and .irq_free_resources locking the GPIO
lines for interrupt, see other drivers that do this or the
gpiolib core code in gpiolib.c.

It would be really neat if you could instead use the
GPIOLIB_IRQCHIP though, but I know it will be a bit tricky
and maybe not possible.

> +       for (i = 0; i < pctrl->soc->nports; i++) {
> +               irq_set_chained_handler_and_data(pctrl->irq[i],
> +                                               owl_gpio_irq_handler,
> +                                               pctrl);
> +       }

If you use GPIOLIB_IRQCHIP with several parent IRQs.
See Thierry's work in drivers/gpio/gpio-tegra186.c for the
only example.

I think that is what you want to do here.

We do want to add helpers in gpiolib to do this in a more
organized and easy-to-use fashion. Patches welcome ;)

Yours,
Linus Walleij
