From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Sep 2015 17:18:03 +0200
Subject: [PATCH 2/2] Documentation: gpio: Update description for X-Gene
 standby GPIO controller DTS binding
In-Reply-To: <CAL4ahLdOtJ=W2xZbORYFi9ocnqB3oX0OzfC9zGiarBezjuxGwQ@mail.gmail.com>
References: <1441963332-13329-1-git-send-email-yvo@apm.com>
 <2516438.vcQPNoorc9@wuerfel>
 <CAL4ahLdOtJ=W2xZbORYFi9ocnqB3oX0OzfC9zGiarBezjuxGwQ@mail.gmail.com>
Message-ID: <8906562.oG8T3AYRWq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 September 2015 22:06:15 Y Vo wrote:
> >
> > Did 1b7047edfcfb25 ("genirq: Allow the irqchip state of an IRQ to be
> > save/restored") not address the problem for you? You were on
> > Cc to that patch and should have spoken up when the code that was
> > merged was not sufficient.
> 
> Yes, I am in this mail-list too, but I also had a issue on this, I
> think you are still in my submitted for this.
> Currently, irq_get|set_irqchip_state(..) supports access to
> GIC_DIST_ENABLE_SET, GIC_DIST_ACTIVE_SET, GIC_DIST_PENDING_SET. But
> our hw only has the valid value at SPISR register ("[PATCH v4 2/3]
> irqchip: GIC: Add support for irq_{get,set}_irqchip_state"), so I
> still can not use it.

Ok.

> >> >> > It also seems to me that the binding cannot distinguish between a
> >> >> > line configured as an input and one that is configured as an
> >> >> > interrupt, which are for other gpio chips the same thing, but
> >> >> > not on this one.  Could this be rectified by using another bit
> >> >> > of the second gpio cell? The low bit is used for active-high/active-low,
> >> >> > so you could use the second bit for irq/input.
> >> >> >
> >> >> Do you mean #gpio-cells property and using the high bit of the second
> >> >> bit for irq/input  ?
> >> >
> >> > Yes, that would be an option.
> >> I will look into it.
> >>
> >> Is there possible if:
> >> - Keep GPIO8..GPIO as interrupt by default.
> >> - Anyone want to use these GPIO pins as GPIO, we will re-configure
> >> them to GPIO mode ?
> >
> > That's not perfect but better than the patch you sent here.
> > The main disadvantage is that you end up with two references
> > to the same IRQ. It can still work, but only as long as nothing
> > tries to walk the entire DT to parse all the interrupts properties.
> >
> Let me think how.
> 
> > It would be ok for gpio-keys, as that does not need both the state
> > and the event together, but for other gpio users, you still need a
> > working driver that supports reading the state and getting an
> > interrupt.
> >
> In irq mode, if I reconfigured that gpio pin to gpio mode, then
> reading -> the value is valid.
> Could I do that way badly ? It means switch to gpio mode to read
> value, then switch back to  irq mode.

I don't see any downsides of this at the moment, other than it being
a bit slow. As long as we don't try to do any high-speed communication
over this gpio line, that seems like the best workaround given the
various constraints of the hardware.

	Arnd
