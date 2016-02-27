From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 27 Feb 2016 17:03:35 +0100
Subject: [PATCH 1/2] irqchip: add lpc18xx gpio pin interrupt driver
In-Reply-To: <alpine.DEB.2.11.1602261122120.3638@nanos>
References: <1456437887-24432-1-git-send-email-manabian@gmail.com>
 <1456437887-24432-2-git-send-email-manabian@gmail.com>
 <alpine.DEB.2.11.1602261122120.3638@nanos>
Message-ID: <CAGhQ9VxqMO24uKX8rJcbAHBcNKGkh9aYmM-+5FaNwYqqSnh-Hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 26 February 2016 at 11:26, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 25 Feb 2016, Joachim Eastwood wrote:
>> +static void lpc18xx_gpio_pint_handler(struct irq_desc *desc)
>> +{
>> +     struct lpc18xx_gpio_pint_chip *pint = irq_desc_get_handler_data(desc);
>> +     unsigned int irq = irq_desc_get_irq(desc);
>> +     int irq_no, i;
>> +
>> +     /* Find the interrupt */
>> +     for (i = 0; i < pint->nrirqs; i++) {
>> +             if (pint->irqmap[i] == irq) {
>
> Why don't you have a reverse map for this?

Is there any thing it the irq subsystem for this that I can use?

I have now implement one based on linear_revmap in the irq domain code
and it seems to work. Slightly more code and I needed two loops in
probe. First one to determine the max virq number from the main irq
controller and then another one to create the mapping/register the irq
themselves.

Looked at radix tree also, but I think it might be overkill here.

What do you think?


>> +                     irq_no = irq_find_mapping(pint->domain, i);
>> +                     generic_handle_irq(irq_no);
>> +             }
>> +     }
>> +}
>> +
>> +static void lpc18xx_gpio_pint_edge_ack(struct irq_data *d)
>> +{
>> +     struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
>> +     u32 mask = d->mask;
>> +
>> +     irq_gc_lock(gc);
>> +     irq_reg_writel(gc, mask, LPC18XX_GPIO_PINT_IST);
>> +     irq_gc_unlock(gc);
>> +}
>
> How is that different from irq_gc_ack_set_bit ?

No, the generic one is same. I'll fix it.


>> +static void lpc18xx_gpio_pint_edge_mask(struct irq_data *d)
>> +{
>> +     struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
>> +     u32 mask = d->mask;
>> +
>> +     irq_gc_lock(gc);
>> +     irq_reg_writel(gc, mask, LPC18XX_GPIO_PINT_CIENR);
>> +     irq_reg_writel(gc, mask, LPC18XX_GPIO_PINT_CIENF);
>> +     irq_gc_unlock(gc);
>> +}
>
> If you use seperate irq types, then you can use the generic chip functions and
> be done with it.

Do you mean one type for IRQ_TYPE_EDGE_RISING and one for IRQ_TYPE_EDGE_FALLING?

Will those two handle the EDGE_BOTH case too? or do I need a type for that also?


>> +static void lpc18xx_gpio_pint_edge_unmask(struct irq_data *d)
>> +{
>> +     struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
>> +     u32 type, mask = d->mask;
>> +
>> +     irq_gc_lock(gc);
>> +     type = irqd_get_trigger_type(d);
>> +     if (type & IRQ_TYPE_EDGE_RISING)
>> +             irq_reg_writel(gc, mask, LPC18XX_GPIO_PINT_SIENR);
>> +     if (type & IRQ_TYPE_EDGE_FALLING)
>> +             irq_reg_writel(gc, mask, LPC18XX_GPIO_PINT_SIENF);
>> +     irq_gc_unlock(gc);
>> +}
>> +
>> +static void lpc18xx_gpio_pint_level_mask(struct irq_data *d)
>> +{
>> +     struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
>> +     u32 mask = d->mask;
>> +
>> +     irq_gc_lock(gc);
>> +     irq_reg_writel(gc, mask, LPC18XX_GPIO_PINT_CIENR);
>> +     irq_gc_unlock(gc);
>> +}
>> +
>> +static void lpc18xx_gpio_pint_level_unmask(struct irq_data *d)
>> +{
>> +     struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
>> +     u32 mask = d->mask;
>> +
>> +     irq_gc_lock(gc);
>> +     irq_reg_writel(gc, mask, LPC18XX_GPIO_PINT_SIENR);
>> +     irq_gc_unlock(gc);
>> +}
>
> All the callbacks can go away.

I have now replaced lpc18xx_gpio_pint_edge_ack,
lpc18xx_gpio_pint_level_mask and lpc18xx_gpio_pint_level_unmask with
the equivalent generic versions.


Thanks for taking the time to look at this, Thomas.


regards,
Joachim Eastwood
