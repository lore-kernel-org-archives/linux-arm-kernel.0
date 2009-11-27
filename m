From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Nov 2009 19:58:57 +0000
Subject: [RESENT PATCH] Don't disable irqs in set_next_event and
	set_mode callbacks
In-Reply-To: <20091127104454.GA26570@pengutronix.de>
References: <1253518763-15087-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259231164-21242-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091126105002.GB2393@n2100.arm.linux.org.uk>
	<20091126113158.GC2393@n2100.arm.linux.org.uk>
	<20091127104454.GA26570@pengutronix.de>
Message-ID: <20091127195857.GB28193@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2009 at 11:44:55AM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Thu, Nov 26, 2009 at 11:31:58AM +0000, Russell King - ARM Linux wrote:
> > tick_do_broadcast
> > +-tick_do_periodic_broadcast
> > | `-tick_handle_periodic_broadcast
> > |   `- dev->event_handler
> > `-tick_handle_oneshot_broadcast
> >    `- dev->event_handler
> I currently fail to trace where the irqs are disabled, but I have an
> at91rm2000 machine and the warning doesn't trigger.
> Where are irqs reenabled after exception entry?  Is it before or after
> the handler is called?

If interrupt handlers are requested with IRQF_DISABLED (as timer
interrupts should be), they will be called with IRQs disabled.

There is one exception: if an interrupt is requested with
IRQF_SHARED|IRQF_DISABLED and either another handler enables interrupts
itself and leaves them enabled, or was requested without IRQF_DISABLED.
In this case, such a handler can still be called with IRQs enabled.
