From: eduardo.valentin@nokia.com (Eduardo Valentin)
Date: Thu, 6 Jan 2011 08:24:04 +0200
Subject: [PATCH 1/1] arm: omap: gpio: define .disable callback for gpio
	irq chip
In-Reply-To: <87aajfvstw.fsf@ti.com>
References: <1294250283-18182-1-git-send-email-eduardo.valentin@nokia.com>
	<20110105181918.GB8717@n2100.arm.linux.org.uk>
	<20110105192425.GA24729@besouro.research.nokia.com>
	<87aajfvstw.fsf@ti.com>
Message-ID: <20110106062404.GA14141@besouro.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 05, 2011 at 03:22:51PM -0800, ext Kevin Hilman wrote:
> Eduardo Valentin <eduardo.valentin@nokia.com> writes:
> 
> > Hello Russell,
> >
> > On Wed, Jan 05, 2011 at 06:19:18PM +0000, Russell King wrote:
> >> On Wed, Jan 05, 2011 at 07:58:03PM +0200, Eduardo Valentin wrote:
> >> > Currently, if one calls disable_irq(gpio_irq), the irq
> >> > won't get disabled.
> >> > 
> >> > This is happening because the omap gpio code defines only
> >> > a .mask callback. And the default_disable function is just
> >> > a stub. The result is that, when someone calls disable_irq
> >> > for an irq in a gpio line, it will be kept enabled.
> >> > 
> >> > This patch solves this issue by setting the .disable
> >> > callback to point to the same .mask callback.
> >> 
> >> Amd this is a problem because?
> >
> > errr.. because the interrupt is enabled when it was supposed to be disabled?
> >
> 
> As Russell pointed out, it's not actually "supposed" to be.
> 
> With lazy disable, what disable_irq() does is prevent the *handler* from
> ever being called.  If another interrupt arrives, it will be caught by
> the genirq core, marked as IRQ_PENDING and then masked.  This "don't
> disable unless we really have to" is the desired behavior of the lazy
> disable feature.

Right. I'm convinced that the handler won't be called because of the lazy
disable mechanism.

> 
> >> 
> >> The way this works is that although it isn't disabled at that point,
> >> if it never triggers, then everything remains happy.  However, if it
> >> does trigger, the genirq code will then mask the interrupt and won't
> >> call the handler.
> >
> > Right.. I didn't see from this point. I will check how that gets unmasked.
> > But even so, if I understood correctly what you described, it would still
> > open a time window which the system would see at least 1 interrupt during
> > the time it was not suppose to. And that can wakeup a system which  is in
> > deep sleep mode, either via dynamic idle or static suspend.
> >
> > It is unlikely, I know. But it can still happen. And can be avoided.
> 
> If the GPIO is configured as a wakeup source, then wouldn't you want
> activity on that GPIO to wake up the system?

Yes I would want it.. of course, if the interrupt is enabled though..

I'm still trying to find a valid situation where someone disables an irq
but still wants its activity to be a wakeup source. I couldn't find so far..


> 
> If you don't want wakeups on that GPIO, then the driver should probably
> be using disable_irq_wake().

Yes. Let's take this situation. Let's assume a driver, at its suspend callback,
explicitly reports to the system that its irq can be disabled and also should
not be seen as a wakeup source, by calling disable_irq(gpio_irq) and
disable_irq_wake(gpio_irq).

What should be the expected system behavior when the user says echo mem > /sys/power/state?
