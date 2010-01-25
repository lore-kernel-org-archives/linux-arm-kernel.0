From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 25 Jan 2010 11:59:32 +0000
Subject: [PATCH 2/4] mfd: update irq handler in max8925
In-Reply-To: <771cded01001250308mfd2b3d2l76bc2a2df88e7b93@mail.gmail.com>
References: <771cded01001250308mfd2b3d2l76bc2a2df88e7b93@mail.gmail.com>
Message-ID: <20100125115930.GE22909@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2010 at 06:08:19AM -0500, Haojian Zhuang wrote:

> +static struct resource power_supply_resources[] = {
> +	{
> +		.name	= "max8925-power",
> +		.start	= MAX8925_CHG_IRQ1,
> +		.end	= MAX8925_CHG_IRQ1,
> +		.flags	= IORESOURCE_IO,

These should be IORESOURCE_IRQ.

> +		else if (value & irq_data->offs) {
> +			dev_err(chip->dev, "Noboday cares IRQ #%d. Mask it\n",
> +				chip->irq_base + i);
> +			max8925_set_bits(i2c, irq_data->mask_reg,
> +					irq_data->offs, irq_data->offs);

genirq ought to be handling this for you?

> +	for (i = 0; i < ARRAY_SIZE(max8925_irqs); i++) {
> +		irq_data = &max8925_irqs[i];
> +		/* non TSC IRQ should be serviced in max8925_irq() */
> +		if (!irq_data->tsc_irq)
> +			continue;

Shouldn't the interrupt handlers be able to avoid having to iterate
through the array?  It's unlikely to be expensive in the context of the
I/O but it looks a bit odd.

> + * clear_irq: operation on clearing status of nIRQ pin in platform
> + * clear_tsc_irq: operation on clearing status of nTIRQ pin in platform
> + */

Shouldn't these also be handled by genirq as functions of the interrupt
controller that the chip is chained from?
