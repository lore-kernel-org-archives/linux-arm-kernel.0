From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 Sep 2017 17:51:41 +0100
Subject: On NTP, RTCs and accurately setting their time
In-Reply-To: <20170920162208.GB536@obsidianresearch.com>
References: <20170920112152.GL20805@n2100.armlinux.org.uk>
 <20170920162208.GB536@obsidianresearch.com>
Message-ID: <20170920165141.GP20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 10:22:08AM -0600, Jason Gunthorpe wrote:
> On Wed, Sep 20, 2017 at 12:21:52PM +0100, Russell King - ARM Linux wrote:
> 
> > However, assumptions are made about the RTC:
> > 
> > 1. kernel/time/ntp.c assumes that all RTCs want to be told to set the
> >    time at around 500ms into the second.
> > 
> > 2. drivers/rtc/systohc.c assumes that if the time being set is >= 500ms,
> >    then we want to set the _next_ second.
> 
> I looked at these issues when I did the sys to HC patches and I
> concluced the first problem was that the RTC read functions generally
> did not return sub second resolution, either in sense of directly
> returning ts_nsec, or the sense of delaying the read until a clock
> tick over event.

The boot time problem can be resolved by using hwclock to set the
system time in userspace - there are distros that do exactly that.
For example, debian has a udev rule:

# Set the System Time from the Hardware Clock and set the kernel's timezone
# value to the local timezone when the kernel clock module is loaded.

KERNEL=="rtc0", RUN+="/lib/udev/hwclock-set $root/$name"

and that script uses hwclock to set the system time from the RTC.
hwclock doesn't just read the RTC and set the system time, it tries
to read the RTC at a whole second, and apply any known RTC drift
correction.

So I wouldn't worry about the kernel's RTC read being inaccurate,
that's been worked around in distros for years.

Embedded distros may not care so much about this (since they care
more about boot speed) except if they're reliant on having correct
time, in which case they may /choose/ to use hwclock in a blocking
manner to ensure that system time is accurately set from the RTC.

However, all that effort is for nowt if the RTC isn't set correctly
in the first place.

> I think we also did some experiments with a few of the RTCs we were
> using and some of them did not adjust the seconds clock phase on
> write, so they seemed incapable of storing sub second data anyhow.

I can imagine that there are RTCs out there which do not reset the
seconds pre-scaler, but just because there are some like that is no
reason to cripple those which are more inteligent about it.

> So.. My feeling was that we'd need driver support in each RTC driver
> to enable sub section resolution.
> 
> Do you know differently?

See above...

> Our pragmatic solution in our products was to have the initial time
> sync from NTP step the clock even if the offset is small.

That's all very well, but consider when your time source is GPS and
you're not on a network connection that would allow ntpdate to do
any better (eg, a 3G mobile data card...)  I have exactly that setup
with a remote monitoring system.  If I reboot the gateway with the
3G and GPS, NTP makes big PPM adjustments while trying to correct for
the 970ms time shift, and that madness is transmitted by ntpd to the
stratum 2 servers.

> > So, the question is... how should these differences in rtc requirements
> > be handled?
> 
> I think patch wise, this is something I would rather see handled
> internally via the drivers and perhaps with input from DT, not via
> sysctl knobs.

I sort-of agree as far as the time offset information goes, but there's
a complication that we only open the RTC to set the time at the point in
time that we want to set it - while the RTC is closed, the RTC driver
module could be removed and replaced by a different RTC driver which
replaces the existing device.

Don't think that's not possible, there are boards out there with multiple
RTCs on them, so its entirely possible that the wrong RTC could be
selected with random module probe ordering and need manual resolution.
For example, the system I mention above has the built-in iMX6 SVNS RTC
which gets powered down when power is removed, and a PCF8523 RTC which
doesn't... and there's variants of the board where the PCF8523 isn't
fitted, so users are reliant on the iMX6 RTC for cross-reboot time.


The patch is not meant to be a final solution, so criticising it for
using sysctls is not appropriate - it is firstly to prove the point that
we are in fact able to correctly set RTCs, and secondly (as I explained
in the bits you cut) to provide a knob to turn off the kernel's automatic
RTC setting so it's possible to accurately trim the RTC.

Many RTCs contain registers that allow fine trimming of their tick rate,
and if you care about the time keeping of your RTC, it's something that
needs to be calibrated against a known correct time source.  Having the
kernel repeatedly set the RTC every 11 minutes while you're trying to
measure the RTCs drift over a period of 12 hours is not on - and in
order to make such a measurement, you want the machine to be NTP
synchronised.  That's the exact situation that triggers kernels to
periodically write the time to the RTC.

So, we _do_ need a knob to turn that kernel timekeeping facility on and
off in addition to the "are we NTP sync'd" status.

> The HW driver should know how to read and write with sub second
> resolution. If it works best with a certain value in the ts_nsec
> field, then it should set something inside rtc_chip that causes the
> systohc code to try and call it with that tv_nsec.

The problem is deeper than the systohc.c code - the timing of the call
made into the systohc.c code is decided by kernel/time/ntp.c, and
currently is within a tick of 500ms past the second.

> It would probably also make sense to add new ntp ops for sub second
> get/set that includes the full timespec. This way the RTC driver can
> provide the right adjustments and we can get rid of the +1 in
> rtc_set_ntp_time and the +0.5 in rtc_hctosys for sub sec aware
> drivers..

Do we have any sub-second aware drivers?  None of my RTCs are, and I
don't think it's fair for RTC drivers to sleep when getting a request
to set the time.

The userspace API doesn't do that, and the workqueue involved in
setting NTP time is probably run using shared system_power_efficient_wq
resources, so blocking there will be detrimental to other works queued
on that.

Maybe the NTP code should call into RTCs to enable/disable the time
setting feature and leave RTC drivers to do that, but that seems to me
like a lot of code in each driver as well as something of a layering
issue.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
