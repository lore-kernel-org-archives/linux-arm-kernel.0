From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Sep 2017 10:57:13 +0100
Subject: On NTP, RTCs and accurately setting their time
In-Reply-To: <20170921232040.GA15130@obsidianresearch.com>
References: <20170920112152.GL20805@n2100.armlinux.org.uk>
 <20170920162208.GB536@obsidianresearch.com>
 <20170920165141.GP20805@n2100.armlinux.org.uk>
 <20170920224522.GB20974@obsidianresearch.com>
 <20170921075907.GR20805@n2100.armlinux.org.uk>
 <20170921093218.GS20805@n2100.armlinux.org.uk>
 <20170921220510.GA11395@obsidianresearch.com>
 <20170921224541.GC20805@n2100.armlinux.org.uk>
 <20170921232040.GA15130@obsidianresearch.com>
Message-ID: <20170922095713.GD20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 21, 2017 at 05:20:40PM -0600, Jason Gunthorpe wrote:
> On Thu, Sep 21, 2017 at 11:45:41PM +0100, Russell King - ARM Linux wrote:
> > > I've combined several of your messages together into this reply...
> > 
> > Sorry about that, I'm currently ill and sleep deprived, so it's been
> > a struggle to pick up on everything together.
> 
> No worries, your replys were easy to follow, thanks

Feeling better today, thankfully.

> > > So with v2 of this patch, the driver would specify positive 1s, and
> > > then the set will be called when tv_nsec == 0, but the tv_sec will
> > > be +1.
> > > 
> > > Similarly the existing case of 0.5s offset will work more like
> > > before, where it will be called with tv_nsec == .5s and the tv_sec
> > > will be +1 - before I think this happened reliably 'by accident' due
> > > to the rounding.
> > 
> > It seems to mean (from reading the code) that I'd need to specify
> > -470ms for the PCF8523, if I'm understand what you're saying and
> > the code correctly.
> 
> Okay.. but I guessed a negative number is probably not what most RTCs would
> want, eg a positive number would compensate for delays executing an
> I2C command, assuming the RTC zeros its divider when it sets the time.

Okay, I thought I'd investigate a few other systems:

With the mainline code, which sets the RTC to tv_sec + 1 when tv_nsec
>= 500ms or tv_sec when tv_nsec < 500ms, at about tv_nsec = 500ms:

Dove - drifting about 4-5ms per minute:
RTC Time: 22-09-2017 09:06:38
System Time was:     09:06:37.464
RTC Time: 22-09-2017 09:07:38
System Time was:     09:07:37.508
RTC Time: 22-09-2017 09:08:39
System Time was:     09:08:38.504
...
RTC Time: 22-09-2017 09:17:48
System Time was:     09:17:47.464
RTC Time: 22-09-2017 09:18:48
System Time was:     09:18:47.500

I suspect this wants the time to be set at or around tv_nsec = 0.


Armada 388 - drifting@about 2-3ms per minute:
RTC Time: 22-09-2017 08:22:25
System Time was:     08:22:25.498
...
RTC Time: 22-09-2017 08:30:42
System Time was:     08:30:42.516
RTC Time: 22-09-2017 08:31:43
System Time was:     08:31:43.518
RTC Time: 22-09-2017 08:32:45
System Time was:     08:32:44.520
RTC Time: 22-09-2017 08:33:46
System Time was:     08:33:45.522
...
RTC Time: 22-09-2017 08:41:54
System Time was:     08:41:53.540
RTC Time: 22-09-2017 08:42:55
System Time was:     08:42:54.542
RTC Time: 22-09-2017 08:43:56
System Time was:     08:43:55.520
RTC Time: 22-09-2017 08:44:57
System Time was:     08:44:56.522

This looks the same as the Dove case - although there's some flucuation
in the second offset, probably caused by the 500ms threshold in
rtc_set_ntp_time().

> > Also... don't we want to move the call to rtc_set_ntp_time() from out
> > of the "if (abs(now.tv_nsec - (NSEC_PER_SEC / 2)) <= tick_nsec * 5) {"
> > check, otherwise how could it be called except at about .5s?
> 
> Yes, definitely. If we do not call through to rtc_set_ntp_time then it
> does not update target_nsec, and we go back to the 0.5 offset not the
> offset you want, which will certainly cause random rtc_tv_nsec_ok
> failures.
> 
> My bad to not notice that.. But I'm not sure what the revision should
> be.. I think this is using tick_nsec similarly to TIME_SET_NSEC_FUZZ,
> but I'm not sure where tick_nsec comes from or if we should push it
> down in to TIME_SET_NSEC_FUZZ, or something else.

I think tick_nsec is the length of one tick in nanoseconds, adjusted
by NTP (see ntp_update_frequency() where it's calculated.)

It's probably easiest to think about it in terms of the old timekeeping
model, where we had a periodic tick whose period was fixed and defined
the point at which time incremented.  tick_nsec would be the amount of
time for one period.

I think that's still relevant in a modern kernel, especially when it's
using a clock event in periodic mode, as that's when we get the regular
interrupts which guarantee a scheduling point (other scheduling points
are available!) and hence when the workqueue can be run.

The only places it's used is by the NTP code, and also by a few
architectures to that still have gettimeoffset() functionality (pre-
clocksource) as it can be used to derive the scaling factor to convert
timer count ticks to wall time.

I also don't see an obvious rearrangement of the code to fix this -
the problem is we need to call update_persistent_clock64() to know
whether we should call rtc_set_ntp_time(), but we can only call
update_persistent_clock64() on tv_nsec=500ms.

It looks like the users of update_persistent_clock*() are:
arch/mips/kernel/time.c
arch/powerpc/kernel/time.c
arch/sh/kernel/time.c
arch/x86/kernel/rtc.c

I thought SH was introduced after rtclib was born?

All of these have some kind of architecture specific multiplexing of
the update_persistent_clock() call - switch statements depending on
rtc type, function pointers set according to the rtc type, etc.  They
all look like legacy code that no one wants to update to rtclib.

Maybe the solution here is to split two forms of ntp RTC synchronisation
so:
- If you enable CONFIG_GENERIC_CMOS_UPDATE, then you get the
  update_persistent_clock*() methods called.
- If you enable CONFIG_RTC_SYSTOHC, rtc_set_ntp_time() gets called.
- If you enable both, then both get called at their appropriate times.

This would certainly simplify sync_cmos_clock().

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
