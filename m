From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 5 Mar 2015 10:53:08 +0000
Subject: [PATCH v2 5/6] watchdog: at91sam9: request the irq with
 IRQF_NO_SUSPEND
In-Reply-To: <20150305095306.3db98ac8@bbrezillon>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
 <1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150304183809.GD22156@leverpostej>
 <20150305095306.3db98ac8@bbrezillon>
Message-ID: <20150305105308.GA13617@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

I'd missed the fact that this was for SW watchdog as opposed to HW
watchdog, which may explain my confusion.

[...]

> > >  		err = request_irq(wdt->irq, wdt_interrupt,
> > > -				  IRQF_SHARED | IRQF_IRQPOLL,
> > > +				  IRQF_SHARED | IRQF_IRQPOLL |
> > > +				  IRQF_NO_SUSPEND,
> > 
> > I'm a little confused by this. What happens if the watchdog fires when
> > we're actually in the suspended state (when IRQF_NO_SUSPEND interrupts
> > aren't guaranteed to be delivered).
> 
> It reboot the system.

Is the timer we use to ping the watchdog guaranted to result in a wakeup
before an interrupt will be triggered? If so, then I think we're ok.

If not, then don't we need to clear a potentially pending watchdog irq
at resume time so at to not immediately reboot the machine? I couldn't
see any logic to that effect in the driver.

Regardless, if the only reason we care about taking the interrupt during
the suspend/resume phases is due to the timer sharing the IRQ, then
shouldn't we be using IRQF_COND_SUSPEND?

Thanks,
Mark.
