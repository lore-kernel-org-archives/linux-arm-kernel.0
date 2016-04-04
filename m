From: rabin@rab.in (Rabin Vincent)
Date: Mon, 4 Apr 2016 13:53:30 +0200
Subject: [PATCH] clockevents/drivers/arm_global_timer: Fix erratum 740657
 workaround
In-Reply-To: <56FAA991.1080401@arm.com>
References: <1459238917-2240-1-git-send-email-rabin.vincent@axis.com>
 <56FAA991.1080401@arm.com>
Message-ID: <20160404115330.GB27198@lnxrabinv.se.axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2016 at 05:13:05PM +0100, Marc Zyngier wrote:
> - What if my timer is not connected to a controller that implements this
> API? Something that is not a GIC, for example?

As you know irq_set_irqchip_state() does nothing in that case, and the erratum
is thus presumably not worked around in such a system.

By the way, while the original document from ARM is not public, this
erratum can be seen here (among other places):
http://www.nxp.com/files/32bit/doc/errata/IMX6DQCE.pdf#page=13
https://www.altera.com/content/dam/altera-www/global/en_US/pdfs/literature/es/es-01042.pdf#page=26

> - How does it work when the GIC (with EOImode==1) performs a priority
> drop (by writing to the EOI register) before calling into the timer
> handler, and finishing the handling with a write to DIR?

I guess it doesn't.

> - What are the comparative costs of taking a spurious (but nonetheless
> harmless) interrupt vs poking the distributor (which is by no mean a
> cheap operation)?

The time taken by irq_set_irqchip_state() appears to be about 15%
shorter than the time gic_handle_irq() and its called functions take to
handle the spurious interrrupt.  The overhead of going in and out of
interrupt context for the spurious interrupt is not included in the
latter time.
