From: tglx@linutronix.de (Thomas Gleixner)
Date: Sun, 28 Oct 2012 18:34:50 +0100 (CET)
Subject: irq_set_chained_handler() called too early for hwirq to be
 initialized
In-Reply-To: <508D55C9.3030702@antcom.de>
References: <508D55C9.3030702@antcom.de>
Message-ID: <alpine.LFD.2.02.1210281810390.2756@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 28 Oct 2012, Roland Stigge wrote:
> 
> consider arch/arm/mach-lpc32xx/irq.c: irq_set_chained_handler() is
> called at a point where it accesses
> irq_to_desc(IRQ_LPC32XX_SUB2IRQ)->irq_data.hwirq but which is not yet
> initialized.

None of the functions which are called inside of
irq_set_chained_handler() touches desc->irq_data.hwirq.

So what are you talking about?

I just had a look into that lpc32xx irq code. At the end of
lpc32xx_init_irq():

        irq_base = irq_alloc_descs(-1, 0, NR_IRQS, 0);
        if (irq_base < 0) {
                pr_warn("Cannot allocate irq_descs, assuming pre-allocated\n");
                irq_base = 0;
        }

That's just hilarious.

Of course are the interrupts preallocated, simply because
machine_desc->nr_irqs is 0 and therefor the ARM core code allocates
NR_IRQS irq descriptors in the early setup way before
lpc32xx_init_irq() is called.

If those interrupts would not be preallocated, then the code would
fail to initialize any interrupt at all. And of course nothing would
notice as all function calls to set_irq_* do not check the return
value.

That brilliant thing came in via commit f5c42271 (ARM: LPC32xx: Device
tree support). I have no idea from where you copied that and why you
thought putting it at the end of the init function would be a good
idea.

Though, that has nothing todo with your problem description above.

Thanks,

	tglx
