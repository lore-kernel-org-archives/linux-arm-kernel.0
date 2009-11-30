From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 30 Nov 2009 14:51:22 +0000
Subject: Get rid of IRQF_DISABLED - (was [PATCH] genirq: warn about
	IRQF_SHARED|IRQF_DISABLED)
In-Reply-To: <20091130143703.GA7028@n2100.arm.linux.org.uk>
References: <1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259578067-29169-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.0911301225110.24119@localhost.localdomain>
	<20091130143703.GA7028@n2100.arm.linux.org.uk>
Message-ID: <20091130145122.7057a1e3@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> However, I think we still have a number of corner cases.  The SMC91x
> driver comes to mind, with its stupidly small FIFOs, where the majority
> of implementations have to have the packets loaded via PIO - and this
> seems to generally happen from IRQ context.

Everything 8390 based is in the same boat. It relies on being able to
use disable_irq_nosync/enable_irq and knows all about the joys of
interrupt bus asynchronicity internally. That does however allow it to
get sane results by using the irq controller to mask the potentially
shared IRQ at source.
