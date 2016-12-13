From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 13 Dec 2016 15:29:33 +0000
Subject: [PATCH V8 3/3] irqchip: qcom: Add IRQ combiner driver
In-Reply-To: <78bfd90d47200347628f7dd98451122f@codeaurora.org>
References: <1480460259-8585-1-git-send-email-agustinv@codeaurora.org>
 <1480460259-8585-4-git-send-email-agustinv@codeaurora.org>
 <b009635d-8a10-5e22-4438-0019d79d01d3@arm.com>
 <78bfd90d47200347628f7dd98451122f@codeaurora.org>
Message-ID: <16d16d25-1cbd-ea8c-a752-49dd264b4275@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/12/16 15:23, Agustin Vega-Frias wrote:
> On 2016-12-07 13:16, Marc Zyngier wrote:
>> Hi Agustin,
>>
>> On 29/11/16 22:57, Agustin Vega-Frias wrote:
>>> Driver for interrupt combiners in the Top-level Control and Status
>>> Registers (TCSR) hardware block in Qualcomm Technologies chips.
>>>
>>> An interrupt combiner in this block combines a set of interrupts by
>>> OR'ing the individual interrupt signals into a summary interrupt
>>> signal routed to a parent interrupt controller, and provides read-
>>> only, 32-bit registers to query the status of individual interrupts.
>>> The status bit for IRQ n is bit (n % 32) within register (n / 32)
>>> of the given combiner. Thus, each combiner can be described as a set
>>> of register offsets and the number of IRQs managed.
>>>
>>> Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
>>> ---
>>>  drivers/irqchip/Kconfig             |   8 +
>>>  drivers/irqchip/Makefile            |   1 +
>>>  drivers/irqchip/qcom-irq-combiner.c | 337 
>>> ++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 346 insertions(+)
>>>  create mode 100644 drivers/irqchip/qcom-irq-combiner.c
>>>
>>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>>> index bc0af33..610f902 100644
>>> --- a/drivers/irqchip/Kconfig
>>> +++ b/drivers/irqchip/Kconfig
>>> @@ -279,3 +279,11 @@ config EZNPS_GIC
>>>  config STM32_EXTI
>>>  	bool
>>>  	select IRQ_DOMAIN
>>> +
>>> +config QCOM_IRQ_COMBINER
>>> +	bool "QCOM IRQ combiner support"
>>> +	depends on ARCH_QCOM
>>> +	select IRQ_DOMAIN
>>> +	help
>>> +	  Say yes here to add support for the IRQ combiner devices embedded
>>> +	  in Qualcomm Technologies chips.
>>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>>> index e4dbfc8..1818a0b 100644
>>> --- a/drivers/irqchip/Makefile
>>> +++ b/drivers/irqchip/Makefile
>>> @@ -74,3 +74,4 @@ obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
>>>  obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
>>>  obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o
>>>  obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
>>> +obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
>>> diff --git a/drivers/irqchip/qcom-irq-combiner.c 
>>> b/drivers/irqchip/qcom-irq-combiner.c
>>> new file mode 100644
>>> index 0000000..fc25251
>>> --- /dev/null
>>> +++ b/drivers/irqchip/qcom-irq-combiner.c
>>> @@ -0,0 +1,337 @@
>>> +/* Copyright (c) 2015-2016, The Linux Foundation. All rights 
>>> reserved.
>>> + *
>>> + * This program is free software; you can redistribute it and/or 
>>> modify
>>> + * it under the terms of the GNU General Public License version 2 and
>>> + * only version 2 as published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + */
>>> +
>>> +/*
>>> + * Driver for interrupt combiners in the Top-level Control and Status
>>> + * Registers (TCSR) hardware block in Qualcomm Technologies chips.
>>> + * An interrupt combiner in this block combines a set of interrupts 
>>> by
>>> + * OR'ing the individual interrupt signals into a summary interrupt
>>> + * signal routed to a parent interrupt controller, and provides read-
>>> + * only, 32-bit registers to query the status of individual 
>>> interrupts.
>>> + * The status bit for IRQ n is bit (n % 32) within register (n / 32)
>>> + * of the given combiner. Thus, each combiner can be described as a 
>>> set
>>> + * of register offsets and the number of IRQs managed.
>>> + */
>>> +
>>> +#include <linux/acpi.h>
>>> +#include <linux/irqchip/chained_irq.h>
>>> +#include <linux/irqdomain.h>
>>> +#include <linux/platform_device.h>
>>> +
>>> +#define REG_SIZE 32
>>> +
>>> +struct combiner_reg {
>>> +	void __iomem *addr;
>>> +	unsigned long mask;
>>> +};
>>> +
>>> +struct combiner {
>>> +	struct irq_chip     irq_chip;
>>> +	struct irq_domain   *domain;
>>> +	int                 parent_irq;
>>> +	u32                 nirqs;
>>> +	u32                 nregs;
>>> +	struct combiner_reg regs[0];
>>> +};
>>> +
>>> +static inline u32 irq_register(int irq)
>>> +{
>>> +	return irq / REG_SIZE;
>>> +}
>>> +
>>> +static inline u32 irq_bit(int irq)
>>> +{
>>> +	return irq % REG_SIZE;
>>> +
>>> +}
>>> +
>>> +static inline int irq_nr(u32 reg, u32 bit)
>>> +{
>>> +	return reg * REG_SIZE + bit;
>>> +}
>>> +
>>> +/*
>>> + * Handler for the cascaded IRQ.
>>> + */
>>> +static void combiner_handle_irq(struct irq_desc *desc)
>>> +{
>>> +	struct combiner *combiner = irq_desc_get_handler_data(desc);
>>> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>>> +	u32 reg;
>>> +
>>> +	chained_irq_enter(chip, desc);
>>> +
>>> +	for (reg = 0; reg < combiner->nregs; reg++) {
>>> +		int virq;
>>> +		int hwirq;
>>> +		u32 bit;
>>> +		u32 status;
>>> +
>>> +		if (combiner->regs[reg].mask == 0)
>>> +			continue;
>>> +
>>> +		status = readl_relaxed(combiner->regs[reg].addr);
>>> +		status &= combiner->regs[reg].mask;
>>> +
>>> +		while (status) {
>>> +			bit = __ffs(status);
>>> +			status &= ~(1 << bit);
>>> +			hwirq = irq_nr(reg, bit);
>>> +			virq = irq_find_mapping(combiner->domain, hwirq);
>>> +			if (virq >= 0)
>>> +				generic_handle_irq(virq);
>>> +
>>> +		}
>>> +	}
>>> +
>>> +	chained_irq_exit(chip, desc);
>>> +}
>>> +
>>> +/*
>>> + * irqchip callbacks
>>> + */
>>> +
>>> +static void combiner_irq_chip_mask_irq(struct irq_data *data)
>>> +{
>>> +	struct combiner *combiner = irq_data_get_irq_chip_data(data);
>>> +	struct combiner_reg *reg = combiner->regs + 
>>> irq_register(data->hwirq);
>>> +
>>> +	clear_bit(irq_bit(data->hwirq), &reg->mask);
>>> +}
>>> +
>>> +static void combiner_irq_chip_unmask_irq(struct irq_data *data)
>>> +{
>>> +	struct combiner *combiner = irq_data_get_irq_chip_data(data);
>>> +	struct combiner_reg *reg = combiner->regs + 
>>> irq_register(data->hwirq);
>>> +
>>> +	set_bit(irq_bit(data->hwirq), &reg->mask);
>>> +}
>>> +
>>> +/*
>>> + * irq_domain_ops callbacks
>>> + */
>>> +
>>> +static int combiner_irq_map(struct irq_domain *domain, unsigned int 
>>> irq,
>>> +				   irq_hw_number_t hwirq)
>>> +{
>>> +	struct combiner *combiner = domain->host_data;
>>> +
>>> +	if (hwirq >= combiner->nirqs)
>>> +		return -EINVAL;
>>> +
>>> +	irq_set_chip_and_handler(irq, &combiner->irq_chip, 
>>> handle_level_irq);
>>> +	irq_set_chip_data(irq, combiner);
>>> +	irq_set_parent(irq, combiner->parent_irq);
>>
>> Do you really need this irq_set_parent? This only makes sense if you're
>> resending edge interrupts, and you seem to be level only.
> 
> OK, I'll take a look.
> 
>>
>>> +	irq_set_noprobe(irq);
>>> +	return 0;
>>> +}
>>> +
>>> +static void combiner_irq_unmap(struct irq_domain *domain, unsigned 
>>> int irq)
>>> +{
>>> +	irq_set_chip_and_handler(irq, NULL, NULL);
>>> +	irq_set_chip_data(irq, NULL);
>>> +	irq_set_parent(irq, -1);
>>
>> All of this should probably be replaced with a call to
>> irq_domain_reset_irq_data().
> 
> Will do.
> 
>>
>>> +}
>>> +
>>> +#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
>>
>> Is there any case where this is not valid?
> 
> What do you mean? Are you asking why is this under a preprocessor
> conditional? If so I did it to be on the safe side since translate
> in struct irq_domain_ops under that conditional.

Since this code can only work when CONFIG_IRQ_DOMAIN_HIERARCHY is
selected, you might as well make the KConfig entry select (or depend on
- I'm always confused about which one should be used when) this
configuration symbol, and make the code more readable.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
