From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 16 Dec 2014 12:25:03 +0100
Subject: [PATCH 0/5] ARM: at91: fix irq_pm_install_action WARNING
In-Reply-To: <alpine.DEB.2.11.1412161013570.17382@nanos>
References: <1418660152-17185-1-git-send-email-boris.brezillon@free-electrons.com>
 <2662748.NJbkr6jW7r@vostro.rjw.lan>
 <3542278.8lcJeXLMFm@vostro.rjw.lan>
 <20141216100715.57baeb65@bbrezillon>
 <alpine.DEB.2.11.1412161013570.17382@nanos>
Message-ID: <20141216122503.77c5632f@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Tue, 16 Dec 2014 11:03:55 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, 16 Dec 2014, Boris Brezillon wrote:
> > On Mon, 15 Dec 2014 23:48:14 +0100
> > "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> > > Or even set IRFQ_NO_SUSPEND for all of the users of this interrupt and add
> > > comments to them explaining why it is set.
> > Actually I thought about adding a new flag (let's call it
> > IRQF_DONT_COMPLAIN for now ;-)) to remove those warnings (or specifying
> > IRFQ_NO_SUSPEND in all peripherals sharing the IRQ with the init
> > timer), but after discussing the problem with Thomas I decided to go
> > for the approach described in my cover letter.
> > 
> > Thomas, correct me if I'm wrong, but your concern about the
> > IRQF_DONT_COMPLAIN approach was that it was leaving interrupt handlers
> > of suspended devices in an active state (meaning that they could be
> > called in "suspend" or "early resume" state), and such devices might
> > not properly handle interrupts while being in a suspended state (clocks
> > and regulators disabled).
> > In at91 specific case this should not be an issue thought.
> > 
> > We have the same problem when setting IRFQ_NO_SUSPEND on all peripherals
> > sharing the IRQ with the init timer.
> > Moreover, I'd like to keep the core automatically disabling the IRQ when
> > the PMC, RTC, watchdog or DBGU (UART) peripherals have their own
> > dedicated IRQ (which is the case on Atmel sama5 SoCs).
> > This implies testing for the SoC version in each of these drivers and
> > adapting the request_irq call accordingly.
> 
> But still all those drivers must disable the interrupts at the device
> level on suspend, right?

Absolutely.

> 
> > Thomas, Rafael, if both of you think I should either introduce a new
> > flag or specify IRFQ_NO_SUSPEND in all shared IRQ users, then I can go
> > for one of this solution.
> 
> All of this really sucks. What about the following?
> 
> Install the timer interrupt as a demultiplexing interrupt.

I can try to hack the AIC irqchip driver to implement this demux logic,
but this logic can't be placed in the PIT (Periodic Interval Timer)
driver itself, because the shared IRQ line is used by the at91 clock
controller (PMC) which is providing the clock to the PIT device.
This gives the following dependency graph:

PIT =depends-on=> Master Clock =provided-by=> PMC =needs=> PMC IRQ.

Anyway, I'll give this solution another try.

Thanks for your detailed answer.

Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
