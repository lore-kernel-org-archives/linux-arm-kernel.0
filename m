From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Nov 2010 11:05:08 +0000
Subject: [Question] Local Timer based on SPI
In-Reply-To: <000b01cb8faf$c1841a20$448c4e60$%kim@samsung.com>
References: <000001cb8d0d$dbacd760$93068620$%kim@samsung.com>
	<20101126091004.GD9310@n2100.arm.linux.org.uk>
	<000b01cb8faf$c1841a20$448c4e60$%kim@samsung.com>
Message-ID: <20101129110508.GB10703@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 29, 2010 at 07:25:30PM +0900, Kukjin Kim wrote:
> Yeah, it seems CONFIG_LOCAL_TIMER is just for PPI.
> 
> The purpose of my question is for the plan to use different SPIs to support
> each CPU event timer. According to the help message of LOCAL_TIMER in
> Kconfig, it seems better each CPU has a different event timer source clock
> instead of using IPI broadcast method. Current ARM implementation registers
> dummy_timers when CONFIG_LOCAL_TIMERS is not set so, I think need to set
> CONFIG_LOCAL_TIMERS.

The dummy timer clock event device is setup to provide the core with a
means to broadcast the timer IPI when there isn't a local timer.  When
there is a local timer, this function falls to the local timer clock
event device (which is actually the same structure, just initialized in
a different way.)

> To support different SPIs for each CPU event timer, should I neglect the
> dummy_timer?
> Or is it not worth to implement?...

It depends how many CPU cores you have.  If you have just two, then the
"thundering herd" issue may not affect you too much.

The idea behind local timers is to avoid all CPUs being woken at the same
point in time, and then immediately contending over the same set of locks.
Local timers help to distribute the wakeups throughout the interval, and
thereby avoid contention.

If you have one CPU and you IPI the timer to it, then you've probably
already done much of the work with the locks held already.
