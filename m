From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Sep 2015 16:42:21 +0200
Subject: [RFC/PATCH 00/11] arm: omap: counter32k rework
In-Reply-To: <20150930141338.GC31865@saruman.tx.rr.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
 <1986790.syN3WBv9AR@wuerfel> <20150930141338.GC31865@saruman.tx.rr.com>
Message-ID: <3705422.OMk7ysE7Jn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 September 2015 09:13:38 Felipe Balbi wrote:
> On Wed, Sep 30, 2015 at 10:22:46AM +0200, Arnd Bergmann wrote:
> > On Tuesday 29 September 2015 15:43:55 Felipe Balbi wrote:
> > > 
> > > the following patches de-obfuscate arch/arm/mach-omap2/timer.c
> > > and start moving code to drivers/clocksource. So far only counter32k
> > > has been moved over.
> > > 
> > > Note that we can't get rid of all the code (yet) because there are
> > > still platforms relying to legacy boot and because of the strong
> > > coupling with OMAP's hwmod layer.
> > > 
> > > This is, for now, an RFC and has be written on top of [1]. Boot tested
> > > with AM335x and AM437x.
> > > 
> > > [1] http://marc.info/?l=linux-omap&m=144354336924308&w=2
> > 
> > Looks very nice!
> > 
> > > ps: if anybody has a good idea on how to get rid of
> > > register_persistent_clock(), please let me know
> > 
> > I don't think we want to get rid of that, because it is the more
> > accurate interface. IIRC systems that have an RTC will use
> > timekeeping_inject_sleeptime64() in rtc_resume(). I don't know however
> > how the two methods are coordinated, i.e. how the kernel ensures that
> > exactly one of the two is used, but never both.
> 
> however register_persistent_clock() is an ARM-only thing, the question
> was more towards that. Do we want to continue using the ARM-only
> register_persistent_clock() or is there a more generic version of it ?

Ah, got it.

I wouldn't worry about it at the moment, the read_persistent_clock64
interface is very rarely used: only arm, ia64, mips/lasat and s390
define it at all, only arm has more than one implementation (omap
and tegra) and the tegra, ia64 and mips implementations should really
use timekeeping_inject_sleeptime64() instead.

read_boot_clock64() is even rarer: only s390 defines it, apparently
because it is the only architecture that uses a single register for
wall-clock time and high-resolution time (it has a 96-bit
quarternanosecond register that is synchronized before booting Linux).	

TEGRA folks: the tegra_read_persistent_clock() implementation apparently
predates the Tegra RTC driver and I wonder if they actually do the
right thing in combination. Could it be that the wall time forwards
twice as fast as it should during resume when the RTC driver is loaded?
Could it be that we can simply remove  tegra_read_persistent_clock()
and the register_persistent_clock() infrastructure?

	Arnd
