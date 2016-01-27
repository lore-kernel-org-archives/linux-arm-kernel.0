From: qnguyen@apm.com (Quan Nguyen)
Date: Wed, 27 Jan 2016 19:48:42 +0700
Subject: [PATCH v4 1/3] gpio: xgene: Enable X-Gene standby GPIO as
 interrupt controller
In-Reply-To: <56A7AF48.8020605@arm.com>
References: <1453792935-19916-1-git-send-email-qnguyen@apm.com>
 <1453792935-19916-2-git-send-email-qnguyen@apm.com>
 <56A74BD3.40801@arm.com>
 <CAFopSPTz=sdZs_WZrU8ryTRXNtb4GPOMA_sj8HMPMxWBxV2w4A@mail.gmail.com>
 <56A7AF48.8020605@arm.com>
Message-ID: <CAFopSPR1ZKinH=N29gaAu3M8oc-vfKUnPsFpAu3EUNb3Doi68w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 12:39 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 26/01/16 16:27, Quan Nguyen wrote:
>> On Tue, Jan 26, 2016 at 5:34 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>
>>> On 26/01/16 07:22, Quan Nguyen wrote:
>>>> Enable X-Gene standby GPIO controller as interrupt controller to provide
>>>> its own resources. This avoids ambiguity where GIC interrupt resource is
>>>> use as X-Gene standby GPIO interrupt resource in user driver.
>>>>
>>>> Signed-off-by: Y Vo <yvo@apm.com>
>>>> Signed-off-by: Quan Nguyen <qnguyen@apm.com>
>>>> ---
>>>>  drivers/gpio/gpio-xgene-sb.c | 331 ++++++++++++++++++++++++++++++++++++-------
>>>>  1 file changed, 276 insertions(+), 55 deletions(-)
>
> [...]
>
>>>> +static int xgene_gpio_sb_irq_set_type(struct irq_data *d, unsigned int type)
>>>> +{
>>>> +     struct xgene_gpio_sb *priv = irq_data_get_irq_chip_data(d);
>>>> +     int gpio = d->hwirq + IRQ_START_PIN(priv);
>>>> +     int lvl_type;
>>>> +     int ret;
>>>> +
>>>> +     switch (type & IRQ_TYPE_SENSE_MASK) {
>>>> +     case IRQ_TYPE_EDGE_RISING:
>>>> +     case IRQ_TYPE_LEVEL_HIGH:
>>>> +             lvl_type = GPIO_INT_LEVEL_H;
>>>> +             break;
>>>> +     case IRQ_TYPE_EDGE_FALLING:
>>>> +     case IRQ_TYPE_LEVEL_LOW:
>>>> +             lvl_type = GPIO_INT_LEVEL_L;
>>>> +             break;
>>>> +     default:
>>>> +             return -EINVAL;
>>>> +     }
>>>> +
>>>> +     ret = gpiochip_lock_as_irq(&priv->gc, gpio);
>>>
>>> This has no business whatsoever in set_type. This should be done either
>>> when the GPIO is activated as an IRQ in the domain "activate" method, or
>>> in the "startup" method of the irqchip.
>>
>> The irq pin can do high/low level as well as edge rising/falling,
>> while its parent(GIC) can only be high level/edge rising. Hence, there
>> is need to configure the irq pin to indicate its parent irq chip when
>> there is "high" or "low" on the pin, very much like an invert as the
>> code below:
>> xgene_gpio_set_bit(&priv->gc, priv->regs + MPA_GPIO_INT_LVL, d->hwirq,
>> lvl_type);
>
> I don't get it. your "gpiochip_lock_as_irq" doesn't seem to go anywhere
> the GIC, and doesn't have any knowledge of the trigger. So what is the
> trick?

Sorry Marc, it was me who misunderstood here.
And yes, gpiochip_lock_as_irq() should go to activate method.

>
>>>
>>>> +     if (ret) {
>>>> +             dev_err(priv->gc.parent,
>>>> +             "Unable to configure XGene GPIO standby pin %d as IRQ\n",
>>>> +                             gpio);
>>>> +             return ret;
>>>> +     }
>>>> +
>>>> +     if ((gpio >= IRQ_START_PIN(priv)) &&
>>>> +                     (d->hwirq < NIRQ_MAX(priv))) {
>>>
>>> How can we end-up here if your GPIO is not part that range? This should
>>> be guaranteed by construction.
>>
>> I agree, let me remove it.
>>
>>>
>>>> +             xgene_gpio_set_bit(&priv->gc, priv->regs + MPA_GPIO_SEL_LO,
>>>> +                             gpio * 2, 1);
>>>> +             xgene_gpio_set_bit(&priv->gc, priv->regs + MPA_GPIO_INT_LVL,
>>>> +                             d->hwirq, lvl_type);
>>>> +     }
>>>> +
>>>> +     /* Propagate IRQ type setting to parent */
>>>> +     if (type & IRQ_TYPE_EDGE_BOTH)
>>>> +             return irq_chip_set_type_parent(d, IRQ_TYPE_EDGE_RISING);
>>>> +     else
>>>> +             return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
>>>> +}
>>>> +
>>>> +static void xgene_gpio_sb_irq_shutdown(struct irq_data *d)
>>>> +{
>>>> +     struct xgene_gpio_sb *priv = irq_data_get_irq_chip_data(d);
>>>> +
>>>> +     gpiochip_unlock_as_irq(&priv->gc, d->hwirq + IRQ_START_PIN(priv));
>>>> +}
>>>> +
>>>> +static struct irq_chip xgene_gpio_sb_irq_chip = {
>>>> +     .name           = "sbgpio",
>>>> +     .irq_ack        = irq_chip_ack_parent,
>>>> +     .irq_eoi        = irq_chip_eoi_parent,
>>>> +     .irq_mask       = irq_chip_mask_parent,
>>>> +     .irq_unmask     = irq_chip_unmask_parent,
>>>> +     .irq_set_type   = xgene_gpio_sb_irq_set_type,
>>>> +     .irq_shutdown   = xgene_gpio_sb_irq_shutdown,
>>>> +};
>>>> +
>>>> +static int xgene_gpio_sb_to_irq(struct gpio_chip *gc, u32 gpio)
>>>>  {
>>>>       struct xgene_gpio_sb *priv = gpiochip_get_data(gc);
>>>> +     struct irq_fwspec fwspec;
>>>> +     unsigned int virq;
>>>> +
>>>> +     if ((gpio < IRQ_START_PIN(priv)) ||
>>>> +                     (gpio > NIRQ_MAX(priv) + IRQ_START_PIN(priv)))
>>>> +             return -ENXIO;
>>>> +     if (gc->parent->of_node)
>>>> +             fwspec.fwnode = of_node_to_fwnode(gc->parent->of_node);
>>>> +     else
>>>> +             fwspec.fwnode = gc->parent->fwnode;
>>>> +     fwspec.param_count = 2;
>>>> +     fwspec.param[0] = gpio - IRQ_START_PIN(priv);
>>>> +     fwspec.param[1] = IRQ_TYPE_NONE;
>>>> +     virq = irq_find_mapping(priv->irq_domain, gpio - IRQ_START_PIN(priv));
>>>> +     if (!virq)
>>>> +             virq =  irq_domain_alloc_irqs(priv->irq_domain, 1,
>>>> +                                             NUMA_NO_NODE, &fwspec);
>>>
>>> You should not use these low-level functions directly. Use
>>> irq_create_fwspec_mapping, which will do the right thing.
>>
>> Yes, agree, the code should be much better.
>>
>> Let me change:
>>
>> virq = irq_find_mapping(priv->irq_domain, gpio - IRQ_START_PIN(priv));
>> if (!virq)
>> virq =  irq_domain_alloc_irqs(priv->irq_domain, 1, NUMA_NO_NODE, &fwspec);
>> return virq;
>>
>> to:
>> return irq_create_fwspec_mapping(&fwspec);
>>
>>>
>>>> +     return virq;
>>>> +}
>>>> +
>>>> +static void xgene_gpio_sb_domain_activate(struct irq_domain *d,
>>>> +             struct irq_data *irq_data)
>>>> +{
>>>> +     struct xgene_gpio_sb *priv = d->host_data;
>>>> +     u32 gpio = irq_data->hwirq + IRQ_START_PIN(priv);
>>>>
>>>> -     if (priv->irq[gpio])
>>>> -             return priv->irq[gpio];
>>>> +     if ((gpio < IRQ_START_PIN(priv)) ||
>>>> +                     (gpio > NIRQ_MAX(priv) + IRQ_START_PIN(priv)))
>>>> +             return;
>>>
>>> Again, how can this happen?
>>
>> let me remove this redundant code.
>>
>>>
>>>>
>>>> -     return -ENXIO;
>>>> +     xgene_gpio_set_bit(&priv->gc, priv->regs + MPA_GPIO_SEL_LO,
>>>> +                     gpio * 2, 1);
>>>
>>> This seems to program the interrupt to be active on a low level. Why?
>>> Isn't that what set_type is supposed to do?
>>
>> set_type currently does it, so this activate can be removed, but
>> deactivate() is need as it helps to convert the pin back to gpio
>> function.
>>
>>>
>>>> +}
>>>> +
>>>> +static void xgene_gpio_sb_domain_deactivate(struct irq_domain *d,
>>>> +             struct irq_data *irq_data)
>>>> +{
>>>> +     struct xgene_gpio_sb *priv = d->host_data;
>>>> +     u32 gpio = irq_data->hwirq + IRQ_START_PIN(priv);
>>>
>>> It really feels like you need a hwirq_to_gpio() accessor.
>>
>> Yes. I'll add it.
>>
>>>
>>>> +
>>>> +     if ((gpio < IRQ_START_PIN(priv)) ||
>>>> +                     (gpio > NIRQ_MAX(priv) + IRQ_START_PIN(priv)))
>>>> +             return;
>>>
>>> Why do we need this?
>>
>> Again, let me remove it.
>>
>>>
>>>> +
>>>> +     xgene_gpio_set_bit(&priv->gc, priv->regs + MPA_GPIO_SEL_LO,
>>>> +                     gpio * 2, 0);
>>>> +}
>>>> +
>>>> +static int xgene_gpio_sb_domain_translate(struct irq_domain *d,
>>>> +             struct irq_fwspec *fwspec,
>>>> +             unsigned long *hwirq,
>>>> +             unsigned int *type)
>>>> +{
>>>> +     if (fwspec->param_count != 2)
>>>> +             return -EINVAL;
>>>> +     *hwirq = fwspec->param[0];
>>>> +     *type = fwspec->param[1];
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int xgene_gpio_sb_domain_alloc(struct irq_domain *domain,
>>>> +                                     unsigned int virq,
>>>> +                                     unsigned int nr_irqs, void *data)
>>>> +{
>>>> +     struct irq_fwspec *fwspec = data;
>>>> +     struct irq_fwspec parent_fwspec;
>>>> +     struct xgene_gpio_sb *priv = domain->host_data;
>>>> +     irq_hw_number_t hwirq;
>>>> +     unsigned int type = IRQ_TYPE_NONE;
>>>> +     unsigned int i;
>>>> +     u32 ret;
>>>> +
>>>> +     ret = xgene_gpio_sb_domain_translate(domain, fwspec, &hwirq, &type);
>>>> +     if (ret)
>>>> +             return ret;
>>>
>>> How can this fail here?
>>
>> This could fail if wrong param_count was detected in _translate().
>
> But you only get there if translate succeeded the first place when
> called from irq_create_fwspec_mapping -> irq_domain_translate, which
> happens before trying any allocation.
>
> So I'm still stating that this cannot fail in any way.
>

I think I understand now. If so, calling translate here is redundant,
and hence, let me remove these code.

>>
>>>
>>>> +
>>>> +     hwirq = fwspec->param[0];
>>>> +     if ((hwirq >= NIRQ_MAX(priv)) ||
>>>> +                     (hwirq + nr_irqs > NIRQ_MAX(priv)))
>>>> +             return -EINVAL;
>>>
>>> How can this happen?
>>
>> This is for case of out of range hwirq.
>
> Then it would be better placed in the translate method, so that we can
> abort early.
>

And here also, let me move these into translate method instead.

>>>
>>>> +
>>>> +     for (i = 0; i < nr_irqs; i++)
>>>> +             irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
>>>> +                             &xgene_gpio_sb_irq_chip, priv);
>>>> +
>>>> +     if (is_of_node(domain->parent->fwnode)) {
>>>> +             parent_fwspec.fwnode = domain->parent->fwnode;
>>>> +             parent_fwspec.param_count = 3;
>>>> +             parent_fwspec.param[0] = 0;/* SPI */
>>>> +             /* Skip SGIs and PPIs*/
>>>> +             parent_fwspec.param[1] = hwirq + START_PARENT_IRQ(priv) - 32;
>>>> +             parent_fwspec.param[2] = fwspec->param[1];
>>>> +     } else if (is_fwnode_irqchip(domain->parent->fwnode)) {
>>>> +             parent_fwspec.fwnode = domain->parent->fwnode;
>>>> +             parent_fwspec.param_count = 2;
>>>> +             parent_fwspec.param[0] = hwirq + START_PARENT_IRQ(priv);
>>>> +             parent_fwspec.param[1] = fwspec->param[1];
>>>> +     } else
>>>> +             return -EINVAL;
>>>> +
>>>> +     return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
>>>> +                     &parent_fwspec);
>>>> +}
>>>> +
>>>> +static void xgene_gpio_sb_domain_free(struct irq_domain *domain,
>>>> +             unsigned int virq,
>>>> +             unsigned int nr_irqs)
>>>> +{
>>>> +     struct irq_data *d;
>>>> +     unsigned int i;
>>>> +
>>>> +     for (i = 0; i < nr_irqs; i++) {
>>>> +             d = irq_domain_get_irq_data(domain, virq + i);
>>>> +             irq_domain_reset_irq_data(d);
>>>> +     }
>>>>  }
>>>>
>>>> +static const struct irq_domain_ops xgene_gpio_sb_domain_ops = {
>>>> +     .translate      = xgene_gpio_sb_domain_translate,
>>>> +     .alloc          = xgene_gpio_sb_domain_alloc,
>>>> +     .free           = xgene_gpio_sb_domain_free,
>>>> +     .activate       = xgene_gpio_sb_domain_activate,
>>>> +     .deactivate     = xgene_gpio_sb_domain_deactivate,
>>>> +};
>>>> +
>>>> +static const struct of_device_id xgene_gpio_sb_of_match[] = {
>>>> +     {.compatible = "apm,xgene-gpio-sb", .data = (const void *)SBGPIO_XGENE},
>>>> +     {},
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, xgene_gpio_sb_of_match);
>>>> +
>>>> +#ifdef CONFIG_ACPI
>>>> +static const struct acpi_device_id xgene_gpio_sb_acpi_match[] = {
>>>> +     {"APMC0D15", SBGPIO_XGENE},
>>>> +     {},
>>>> +};
>>>> +MODULE_DEVICE_TABLE(acpi, xgene_gpio_sb_acpi_match);
>>>> +#endif
>>>> +
>>>>  static int xgene_gpio_sb_probe(struct platform_device *pdev)
>>>>  {
>>>>       struct xgene_gpio_sb *priv;
>>>> -     u32 ret, i;
>>>> -     u32 default_lines[] = {0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D};
>>>> +     u32 ret;
>>>>       struct resource *res;
>>>>       void __iomem *regs;
>>>> +     const struct of_device_id *of_id;
>>>> +     struct irq_domain *parent_domain = NULL;
>>>>
>>>>       priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>>>>       if (!priv)
>>>> @@ -90,6 +301,32 @@ static int xgene_gpio_sb_probe(struct platform_device *pdev)
>>>>       if (IS_ERR(regs))
>>>>               return PTR_ERR(regs);
>>>>
>>>> +     priv->regs = regs;
>>>> +
>>>> +     of_id = of_match_device(xgene_gpio_sb_of_match, &pdev->dev);
>>>> +     if (of_id)
>>>> +             priv->flags = (uintptr_t)of_id->data;
>>>
>>> Wait. Everything is hardcoded? So why do we have to deal with looking
>>> into that structure if nothing is actually parametrized?
>>
>> There will be other instances with difference number of irq pins /gpio
>> /start_irq_base etc.
>
> Then it has to be described in DT right now.
>

What I was thinking is to have other id to match with difference
instances and these code can be use for ACPI also. Let say
"apm,xgene2-gpio-sb"
Please help correcting me if it is not right.

>>
>>>
>>>> +#ifdef CONFIG_ACPI
>>>> +     else {
>>>> +             const struct acpi_device_id *acpi_id;
>>>> +
>>>> +             acpi_id = acpi_match_device(xgene_gpio_sb_acpi_match,
>>>> +                             &pdev->dev);
>>>> +             if (acpi_id)
>>>> +                     priv->flags = (uintptr_t)acpi_id->driver_data;
>>>> +     }
>>>> +#endif
>>>
>>> nit: you can write this as
>>>
>>>         if (of_id) {
>>>                 ...
>>> #ifdef ...
>>>         } else {
>>>                 ...
>>> #endif
>>>         }
>>>
>>>
>>> Which preserves the Linux coding style.
>>>
>>
>> Thanks, let me change the code that way.
>>
>>>> +     ret = platform_get_irq(pdev, 0);
>>>> +     if (ret > 0) {
>>>> +             priv->flags &= ~0xff;
>>>> +             priv->flags |= irq_get_irq_data(ret)->hwirq & 0xff;
>>>> +             parent_domain = irq_get_irq_data(ret)->domain;
>>>> +     }
>>>
>>> This is rather ugly. You have the interrupt-parent property. Why don't
>>> you look it up, and do a irq_find_matching_fwnode? Also, what guarantee
>>> do you have that the interrupts are going to be sorted in the DT? There
>>> is no such garantee in the documentation.
>>
>> I decided to keep them because I still found difficult with ACPI
>> table, which does not have interrupt-parent property. This code works
>> with both DT and ACPI so I keep it.
>
> Then again: what guarantees that you will have:
> - the lowest interrupt listed first?
> - a set contiguous interrupts?
>
> Your DT binding doesn't specify anything of that sort, so I could write
> a DT that uses interrupts 7 5 and 142, in that order. It would be legal,
> and yet things would explode. So please be clear in your DT binding
> about what you do support.

Thanks Marc for this suggestion. I'll update DT binding document to
state that the first/lowest interrupt must be specified

Thanks Marc,
-- Quan Nguyen
