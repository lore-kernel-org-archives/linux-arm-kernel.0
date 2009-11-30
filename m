From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Nov 2009 14:37:03 +0000
Subject: Get rid of IRQF_DISABLED - (was [PATCH] genirq: warn about
	IRQF_SHARED|IRQF_DISABLED)
In-Reply-To: <alpine.LFD.2.00.0911301225110.24119@localhost.localdomain>
References: <1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259578067-29169-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.0911301225110.24119@localhost.localdomain>
Message-ID: <20091130143703.GA7028@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2009 at 02:54:54PM +0100, Thomas Gleixner wrote:
> The correct solution IMNSHO is to get rid of IRQF_DISABLED and run
> interrupt handlers always with interrupts disabled and require them
> not to reenable interrupts themself.

I think Linus advocated at one point making the default be "irqs disabled"
and only only if a flag was passed would handlers run with IRQs enabled.
However, that might have been a step towards having all handlers running
with IRQs disabled.

I'm all in favour of it.  There are a large number of relatively simple
interrupt handlers out there which don't care about whether they're
called with IRQs disabled or not.

However, I think we still have a number of corner cases.  The SMC91x
driver comes to mind, with its stupidly small FIFOs, where the majority
of implementations have to have the packets loaded via PIO - and this
seems to generally happen from IRQ context.

The upshot of that is switching the SMC91x interrupt handler to run with
IRQs disabled will mean that serial can suffer with overruns, especially
if the serial port FIFO is also small.

The alternative is to push the "expensive" packet-loading parts of SMC91x
support into a tasklet, but that's probably going to impact performance
of the driver.

What I'm saying is that I think it's a good idea, but we should be
cautious about forcing a blanket change - to do so I believe risks creating
performance regressions.

Maybe a "safer" way forward is to go and find all those request_irq()
sites and add IRQF_DISABLED to them all, wait for regression reports and
selectively remove the IRQF_DISABLED flags?  We would then be able to
build up a picture of the problematical drivers that need to be reworked,
and whether the "run everything with irqs disabled" is even a practical
proposition.


Now, at the risk of covering old ground, how about we have two separate
irqaction lists, one for handlers to be called with irqs disabled and
one for handlers with irqs enabled.  We run the irqs-disabled list
first, naturally with irqs disabled.  If, at the end of that run (or
maybe after each handler), IRQs have ended being enabled, print some
diagnostics.  (We're going to need something like this to ensure that
drivers interrupt handlers don't enable IRQs themselves.)  Then enable
IRQs and run the irqs-enabled chain.
