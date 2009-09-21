From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Sep 2009 10:30:37 +0100
Subject: [PATCH] Don't disable irqs in set_next_event and set_mode
	callbacks
In-Reply-To: <20090921091614.GA25422@pengutronix.de>
References: <1253518763-15087-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20090921090400.GD27357@n2100.arm.linux.org.uk>
	<20090921091614.GA25422@pengutronix.de>
Message-ID: <20090921093037.GE27357@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2009 at 11:16:14AM +0200, Uwe Kleine-K?nig wrote:
> On Mon, Sep 21, 2009 at 10:04:00AM +0100, Russell King - ARM Linux wrote:
> > On Mon, Sep 21, 2009 at 09:39:22AM +0200, Uwe Kleine-K?nig wrote:
> > > These functions are called with irqs already off.
> > > 
> > > at91rm2000 had a WARN_ON_ONCE if irqs were enabled since Nov 2008 with
> > > noone reporting having hit it.
> > 
> > It might be useful to document these clockevent interfaces.  There's
> > at least a few ARM clockevent implementations which don't set the
> > periodic interval when set_next_event() is called - probably because
> > it wasn't realised that it was required.
> I'm a bit confused now as AFAIK set_next_event isn't called in periodic
> mode.
> 
> You mean they don't start the timer if mode==CLOCK_EVT_MODE_PERIODIC in
> .set_mode?
> It looks as if pxa is such an implementation, it does nothing in this
> case.

PXA doesn't support periodic mode - the hardware is incapable of providing
periodic interrupts without software support, so we only support it in
one-shot mode (that's actually what the hardware provides.)

I'm talking about this kind of thing:

        case CLOCK_EVT_MODE_PERIODIC:
                /* timer load already set up */
                ctrl = TWD_TIMER_CONTROL_ENABLE | TWD_TIMER_CONTROL_IT_ENABLE
                        | TWD_TIMER_CONTROL_PERIODIC;
                break;
        case CLOCK_EVT_MODE_ONESHOT:
                /* period set, and timer enabled in 'next_event' hook */
                ctrl = TWD_TIMER_CONTROL_IT_ENABLE | TWD_TIMER_CONTROL_ONESHOT;
                break;

The first comment is not true if we ever switch to oneshot mode - the
reload register is overwritten.  If we then switch back to periodic
mode, we'll interrupt at whatever periodic rate which was programmed
by the oneshot code.  OMAP mpu_timer1 looks to be the same.

Nomadik only works because it doesn't support periodic mode.
