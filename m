From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 25 Oct 2014 21:35:48 +0200 (CEST)
Subject: [PATCH 1/3] genirq: Allow the irqchip state of an IRQ to be
 save/restored
In-Reply-To: <1414232097-4328-2-git-send-email-marc.zyngier@arm.com>
References: <1414232097-4328-1-git-send-email-marc.zyngier@arm.com>
 <1414232097-4328-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.11.1410252131110.5308@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 25 Oct 2014, Marc Zyngier wrote:
> +int irq_get_irqchip_state(unsigned int irq, int state)
> +{
> +	struct irq_desc *desc;
> +	struct irq_data *data;
> +	struct irq_chip *chip;
> +	int val;
> +
> +	desc = irq_to_desc(irq);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	data = irq_desc_get_irq_data(desc);
> +
> +	chip = irq_desc_get_chip(desc);
> +	if (!chip->irq_get_irqchip_state)
> +		return -EINVAL;
> +
> +	chip_bus_lock(desc);
> +	val = chip->irq_get_irqchip_state(data, state);

Hmm. What's the irq_get_irqchip_state() callback supposed to return?

Thanks,

	tglx
