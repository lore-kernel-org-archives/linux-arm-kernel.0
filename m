From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 30 Nov 2009 22:59:43 +0100 (CET)
Subject: Get rid of IRQF_DISABLED - (was [PATCH] genirq: warn about
	IRQF_SHARED|IRQF_DISABLED)
In-Reply-To: <20091130145122.7057a1e3@lxorguk.ukuu.org.uk>
References: <1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259578067-29169-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.0911301225110.24119@localhost.localdomain>
	<20091130143703.GA7028@n2100.arm.linux.org.uk>
	<20091130145122.7057a1e3@lxorguk.ukuu.org.uk>
Message-ID: <alpine.LFD.2.00.0911302255590.24119@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Nov 2009, Alan Cox wrote:

> > However, I think we still have a number of corner cases.  The SMC91x
> > driver comes to mind, with its stupidly small FIFOs, where the majority
> > of implementations have to have the packets loaded via PIO - and this
> > seems to generally happen from IRQ context.
> 
> Everything 8390 based is in the same boat. It relies on being able to
> use disable_irq_nosync/enable_irq and knows all about the joys of
> interrupt bus asynchronicity internally. That does however allow it to
> get sane results by using the irq controller to mask the potentially
> shared IRQ at source.

So that would be a known candidate for IRQF_NEEDS_IRQS_ENABLED, right?

Either that or we decide to push such beasts into the threaded irq
space to keep them working until the last card hits the trashcan. I
know that this would still need to disable the interrupt on the PIC
level, but we have already mechanisms for that in the threaded code.

Thanks,

	tglx
