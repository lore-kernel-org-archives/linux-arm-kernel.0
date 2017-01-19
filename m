From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 19 Jan 2017 10:02:00 +0000
Subject: [PATCH V10 3/3] irqchip: qcom: Add IRQ combiner driver
In-Reply-To: <1484757988-23739-4-git-send-email-agustinv@codeaurora.org>
References: <1484757988-23739-1-git-send-email-agustinv@codeaurora.org>
 <1484757988-23739-4-git-send-email-agustinv@codeaurora.org>
Message-ID: <e1bc419d-345c-4500-0a46-b730ed9ecc18@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Agustin,

On 18/01/17 16:46, Agustin Vega-Frias wrote:
> Driver for interrupt combiners in the Top-level Control and Status
> Registers (TCSR) hardware block in Qualcomm Technologies chips.
> 
> An interrupt combiner in this block combines a set of interrupts by
> OR'ing the individual interrupt signals into a summary interrupt
> signal routed to a parent interrupt controller, and provides read-
> only, 32-bit registers to query the status of individual interrupts.
> The status bit for IRQ n is bit (n % 32) within register (n / 32)
> of the given combiner. Thus, each combiner can be described as a set
> of register offsets and the number of IRQs managed.
> 
> Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
> ---
>  drivers/irqchip/Kconfig             |   9 +
>  drivers/irqchip/Makefile            |   1 +
>  drivers/irqchip/qcom-irq-combiner.c | 319 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 329 insertions(+)
>  create mode 100644 drivers/irqchip/qcom-irq-combiner.c
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index ae96731..125528f 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -283,3 +283,12 @@ config EZNPS_GIC
>  config STM32_EXTI
>  	bool
>  	select IRQ_DOMAIN
> +
> +config QCOM_IRQ_COMBINER
> +	bool "QCOM IRQ combiner support"
> +	depends on ARCH_QCOM && ACPI
> +	select IRQ_DOMAIN
> +	select IRQ_DOMAIN_HIERARCHY
> +	help
> +	  Say yes here to add support for the IRQ combiner devices embedded
> +	  in Qualcomm Technologies chips.
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 0e55d94..5a531863 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -75,3 +75,4 @@ obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
>  obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
>  obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o
>  obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
> +obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
> diff --git a/drivers/irqchip/qcom-irq-combiner.c b/drivers/irqchip/qcom-irq-combiner.c
> new file mode 100644
> index 0000000..b7f0631
> --- /dev/null
> +++ b/drivers/irqchip/qcom-irq-combiner.c
> @@ -0,0 +1,319 @@
> +/* Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +/*
> + * Driver for interrupt combiners in the Top-level Control and Status
> + * Registers (TCSR) hardware block in Qualcomm Technologies chips.
> + * An interrupt combiner in this block combines a set of interrupts by
> + * OR'ing the individual interrupt signals into a summary interrupt
> + * signal routed to a parent interrupt controller, and provides read-
> + * only, 32-bit registers to query the status of individual interrupts.
> + * The status bit for IRQ n is bit (n % 32) within register (n / 32)
> + * of the given combiner. Thus, each combiner can be described as a set
> + * of register offsets and the number of IRQs managed.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/platform_device.h>
> +
> +#define REG_SIZE 32
> +
> +struct combiner_reg {
> +	void __iomem *addr;
> +	unsigned long mask;
> +};
> +
> +struct combiner {
> +	struct irq_domain   *domain;
> +	int                 parent_irq;
> +	u32                 nirqs;
> +	u32                 nregs;
> +	struct combiner_reg regs[0];
> +};
> +
> +static inline u32 irq_register(int irq)
> +{
> +	return irq / REG_SIZE;
> +}
> +
> +static inline u32 irq_bit(int irq)
> +{
> +	return irq % REG_SIZE;
> +
> +}
> +
> +static inline int irq_nr(u32 reg, u32 bit)
> +{
> +	return reg * REG_SIZE + bit;
> +}
> +
> +/*
> + * Handler for the cascaded IRQ.
> + */
> +static void combiner_handle_irq(struct irq_desc *desc)
> +{
> +	struct combiner *combiner = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	u32 reg;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	for (reg = 0; reg < combiner->nregs; reg++) {
> +		int virq;
> +		int hwirq;
> +		u32 bit;
> +		u32 status;
> +
> +		if (combiner->regs[reg].mask == 0) {
> +			WARN_ON(readl_relaxed(combiner->regs[reg].addr) != 0);

Since we've now established that you couldn't really mask interrupts at 
all, screaming like this is just going to make the matter worse. Please 
drop this, or at the very least ratelimit it. Also, this is really 
tortuous since your 'mask' is actually an 'enable' (you only accept an 
interrupt if the bit is set).

But let's look at what you're testing here: If no interrupt is enabled, 
scream if something is pending. I really wonder what you get by doing 
so -- pending and masked interrupts are extremely common, and because 
you cannot handle them doesn't mean you should kill the machine (which 
your WARN_ON is guaranteed to do). Also, this should be consolidated 
with the code below...

> +			continue;
> +		}
> +
> +		status = readl_relaxed(combiner->regs[reg].addr);
> +		WARN_ON((status & ~combiner->regs[reg].mask) != 0);
> +		status &= combiner->regs[reg].mask;

Same thing: protesting against masked+pending interrupts is futile. If 
they happen, your CPU is wedged anyway. I'd suggest that you drop the 0 
test case (which doesn't save anything anyway):

		#define pr_fmt(fmt)     "QCOM80B1:" fmt

		bit = readl_relaxed(combiner->regs[reg].addr);
		status = bit & combiner->regs[reg].mask;
		if (!status)
			pr_warn_ratelimited("screaming interrupt (%08x %08x), CPU%d wedged\n", 
					    bit, combiner->regs[reg].mask, smp_processor_id());

and that's it, as the rest of the code already takes care of the status==0
case. Optionally, you could disable the parent interrupt and kill all the
other devices connected to the same combiner, since that's your only
alternative to loosing a CPU.

> +
> +		while (status) {
> +			bit = __ffs(status);
> +			status &= ~(1 << bit);
> +			hwirq = irq_nr(reg, bit);
> +			virq = irq_find_mapping(combiner->domain, hwirq);
> +			if (virq > 0)
> +				generic_handle_irq(virq);
> +
> +		}
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +/*
> + * irqchip callbacks
> + */
> +
> +static void combiner_irq_chip_mask_irq(struct irq_data *data)
> +{
> +	struct combiner *combiner = irq_data_get_irq_chip_data(data);
> +	struct combiner_reg *reg = combiner->regs + irq_register(data->hwirq);
> +
> +	clear_bit(irq_bit(data->hwirq), &reg->mask);
> +}
> +
> +static void combiner_irq_chip_unmask_irq(struct irq_data *data)
> +{
> +	struct combiner *combiner = irq_data_get_irq_chip_data(data);
> +	struct combiner_reg *reg = combiner->regs + irq_register(data->hwirq);
> +
> +	set_bit(irq_bit(data->hwirq), &reg->mask);
> +}

I'd still advocate for 'mask' to be renamed 'enabled', or to have the
bits flipped the other way around. Your call.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
