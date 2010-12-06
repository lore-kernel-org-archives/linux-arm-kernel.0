From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Dec 2010 10:20:46 +0000
Subject: [PATCH 3/5] msm: timer: SMP timer support for msm
In-Reply-To: <alpine.LFD.2.00.1012061025240.2653@localhost6.localdomain6>
References: <1291619778-30289-1-git-send-email-johlstei@codeaurora.org>
	<1291619778-30289-4-git-send-email-johlstei@codeaurora.org>
	<alpine.LFD.2.00.1012061025240.2653@localhost6.localdomain6>
Message-ID: <20101206102046.GD29563@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 06, 2010 at 10:56:14AM +0100, Thomas Gleixner wrote:
> > +	local_irq_save(flags);
> > +	get_irq_chip(clock->irq.irq)->unmask(clock->irq.irq);
> 
> Why are you fiddling wiht the irqchip functions directly ? Please use
> disable_irq/enable_irq if at all.

PPI.  The interrupt has to be enabled by the very same CPU that wants
to receive the interrupt.  Other CPUs on the system do not have access
to the interrupt enable bits for PPIs.

That's something which genirq can't handle because it doesn't _actually_
support real per-CPU interrupts - iow, ones which are truely private to
CPU N.

Eg, if IRQ 29 is the local timer interrupt, then CPU0 has its own IRQ29
which is distinctly different - and has separate enable registers and
ultimately different timer hardware - from CPU1's IRQ29.

On the other SMP platforms, these interrupts aren't handled by genirq,
but we do control them via code like the above (which I'm about to kill
off and move that detail into gic.c.)
