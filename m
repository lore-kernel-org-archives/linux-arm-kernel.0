From: ludovic.barre@st.com (Ludovic BARRE)
Date: Tue, 8 Aug 2017 11:28:24 +0200
Subject: [PATCH 2/8] irqchip: stm32: add multi-bank management
In-Reply-To: <1d693fee-2804-01ec-f0a6-ef5ca1854b46@arm.com>
References: <1499412391-25480-1-git-send-email-ludovic.Barre@st.com>
 <1499412391-25480-3-git-send-email-ludovic.Barre@st.com>
 <1d693fee-2804-01ec-f0a6-ef5ca1854b46@arm.com>
Message-ID: <cb1943ea-1ca9-3a90-252c-d11b9de11b03@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Marc

sorry for previous message in html
(recently, I've changed my laptop and forgot my setup for plain text) :-(

On 08/07/2017 03:21 PM, Marc Zyngier wrote:
> On 07/07/17 08:26, Ludovic Barre wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> -prepare to manage multi-bank
>> -prepare to manage registers offset by compatible
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   drivers/irqchip/irq-stm32-exti.c | 137 ++++++++++++++++++++++++++-------------
>>   1 file changed, 91 insertions(+), 46 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
>> index 491568c..308cef5 100644
>> --- a/drivers/irqchip/irq-stm32-exti.c
>> +++ b/drivers/irqchip/irq-stm32-exti.c
>> @@ -14,27 +14,52 @@
>>   #include <linux/of_address.h>
>>   #include <linux/of_irq.h>
>>   
>> -#define EXTI_IMR	0x0
>> -#define EXTI_EMR	0x4
>> -#define EXTI_RTSR	0x8
>> -#define EXTI_FTSR	0xc
>> -#define EXTI_SWIER	0x10
>> -#define EXTI_PR		0x14
>> +struct stm32_exti_bank {
>> +	u32 imr_ofst;
>> +	u32 emr_ofst;
>> +	u32 rtsr_ofst;
>> +	u32 ftsr_ofst;
>> +	u32 swier_ofst;
>> +	u32 pr_ofst;
>> +
>> +	u32 irqs_mask;
>> +};
> 
> This looks weird. On one hand, you have a set of offsets that are
> typical of the HW, and yet you add to it a mask that is read from the HW
> (and not hardcoded like the rest).
oops,  It is a residue, (set in probe but not used)
So, I will remove irqs_mask, and adds a const

> 
>> +
>> +static struct stm32_exti_bank stm32f4xx_exti_b1 = {
>> +	.imr_ofst	= 0x00,
>> +	.emr_ofst	= 0x04,
>> +	.rtsr_ofst	= 0x08,
>> +	.ftsr_ofst	= 0x0C,
>> +	.swier_ofst	= 0x10,
>> +	.pr_ofst	= 0x14,
>> +};
> 
> And this prevents making this structure const, which it should be.
> 
>> +
>> +static struct stm32_exti_bank *stm32f4xx_exti_banks[] = {
>> +	&stm32f4xx_exti_b1,
>> +};
>>   
>>   static void stm32_irq_handler(struct irq_desc *desc)
>>   {
>>   	struct irq_domain *domain = irq_desc_get_handler_data(desc);
>> -	struct irq_chip_generic *gc = domain->gc->gc[0];
>>   	struct irq_chip *chip = irq_desc_get_chip(desc);
>> +	unsigned int virq, nbanks = domain->gc->num_chips;
>> +	struct irq_chip_generic *gc;
>> +	struct stm32_exti_bank *stm32_bank;
>>   	unsigned long pending;
>> -	int n;
>> +	int n, i, irq_base = 0;
>>   
>>   	chained_irq_enter(chip, desc);
>>   
>> -	while ((pending = irq_reg_readl(gc, EXTI_PR))) {
>> -		for_each_set_bit(n, &pending, BITS_PER_LONG) {
>> -			generic_handle_irq(irq_find_mapping(domain, n));
>> -			irq_reg_writel(gc, BIT(n), EXTI_PR);
>> +	for (i = 0; i < nbanks; i++, irq_base += BITS_PER_LONG) {
> 
> Are you guaranteed that all the interrupts are organised in a linear
> way? No hole between them? Ever?
currently, Exti could manage up to N linear input events distributed in 
X banks of 32 events.
example H7 has 96 events => 3*32
There is no hole between the bank, but some inputs may not be connected 
(hardware design choice).

> 
>> +		gc = irq_get_domain_generic_chip(domain, irq_base);
>> +		stm32_bank = gc->private;
>> +
>> +		while ((pending = irq_reg_readl(gc, stm32_bank->pr_ofst))) {
>> +			for_each_set_bit(n, &pending, BITS_PER_LONG) {
>> +				virq = irq_find_mapping(domain, irq_base + n);
>> +				generic_handle_irq(virq);
>> +				irq_reg_writel(gc, BIT(n), stm32_bank->pr_ofst);
> 
> This code doesn't look very good. Since you already have the bank as
> part of your gc structure, why don't you add a set of wrappers such as:
> 
> static void stm32_irq_write_pr(struct irq_chip_generic *gc, u32 val)
> {
> 	struct stm32_exti_bank *bank = gc->private;
> 	irq_reg_writel(gc, val, bank->pr_ofst);
> }
> 
> Nobody really want to know about this offset business, so just hide it
> as much as possible.
yes, you're right.  I will create a "stm32_exti_pending" and
"stm32_exti_irq_ack" functions

> 
>> +			}
>>   		}
>>   	}
>>   
>> @@ -44,13 +69,14 @@ static void stm32_irq_handler(struct irq_desc *desc)
>>   static int stm32_irq_set_type(struct irq_data *data, unsigned int type)
>>   {
>>   	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
>> -	int pin = data->hwirq;
>> +	struct stm32_exti_bank *stm32_bank = gc->private;
>> +	int pin = data->hwirq % BITS_PER_LONG;
>>   	u32 rtsr, ftsr;
>>   
>>   	irq_gc_lock(gc);
>>   
>> -	rtsr = irq_reg_readl(gc, EXTI_RTSR);
>> -	ftsr = irq_reg_readl(gc, EXTI_FTSR);
>> +	rtsr = irq_reg_readl(gc, stm32_bank->rtsr_ofst);
>> +	ftsr = irq_reg_readl(gc, stm32_bank->ftsr_ofst);
>>   
>>   	switch (type) {
>>   	case IRQ_TYPE_EDGE_RISING:
>> @@ -70,8 +96,8 @@ static int stm32_irq_set_type(struct irq_data *data, unsigned int type)
>>   		return -EINVAL;
>>   	}
>>   
>> -	irq_reg_writel(gc, rtsr, EXTI_RTSR);
>> -	irq_reg_writel(gc, ftsr, EXTI_FTSR);
>> +	irq_reg_writel(gc, rtsr, stm32_bank->rtsr_ofst);
>> +	irq_reg_writel(gc, ftsr, stm32_bank->ftsr_ofst);
>>   
>>   	irq_gc_unlock(gc);
>>   
>> @@ -81,17 +107,18 @@ static int stm32_irq_set_type(struct irq_data *data, unsigned int type)
>>   static int stm32_irq_set_wake(struct irq_data *data, unsigned int on)
>>   {
>>   	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
>> -	int pin = data->hwirq;
>> +	struct stm32_exti_bank *stm32_bank = gc->private;
>> +	int pin = data->hwirq % BITS_PER_LONG;
>>   	u32 emr;
>>   
>>   	irq_gc_lock(gc);
>>   
>> -	emr = irq_reg_readl(gc, EXTI_EMR);
>> +	emr = irq_reg_readl(gc, stm32_bank->emr_ofst);
>>   	if (on)
>>   		emr |= BIT(pin);
>>   	else
>>   		emr &= ~BIT(pin);
>> -	irq_reg_writel(gc, emr, EXTI_EMR);
>> +	irq_reg_writel(gc, emr, stm32_bank->emr_ofst);
>>   
>>   	irq_gc_unlock(gc);
>>   
>> @@ -101,11 +128,12 @@ static int stm32_irq_set_wake(struct irq_data *data, unsigned int on)
>>   static int stm32_exti_alloc(struct irq_domain *d, unsigned int virq,
>>   			    unsigned int nr_irqs, void *data)
>>   {
>> -	struct irq_chip_generic *gc = d->gc->gc[0];
>> +	struct irq_chip_generic *gc;
>>   	struct irq_fwspec *fwspec = data;
>>   	irq_hw_number_t hwirq;
>>   
>>   	hwirq = fwspec->param[0];
>> +	gc = irq_get_domain_generic_chip(d, hwirq);
>>   
>>   	irq_map_generic_chip(d, virq, hwirq);
>>   	irq_domain_set_info(d, virq, hwirq, &gc->chip_types->chip, gc,
>> @@ -129,8 +157,8 @@ struct irq_domain_ops irq_exti_domain_ops = {
>>   	.free	= stm32_exti_free,
>>   };
>>   
>> -static int __init stm32_exti_init(struct device_node *node,
>> -				  struct device_node *parent)
>> +static int __init stm32_exti_init(struct stm32_exti_bank **stm32_exti_banks,
>> +				  int bank_nr, struct device_node *node)
>>   {
>>   	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
>>   	int nr_irqs, nr_exti, ret, i;
>> @@ -144,23 +172,16 @@ static int __init stm32_exti_init(struct device_node *node,
>>   		return -ENOMEM;
>>   	}
>>   
>> -	/* Determine number of irqs supported */
>> -	writel_relaxed(~0UL, base + EXTI_RTSR);
>> -	nr_exti = fls(readl_relaxed(base + EXTI_RTSR));
>> -	writel_relaxed(0, base + EXTI_RTSR);
>> -
>> -	pr_info("%s: %d External IRQs detected\n", node->full_name, nr_exti);
>> -
>> -	domain = irq_domain_add_linear(node, nr_exti,
>> +	domain = irq_domain_add_linear(node, bank_nr * BITS_PER_LONG,
> 
> You used to size the domain with the number of *implemented* interrupts.
> Now, it becomes something else. Why is that so?
when there was only 32 events we could use number of implemented event,
anyway the 32 events was parsed in stm32_irq_handler.
Today the irq number allow to look up the appropriate bank

  Also, is BITS_PER_LONG
> the right macro? Shouldn't it be something like "IRQS_PER_BANK", or
> something similar? Just in case someone recycles this block on a 64bit
> CPU...
I just reuse "BITS_PER_LONG" used in stm32_irq_handler.
But yes, that make sense to change to IRQS_PER_BANK.

> 
>>   				       &irq_exti_domain_ops, NULL);
>>   	if (!domain) {
>>   		pr_err("%s: Could not register interrupt domain.\n",
>> -				node->name);
>> +		       node->name);
>>   		ret = -ENOMEM;
>>   		goto out_unmap;
>>   	}
>>   
>> -	ret = irq_alloc_domain_generic_chips(domain, nr_exti, 1, "exti",
>> +	ret = irq_alloc_domain_generic_chips(domain, BITS_PER_LONG, 1, "exti",
> 
> And here, you're not multiplying it by the number of banks. Why?
The goal is to create one domain with "bank_nr" generic chips (for stm32 
h7: 1 domain with 3 gc).
irq_alloc_domain_generic_chips funtion set  dgc->num_chips = 
irqs_per_chip / domain size.
like this, each gc match with a bank (each gc has bank specification in 
gc->private = stm32_bank_N).
irq_get_domain_generic_chip allow to look up bank specification with 
"irq number" (see stm32_irq_handler).
I'm inspired of  irq-atmel-aic-common.c or irq-bcm7120-l2c

> 
>>   					     handle_edge_irq, clr, 0, 0);
>>   	if (ret) {
>>   		pr_err("%s: Could not allocate generic interrupt chip.\n",
>> @@ -168,18 +189,35 @@ static int __init stm32_exti_init(struct device_node *node,
>>   		goto out_free_domain;
>>   	}
>>   
>> -	gc = domain->gc->gc[0];
>> -	gc->reg_base                         = base;
>> -	gc->chip_types->type               = IRQ_TYPE_EDGE_BOTH;
>> -	gc->chip_types->chip.name          = gc->chip_types[0].chip.name;
>> -	gc->chip_types->chip.irq_ack       = irq_gc_ack_set_bit;
>> -	gc->chip_types->chip.irq_mask      = irq_gc_mask_clr_bit;
>> -	gc->chip_types->chip.irq_unmask    = irq_gc_mask_set_bit;
>> -	gc->chip_types->chip.irq_set_type  = stm32_irq_set_type;
>> -	gc->chip_types->chip.irq_set_wake  = stm32_irq_set_wake;
>> -	gc->chip_types->regs.ack           = EXTI_PR;
>> -	gc->chip_types->regs.mask          = EXTI_IMR;
>> -	gc->chip_types->handler            = handle_edge_irq;
>> +	for (i = 0; i < bank_nr; i++) {
>> +		struct stm32_exti_bank *stm32_bank = stm32_exti_banks[i];
>> +		u32 irqs_mask;
>> +
>> +		gc = irq_get_domain_generic_chip(domain, i * BITS_PER_LONG);
>> +
>> +		gc->reg_base = base;
>> +		gc->chip_types->type = IRQ_TYPE_EDGE_BOTH;
>> +		gc->chip_types->chip.name = gc->chip_types[0].chip.name;
>> +		gc->chip_types->chip.irq_ack = irq_gc_ack_set_bit;
>> +		gc->chip_types->chip.irq_mask = irq_gc_mask_clr_bit;
>> +		gc->chip_types->chip.irq_unmask = irq_gc_mask_set_bit;
>> +		gc->chip_types->chip.irq_set_type = stm32_irq_set_type;
>> +		gc->chip_types->chip.irq_set_wake = stm32_irq_set_wake;
>> +		gc->chip_types->regs.ack = stm32_bank->pr_ofst;
>> +		gc->chip_types->regs.mask = stm32_bank->imr_ofst;
>> +		gc->chip_types->handler = handle_edge_irq;
>> +		gc->private = stm32_bank;
>> +
>> +		/* Determine number of irqs supported */
>> +		writel_relaxed(~0UL, base + stm32_bank->rtsr_ofst);
>> +		irqs_mask = readl_relaxed(base + stm32_bank->rtsr_ofst);
>> +		stm32_bank->irqs_mask = irqs_mask;
>> +		nr_exti = fls(readl_relaxed(base + stm32_bank->rtsr_ofst));
>> +		writel_relaxed(0, base + stm32_bank->rtsr_ofst);
>> +
>> +		pr_info("%s: bank%d, External IRQs available:%#x\n",
>> +			node->full_name, i, irqs_mask);
>> +	}
>>   
>>   	nr_irqs = of_irq_count(node);
>>   	for (i = 0; i < nr_irqs; i++) {
>> @@ -198,4 +236,11 @@ static int __init stm32_exti_init(struct device_node *node,
>>   	return ret;
>>   }
>>   
>> -IRQCHIP_DECLARE(stm32_exti, "st,stm32-exti", stm32_exti_init);
>> +static int __init stm32f4_exti_of_init(struct device_node *np,
>> +				       struct device_node *parent)
>> +{
>> +	return stm32_exti_init(stm32f4xx_exti_banks,
>> +			ARRAY_SIZE(stm32f4xx_exti_banks), np);
>> +}
>> +
>> +IRQCHIP_DECLARE(stm32f4_exti, "st,stm32-exti", stm32f4_exti_of_init);
>>
> 
> Thanks,
> 
> 	M.
> 

BR
Ludo
