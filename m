From: ming.lei@canonical.com (Ming Lei)
Date: Sat, 15 Jun 2013 09:49:20 +0800
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <Pine.LNX.4.44L0.1306141620110.3152-100000@netrider.rowland.org>
References: <CACVXFVO1Ou-wZedv0VntNwS1NZSRzvOjfVhvHBew0odz-PUYjg@mail.gmail.com>
 <Pine.LNX.4.44L0.1306141620110.3152-100000@netrider.rowland.org>
Message-ID: <CACVXFVO97Kng9eYVZww+GdJiO6Vx80tcwjmreSwRi2qfUk2JBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 15, 2013 at 4:23 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> Not entirely.  On a UP system, leaving interrupts disabled for a long
> time (which is what we do now) increases the delay between when the IRQ
> is raised and when it is serviced.  On an SMP system, a long-running

Yes, I mean the HCD IRQ handling time is already too long, and it
isn't affected by the time between raising and servicing the IRQ.

> interrupt handler will delay servicing a different device that shares
> the same IRQ line.

Not always so.

Currently, ARM can only set one irq line to be served by one of CPU
at the same time for power saving, which still results in above situation.
In fact, without irq-balance, on ARM, all IRQs are handled by CPU0 only.

On Sat, Jun 15, 2013 at 5:09 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> And on UP it delays ALL other interrupts. I've seen 500us+ caused by
> the USB interrupt handlers...

On SMP the above case may be worse than UP, when the same completion
things(from hw view) happen on one of CPU, the releasing & reacquiring HCD
private lock in interrupt handler may cause longer time.


Thanks,
--
Ming Lei
