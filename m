From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 6 Jun 2017 09:39:25 +0200 (CEST)
Subject: Design of interrupt controller driver
In-Reply-To: <77a6e423-5c6a-9e5a-d679-c2576074fe6d@free.fr>
References: <8bce8bdd-5801-f0c3-ada3-e1c68acc8913@free.fr>
 <alpine.DEB.2.20.1706041551530.2813@nanos>
 <025780ef-06e6-1e85-58da-4ce8f6c93536@free.fr>
 <alpine.DEB.2.20.1706042208080.3517@nanos>
 <6e4da485-42cc-9b70-1b4a-9729f646e014@free.fr>
 <alpine.DEB.2.20.1706051007050.3517@nanos>
 <77a6e423-5c6a-9e5a-d679-c2576074fe6d@free.fr>
Message-ID: <alpine.DEB.2.20.1706060922220.1885@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Jun 2017, Mason wrote:
> Is it possible to call the interrupt controller's mask callback
> from the DMA engine driver ISR, or is that reserved for the IRQ
> framework? Because that's what the HW designers had in mind,
> thus they didn't provide a way to mask the interrupt in the
> device. It just outputs the signal to the interrupt router.

No, it's not and we are not going to provide an interface for that because
that violates any form of layering and abstractions. The DMA device driver
has to be oblivious of the underlying interrupt handling machinery.

> So their proposed setup is as follows:
> 
> Start the system with the DMA interrupt masked in the intc.
> When SW needs to perform a DMA op, the DMA driver starts
> the op (thus the interrupt signal goes low), then unmasks
> the interrupt in the intc. Interrupt triggers when signal
> goes high (level high). Driver masks interrupt in ISR,
> until next op is available.
> 
> Is that possible in the Linux framework?

You can do that, but not for shared interrupts:

isr()
{
	disable_irq_nosync();
	.....
}

submit()
{
	....
	enable_irq();
}

init()
{
	irq_set_status_flags(irq, IRQ_NOAUTOEN);
	request_irq(irq, ....);
}

This affects the whole interrupt line, so if you share that interrupt at
the CPU interrupt controller level this wont work.

If your 'router' IP has a mechanism to mask input lines individually, then
you can do something about this.

Each group of inputs which shares an output becomes it's own demultiplexing
interrupt domain with it's own interrupt chip which controls the input
lines. The output is handled by a chained interrupt handler which checks
the status of the input lines and invokes the handlers for the devices with
an active input.

Then the above example will disable the interrupt at the 'router' level
which will not affect the other device which shares the underlying output
to the GIC (or whatever interrupt controller your CPU has).

Thanks,

	tglx
