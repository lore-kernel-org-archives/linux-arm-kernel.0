From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 13 Sep 2016 18:29:36 +0200
Subject: [PATCH v5 2/9] drivers: irqchip: Add STM32 external interrupts
 support
In-Reply-To: <alpine.DEB.2.20.1609131713490.6233@nanos>
References: <1473432124-6784-1-git-send-email-alexandre.torgue@st.com>
 <1473432124-6784-3-git-send-email-alexandre.torgue@st.com>
 <alpine.DEB.2.20.1609131713490.6233@nanos>
Message-ID: <6941f61d-0b33-4108-0135-b11887cd0488@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 09/13/2016 05:21 PM, Thomas Gleixner wrote:
> On Fri, 9 Sep 2016, Alexandre TORGUE wrote:
>> +static void stm32_exti_free(struct irq_domain *d, unsigned int virq,
>> +			    unsigned int nr_irqs)
>> +{
>> +	struct irq_data *data = irq_get_irq_data(virq);
>> +
>> +	irq_gc_mask_clr_bit(data->parent_data);
>
> I have a hard time to understand this. The irq domain is not hierarchical.

Actually, I wanted to test ".free" callback function of gpio_irq_domain 
in STM32 pinctrl driver. To do that I modified gpio driver: just after 
getting virq through gpio_to_irq, I called "irq_dispose_mapping(virq)".
I know it is dirty but I thought it was the only way to test.

Doing that, I see that ".free" callback of gpio domain is called but as 
it is hirerchical ".free" callback for parent domain (exti one) is also 
called. I observed that virq was well unmapped, but not masked at exti 
level. It is for this reason than I added 
"irq_gc_mask_clr_bit(data->parent_data);" which mask interrupt at exti 
level.

Maybe this use case can never happen ? (and in this case all this stuff 
is not needed)

>
>> +	irq_domain_reset_irq_data(data);
>
>> +	domain = irq_domain_add_linear(node, nr_exti,
>> +				       &irq_exti_domain_ops, NULL);
>
> It's a simple linear domain. So how can data->parent_data be a valid
> irq_data pointer? Answer: It can't!

This Exti domain is parent of stm32 gpio domain. When ".free" callback 
of stm32 gpio domain is called then ".free" callback of Exti domain will 
be automatically called. Those both ".free" callbacks are called with 
"virq". This virq is created through stm32 gpio domain (in stm32 pinctrl 
driver), data and parent->data are then associated to it.

Sorry if it is not clear.

Regards

Alex

>
> But it doesn't blow up in your face simply because the alloc/free callbacks
> are never invoked for simple non hierarchical domains. So you should have
> removed that stuff after copying some other irqchip driver.



>
> Thanks,
>
> 	tglx
>
