From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Mar 2017 11:15:56 +0200
Subject: [PATCH v2 5/7] pinctrl: aramda-37xx: Add irqchip support
In-Reply-To: <0e60fccd7913b83ee53d2921ce8f297927e8b6f3.1490120798.git-series.gregory.clement@free-electrons.com>
References: <cover.26288667a039bc9f8e62dec2fd6342ded4014d12.1490120798.git-series.gregory.clement@free-electrons.com>
 <0e60fccd7913b83ee53d2921ce8f297927e8b6f3.1490120798.git-series.gregory.clement@free-electrons.com>
Message-ID: <CACRpkdYv6WDWM60dRMaYfEt50M8N-yLYk2TRguNi78aQtt6X9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 7:28 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> The Armada 37xx SoCs can handle interrupt through GPIO. However it can
> only manage the edge ones.
>
> The way the interrupt are managed are classical so we can use the generic
> interrupt chip model.
>
> The only unusual "feature" is that many interrupts are connected to the
> parent interrupt controller. But we do not take advantage of this and use
> the chained irq with all of them.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

You need something in your Kconfig
doing select GPIOLIB_IRQCHIP unless there is
something I miss here.

> +#define IRQ_EN         0x0
> +#define IRQ_POL                0x08
> +#define IRQ_STATUS     0x10

This just cries out to me that there is a register 0x0c
and I bet it handles edges vs levels so you could also implement
level IRQs. Am I right?

> -       aramda_37xx_update_reg(&reg, offset);
> +       armada_37xx_update_reg(&reg, offset);
(...)
> -       aramda_37xx_update_reg(&reg, offset);
> +       armada_37xx_update_reg(&reg, offset);

These spelling fixes, do not do them in this patch, fix the first
patch adding them
instead. It's super-confusing. Applies everywhere.

> +static void armada_37xx_irq_handler(struct irq_desc *desc)
> +{
> +       struct gpio_chip *gc = irq_desc_get_handler_data(desc);
> +       struct irq_chip *chip = irq_desc_get_chip(desc);
> +       struct armada_37xx_pinctrl *info = gpiochip_get_data(gc);
> +       struct irq_domain *d = gc->irqdomain;
> +       int i;
> +
> +       chained_irq_enter(chip, desc);
> +       for (i = 0; i <= d->revmap_size / GPIO_PER_REG; i++) {
> +               u32 status;
> +               unsigned long flags;
> +
> +               spin_lock_irqsave(&info->irq_lock, flags);
> +               status = readl_relaxed(info->base + IRQ_STATUS + 4 * i);
> +               /* Manage only the interrupt that was enabled */
> +               status &= readl_relaxed(info->base + IRQ_EN + 4 * i);
> +               spin_unlock_irqrestore(&info->irq_lock, flags);
> +               while (status) {
> +                       u32 hwirq = ffs(status) - 1;
> +                       u32 virq = irq_linear_revmap(d, hwirq +
> +                                                    i * GPIO_PER_REG);

Use irq_find_mapping() instead please.

> +                       generic_handle_irq(virq);
> +                       status &= ~(1 << hwirq);

Why not status &= ~BIT(hwirq);

> +               }
> +       }
> +       chained_irq_exit(chip, desc);

Apart from that nice, it re-reads status on every iteration which is
good.

> +static int armada_37xx_irqchip_register(struct platform_device *pdev,
> +                                       struct armada_37xx_pinctrl *info)
> +{
> +       struct device_node *np = info->dev->of_node;
> +       int nrirqs = info->data->nr_pins;
> +       struct gpio_chip *gc = &info->gpio_chip;
> +       struct irq_chip *irqchip = &info->irq_chip;
> +       struct resource res;
> +       int ret, i, nr_irq_parent;
> +
> +       for_each_child_of_node(info->dev->of_node, np) {
> +               if (of_find_property(np, "gpio-controller", NULL)) {
> +                       ret = 0;
> +                       break;
> +               }
> +       };

Now there is this thing again looping over the nodes.

> +       if (ret)
> +               return ret;

ret may be used uninitialized here, if you loop over all nodes
and do not find any "gpio-controller".

The static code checks will just scream about this.

(Please fix in the other patch as well if present there.)

> +       nr_irq_parent = of_irq_count(np);
> +       spin_lock_init(&info->irq_lock);
> +
> +       if (!nr_irq_parent) {
> +               dev_err(&pdev->dev, "Invalid or no IRQ\n");
> +               return 0;
> +       }

What if it is > 1? That doesn't seem to work but will pass this
check silently.

> +       ret = gpiochip_irqchip_add(gc, irqchip, 0,
> +                                  handle_level_irq, IRQ_TYPE_NONE);

If you also set up the handler in .set_type() you can assign
handle_bad_irq() here and let .set_type set the right handler
as e.g. drivers/gpio/gpio-pl061.c.

> +       for (i = 0; i < nrirqs; i++) {
> +               struct irq_data *d = irq_get_irq_data(gc->irq_base + i);
> +
> +               d->mask = 1 << (i % GPIO_PER_REG);
> +       }

What is this? It looks like a big hack. At least put in a fat
comment about what is going on and why.

> +       for (i = 0; i < nr_irq_parent; i++) {
> +               int irq = irq_of_parse_and_map(np, i);

I think gpiochip_irqchip_add() will do this for you already,
as it calls irq_create_mapping() for all offsets which will call
irq_of_parse_and_map() am I right?

> +
> +               if (irq < 0)
> +                       continue;
> +
> +               gpiochip_set_chained_irqchip(gc, irqchip, irq,
> +                                            armada_37xx_irq_handler);
> +       }

So only this statement for each IRQ should be all right.

I think this driver needs a bit of tinkering and refining.

Yours,
Linus Walleij
