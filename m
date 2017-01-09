From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 9 Jan 2017 15:25:26 +0000
Subject: [PATCH V9 3/3] irqchip: qcom: Add IRQ combiner driver
In-Reply-To: <a1d3e5706ea8c97a4712a8fb33db71ca@codeaurora.org>
References: <1481753438-3905-1-git-send-email-agustinv@codeaurora.org>
 <1481753438-3905-4-git-send-email-agustinv@codeaurora.org>
 <ded278ef-a0a2-811a-f362-70555f74d6fc@arm.com>
 <a1d3e5706ea8c97a4712a8fb33db71ca@codeaurora.org>
Message-ID: <a292f6c6-8b55-a2a9-c5a4-12c114816c91@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/17 13:17, Agustin Vega-Frias wrote:
> Hey Marc,
> 
> On 2017-01-05 11:48, Marc Zyngier wrote:
>> Hi Agustin,
>>
>> On 14/12/16 22:10, Agustin Vega-Frias wrote:
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
>>>  drivers/irqchip/Kconfig             |   9 +
>>>  drivers/irqchip/Makefile            |   1 +
>>>  drivers/irqchip/qcom-irq-combiner.c | 322 
>>> ++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 332 insertions(+)
>>>  create mode 100644 drivers/irqchip/qcom-irq-combiner.c
>>>
>>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>>> index bc0af33..3e3430c 100644
>>> --- a/drivers/irqchip/Kconfig
>>> +++ b/drivers/irqchip/Kconfig
>>> @@ -279,3 +279,12 @@ config EZNPS_GIC
>>>  config STM32_EXTI
>>>  	bool
>>>  	select IRQ_DOMAIN
>>> +
>>> +config QCOM_IRQ_COMBINER
>>> +	bool "QCOM IRQ combiner support"
>>> +	depends on ARCH_QCOM && ACPI
>>> +	select IRQ_DOMAIN
>>> +	select IRQ_DOMAIN_HIERARCHY
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
>>> index 0000000..0055e08
>>> --- /dev/null
>>> +++ b/drivers/irqchip/qcom-irq-combiner.c
>>> @@ -0,0 +1,322 @@
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
>>
>> I'm a bit worried by this. If I understand it well, this is a pure
>> software construct (controlled from combiner_irq_chip_{un,}mask_irq) 
>> and
>> there is nothing that actually masks the interrupt at the HW level.
>>
>> So if a device asserts its interrupt line, what mechanism do we have to
>> make sure that we don't end-up with the CPU pegged in interrupt 
>> context?
>>
> 
> Yes, unfortunately this is a dumb hardware combiner; however, the
> real use of mask here is to optimize IRQ handling if the combiner
> instance has its IRQ statuses across more than one register.
> Currently all active instances only use one register, but we are
> getting close to 32 in one case, so I wanted to accommodate a general
> case where an instance can combine more than 32 IRQs.
> 
> Having said that, what I'm inclined to do is to remove the use of mask
> on the status read form the register on the next two lines, and then let
> irq_find_mapping fail if we are getting an unexpected IRQ, then call
> handle_bad_irq(desc).

Unfortunately, having a mapping in place is not an indication that
someone can handle the interrupt. Also, you still need to handle
mask/unmask, and I don't see how you manage that, given that this
interrupt combiner seems to be a glorified OR gate.

> Do you have any other suggestions to handle the scenario? E.g., can we
> safely disable the parent IRQ from this context if we see too many
> spurious interrupts?

I don't think so. There is two issues here:
- If a device is stuck with an active interrupt, you won't be able to
reliably detect that this is an invalid condition (the mapping trick
above is not reliable, and generic_handle_irq doesn't return anything
useful)
- Even if you could detect it, what do you do? Killing the cascade
interrupt would also kill all the other devices. Is that something
acceptable in your setup? Can you implement mask/unmask the same way?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
