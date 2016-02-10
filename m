From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Feb 2016 11:58:46 +0100
Subject: [PATCH v5 1/3] gpio: xgene: Enable X-Gene standby GPIO as
 interrupt controller
In-Reply-To: <1454041735-8434-2-git-send-email-qnguyen@apm.com>
References: <1454041735-8434-1-git-send-email-qnguyen@apm.com>
 <1454041735-8434-2-git-send-email-qnguyen@apm.com>
Message-ID: <CACRpkdZXFVgtQfMM_r+xxceiAuiUDsxH-XGBOpEA9Am0BF+gRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2016 at 5:28 AM, Quan Nguyen <qnguyen@apm.com> wrote:

> Enable X-Gene standby GPIO controller as interrupt controller to provide
> its own resources. This avoids ambiguity where GIC interrupt resource is
> use as X-Gene standby GPIO interrupt resource in user driver.
>
> Signed-off-by: Y Vo <yvo@apm.com>
> Signed-off-by: Quan Nguyen <qnguyen@apm.com>

I want Marc's ACK on this before I merge it.

But it is looking way more acceptable than earlier incarnations! :)

> +       /* Propagate IRQ type setting to parent */
> +       if (type & IRQ_TYPE_EDGE_BOTH)
> +               return irq_chip_set_type_parent(d, IRQ_TYPE_EDGE_RISING);
> +       else
> +               return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);

This makes it look much more solid, nice.

> +static void xgene_gpio_sb_irq_shutdown(struct irq_data *d)
> +{
> +       struct xgene_gpio_sb *priv = irq_data_get_irq_chip_data(d);
> +
> +       gpiochip_unlock_as_irq(&priv->gc, HWIRQ_TO_GPIO(priv, d->hwirq));

Oh really. Well.

> +       if (is_of_node(domain->parent->fwnode)) {
> +               parent_fwspec.fwnode = domain->parent->fwnode;
> +               parent_fwspec.param_count = 3;
> +               parent_fwspec.param[0] = 0;/* SPI */
> +               /* Skip SGIs and PPIs*/
> +               parent_fwspec.param[1] = hwirq + priv->parent_irq_base - 32;
> +               parent_fwspec.param[2] = fwspec->param[1];
> +       } else if (is_fwnode_irqchip(domain->parent->fwnode)) {
> +               parent_fwspec.fwnode = domain->parent->fwnode;
> +               parent_fwspec.param_count = 2;
> +               parent_fwspec.param[0] = hwirq + priv->parent_irq_base;
> +               parent_fwspec.param[1] = fwspec->param[1];
> +       } else
> +               return -EINVAL;

This kind of stuff hardcodes knowledge of the GIC into this controller,
like that the SGI+PPI occupy the first 32 hwIRQs. But maybe there is
no better way to do it?

Yours,
Linus Walleij
