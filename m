From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 31 Oct 2017 08:37:57 +0000
Subject: [RFC PATCH] drivers/irqchip: add support for Socionext Synquacer
 EXIU controller
In-Reply-To: <86bmko5cfb.fsf@arm.com>
References: <20171030181510.10022-1-ard.biesheuvel@linaro.org>
 <86bmko5cfb.fsf@arm.com>
Message-ID: <CAKv+Gu9a00w6MPtUvOjZTQm0TK1rGbs7ZQ22j0Kk9Jp22JsTKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 October 2017 at 01:33, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Mon, Oct 30 2017 at  6:15:10 pm GMT, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> The Socionext Synquacer SoC has an external interrupt unit (EXIU)
>> that forwards a block of 32 input lines to 32 adjacent GICv3 SPIs.
>
> Hooray, yet another one! ;-)
>

No comment.

>> The EXIU has per-interrupt level/edge and polarity controls, and
>> mask bits that keep the outgoing lines de-asserted, even though
>> the controller may still latch occurring interrupt conditions while
>> the line is masked.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>
>> If this doesn't look to insane, I will follow up with a DT binding
>> as well.
>>
>>     exiu: exiu at 510c0000 {
>>         compatible = "socionext,sc2a11-exiu";
>>         reg = <0x0 0x510c0000 0x0 0x20>;
>>         interrupt-controller;
>>         interrupt-parent = <&gic>;
>>         #interrupt-cells = <3>;
>>         spi-base = <112>;
>>     };
>>
>>  arch/arm64/Kconfig.platforms   |   3 +
>>  drivers/irqchip/Makefile       |   1 +
>>  drivers/irqchip/irq-sni-exiu.c | 230 ++++++++++++++++++++
>>  3 files changed, 234 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>> index 6b54ee8c1262..d0fc6c2a32e7 100644
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -161,6 +161,9 @@ config ARCH_SEATTLE
>>  config ARCH_SHMOBILE
>>       bool
>>
>> +config ARCH_SYNQUACER
>> +     bool "Socionext Synquacer SoC Family"
>> +
>>  config ARCH_RENESAS
>>       bool "Renesas SoC Platforms"
>>       select ARCH_SHMOBILE
>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>> index 845abc107ad5..f6825aa30098 100644
>> --- a/drivers/irqchip/Makefile
>> +++ b/drivers/irqchip/Makefile
>> @@ -79,3 +79,4 @@ obj-$(CONFIG_ARCH_ASPEED)           += irq-aspeed-vic.o irq-aspeed-i2c-ic.o
>>  obj-$(CONFIG_STM32_EXTI)             += irq-stm32-exti.o
>>  obj-$(CONFIG_QCOM_IRQ_COMBINER)              += qcom-irq-combiner.o
>>  obj-$(CONFIG_IRQ_UNIPHIER_AIDET)     += irq-uniphier-aidet.o
>> +obj-$(CONFIG_ARCH_SYNQUACER)         += irq-sni-exiu.c
>> diff --git a/drivers/irqchip/irq-sni-exiu.c b/drivers/irqchip/irq-sni-exiu.c
>> new file mode 100644
>> index 000000000000..0ab812523a11
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-sni-exiu.c
>> @@ -0,0 +1,230 @@
>> +/*
>> + * Driver for Socionext External Interrupt Unit (EXIU)
>> + *
>> + * Copyright (c) 2017 Linaro, Ltd. <ard.biesheuvel@linaro.org>
>> + *
>> + * Based on irq-tegra.c:
>> + *   Copyright (C) 2011 Google, Inc.
>> + *   Copyright (C) 2010,2013, NVIDIA Corporation
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/irq.h>
>> +#include <linux/irqchip.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +#define NUM_IRQS     32
>> +
>> +#define EIMASK               0x00
>> +#define EISRCSEL     0x04
>> +#define EIREQSTA     0x08
>> +#define EIRAWREQSTA  0x0C
>> +#define EIREQCLR     0x10
>> +#define EILVL                0x14
>> +#define EIEDG                0x18
>> +#define EISIR                0x1C
>> +
>> +struct exiu_irq_data {
>> +     void __iomem    *base;
>> +     u32             spi_base;
>> +};
>> +
>> +static void exiu_irq_eoi(struct irq_data *d)
>> +{
>> +     struct exiu_irq_data *data = irq_data_get_irq_chip_data(d);
>> +
>> +     writel(BIT(d->hwirq), data->base + EIREQCLR);
>> +     irq_chip_eoi_parent(d);
>> +}
>> +
>> +static void exiu_irq_mask(struct irq_data *d)
>> +{
>> +     struct exiu_irq_data *data = irq_data_get_irq_chip_data(d);
>> +     u32 val;
>> +
>> +     val = readl_relaxed(data->base + EIMASK) | BIT(d->hwirq);
>> +     writel_relaxed(val, data->base + EIMASK);
>> +     irq_chip_mask_parent(d);
>> +}
>> +
>> +static void exiu_irq_unmask(struct irq_data *d)
>> +{
>> +     struct exiu_irq_data *data = irq_data_get_irq_chip_data(d);
>> +     u32 val;
>> +
>> +     val = readl_relaxed(data->base + EIMASK) & ~BIT(d->hwirq);
>> +     writel_relaxed(val, data->base + EIMASK);
>> +     irq_chip_unmask_parent(d);
>> +}
>> +
>> +static void exiu_irq_enable(struct irq_data *d)
>> +{
>> +     struct exiu_irq_data *data = irq_data_get_irq_chip_data(d);
>> +     u32 val;
>> +
>> +     /* clear interrupts that were latched while disabled */
>> +     writel_relaxed(BIT(d->hwirq), data->base + EIREQCLR);
>> +
>> +     val = readl_relaxed(data->base + EIMASK) & ~BIT(d->hwirq);
>> +     writel_relaxed(val, data->base + EIMASK);
>> +     irq_chip_enable_parent(d);
>> +}
>> +
>> +static int exiu_irq_set_type(struct irq_data *d, unsigned int type)
>> +{
>> +     struct exiu_irq_data *data = irq_data_get_irq_chip_data(d);
>> +     u32 val;
>> +
>> +     val = readl_relaxed(data->base + EILVL);
>> +     if (type == IRQ_TYPE_EDGE_RISING || type == IRQ_TYPE_LEVEL_HIGH)
>> +             val |= BIT(d->hwirq);
>> +     else
>> +             val &= ~BIT(d->hwirq);
>> +     writel_relaxed(val, data->base + EILVL);
>> +
>> +     val = readl_relaxed(data->base + EIEDG);
>> +     if (type == IRQ_TYPE_LEVEL_LOW || type == IRQ_TYPE_LEVEL_HIGH)
>> +             val &= ~BIT(d->hwirq);
>> +     else
>> +             val |= BIT(d->hwirq);
>> +     writel_relaxed(val, data->base + EIEDG);
>> +
>> +     writel_relaxed(BIT(d->hwirq), data->base + EIREQCLR);
>> +
>> +     return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
>
> This is a bit confusing. Does the controller always present a level
> interrupt to the GIC, no matter if the input is actually edge? If so,
> that would definitely deserve a comment.
>

Yes, as far as I can tell. An edge interrupt drives the outgoing line
high until you clear it by writing a 1 to the EIREQCLR register.

> Also, can you change the trigger without disabling the interrupt first?
> Are you guaranteed that you won't see spurious interrupts being
> generated on the GIC input? It is probably not a big deal, but I thought
> I'd ask...
>

No, but I thought that was what IRQCHIP_SET_TYPE_MASKED is for?

>> +}
>> +
>> +static struct irq_chip exiu_irq_chip = {
>> +     .name                   = "EXIU",
>> +     .irq_eoi                = exiu_irq_eoi,
>> +     .irq_enable             = exiu_irq_enable,
>> +     .irq_mask               = exiu_irq_mask,
>> +     .irq_unmask             = exiu_irq_unmask,
>> +     .irq_set_type           = exiu_irq_set_type,
>> +     .irq_set_affinity       = irq_chip_set_affinity_parent,
>> +     .flags                  = IRQCHIP_SET_TYPE_MASKED |
>> +                               IRQCHIP_SKIP_SET_WAKE |
>> +                               IRQCHIP_EOI_THREADED |
>> +                               IRQCHIP_MASK_ON_SUSPEND,
>> +};
>> +
>> +static int exiu_domain_translate(struct irq_domain *domain,
>> +                              struct irq_fwspec *fwspec,
>> +                              unsigned long *hwirq,
>> +                              unsigned int *type)
>> +{
>> +     struct exiu_irq_data *info = domain->host_data;
>> +
>> +     if (is_of_node(fwspec->fwnode)) {
>> +             if (fwspec->param_count != 3)
>> +                     return -EINVAL;
>> +
>> +             if (fwspec->param[0] != GIC_SPI)
>> +                     return -EINVAL; /* No PPI should point to this domain */
>> +
>> +             *hwirq = fwspec->param[1] - info->spi_base;
>> +             *type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
>> +             return 0;
>> +     }
>> +     return -EINVAL;
>> +}
>> +
>> +static int exiu_domain_alloc(struct irq_domain *domain, unsigned int virq,
>> +                          unsigned int nr_irqs, void *data)
>> +{
>> +     struct irq_fwspec *fwspec = data;
>> +     struct irq_fwspec parent_fwspec;
>> +     struct exiu_irq_data *info = domain->host_data;
>> +     irq_hw_number_t hwirq;
>> +     unsigned int i;
>> +
>> +     if (fwspec->param_count != 3)
>> +             return -EINVAL; /* Not GIC compliant */
>> +     if (fwspec->param[0] != GIC_SPI)
>> +             return -EINVAL; /* No PPI should point to this domain */
>> +
>> +     hwirq = fwspec->param[1] - info->spi_base;
>> +     for (i = 0; i < nr_irqs; i++)
>> +             irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
>> +                                           &exiu_irq_chip, info);
>
> You should be able to drop this loop. Only MSI chips end-up being the
> target of multiple interrupts at the same time (multi-MSI support). You
> can replace it with a WARN_ON(nr_irqs != 1).
>

