From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 27 Nov 2009 11:44:55 +0100
Subject: [RESENT PATCH] Don't disable irqs in set_next_event and
	set_mode callbacks
In-Reply-To: <20091126113158.GC2393@n2100.arm.linux.org.uk>
References: <1253518763-15087-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259231164-21242-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091126105002.GB2393@n2100.arm.linux.org.uk>
	<20091126113158.GC2393@n2100.arm.linux.org.uk>
Message-ID: <20091127104454.GA26570@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Nov 26, 2009 at 11:31:58AM +0000, Russell King - ARM Linux wrote:
> On Thu, Nov 26, 2009 at 10:50:02AM +0000, Russell King - ARM Linux wrote:
> > On Thu, Nov 26, 2009 at 11:26:04AM +0100, Uwe Kleine-K?nig wrote:
> > > These functions are called with irqs already off.
> > > 
> > > AT91RM2000 had a WARN_ON_ONCE if irqs were enabled since Nov 2008 with
> > > noone reporting having hit it.
> > 
> > Can we please start to create some documentation for this, even if it
> > just starts off as "these callbacks are always called with irqs
> > disabled" or some such thing.
> > 
> > I find the generic time stuff extremely difficult to work with, and I
> > suspect I'm not the only one.  This is probably why people like to be
> > sure by having their own IRQ disabling.
> 
> To prove the IRQ-ness of the set_next_event callback, I've traced through
> all the time code and come up with all these possible call paths:
> 
> [...]
> 
> All leaves end in one of four cases:
> 1. a call via dev->event_handler
> 2. a function which uses spin_lock_irqsave before calling the child
> 3. a function which uses local_irq_disable before calling the child
> 4. a call which is #if 0'd out
> 
> So, we can be certain that in cases 2, 3, 4, set_next_event will be
> called with IRQs disabled.  That leaves case 1, which is called from
> the implementations interrupt handling function, or:
> 
> tick_do_broadcast
> +-tick_do_periodic_broadcast
> | `-tick_handle_periodic_broadcast
> |   `- dev->event_handler
> `-tick_handle_oneshot_broadcast
>    `- dev->event_handler
I currently fail to trace where the irqs are disabled, but I have an
at91rm2000 machine and the warning doesn't trigger.
Where are irqs reenabled after exception entry?  Is it before or after
the handler is called?
 
For that machine event_handler is hrtimer_interrupt.  That has an
annotation that it's always called with irqs disabled.

> which basically leaves us with the implementations interrupt handling
> function.  If that always calls the event handler with IRQs disabled,
> then set_next_event will also be called with IRQs disabled.
Thomas, do you care to shed light on this?

If you don't care I suggest to add the same check as for at91rm2000 for
the other platforms and see what happens.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
