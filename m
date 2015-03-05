From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 5 Mar 2015 10:57:29 +0000
Subject: [PATCH v2 5/6] watchdog: at91sam9: request the irq with
 IRQF_NO_SUSPEND
In-Reply-To: <14143668.0aRkeVrc3Q@vostro.rjw.lan>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
 <1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150304183809.GD22156@leverpostej>
 <14143668.0aRkeVrc3Q@vostro.rjw.lan>
Message-ID: <20150305105729.GB13617@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
> Why wouldn't they be delivered?
> 
> If that's suspend-to-idle, we'll handle them normally.  If that's full suspend,
> they may not be handled at the last stage (when we run on one CPU with interrupts
> off), but that was the case before the wakeup interrupts rework already and I'd
> expect it to be taken into account somehow in the existing code (or if it isn't
> taken into account, we have a bug, but it is not related to this series).

There's no enable_irq_wake(wdt->irq), and I was under the impression this
is for full suspend.

I agree that if problematic, it's an existing bug. Given Boris's
comments in the other thread this may just a minor semantic issue w.r.t.
IRQF_NO_SUSPEND vs IRQF_COND_SUSPEND.

Thanks,
Mark.
