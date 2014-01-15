From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Jan 2014 08:46:47 +0100
Subject: [PATCH v3.1 11/21] ARM: pxa: support ICP DAS LP-8x4x FPGA irq
In-Reply-To: <1389308855-32588-1-git-send-email-ynvich@gmail.com>
References: <1387309071-22382-12-git-send-email-ynvich@gmail.com>
 <1389308855-32588-1-git-send-email-ynvich@gmail.com>
Message-ID: <CACRpkdaA_HBcRgBj9+x_RJquSnvy-r7Wqp-z=ZnoGaCBy+wamw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is looking much better!

On Fri, Jan 10, 2014 at 12:07 AM, Sergei Ianovich <ynvich@gmail.com> wrote:

> +++ b/drivers/irqchip/irq-lp8x4x.c
(...)

You could add some kerneldoc to this following struct (OK nitpick, but
still nice, especially for the last two variables).

> +struct lp8x4x_irq_data {
> +       void                    *base;
> +       struct irq_domain       *domain;
> +       unsigned long           num_irq;
> +       unsigned char           irq_sys_enabled;
> +       unsigned char           irq_high_enabled;
> +};
> +
> +static void lp8x4x_mask_irq(struct irq_data *d)
> +{
> +       unsigned mask;
> +       unsigned long irq = d->hwirq;

Name the local variable hwirq too so we know what it is.

> +       struct lp8x4x_irq_data *host = irq_data_get_irq_chip_data(d);
> +
> +       if (!host) {
> +               pr_err("lp8x4x: missing host data for irq %i\n", d->irq);
> +               return;
> +       }
> +
> +       if (irq >= host->num_irq) {
> +               pr_err("lp8x4x: wrong irq handler for irq %i\n", d->irq);
> +               return;
> +       }

This is on the hotpath. Do you *really* need these two checks?

(...)
> +static void lp8x4x_unmask_irq(struct irq_data *d)
> +{
> +       unsigned mask;
> +       unsigned long irq = d->hwirq;

Name the variable "hwirq".

> +       struct lp8x4x_irq_data *host = irq_data_get_irq_chip_data(d);
> +
> +       if (!host) {
> +               pr_err("lp8x4x: missing host data for irq %i\n", d->irq);
> +               return;
> +       }
> +
> +       if (irq >= host->num_irq) {
> +               pr_err("lp8x4x: wrong irq handler for irq %i\n", d->irq);
> +               return;
> +       }

Again overzealous error checks.

(...)
> +static void lp8x4x_irq_handler(unsigned int irq, struct irq_desc *desc)
> +{
> +       int n;
> +       unsigned long mask;
> +       struct irq_chip *chip = irq_desc_get_chip(desc);
> +       struct lp8x4x_irq_data *host = irq_desc_get_handler_data(desc);
> +
> +       if (!host)
> +               return;

I don't think this happens either?

> +       chained_irq_enter(chip, desc);
> +
> +       for (;;) {
> +               mask = ioread8(host->base + CLRHILVINT) & 0xff;
> +               mask |= (ioread8(host->base + SECOINT) & SECOINT_MASK) << 8;
> +               mask |= (ioread8(host->base + PRIMINT) & PRIMINT_MASK) << 8;
> +               mask &= host->irq_high_enabled | (host->irq_sys_enabled << 8);
> +               if (mask == 0)
> +                       break;
> +               for_each_set_bit(n, &mask, BITS_PER_LONG)
> +                       generic_handle_irq(irq_find_mapping(host->domain, n));
> +       }

I like the looks of this.

If you fix this:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
