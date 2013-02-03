From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 3 Feb 2013 11:45:03 -0500
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that
 kirkwood_ge0[01]_init() finds its clock
In-Reply-To: <20130202230418.GA17361@schnuecks.de>
References: <51082C4E.5050903@gmail.com> <20130130000341.GA10600@schnuecks.de>
 <51086E86.8040705@gmail.com> <20130130083044.GA25688@schnuecks.de>
 <5108F300.7000705@gmail.com>
 <20130130230100.GV7717@titan.lakedaemon.net>
 <20130131224457.GB17976@schnuecks.de>
 <20130201000109.GK7717@titan.lakedaemon.net>
 <20130201001932.GA13044@obsidianresearch.com>
 <20130202230418.GA17361@schnuecks.de>
Message-ID: <20130203164503.GE14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 03, 2013 at 12:04:18AM +0100, Simon Baatz wrote:
> Hi Jason,
> 
> On Thu, Jan 31, 2013 at 05:19:32PM -0700, Jason Gunthorpe wrote:
> > On Thu, Jan 31, 2013 at 07:01:09PM -0500, Jason Cooper wrote:
> > 
> > > If you're interested, I still have a few ideas.  One was to wire two USB
> > > serial adapters end to end to create a different console
> > > (console=/dev/ttyUSB0,115200, getty, etc).  Since they would be going
> > > over usb, that's a different clock, so it should work and provide us
> > > with a safety net.
> > 
> > I can't recall, can you still use JTAG once the CPU has hung on a mbus
> > access?
> > 
> > If so memory dumping the console ring, or cpu registers would get the
> > answer pretty directly..
> > 
> > My guesses would be the RTC and/or GPIO blocks (the GPIO blinker needs
> > a clock), based on table 94.
> 
> These guesses seem to be dead on:
> 
> Moved the RTC module and GPIO modules (keys, leds) out of the way, to
> see whether they cause the boot with disabled runit to lock up.
> 
> System boots now and SSH login is possible!
> 
> # mount -t debugfs debugfs /sys/kernel/debug 
> # cat /sys/kernel/debug/clk/tclk/runit/clk_enable_count 
> 0
> # insmod ./gpio_keys.ko 
> 
> System locks up.
> 
> and, after a reboot:
> 
> # insmod ./rtc-mv.ko 
> 
> System locks up.
> 
> Bingo!

Awesome!  Thanks for running the test Simon!  I see Andrew sent two
patches hopefully fixing these lockups.  I'll wait for your tested-by
and then apply all four to mvebu/fixes:

ARM: kirkwood: of_serial: fix clock gating by removing clock-frequency
ARM: kirkwood: fix to retain gbe MAC addresses for DT kernels
gpio: mvebu: Add clk support to prevent lockup
rtc: rtc-mv: Add support for clk to avoid lockups

I'll push Jason's local-mac-address patch to v3.9.

That should cover everything.

thx,

Jason.