Ah ok, I didn't know that. Will drop it.

>> +
>> +     parent_fwspec = *fwspec;
>> +     parent_fwspec.fwnode = domain->parent->fwnode;
>> +     return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
>> +                                         &parent_fwspec);
>> +}
>> +
>> +static const struct irq_domain_ops exiu_domain_ops = {
>> +     .translate      = exiu_domain_translate,
>> +     .alloc          = exiu_domain_alloc,
>> +     .free           = irq_domain_free_irqs_common,
>> +};
>> +
>> +static int __init exiu_init(struct device_node *node,
>> +                         struct device_node *parent)
>> +{
>> +     struct irq_domain *parent_domain, *domain;
>> +     struct exiu_irq_data *data;
>> +     int err;
>> +
>> +     if (!parent) {
>> +             pr_err("%pOF: no parent, giving up\n", node);
>> +             return -ENODEV;
>> +     }
>> +
>> +     parent_domain = irq_find_host(parent);
>> +     if (!parent_domain) {
>> +             pr_err("%pOF: unable to obtain parent domain\n", node);
>> +             return -ENXIO;
>> +     }
>> +
>> +     data = kzalloc(sizeof(*data), GFP_KERNEL);
>> +     if (!data)
>> +             return -ENOMEM;
>> +
>> +     if (of_property_read_u32(node, "spi-base", &data->spi_base)) {
>> +             pr_err("%pOF: failed to parse 'spi-base' property\n", node);
>> +             err = -ENODEV;
>> +             goto out_free;
>> +     }
>> +
>> +     data->base = of_iomap(node, 0);
>> +     if (IS_ERR(data->base)) {
>> +             err = PTR_ERR(data->base);
>> +             goto out_free;
>> +     }
>> +
>> +     /* clear and mask all interrupts */
>> +     writel_relaxed(0xFFFFFFFF, data->base + EIREQCLR);
>> +     writel_relaxed(0xFFFFFFFF, data->base + EIMASK);
>> +
>> +     domain = irq_domain_add_hierarchy(parent_domain, 0, NUM_IRQS, node,
>> +                                       &exiu_domain_ops, data);
>> +     if (!domain) {
>> +             pr_err("%pOF: failed to allocated domain\n", node);
>> +             err = -ENOMEM;
>> +             goto out_unmap;
>> +     }
>> +
>> +     pr_info("%pOF: %d interrupts forwarded to %pOF\n", node, NUM_IRQS,
>> +             parent);
>> +
>> +     return 0;
>> +
>> +out_unmap:
>> +     iounmap(data->base);
>> +out_free:
>> +     kfree(data);
>> +     return err;
>> +}
>> +IRQCHIP_DECLARE(exiu, "socionext,sc2a11-exiu", exiu_init);
>
> Otherwise, looks pretty good.
>

Thanks!
