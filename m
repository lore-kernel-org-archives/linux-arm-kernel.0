From: qnguyen@apm.com (Quan Nguyen)
Date: Tue, 26 Jan 2016 23:27:13 +0700
Subject: [PATCH v4 1/3] gpio: xgene: Enable X-Gene standby GPIO as
 interrupt controller
In-Reply-To: <56A74BD3.40801@arm.com>
References: <1453792935-19916-1-git-send-email-qnguyen@apm.com>
 <1453792935-19916-2-git-send-email-qnguyen@apm.com>
 <56A74BD3.40801@arm.com>
Message-ID: <CAFopSPTz=sdZs_WZrU8ryTRXNtb4GPOMA_sj8HMPMxWBxV2w4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 5:34 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> On 26/01/16 07:22, Quan Nguyen wrote:
> > Enable X-Gene standby GPIO controller as interrupt controller to provide
> > its own resources. This avoids ambiguity where GIC interrupt resource is
> > use as X-Gene standby GPIO interrupt resource in user driver.
> >
> > Signed-off-by: Y Vo <yvo@apm.com>
> > Signed-off-by: Quan Nguyen <qnguyen@apm.com>
> > ---
> >  drivers/gpio/gpio-xgene-sb.c | 331 ++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 276 insertions(+), 55 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-xgene-sb.c b/drivers/gpio/gpio-xgene-sb.c
> > index 282004d..b703114 100644
> > --- a/drivers/gpio/gpio-xgene-sb.c
> > +++ b/drivers/gpio/gpio-xgene-sb.c
> > @@ -2,8 +2,9 @@
> >   * AppliedMicro X-Gene SoC GPIO-Standby Driver
> >   *
> >   * Copyright (c) 2014, Applied Micro Circuits Corporation
> > - * Author:   Tin Huynh <tnhuynh@apm.com>.
> > - *           Y Vo <yvo@apm.com>.
> > + * Author:   Tin Huynh <tnhuynh@apm.com>.
> > + *           Y Vo <yvo@apm.com>.
> > + *           Quan Nguyen <qnguyen@apm.com>.
> >   *
> >   * This program is free software; you can redistribute  it and/or modify it
> >   * under  the terms of  the GNU General  Public License as published by the
> > @@ -22,14 +23,20 @@
> >  #include <linux/module.h>
> >  #include <linux/io.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/of_platform.h>
> >  #include <linux/of_gpio.h>
> > +#include <linux/of_irq.h>
> >  #include <linux/gpio/driver.h>
> >  #include <linux/acpi.h>
> >
> >  #include "gpiolib.h"
> >
> > -#define XGENE_MAX_GPIO_DS            22
> > -#define XGENE_MAX_GPIO_DS_IRQ                6
> > +#define XGENE_MAX_NGPIO                      22
> > +#define XGENE_MAX_NIRQ                       6
> > +#define XGENE_IRQ_START_PIN          8
> > +#define SBGPIO_XGENE                 ((XGENE_IRQ_START_PIN << 24) | \
> > +                                     (XGENE_MAX_NIRQ << 16) | \
> > +                                     (XGENE_MAX_NGPIO << 8))
> >
> >  #define GPIO_MASK(x)                 (1U << ((x) % 32))
> >
> > @@ -39,19 +46,30 @@
> >  #define MPA_GPIO_IN_ADDR             0x02a4
> >  #define MPA_GPIO_SEL_LO              0x0294
> >
> > +#define GPIO_INT_LEVEL_H     0x000001
> > +#define GPIO_INT_LEVEL_L     0x000000
> > +
> >  /**
> >   * struct xgene_gpio_sb - GPIO-Standby private data structure.
> >   * @gc:                              memory-mapped GPIO controllers.
> > - * @irq:                     Mapping GPIO pins and interrupt number
> > - * nirq:                     Number of GPIO pins that supports interrupt
> > + * @regs:                    GPIO register base offset
> > + * @irq_domain:                      GPIO interrupt domain
> > + * flags:                    GPIO per-instance flags assigned by the driver
>
> nit: missing @ before "flags".

let me fix it.

>
> >   */
> >  struct xgene_gpio_sb {
> >       struct gpio_chip        gc;
> > -     u32 *irq;
> > -     u32 nirq;
> > +     void __iomem            *regs;
> > +     struct irq_domain       *irq_domain;
> > +     u32                     flags;
> >  };
> >
> > -static void xgene_gpio_set_bit(struct gpio_chip *gc, void __iomem *reg, u32 gpio, int val)
> > +#define IRQ_START_PIN(priv)  (((priv)->flags >> 24) & 0xff)
> > +#define NIRQ_MAX(priv)               (((priv)->flags >> 16) & 0xff)
> > +#define NGPIO_MAX(priv)              (((priv)->flags >>  8) & 0xff)
> > +#define START_PARENT_IRQ(priv)       ((priv)->flags & 0xff)
> > +
>
> So flags is actually a set of fields, all 8bits, called irq_start, nirq,
> ngpio, and parent_irq_base (or something along those lines).
>
> You might as well make that explicit in your structure, as there is
> hardly any point in hiding this information behind a bag of bits and a
> set of obscure accessors...

