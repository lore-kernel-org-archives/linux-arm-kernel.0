From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 13 Nov 2009 11:55:19 +0000
Subject: [PATCH 05/10] mfd add irq support in 88pm860x
In-Reply-To: <771cded00911130059q23c2bc97ja4509b7965f12eed@mail.gmail.com>
References: <771cded00911130059q23c2bc97ja4509b7965f12eed@mail.gmail.com>
Message-ID: <20091113115519.GA30966@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 13, 2009 at 03:59:21AM -0500, Haojian Zhuang wrote:

> +int pm860x_request_irq(struct pm860x_chip *chip, int irq,
> +		       void (*handle_irq)(struct pm860x_chip *, int, void *),
> +		       void *data)
> +{

It might be nice to make the IRQ handler be an irq_handler_t - that way
if you convert the driver to use the generic IRQ infrastructure in
future it'll be straightforward to transition the drivers by providing
stub functions that pass through to generic IRQ.

Given that Thomas did the work it'd be good if we could use it
eventually :) .

> +#if 0
> +	mask = PM8607_MISC1_INV_INT | PM8607_MISC1_INT_CLEAR
> +		| PM8607_MISC1_INT_MASK;
> +	data = PM8607_MISC1_INT_CLEAR;
> +	chip->irq_mode = 1;
> +	if (pdata) {
> +		/*
> +		 * irq_mode defines the way of clearing interrupt.
> +		 * If it's 1, clear IRQ by write. Otherwise, clear it by read.
> +		 * This control bit is valid from 88PM8607 B0 steping.
> +		 */
> +		if ((chip->chip_id >= PM8607_CHIP_B0) && (!pdata->irq_mode)) {
> +			data = 0;
> +			chip->irq_mode = 0;
> +		}
> +	}
> +	ret = pm860x_set_bits(chip->parent, DESC_8607, PM8607_MISC1,
> +			      mask, data);
> +#else

The if 0 stuff should just be removed for mainline.
