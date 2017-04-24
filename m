From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Apr 2017 14:14:36 +0200
Subject: [PATCH v4 5/7] pinctrl: aramda-37xx: Add irqchip support
In-Reply-To: <70ffe3343c13d01737bf74e5de4898d0c0be07a0.1491405475.git-series.gregory.clement@free-electrons.com>
References: <cover.65d0e6796fecf1fe6c5d07b981160b54dc9b4acd.1491405475.git-series.gregory.clement@free-electrons.com>
 <70ffe3343c13d01737bf74e5de4898d0c0be07a0.1491405475.git-series.gregory.clement@free-electrons.com>
Message-ID: <CACRpkdZ=mVXBbVf1iHg8nQ6pYUkvpB+egH+stoMrkD8V_vaYpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 5, 2017 at 5:18 PM, Gregory CLEMENT
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

There are some issues with this patch.

First:
You need to add
select GPIOLIB_IRQCHIP
to the Kconfig entry. It's only working in your setup
because something else is selecting this for you, probably.

At all places like this:

> +       u32 mask = d->mask;
(...)
> +       if (on)
> +               val |= mask;
> +       else
> +               val &= ~mask;

Isn't it simpler to just use d->mask directly in the code and skip the local
variable?

if (on)
  val |= d->mask;
(...)

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
> +                       u32 virq = irq_find_mapping(d, hwirq +
> +                                                    i * GPIO_PER_REG);
> +
> +                       generic_handle_irq(virq);
> +                       status &= ~BIT(hwirq);
> +               }

You hae a problem here is a new IRQ appears while you are inside
of this loop. You need to re-read the status register for each iteration
(and &= with the IRQ_EN I guess).

> +static int armada_37xx_irqchip_register(struct platform_device *pdev,
> +                                       struct armada_37xx_pinctrl *info)
> +{
> +       struct device_node *np = info->dev->of_node;
> +       int nrirqs = info->data->nr_pins;
> +       struct gpio_chip *gc = &info->gpio_chip;
> +       struct irq_chip *irqchip = &info->irq_chip;
> +       struct resource res;
> +       int ret = -ENODEV, i, nr_irq_parent;
> +

This warrants a comment:
/* Check if we have at least one gpio-controller child node */

> +       for_each_child_of_node(info->dev->of_node, np) {
> +               if (of_find_property(np, "gpio-controller", NULL)) {
> +                       ret = 0;
> +                       break;
> +               }

Rewrite:

if (of_property_read_bool(np, "gpio-controller"))

> +       };
> +       if (ret)
> +               return ret;


> +
> +       nr_irq_parent = of_irq_count(np);
> +       spin_lock_init(&info->irq_lock);
> +
> +       if (!nr_irq_parent) {
> +               dev_err(&pdev->dev, "Invalid or no IRQ\n");
> +               return 0;
> +       }
> +
> +       if (of_address_to_resource(info->dev->of_node, 1, &res)) {
> +               dev_err(info->dev, "cannot find IO resource\n");
> +               return -ENOENT;
> +       }
> +
> +       info->base = devm_ioremap_resource(info->dev, &res);
> +       if (IS_ERR(info->base))
> +               return PTR_ERR(info->base);
> +
> +       irqchip->irq_ack = armada_37xx_irq_ack;
> +       irqchip->irq_mask = armada_37xx_irq_mask;
> +       irqchip->irq_unmask = armada_37xx_irq_unmask;
> +       irqchip->irq_set_wake = armada_37xx_irq_set_wake;
> +       irqchip->irq_set_type = armada_37xx_irq_set_type;
> +       irqchip->name = info->data->name;
> +
> +       ret = gpiochip_irqchip_add(gc, irqchip, 0,
> +                                  handle_edge_irq, IRQ_TYPE_NONE);
> +       if (ret) {
> +               dev_info(&pdev->dev, "could not add irqchip\n");
> +               return ret;
> +       }
> +
> +       /*
> +        * Many interrupts are connected to the parent interrupt
> +        * controller. But we do not take advantage of this and use
> +        * the chained irq with all of them.
> +        */
> +       for (i = 0; i < nrirqs; i++) {
> +               struct irq_data *d = irq_get_irq_data(gc->irq_base + i);
> +
> +               /*
> +                * The mask field is a "precomputed bitmask for
> +                * accessing the chip registers" which was introduced
> +                * for the generic irqchip framework. As we don't use
> +                * this framework, we can reuse this field for our own
> +                * usage.
> +                */
> +               d->mask = BIT(i % GPIO_PER_REG);
> +       }
> +
> +       for (i = 0; i < nr_irq_parent; i++) {
> +               int irq = irq_of_parse_and_map(np, i);
> +
> +               if (irq < 0)
> +                       continue;
> +
> +               gpiochip_set_chained_irqchip(gc, irqchip, irq,
> +                                            armada_37xx_irq_handler);
> +       }
> +
> +       return 0;
> +}
> +
>  static int armada_37xx_gpiochip_register(struct platform_device *pdev,
>                                         struct armada_37xx_pinctrl *info)
>  {
> @@ -496,6 +714,9 @@ static int armada_37xx_gpiochip_register(struct platform_device *pdev,
>         ret = devm_gpiochip_add_data(&pdev->dev, gc, info);
>         if (ret)
>                 return ret;
> +       ret = armada_37xx_irqchip_register(pdev, info);
> +       if (ret)
> +               return ret;
>
>         return 0;
>  }
> --
> git-series 0.9.1
