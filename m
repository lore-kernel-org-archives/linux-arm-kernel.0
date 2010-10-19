From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Oct 2010 22:58:27 +0200
Subject: [PATCH 1/3] drivers: misc: add omap_hwspinlock driver
In-Reply-To: <AANLkTinNfERyi_bTWc7LOKR1uRLC3E612ubFKBLxWB1E@mail.gmail.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
	<AANLkTimDdPUjo+65vBL0PTQ3b=5NpeVT28XrdkYqx3Ex@mail.gmail.com>
	<AANLkTinNfERyi_bTWc7LOKR1uRLC3E612ubFKBLxWB1E@mail.gmail.com>
Message-ID: <201010192258.27988.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 October 2010 22:43:34 Ohad Ben-Cohen wrote:
> > Disabling irqs might be a concern as a source of RT latency.  It
> > might be better to make the caller responsible for managing local spin
> > locks and irq disable/enable.
> 
> This a coming from an hardware requirement, rather than a choice the
> user should take.
> 
> If a hwspinlock is taken over a long period of time, its other user
> (with which we try to achieve synchronization) might be polling the
> OMAP interconnect for too long (trying to take the hwspinlock) and
> thus preventing it to be used for other transactions.

This sounds exactly like any other spinlock.

> To prevent such lengthy polling on the interconnect, the hwspinlock
> should only be used for very short period of times, with preemption
> and interrupts disabled.

Interrupts disabled in general might go a bit too far -- they are also
short and infrequent events unless you have seriously broken drivers.

When running with CONFIG_PREEMPT, I would guess you actually want to
turn the omap_hwspinlock into a sleeping operation, though that would
require much extra work to implement. Disabling preemption while the
hwspinlock is held is of course a correct implementation technically,
but it might not be what someone enabling CONFIG_PREEMPT expects.

> That's why we don't give users the choice whether to disable
> interrupts or not - it's simply not a decision they should take.

What about those cases where you already know that interrupts are
disabled, e.g. while holding a regular spin_lock_irq or inside
of an interrupt handler?

	Arnd
