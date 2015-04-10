From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 11 Apr 2015 00:42:13 +0200
Subject: [PATCH v2] arm: zynq: Fix system clock with multi_v7_defconfig
In-Reply-To: <9ba39554-1587-42c6-977e-e4da896cf9c8@BN1BFFO11FD051.protection.gbl>
References: <550F6EDA.30709@adapteva.com> <7916396.UBTtkSpjzN@wuerfel>
 <9ba39554-1587-42c6-977e-e4da896cf9c8@BN1BFFO11FD051.protection.gbl>
Message-ID: <6604961.5ESoH44gK3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 10 April 2015 15:15:11 S?ren Brinkmann wrote:
> On Fri, 2015-04-10 at 10:59PM +0200, Arnd Bergmann wrote:
> > On Friday 10 April 2015 13:41:34 S?ren Brinkmann wrote:
> > > On Fri, 2015-04-10 at 10:04PM +0200, Arnd Bergmann wrote:
> > > > I've just had another idea: how about introducing a new compatible string
> > > > for the global timer that gets used for timers that have their frequency
> > > > tied to the CPU (alternatively a bool property in that node). This can
> > > > be checked by the clocksource driver, which will then be able to either
> > > > skip the device if cpufreq is in use, or implement a more sophisticated
> > > > workaround.
> > > 
> > > If this is the only available clocksource, you'd still want to use it
> > > though. A bad clocksource is still better than none. But I guess that
> > > would just mean to lie in the DT.
> > 
> > On zynq, you always have a local time, right?
> 
> Yes, we have the cadence_ttc as clocksource.

I was thinking of the generic ARM timer (drivers/clocksource/arm_arch_timer.c),
but I forgot that this was only introduced with Cortex-A7/A15 while Zynq is
based on the older Cortex-A9.

> > If we get a platform that has no reliable clocksource, it's probably
> > time to implement scaling in the global timer driver.
> 
> IIRC, the person submitting the driver for the arm_gt said something
> like that those days: https://lkml.org/lkml/2013/5/8/250
> No clue what the current status of that is today though.

I see. Well, I'm not making it your problem, since you have another
timer to use, but I guess it will get fixed eventually. This kind of
bug tends to get duplicated across chips from multiple vendors.

	Arnd
