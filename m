From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 1 Jun 2015 16:30:32 +0200
Subject: [PATCH 1/2] pinctrl: meson: Enable GPIO IRQs
In-Reply-To: <1432551641-3256-2-git-send-email-carlo@caione.org>
References: <1432551641-3256-1-git-send-email-carlo@caione.org>
 <1432551641-3256-2-git-send-email-carlo@caione.org>
Message-ID: <CACRpkdYCxnf3nUz+jTSu4qw1_nXKkc+_TioZTxW7LpP_dX-MRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 25, 2015 at 1:00 PM, Carlo Caione <carlo@caione.org> wrote:

> From: Beniamino Galvani <b.galvani@gmail.com>
>
> On Meson8 and Meson8b SoCs there are 8 independent filtered GPIO
> interrupt modules that can be programmed to use any of the GPIOs in the
> chip as an interrupt source.
>
> For each GPIO IRQ we have:
>
> GPIOs --> [mux]--> [polarity]--> [filter]--> [edge select]--> GIC
>
> The eight GPIO interrupts respond to mask/unmask/clear/etc.. just like
> any other interrupt in the chip. The difference for the GPIO interrupts
> is that they can be filtered and conditioned.
>
> This patch adds support for the external GPIOs interrupts and enables
> them for Meson8 and Meson8b SoCs.
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>

Sigh this is gonna be one of these drivers that cannot use
GPIOLIB_IRQCHIP because it has the custom awkward
interrupt generator thing. I guess it is a bit faster to have
a limited number of direct IRQ lines to the CPU though so
it does come with some advantages...

> +static int meson_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
> +{
> +       struct meson_domain *domain = to_meson_domain(chip);
> +       struct meson_pinctrl *pc = domain->pinctrl;
> +       struct meson_bank *bank;
> +       struct of_phandle_args irq_data;
> +       unsigned int pin, virq;

Don't call it "virq" these are Linux irqs they are not any more
virtual than any other IRQs. Call the hardware irq (pin?) hwirq
instead.

> +       int ret;
> +
> +       pin = domain->data->pin_base + offset;

This is not looking good. Nominally you should use the irqdomain to
translate hwirq to Linux IRQ.

Normally this is just

line = irq_find_mapping(domain, hwirq);

> +       ret = meson_get_bank(domain, pin, &bank);
> +       if (ret)
> +               return -ENXIO;
> +
> +       irq_data.args_count = 2;
> +       irq_data.args[0] = pin;
> +       virq = irq_domain_alloc_irqs(pc->irq_domain, 1, NUMA_NO_NODE, &irq_data);

This is wrong. You have to alloc the irqs either

(A) when the driver is probed, looping over all IRQs.
  Then pair with free():in the IRQs in the remove()
  call.

or

(B) in one of the irqchip functions like .irq_request_resources()
  then pair with freeing the IRQs in .irq_release_resources().

Reason: the irqchip API can be used orthogonally from
the gpiolib API, and there is no gurantee *at all* that consumers
will call .to_irq() before using an IRQ. Especially not in the
device tree case.

All set-up/tear-down needs to happen without relying
on .to_irq() to have been called first.

> +       return virq ? virq : -ENXIO;
> +}
> +
(...)

> +static int meson_get_gic_irq(struct meson_pinctrl *pc, int hwirq)
> +{
> +       int i = 0;
> +
> +       for (i = 0; i < pc->num_gic_irqs; i++) {
> +               if (pc->irq_map[i] == hwirq)
> +                       return i;
> +       }
> +
> +       return -1;
> +}

Looks a bit like doing irqdomains work, but I guess it's
not possible any other way, since the GIC already
has its own irqdomain.

