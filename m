From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 27 Nov 2009 21:38:23 +0100
Subject: [RESENT PATCH] Don't disable irqs in set_next_event and
	set_mode callbacks
In-Reply-To: <20091127195857.GB28193@n2100.arm.linux.org.uk>
References: <1253518763-15087-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259231164-21242-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091126105002.GB2393@n2100.arm.linux.org.uk>
	<20091126113158.GC2393@n2100.arm.linux.org.uk>
	<20091127104454.GA26570@pengutronix.de>
	<20091127195857.GB28193@n2100.arm.linux.org.uk>
Message-ID: <20091127203823.GA28789@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Fri, Nov 27, 2009 at 07:58:57PM +0000, Russell King - ARM Linux wrote:
> On Fri, Nov 27, 2009 at 11:44:55AM +0100, Uwe Kleine-K?nig wrote:
> > Hello,
> > 
> > On Thu, Nov 26, 2009 at 11:31:58AM +0000, Russell King - ARM Linux wrote:
> > > tick_do_broadcast
> > > +-tick_do_periodic_broadcast
> > > | `-tick_handle_periodic_broadcast
> > > |   `- dev->event_handler
> > > `-tick_handle_oneshot_broadcast
> > >    `- dev->event_handler
> > I currently fail to trace where the irqs are disabled, but I have an
> > at91rm2000 machine and the warning doesn't trigger.
> > Where are irqs reenabled after exception entry?  Is it before or after
> > the handler is called?
> 
> If interrupt handlers are requested with IRQF_DISABLED (as timer
> interrupts should be), they will be called with IRQs disabled.
> 
> There is one exception: if an interrupt is requested with
> IRQF_SHARED|IRQF_DISABLED and either another handler enables interrupts
> itself and leaves them enabled, or was requested without IRQF_DISABLED.
> In this case, such a handler can still be called with IRQs enabled.
OK, so this should make it save for mach-nomadik/timer.c,
mach-pxa/time.c and mach-sa1100/time.c.

Only mach-at91/at91rm9200_time.c and mach-at91/at91sam926x_time.c
request with IRQF_SHARED | IRQF_DISABLED.
So for there the right solution is to let the local_irq_save in place
and add a comment that it is needed as the timer irq is shared.
This hopefully stopps people copying it unnecessarily.

@Eric: do you still prefer the warning or is it OK for you now to remove
the irq saving for nomadik, pxa and sa1100?

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
