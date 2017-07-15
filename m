From: slash.tmp@free.fr (Mason)
Date: Sun, 16 Jul 2017 01:46:58 +0200
Subject: [RFC PATCH v2] irqchip: Add support for tango interrupt router
In-Reply-To: <c0bd235a-9035-2002-31eb-e68710b076fd@free.fr>
References: <657580dd-0cfe-e377-e425-0deabf6d20c3@free.fr>
 <20170606175219.34ef62b9@free-electrons.com>
 <d8a4d8ad-a9f3-07eb-9e2a-a4bbec01961e@free.fr>
 <dfb86360-2247-65bb-602b-5c21029709fd@free.fr>
 <c0bd235a-9035-2002-31eb-e68710b076fd@free.fr>
Message-ID: <24f34220-a017-f4e0-b72e-d1fdb014c0e1@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/07/2017 15:06, Mason wrote:

> I have two remaining issues:
> 
> 1) In the ISR, I get the hwirq from the GIC. What is the
> API to translate that to the SPI? I'm currently just
> subtracting 32.

gic_set_type() in drivers/irqchip/irq-gic.c

	/* SPIs have restrictions on the supported types */
	if (gicirq >= 32 && type != IRQ_TYPE_LEVEL_HIGH &&
			    type != IRQ_TYPE_EDGE_RISING)
		return -EINVAL;


gic_irq_domain_translate() in the same file:

		/* Get the interrupt number and add 16 to skip over SGIs */
		*hwirq = fwspec->param[1] + 16;

		/*
		 * For SPIs, we need to add 16 more to get the GIC irq
		 * ID number
		 */
		if (!fwspec->param[0])
			*hwirq += 16;


So it seems "acceptable" to compute spi = d->hwirq - 32;


> 2) I'm currently using a single domain, with a
> handle_simple_irq domain handler. That's probably
> wrong. Should I define two domains, one for edge
> IRQs and one for level IRQs, and use the appropriate
> handler?  Should both domain have 128 entries?
> (I.e. are they indexed by the hwirq?)
> And should I use linear or tree?

I will read this again carefully:
https://www.kernel.org/doc/Documentation/IRQ-domain.txt

Regards.