> +static struct irq_chip meson_irq_chip = {
> +       .name                   = "meson-gpio-irqchip",
> +       .irq_mask               = irq_chip_mask_parent,
> +       .irq_unmask             = irq_chip_unmask_parent,
> +       .irq_eoi                = irq_chip_eoi_parent,
> +       .irq_set_type           = meson_irq_set_type,
> +       .irq_retrigger          = irq_chip_retrigger_hierarchy,
> +       .irq_set_affinity       = irq_chip_set_affinity_parent,

You need to add .irq_request_resources() and
.irq_release_resources() with this kind of content at
least:

static int gpiochip_irq_reqres(struct irq_data *d)
{
        struct meson_pinctrl *pc = data->chip_data;

(...)
        if (gpiochip_lock_as_irq(chip, d->hwirq))
                return -EINVAL;
        return 0;
}


static void gpiochip_irq_relres(struct irq_data *d)
{
        struct meson_pinctrl *pc = data->chip_data;

(..)
        gpiochip_unlock_as_irq(chip, d->hwirq);
}


> +static int meson_map_gic_irq(struct irq_domain *irq_domain,
> +                            irq_hw_number_t hwirq)
> +{
> +       struct meson_pinctrl *pc = irq_domain->host_data;
> +       struct meson_domain *domain;
> +       struct meson_bank *bank;
> +       int index, reg, ret;
> +
> +       ret = meson_get_domain_and_bank(pc, hwirq, &domain, &bank);
> +       if (ret)
> +               return ret;
> +
> +       spin_lock(&pc->lock);
> +
> +       index = meson_get_gic_irq(pc, IRQ_FREE);
> +       if (index < 0) {
> +               spin_unlock(&pc->lock);
> +               dev_err(pc->dev, "no free GIC interrupt found");
> +               return -ENOSPC;
> +       }

That's neat, better not run out of IRQs here.
Yeah they designed the hardware like so. ...

> +       dev_dbg(pc->dev, "found free GIC interrupt %d\n", index);
> +       pc->irq_map[index] = hwirq;

Again this is irqdomain territory.

> +static int meson_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +                                 unsigned int nr_irqs, void *arg)

No virq please. Just irq. It is a Linux IRQ, not a virtual IRQ.

> +{
> +       struct meson_pinctrl *pc = domain->host_data;
> +       struct of_phandle_args *irq_data = arg;
> +       struct of_phandle_args gic_data;
> +       irq_hw_number_t hwirq;
> +       int index, ret, i;
> +
> +       if (irq_data->args_count != 2)
> +               return -EINVAL;
> +
> +       hwirq = irq_data->args[0];
> +       dev_dbg(pc->dev, "%s virq %d, nr %d, hwirq %lu\n",
> +               __func__, virq, nr_irqs, hwirq);
> +
> +       for (i = 0; i < nr_irqs; i++) {
> +               index = meson_map_gic_irq(domain, hwirq + i);
> +               if (index < 0)
> +                       return index;
> +
> +               irq_domain_set_hwirq_and_chip(domain, virq + i,
> +                                             hwirq + i,
> +                                             &meson_irq_chip,
> +                                             pc);
> +
> +               gic_data = pc->gic_irqs[index];
> +               ret = irq_domain_alloc_irqs_parent(domain, virq + i, nr_irqs,
> +                                                  &gic_data);
> +       }

OK... hm quite complex.

> +static void meson_irq_domain_free(struct irq_domain *domain, unsigned int virq,
> +                                 unsigned int nr_irqs)

virq -> irq

> +{
> +       struct meson_pinctrl *pc = domain->host_data;
> +       struct irq_data *irq_data;
> +       int index, i;
> +
> +       spin_lock(&pc->lock);
> +       for (i = 0; i < nr_irqs; i++) {
> +               irq_data = irq_domain_get_irq_data(domain, virq + i);
> +               index = meson_get_gic_irq(pc, irq_data->hwirq);
> +               if (index < 0)
> +                       continue;
> +               pc->irq_map[index] = IRQ_FREE;

Don't you need to call irq_dispose_mapping() for all
IRQs here? Or is the irq_domain_free_irqs_paren()
taking care of this?

Sorry if I don't fully understand this. It is a quite complex
interrupt generator logic :(

Yours,
Linus Walleij
