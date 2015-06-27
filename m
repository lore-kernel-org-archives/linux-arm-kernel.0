From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Sat, 27 Jun 2015 11:52:14 +0800
Subject: [PATCH v2 6/9] irqchip / gic: Add stacked irqdomain support for
 ACPI based GICv2 init
In-Reply-To: <20150623173845.GC31466@red-moon>
References: <1434703572-26221-1-git-send-email-hanjun.guo@linaro.org>
 <1434703572-26221-7-git-send-email-hanjun.guo@linaro.org>
 <20150622172014.GB26129@red-moon> <5589772A.8070708@linaro.org>
 <20150623173845.GC31466@red-moon>
Message-ID: <558E1DEE.3090900@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24/2015 01:38 AM, Lorenzo Pieralisi wrote:
> On Tue, Jun 23, 2015 at 04:11:38PM +0100, Hanjun Guo wrote:
>
> [...]
>
>>>> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
>>>> index 8fc67bc..d1b2131 100644
>>>> --- a/drivers/irqchip/irq-gic.c
>>>> +++ b/drivers/irqchip/irq-gic.c
>>>> @@ -851,15 +851,22 @@ static struct notifier_block gic_cpu_notifier = {
>>>>    static int gic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>>>>    				unsigned int nr_irqs, void *arg)
>>>>    {
>>>> -	int i, ret;
>>>> +	int i;
>>>>    	irq_hw_number_t hwirq;
>>>> -	unsigned int type = IRQ_TYPE_NONE;
>>>> -	struct of_phandle_args *irq_data = arg;
>>>>
>>>> -	ret = gic_irq_domain_xlate(domain, irq_data->np, irq_data->args,
>>>> -				   irq_data->args_count, &hwirq, &type);
>>>> -	if (ret)
>>>> -		return ret;
>>>> +	if (domain->of_node) {	/* DT case */
>>>> +		int ret;
>>>> +		unsigned int type = IRQ_TYPE_NONE;
>>>> +		struct of_phandle_args *irq_data = arg;
>>>> +
>>>> +		ret = gic_irq_domain_xlate(domain, irq_data->np,
>>>> +					irq_data->args,
>>>> +					irq_data->args_count, &hwirq, &type);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +	} else {	/* ACPI case */
>>>> +		hwirq = (irq_hw_number_t)*(u32 *)arg;
>>>> +	}
>>>
>>> If domain->of_node is NULL and system booted with DT the code above
>>> does not fail (and if it fails almost certainly that won't be graceful)
>>> but it should.
>>
>> how about the following logic?
>>
>> if (!domain->of_node && acpi_disabled)
>> 	return -ENODEV;
>> else if (domain->of_node)
>> 	dt related code;
>> else
>> 	ACPI related code;
>
> Code is not checking the node at present so:
>
> if (acpi_disabled)
> 	dt code;
> else
> 	ACPI code;
>
> would do, but that's a nit.
>
>>>>    	for (i = 0; i < nr_irqs; i++)
>>>>    		gic_irq_domain_map(domain, virq + i, hwirq + i);
>>>> @@ -945,11 +952,11 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>>>>    		gic_irqs = 1020;
>>>>    	gic->gic_irqs = gic_irqs;
>>>>
>>>> -	if (node) {		/* DT case */
>>>> +	if (node || !acpi_disabled) {		/* DT or ACPI case */
>>>>    		gic->domain = irq_domain_add_linear(node, gic_irqs,
>>>>    						    &gic_irq_domain_hierarchy_ops,
>>>>    						    gic);
>
> I think this is a bit more worrying, I mean passing a NULL node pointer to
> the irqdomain layer which basically means you are booting out of ACPI

I'm little confused here, would you mind explaining more for your
worrying? To me, node pointer is optional and it's ok for ACPI
case.

> (for you, if that's true for the irq_domain_add_linear implementation
> that's another story), the node pointer should be optional but you
> need feedback from IRQ layer maintainers here.

Sure.

Thanks
Hanjun