Yes, I agree. Let me remove those lines and make them explicitly in structure.
But I might remove ngpio in struct gpio_chip as it is redundant.

>
> > +static void xgene_gpio_set_bit(struct gpio_chip *gc,
> > +                             void __iomem *reg, u32 gpio, int val)
> >  {
> >       u32 data;
> >
> > @@ -63,23 +81,216 @@ static void xgene_gpio_set_bit(struct gpio_chip *gc, void __iomem *reg, u32 gpio
> >       gc->write_reg(reg, data);
> >  }
> >
> > -static int apm_gpio_sb_to_irq(struct gpio_chip *gc, u32 gpio)
> > +static int xgene_gpio_sb_irq_set_type(struct irq_data *d, unsigned int type)
> > +{
> > +     struct xgene_gpio_sb *priv = irq_data_get_irq_chip_data(d);
> > +     int gpio = d->hwirq + IRQ_START_PIN(priv);
> > +     int lvl_type;
> > +     int ret;
> > +
> > +     switch (type & IRQ_TYPE_SENSE_MASK) {
> > +     case IRQ_TYPE_EDGE_RISING:
> > +     case IRQ_TYPE_LEVEL_HIGH:
> > +             lvl_type = GPIO_INT_LEVEL_H;
> > +             break;
> > +     case IRQ_TYPE_EDGE_FALLING:
> > +     case IRQ_TYPE_LEVEL_LOW:
> > +             lvl_type = GPIO_INT_LEVEL_L;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret = gpiochip_lock_as_irq(&priv->gc, gpio);
>
> This has no business whatsoever in set_type. This should be done either
> when the GPIO is activated as an IRQ in the domain "activate" method, or
> in the "startup" method of the irqchip.

The irq pin can do high/low level as well as edge rising/falling,
while its parent(GIC) can only be high level/edge rising. Hence, there
is need to configure the irq pin to indicate its parent irq chip when
there is "high" or "low" on the pin, very much like an invert as the
code below:
xgene_gpio_set_bit(&priv->gc, priv->regs + MPA_GPIO_INT_LVL, d->hwirq,
lvl_type);

>
> > +     if (ret) {
> > +             dev_err(priv->gc.parent,
> > +             "Unable to configure XGene GPIO standby pin %d as IRQ\n",
> > +                             gpio);
> > +             return ret;
> > +     }
> > +
> > +     if ((gpio >= IRQ_START_PIN(priv)) &&
> > +                     (d->hwirq < NIRQ_MAX(priv))) {
>
> How can we end-up here if your GPIO is not part that range? This should
> be guaranteed by construction.

I agree, let me remove it.

>
> > +             xgene_gpio_set_bit(&priv->gc, priv->regs + MPA_GPIO_SEL_LO,
> > +                             gpio * 2, 1);
> > +             xgene_gpio_set_bit(&priv->gc, priv->regs + MPA_GPIO_INT_LVL,
> > +                             d->hwirq, lvl_type);
> > +     }
> > +
> > +     /* Propagate IRQ type setting to parent */
> > +     if (type & IRQ_TYPE_EDGE_BOTH)
> > +             return irq_chip_set_type_parent(d, IRQ_TYPE_EDGE_RISING);
> > +     else
> > +             return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
> > +}
> > +
> > +static void xgene_gpio_sb_irq_shutdown(struct irq_data *d)
> > +{
> > +     struct xgene_gpio_sb *priv = irq_data_get_irq_chip_data(d);
> > +
> > +     gpiochip_unlock_as_irq(&priv->gc, d->hwirq + IRQ_START_PIN(priv));
> > +}
> > +
> > +static struct irq_chip xgene_gpio_sb_irq_chip = {
> > +     .name           = "sbgpio",
> > +     .irq_ack        = irq_chip_ack_parent,
> > +     .irq_eoi        = irq_chip_eoi_parent,
> > +     .irq_mask       = irq_chip_mask_parent,
> > +     .irq_unmask     = irq_chip_unmask_parent,
> > +     .irq_set_type   = xgene_gpio_sb_irq_set_type,
> > +     .irq_shutdown   = xgene_gpio_sb_irq_shutdown,
> > +};
> > +
> > +static int xgene_gpio_sb_to_irq(struct gpio_chip *gc, u32 gpio)
> >  {
> >       struct xgene_gpio_sb *priv = gpiochip_get_data(gc);
> > +     struct irq_fwspec fwspec;
> > +     unsigned int virq;
> > +
> > +     if ((gpio < IRQ_START_PIN(priv)) ||
> > +                     (gpio > NIRQ_MAX(priv) + IRQ_START_PIN(priv)))
> > +             return -ENXIO;
> > +     if (gc->parent->of_node)
> > +             fwspec.fwnode = of_node_to_fwnode(gc->parent->of_node);
> > +     else
> > +             fwspec.fwnode = gc->parent->fwnode;
> > +     fwspec.param_count = 2;
> > +     fwspec.param[0] = gpio - IRQ_START_PIN(priv);
> > +     fwspec.param[1] = IRQ_TYPE_NONE;
> > +     virq = irq_find_mapping(priv->irq_domain, gpio - IRQ_START_PIN(priv));
> > +     if (!virq)
> > +             virq =  irq_domain_alloc_irqs(priv->irq_domain, 1,
> > +                                             NUMA_NO_NODE, &fwspec);
>
> You should not use these low-level functions directly. Use
> irq_create_fwspec_mapping, which will do the right thing.

Yes, agree, the code should be much better.

Let me change:

virq = irq_find_mapping(priv->irq_domain, gpio - IRQ_START_PIN(priv));
if (!virq)
virq =  irq_domain_alloc_irqs(priv->irq_domain, 1, NUMA_NO_NODE, &fwspec);
return virq;

to:
return irq_create_fwspec_mapping(&fwspec);

>
> > +     return virq;
> > +}
> > +
> > +static void xgene_gpio_sb_domain_activate(struct irq_domain *d,
> > +             struct irq_data *irq_data)
> > +{
> > +     struct xgene_gpio_sb *priv = d->host_data;
> > +     u32 gpio = irq_data->hwirq + IRQ_START_PIN(priv);
> >
> > -     if (priv->irq[gpio])
> > -             return priv->irq[gpio];
> > +     if ((gpio < IRQ_START_PIN(priv)) ||
> > +                     (gpio > NIRQ_MAX(priv) + IRQ_START_PIN(priv)))
> > +             return;
>
> Again, how can this happen?

let me remove this redundant code.

>
> >
> > -     return -ENXIO;
> > +     xgene_gpio_set_bit(&priv->gc, priv->regs + MPA_GPIO_SEL_LO,
> > +                     gpio * 2, 1);
>
> This seems to program the interrupt to be active on a low level. Why?
> Isn't that what set_type is supposed to do?

set_type currently does it, so this activate can be removed, but
deactivate() is need as it helps to convert the pin back to gpio
function.

>
> > +}
> > +
> > +static void xgene_gpio_sb_domain_deactivate(struct irq_domain *d,
> > +             struct irq_data *irq_data)
> > +{
> > +     struct xgene_gpio_sb *priv = d->host_data;
> > +     u32 gpio = irq_data->hwirq + IRQ_START_PIN(priv);
>
> It really feels like you need a hwirq_to_gpio() accessor.

Yes. I'll add it.

>
> > +
> > +     if ((gpio < IRQ_START_PIN(priv)) ||
> > +                     (gpio > NIRQ_MAX(priv) + IRQ_START_PIN(priv)))
> > +             return;
>
> Why do we need this?

Again, let me remove it.

>
> > +
> > +     xgene_gpio_set_bit(&priv->gc, priv->regs + MPA_GPIO_SEL_LO,
> > +                     gpio * 2, 0);
> > +}
> > +
> > +static int xgene_gpio_sb_domain_translate(struct irq_domain *d,
> > +             struct irq_fwspec *fwspec,
> > +             unsigned long *hwirq,
> > +             unsigned int *type)
> > +{
> > +     if (fwspec->param_count != 2)
> > +             return -EINVAL;
> > +     *hwirq = fwspec->param[0];
> > +     *type = fwspec->param[1];
> > +     return 0;
> > +}
> > +
> > +static int xgene_gpio_sb_domain_alloc(struct irq_domain *domain,
> > +                                     unsigned int virq,
> > +                                     unsigned int nr_irqs, void *data)
> > +{
> > +     struct irq_fwspec *fwspec = data;
> > +     struct irq_fwspec parent_fwspec;
> > +     struct xgene_gpio_sb *priv = domain->host_data;
> > +     irq_hw_number_t hwirq;
> > +     unsigned int type = IRQ_TYPE_NONE;
> > +     unsigned int i;
> > +     u32 ret;
> > +
> > +     ret = xgene_gpio_sb_domain_translate(domain, fwspec, &hwirq, &type);
> > +     if (ret)
> > +             return ret;
>
> How can this fail here?

This could fail if wrong param_count was detected in _translate().

>
> > +
> > +     hwirq = fwspec->param[0];
> > +     if ((hwirq >= NIRQ_MAX(priv)) ||
> > +                     (hwirq + nr_irqs > NIRQ_MAX(priv)))
> > +             return -EINVAL;
>
> How can this happen?

This is for case of out of range hwirq.

>
> > +
> > +     for (i = 0; i < nr_irqs; i++)
> > +             irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
> > +                             &xgene_gpio_sb_irq_chip, priv);
> > +
> > +     if (is_of_node(domain->parent->fwnode)) {
> > +             parent_fwspec.fwnode = domain->parent->fwnode;
> > +             parent_fwspec.param_count = 3;
> > +             parent_fwspec.param[0] = 0;/* SPI */
> > +             /* Skip SGIs and PPIs*/
> > +             parent_fwspec.param[1] = hwirq + START_PARENT_IRQ(priv) - 32;
> > +             parent_fwspec.param[2] = fwspec->param[1];
> > +     } else if (is_fwnode_irqchip(domain->parent->fwnode)) {
> > +             parent_fwspec.fwnode = domain->parent->fwnode;
> > +             parent_fwspec.param_count = 2;
> > +             parent_fwspec.param[0] = hwirq + START_PARENT_IRQ(priv);
> > +             parent_fwspec.param[1] = fwspec->param[1];
> > +     } else
> > +             return -EINVAL;
> > +
> > +     return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
> > +                     &parent_fwspec);
> > +}
> > +
> > +static void xgene_gpio_sb_domain_free(struct irq_domain *domain,
> > +             unsigned int virq,
> > +             unsigned int nr_irqs)
> > +{
> > +     struct irq_data *d;
> > +     unsigned int i;
> > +
> > +     for (i = 0; i < nr_irqs; i++) {
> > +             d = irq_domain_get_irq_data(domain, virq + i);
> > +             irq_domain_reset_irq_data(d);
> > +     }
> >  }
> >
> > +static const struct irq_domain_ops xgene_gpio_sb_domain_ops = {
> > +     .translate      = xgene_gpio_sb_domain_translate,
> > +     .alloc          = xgene_gpio_sb_domain_alloc,
> > +     .free           = xgene_gpio_sb_domain_free,
> > +     .activate       = xgene_gpio_sb_domain_activate,
> > +     .deactivate     = xgene_gpio_sb_domain_deactivate,
> > +};
> > +
> > +static const struct of_device_id xgene_gpio_sb_of_match[] = {
> > +     {.compatible = "apm,xgene-gpio-sb", .data = (const void *)SBGPIO_XGENE},
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, xgene_gpio_sb_of_match);
> > +
> > +#ifdef CONFIG_ACPI
> > +static const struct acpi_device_id xgene_gpio_sb_acpi_match[] = {
> > +     {"APMC0D15", SBGPIO_XGENE},
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(acpi, xgene_gpio_sb_acpi_match);
> > +#endif
> > +
> >  static int xgene_gpio_sb_probe(struct platform_device *pdev)
> >  {
> >       struct xgene_gpio_sb *priv;
> > -     u32 ret, i;
> > -     u32 default_lines[] = {0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D};
> > +     u32 ret;
> >       struct resource *res;
> >       void __iomem *regs;
> > +     const struct of_device_id *of_id;
> > +     struct irq_domain *parent_domain = NULL;
> >
> >       priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> >       if (!priv)
> > @@ -90,6 +301,32 @@ static int xgene_gpio_sb_probe(struct platform_device *pdev)
> >       if (IS_ERR(regs))
> >               return PTR_ERR(regs);
> >
> > +     priv->regs = regs;
> > +
> > +     of_id = of_match_device(xgene_gpio_sb_of_match, &pdev->dev);
> > +     if (of_id)
> > +             priv->flags = (uintptr_t)of_id->data;
>
> Wait. Everything is hardcoded? So why do we have to deal with looking
> into that structure if nothing is actually parametrized?

There will be other instances with difference number of irq pins /gpio
/start_irq_base etc.

>
> > +#ifdef CONFIG_ACPI
> > +     else {
> > +             const struct acpi_device_id *acpi_id;
> > +
> > +             acpi_id = acpi_match_device(xgene_gpio_sb_acpi_match,
> > +                             &pdev->dev);
> > +             if (acpi_id)
> > +                     priv->flags = (uintptr_t)acpi_id->driver_data;
> > +     }
> > +#endif
>
> nit: you can write this as
>
>         if (of_id) {
>                 ...
> #ifdef ...
>         } else {
>                 ...
> #endif
>         }
>
>
> Which preserves the Linux coding style.
>

Thanks, let me change the code that way.

> > +     ret = platform_get_irq(pdev, 0);
> > +     if (ret > 0) {
> > +             priv->flags &= ~0xff;
> > +             priv->flags |= irq_get_irq_data(ret)->hwirq & 0xff;
> > +             parent_domain = irq_get_irq_data(ret)->domain;
> > +     }
>
> This is rather ugly. You have the interrupt-parent property. Why don't
> you look it up, and do a irq_find_matching_fwnode? Also, what guarantee
> do you have that the interrupts are going to be sorted in the DT? There
> is no such garantee in the documentation.

I decided to keep them because I still found difficult with ACPI
table, which does not have interrupt-parent property. This code works
with both DT and ACPI so I keep it.

>
> > +     if (!parent_domain) {
> > +             dev_err(&pdev->dev, "unable to obtain parent domain\n");
> > +             return -ENODEV;
> > +     }
> > +
> >       ret = bgpio_init(&priv->gc, &pdev->dev, 4,
> >                       regs + MPA_GPIO_IN_ADDR,
> >                       regs + MPA_GPIO_OUT_ADDR, NULL,
> > @@ -97,36 +334,34 @@ static int xgene_gpio_sb_probe(struct platform_device *pdev)
> >          if (ret)
> >                  return ret;
> >
> > -     priv->gc.to_irq = apm_gpio_sb_to_irq;
> > -     priv->gc.ngpio = XGENE_MAX_GPIO_DS;
> > -
> > -     priv->nirq = XGENE_MAX_GPIO_DS_IRQ;
> > +     priv->gc.to_irq = xgene_gpio_sb_to_irq;
> > +     priv->gc.ngpio = NGPIO_MAX(priv);
>
> So we do have duplicated information everywhere. Great.

Let me fix it :-D

>
> >
> > -     priv->irq = devm_kzalloc(&pdev->dev, sizeof(u32) * XGENE_MAX_GPIO_DS,
> > -                                GFP_KERNEL);
> > -     if (!priv->irq)
> > -             return -ENOMEM;
> > +     platform_set_drvdata(pdev, priv);
> >
> > -     for (i = 0; i < priv->nirq; i++) {
> > -             priv->irq[default_lines[i]] = platform_get_irq(pdev, i);
> > -             xgene_gpio_set_bit(&priv->gc, regs + MPA_GPIO_SEL_LO,
> > -                                   default_lines[i] * 2, 1);
> > -             xgene_gpio_set_bit(&priv->gc, regs + MPA_GPIO_INT_LVL, i, 1);
> > -     }
> > +     priv->irq_domain = irq_domain_create_hierarchy(parent_domain,
> > +                                     0, NIRQ_MAX(priv),
> > +                                     of_node_to_fwnode(pdev->dev.of_node),
> > +                                     &xgene_gpio_sb_domain_ops, priv);
> > +     if (!priv->irq_domain)
> > +             return -ENODEV;
> >
> > -     platform_set_drvdata(pdev, priv);
> > +     priv->gc.irqdomain = priv->irq_domain;
> >
> >       ret = gpiochip_add_data(&priv->gc, priv);
> > -     if (ret)
> > -             dev_err(&pdev->dev, "failed to register X-Gene GPIO Standby driver\n");
> > -     else
> > -             dev_info(&pdev->dev, "X-Gene GPIO Standby driver registered\n");
> > -
> > -     if (priv->nirq > 0) {
> > -             /* Register interrupt handlers for gpio signaled acpi events */
> > -             acpi_gpiochip_request_interrupts(&priv->gc);
> > +     if (ret) {
> > +             dev_err(&pdev->dev,
> > +                     "failed to register X-Gene GPIO Standby driver\n");
> > +             if (priv->irq_domain)
>
> How can that not be true, given that you've tested irq_domain just above?

Yes, this is redundant, I'll definitely remove it

>
> > +                     irq_domain_remove(priv->irq_domain);
> > +             return ret;
> >       }
> >
> > +     dev_info(&pdev->dev, "X-Gene GPIO Standby driver registered\n");
> > +
> > +     /* Register interrupt handlers for gpio signaled acpi events */
> > +     acpi_gpiochip_request_interrupts(&priv->gc);
> > +
> >       return ret;
> >  }
> >
> > @@ -134,28 +369,14 @@ static int xgene_gpio_sb_remove(struct platform_device *pdev)
> >  {
> >       struct xgene_gpio_sb *priv = platform_get_drvdata(pdev);
> >
> > -     if (priv->nirq > 0) {
> > -             acpi_gpiochip_free_interrupts(&priv->gc);
> > -     }
> > +     acpi_gpiochip_free_interrupts(&priv->gc);
> > +
> > +     irq_domain_remove(priv->irq_domain);
> >
> >       gpiochip_remove(&priv->gc);
> >       return 0;
> >  }
> >
> > -static const struct of_device_id xgene_gpio_sb_of_match[] = {
> > -     {.compatible = "apm,xgene-gpio-sb", },
> > -     {},
> > -};
> > -MODULE_DEVICE_TABLE(of, xgene_gpio_sb_of_match);
> > -
> > -#ifdef CONFIG_ACPI
> > -static const struct acpi_device_id xgene_gpio_sb_acpi_match[] = {
> > -     {"APMC0D15", 0},
> > -     {},
> > -};
> > -MODULE_DEVICE_TABLE(acpi, xgene_gpio_sb_acpi_match);
> > -#endif
> > -
> >  static struct platform_driver xgene_gpio_sb_driver = {
> >       .driver = {
> >                  .name = "xgene-gpio-sb",
> >
>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...

Thanks M. for this detail review,

-- Quan Nguyen
