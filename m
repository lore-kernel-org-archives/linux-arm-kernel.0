From: pnetrisk@gmail.com (dballman)
Date: Wed, 12 May 2010 10:29:04 +0200
Subject: Unnecessary double check of PIO_ISR in gpio_irq_handler?
Message-ID: <w2p30e5226d1005120129g829eb39ei581d1ae3248f4fa5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

In the following function of the file arch/arm/mach-at91/gpio.c it can
be seen that when PIO_ISR is read to check pending interrupts, if no
interrupts are pending the PIO_ISR of the next bank is read by doing a
at91_gpio = at91_gpio->next; and then a continue. But if interrupts
are pending, the code inside while(isr) is executed and when it
finishes it doesn't do the at91_gpio = at91_gpio->next, reading the
same PIO_ISR again in the next iteration.

Since the PIO_ISR register is cleared when it's read, does this
behavior make sense? Maybe it should have to be done the same
at91_gpio = at91_gpio->next whenever possible at the end of the while
loop?

Best regards

static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
{
	unsigned	pin;
	struct irq_desc	*gpio;
	struct at91_gpio_chip *at91_gpio;
	void __iomem	*pio;
	u32		isr;

	at91_gpio = get_irq_chip_data(irq);
	pio = at91_gpio->regbase;

	/* temporarily mask (level sensitive) parent IRQ */
	desc->chip->ack(irq);
	for (;;) {
		/* Reading ISR acks pending (edge triggered) GPIO interrupts.
		 * When there none are pending, we're finished unless we need
		 * to process multiple banks (like ID_PIOCDE on sam9263).
		 */
		isr = __raw_readl(pio + PIO_ISR) & __raw_readl(pio + PIO_IMR);
		if (!isr) {
			if (!at91_gpio->next)
				break;
			at91_gpio = at91_gpio->next;
			pio = at91_gpio->regbase;
			continue;
		}

		pin = at91_gpio->chip.base;
		gpio = &irq_desc[pin];

		while (isr) {
			if (isr & 1) {
				if (unlikely(gpio->depth)) {
					/*
					 * The core ARM interrupt handler lazily disables IRQs so
					 * another IRQ must be generated before it actually gets
					 * here to be disabled on the GPIO controller.
					 */
					gpio_irq_mask(pin);
				}
				else
					generic_handle_irq(pin);
			}
			pin++;
			gpio++;
			isr >>= 1;
		}
	}
	desc->chip->unmask(irq);
	/* now it may re-trigger */
}
