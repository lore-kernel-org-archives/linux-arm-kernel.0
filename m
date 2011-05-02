From: tony@atomide.com (Tony Lindgren)
Date: Mon, 2 May 2011 01:18:47 -0700
Subject: [patch 00/16] arm: Replace arm sched_clock by clocksource
	based sched_clock
In-Reply-To: <alpine.LFD.2.02.1104292355210.3005@ionos>
References: <20110423205036.795894921@linutronix.de>
	<20110429094606.GA5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1104291217120.3005@ionos>
	<20110429103208.GA2849@atomide.com>
	<alpine.LFD.2.02.1104291900290.3005@ionos>
	<BANLkTi=Xymqw9H+aNPbYUWDs7w5HzmJVkw@mail.gmail.com>
	<alpine.LFD.2.02.1104292355210.3005@ionos>
Message-ID: <20110502081846.GD3755@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Thomas Gleixner <tglx@linutronix.de> [110429 14:54]:
> On Fri, 29 Apr 2011, Linus Walleij wrote:
> 
> > 2011/4/29 Thomas Gleixner <tglx@linutronix.de>:
> > > On Fri, 29 Apr 2011, Tony Lindgren wrote:
> > >> What about PRINTK_TIME? I think that uses sched_clock right from the
> > >> start.
> > >
> > > Right, but where is the problem ? A few time stamps with jiffies
> > > resolution and then the finegrained ones.
> > 
> > Jonas ?berg has this pending patch that we call "boot time recorder".
> > What it does is basically start a free running timer before the
> > kernel is booted, e.g. in U-boot or even in the ROM of your
> > machine if you can.
> > 
> > If we need more finegrained sched_clock() before the
> > clocksource is up, a good approach would be to utilize
> > something like that for sched_clock up to that point, plus
> > it has the upside that [0.000000] is as close to electrical
> > power-on as possible.
> 
> Well, you can read out that value at the point the clocksource gets
> installed so you have the time spent up to that point without adding
> another facility, level of indirection ...

I think the problem here too is that we are calling read_persistent_clock
and sched_clock before they're initialized. So we should default to
jiffies based value before the platform code enables the hardware.

Tony
