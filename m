From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Apr 2011 10:46:06 +0100
Subject: [patch 00/16] arm: Replace arm sched_clock by clocksource
	based sched_clock
In-Reply-To: <20110423205036.795894921@linutronix.de>
References: <20110423205036.795894921@linutronix.de>
Message-ID: <20110429094606.GA5126@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 23, 2011 at 08:54:39PM -0000, Thomas Gleixner wrote:
> Most of ARM sched_clocks is using the timekeeping clocksource as the
> sched_clock. Only versatile uses a different clock for it, but there
> is no real reason why it can't use the clocksource as well.

sched_clock really needs to be setup earlier than clocksources are setup,
before sched_init() is called in init/main.c.  This is where the scheduler
reads the initial value of sched_clock() to start its time measurements.
This is well before clocksources are initialized, or even the irq subsystem.

So I don't believe bolting it directly into the clocksource code in this
way is correct.  As things are currently setup with my sched_clock()
implementation, we can (and in any cases do) get the sched_clock() up
and running really early which is what's required.
