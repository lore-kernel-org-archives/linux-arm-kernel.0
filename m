From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Aug 2016 16:43:12 +0100
Subject: About the accuracy of delay loop
In-Reply-To: <20160810153429.2489b087@xhacker>
References: <20160810152456.41f6e727@JAMIE> <20160810153429.2489b087@xhacker>
Message-ID: <20160810154311.GM1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2016 at 03:34:29PM +0800, Jisheng Zhang wrote:
> Per my understanding, udelay is never ensured "accurate", it only ensures
> that it at least delays as required.

... which is inaccurate.  udelay() offers no such guarantee.
udelay() gives you an _approximate_ delay, and when it is based
on loops_per_jiffy, it will inevitably be slightly shorter than
requested.

This is because of the calibration mechanism.  loops_per_jiffy is
calculated as the number of loops between two subsequent timer
interrupts - so it's missing the number of loops that would have
been run had the timer interrupt not happened.

To put it another way:

t(loops) = t(timer_interrupt_period) - t(timer_irq_function)

So, loops_per_jiffy is always going to be less than the ideal
number, which means udelay() will always be slightly short.

It's not desired to "fix" this.

Things also go wrong if you have cpufreq, and the CPU clock
frequency changes mid-delay - and that can make the resulting
delay either longer or shorter.  Most platforms using cpufreq
should be using a timer to implement udelay() to avoid this.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
