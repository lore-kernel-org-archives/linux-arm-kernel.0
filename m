From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 02 Dec 2015 09:03:20 +0000
Subject: [PATCH v3 4/6] pinctrl: meson: Enable GPIO IRQs
In-Reply-To: <CAOQ7t2YN8Ey1vZO4yrn9SdbR7FzPNVY-HGRBZOctLgK1vHo9VA@mail.gmail.com>
References: <1448987062-31225-1-git-send-email-carlo@caione.org>	<1448987062-31225-5-git-send-email-carlo@caione.org>	<565DF211.8000005@arm.com>
 <CAOQ7t2YN8Ey1vZO4yrn9SdbR7FzPNVY-HGRBZOctLgK1vHo9VA@mail.gmail.com>
Message-ID: <565EB3D8.5070400@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/15 19:41, Carlo Caione wrote:
> On Tue, Dec 1, 2015 at 8:16 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 01/12/15 16:24, Carlo Caione wrote:
>>> From: Carlo Caione <carlo@endlessm.com>
> 
>>> +static int meson_irq_domain_alloc(struct irq_domain *domain, unsigned int irq,
>>> +                               unsigned int nr_irqs, void *arg)
>>> +{
>>> +     struct meson_pinctrl *pc = domain->host_data;
>>> +     struct irq_fwspec *irq_data = arg;
>>> +     struct irq_fwspec gic_data;
>>> +     irq_hw_number_t hwirq;
>>> +     int index, ret, i;
>>> +
>>> +     if (irq_data->param_count != 2)
>>> +             return -EINVAL;
>>> +
>>> +     hwirq = irq_data->param[0];
>>> +     dev_dbg(pc->dev, "%s irq %d, nr %d, hwirq %lu\n",
>>> +                     __func__, irq, nr_irqs, hwirq);
>>> +
>>> +     for (i = 0; i < nr_irqs; i++) {
>>> +             index = meson_map_gic_irq(domain, hwirq + i);
>>> +             if (index < 0)
>>> +                     return index;
>>> +
>>> +             irq_domain_set_hwirq_and_chip(domain, irq + i,
>>> +                                           hwirq + i,
>>> +                                           &meson_irq_chip,
>>> +                                           pc);
>>> +
>>> +             gic_data.param_count = 3;
>>> +             gic_data.fwnode = domain->parent->fwnode;
>>> +             gic_data.param[0] = 0; /* SPI */
>>> +             gic_data.param[1] = pc->gic_irqs[index];
>>> +             gic_data.param[1] = IRQ_TYPE_EDGE_RISING;
> 
> Oh, this should be gic_data.param[2]. Just noticed.
> 
>> That feels quite wrong. Hardcoding the trigger like this and hoping for
>> a set_type to set it right at a later time is just asking for trouble.
>> Why can't you use the trigger type that has been provided by the
>> interrupt descriptor?
> 
> In v2 I had the set of fwspec to track number and trigger type of the
> IRQ, so it was straightforward. With this patch I have moved away from
> that solution (as you suggested) and I'm using the 'amlogic,irqs-gpio'
> parameter to track down the IRQ numbers (but not the trigger type).
> It's the same solution we have in drivers/irqchip/irq-crossbar.c where
> the trigger type is hardcoded in allocate_gic_irq().
> If I need to save both the IRQ and the trigger type at this point I
> wonder if it's better to go back to the set of fwspec or convert the
> fwspec to of_phandle_args and save that.

No. This should come from the interrupt specifier you are getting from
the device. You should never make up that information.

Your amlogic,irqs-gpio property gives you a list of downstream
interrupts. The device connected to your pinctrl HW provides you with
the upstream interrupt number (which you will map to one of your
downstream IRQ) and crucially the trigger type. Please look at how the
TI cross bar works (again).

>>> +static int meson_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
>>> +{
>>> +     struct meson_domain *domain = to_meson_domain(chip);
>>> +     struct meson_pinctrl *pc = domain->pinctrl;
>>> +     struct meson_bank *bank;
>>> +     struct irq_fwspec irq_data;
>>> +     unsigned int hwirq, irq;
>>> +
>>> +     hwirq = domain->data->pin_base + offset;
>>> +
>>> +     if (meson_get_bank(domain, hwirq, &bank))
>>> +             return -ENXIO;
>>> +
>>> +     irq_data.param_count = 2;
>>> +     irq_data.param[0] = hwirq;
>>> +
>>> +     /* dummy. It will be changed later in meson_irq_set_type */
>>> +     irq_data.param[1] = IRQ_TYPE_EDGE_RISING;
>>
>> Blah. Worse than I though... How do you end-up here? Why can't you
>> obtain the corresponding of_phandle_args instead of making things up?
> 
> because I do not have a of_phandle. This is basically the .to_irq hook
> of the gpio_chip. This code is being called programmatically from the
> gpiolib. No DTS/OF involved here.
> 
>> This looks mad. Do you really need this?
> 
> Well, I'm open to any suggestion on how improve this mess.

The question to answer is: in what circumstances do you have to convert
a GPIO into an IRQ at runtime? The only case should be "when you
discover a device having an interrupt pointing to your pinctrl". And in
this case, you have all the information to reconfigure the HW and assign
the interrupt.

I really don't get why you want or need to involve gpiolib in this.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
