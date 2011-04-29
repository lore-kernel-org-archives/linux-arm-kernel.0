From: tony@atomide.com (Tony Lindgren)
Date: Fri, 29 Apr 2011 13:32:09 +0300
Subject: [patch 00/16] arm: Replace arm sched_clock by clocksource
	based sched_clock
In-Reply-To: <alpine.LFD.2.02.1104291217120.3005@ionos>
References: <20110423205036.795894921@linutronix.de>
	<20110429094606.GA5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1104291217120.3005@ionos>
Message-ID: <20110429103208.GA2849@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Thomas Gleixner <tglx@linutronix.de> [110429 13:19]:
> On Fri, 29 Apr 2011, Russell King - ARM Linux wrote:
> 
> > On Sat, Apr 23, 2011 at 08:54:39PM -0000, Thomas Gleixner wrote:
> > > Most of ARM sched_clocks is using the timekeeping clocksource as the
> > > sched_clock. Only versatile uses a different clock for it, but there
> > > is no real reason why it can't use the clocksource as well.
> > 
> > sched_clock really needs to be setup earlier than clocksources are setup,
> > before sched_init() is called in init/main.c.  This is where the scheduler
> > reads the initial value of sched_clock() to start its time measurements.
> > This is well before clocksources are initialized, or even the irq subsystem.
> > 
> > So I don't believe bolting it directly into the clocksource code in this
> > way is correct.  As things are currently setup with my sched_clock()
> > implementation, we can (and in any cases do) get the sched_clock() up
> > and running really early which is what's required.
> 
> Not really. There is no requirement to have a high resolution sched
> clock in the early boot process. The only requirement is that
> sched_clock is monotonic increasing nsecs. So the code utilizes
> jiffies up to the point where the clocksource is installed and then
> switches over keeping the clock monotonic. The scheduler does not care
> whether it gets coarse grained time information in the early boot
> stage and then fine grained information at some point later.
> 
> The only drawback is that you don't get precise timestamps for tracing
> up to the point where the clock source is installed. But that's really
> not a big deal to worry about.

What about PRINTK_TIME? I think that uses sched_clock right from the
start.

Tony
