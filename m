From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 5 Sep 2016 09:53:40 +0200
Subject: [PATCH v3 6/9] pinctrl: Add IRQ support to STM32 gpios
In-Reply-To: <alpine.DEB.2.20.1609022057490.5647@nanos>
References: <1472830398-13275-1-git-send-email-alexandre.torgue@st.com>
 <1472830398-13275-7-git-send-email-alexandre.torgue@st.com>
 <alpine.DEB.2.20.1609022057490.5647@nanos>
Message-ID: <670d8249-0f72-50d1-5c1f-07fe53ac524b@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 09/02/2016 09:10 PM, Thomas Gleixner wrote:
> On Fri, 2 Sep 2016, Alexandre TORGUE wrote:
>> +static int stm32_gpio_domain_translate(struct irq_domain *d,
>> +				       struct irq_fwspec *fwspec,
>> +				       unsigned long *hwirq,
>> +				       unsigned int *type)
>> +{
>> +	if ((fwspec->param_count != 2) ||
>> +		(fwspec->param[0] >= STM32_GPIO_IRQ_LINE))
>> +		return -EINVAL;
>
> Just a nitpick. This is unnecessarily hard to parse because you indented
> the line break like a conditional statement

I agree. I will modify it as the one below.
>
>> +	if ((fwspec->param_count != 2) ||
>> +	    (fwspec->param[0] >= STM32_GPIO_IRQ_LINE))
>> +		return -EINVAL;
>
> Makes it immediately obvious that the second line belongs to the if.
>
>> +static void stm32_gpio_domain_activate(struct irq_domain *d,
>> +				       struct irq_data *irq_data)
>> +{
>> +	struct stm32_gpio_bank *bank = d->host_data;
>> +	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
>> +
>> +	if (gpiochip_lock_as_irq(&bank->gpio_chip, irq_data->hwirq)) {
>> +		dev_err(pctl->dev,
>> +			"Unable to configure STM32 %s%ld as IRQ\n",
>> +			bank->gpio_chip.label, irq_data->hwirq);
>> +		return;
>
> Hmm, that's nasty. When an interrupt is mapped then we don't expect the
> activate function to fail. You really should lock that interrupt when it's
> mapped.

Ok. I will remove it from here.

>
>> +	}
>> +	regmap_field_write(pctl->irqmux[irq_data->hwirq], bank->range.id);
>> +}
>
>> +static int stm32_gpio_domain_alloc(struct irq_domain *domain,
>> +				   unsigned int virq,
>> +				   unsigned int nr_irqs, void *data)
>> +{
>> +	struct irq_fwspec *fwspec = data;
>> +	struct irq_fwspec parent_fwspec;
>> +	struct stm32_pinctrl *pctl = domain->host_data;
>> +	irq_hw_number_t hwirq;
>> +	unsigned int i;
>> +
>> +	hwirq = fwspec->param[0];
>> +	for (i = 0; i < nr_irqs; i++)
>> +		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
>> +					      &stm32_gpio_irq_chip, pctl);
>> +
>> +	parent_fwspec.fwnode = domain->parent->fwnode;
>> +	parent_fwspec.param_count = 2;
>> +	parent_fwspec.param[0] = fwspec->param[0];
>> +	parent_fwspec.param[1] = fwspec->param[1];
>> +
>> +	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
>> +			&parent_fwspec);
>
> So doing it here would be probably the right thing to do:
>
>
> 	ret = gpiochip_lock_as_irq();
> 	if (ret)
> 		return ret;
>
>    	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
> 	      				   &parent_fwspec);
> 	if (ret)
> 		gpiochip_unlock_as_irq();
>
> 	return ret;
>
> So of course you need your own free() function which undoes that lock
> thingy.

Ok thanks for proposal.

Best regards.

Alex


>
> Thanks,
>
> 	tglx
>
