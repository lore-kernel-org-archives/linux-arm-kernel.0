From: stigge@antcom.de (Roland Stigge)
Date: Sun, 28 Oct 2012 16:56:57 +0100
Subject: irq_set_chained_handler() called too early for hwirq to be initialized
Message-ID: <508D55C9.3030702@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

consider arch/arm/mach-lpc32xx/irq.c: irq_set_chained_handler() is
called at a point where it accesses
irq_to_desc(IRQ_LPC32XX_SUB2IRQ)->irq_data.hwirq but which is not yet
initialized.

(This bug just surfaced on lpc32xx when the chained interrupt controller
SIC2 wasn't working. SIC1 does, but just by chance: The uninitialized
value 0 is just coincidentally the correct one.)

...->hwirq is actually defined only later on in lpc32xx_init_irq() at
irq_domain_add_legacy(). Ideally, I would just move the
irq_set_chained_handler() calls to after of_irq_init() and
irq_domain_add_legacy(). Is this OK or does this produce any race condition?

Thanks in advance,

Roland
