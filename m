From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Nov 2017 11:23:38 +0000
Subject: [PATCH] rtc: Allow rtc drivers to specify the tv_nsec value for
 ntp
In-Reply-To: <20171123095456.lkc4nkuzsd2q26mm@piout.net>
References: <20171013175433.GA22062@obsidianresearch.com>
 <20171123095456.lkc4nkuzsd2q26mm@piout.net>
Message-ID: <20171123112338.GN31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 23, 2017 at 10:54:56AM +0100, Alexandre Belloni wrote:
> Hi,
> 
> On 13/10/2017 at 11:54:33 -0600, Jason Gunthorpe wrote:
> > ntp is currently hardwired to try and call the rtc set when wall clock
> > tv_nsec is 0.5 seconds. This historical behaviour works well with certain
> > PC RTCs, but is not universal to all rtc hardware.
> > 
> > Change how this works by introducing the driver specific concept of
> > set_offset_nsec, the delay between current wall clock time and the target
> > time to set (with a 0 tv_nsecs).
> > 
> > For x86-style CMOS set_offset_nsec should be -0.5 s which causes the last
> > second to be written 0.5 s after it has started.
> > 
> > For compat with the old rtc_set_ntp_time, the value is defaulted to
> > + 0.5 s, which causes the next second to be written 0.5s before it starts,
> > as things were before this patch.
> > 
> > Testing shows many non-x86 RTCs would like set_offset_nsec ~= 0,
> > so ultimately each RTC driver should set the set_offset_nsec according
> > to its needs, and non x86 architectures should stop using
> > update_persistent_clock64 in order to access this feature.
> > Future patches will revise the drivers as needed.
> > 
> > Since CMOS and RTC now have very different handling they are split
> > into two dedicated code paths, sharing the support code, and ifdefs
> > are replaced with IS_ENABLED.
> > 
> > Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> > ---
> >  drivers/rtc/class.c   |   3 +
> >  drivers/rtc/systohc.c |  53 +++++++++++-----
> >  include/linux/rtc.h   |  43 ++++++++++++-
> >  kernel/time/ntp.c     | 166 ++++++++++++++++++++++++++++++++++----------------
> >  4 files changed, 196 insertions(+), 69 deletions(-)
> > 
> > Hello All,
> > 
> > Here is the latest version of this patch that was circulating between
> > RMK and myself. I have done a few more minor changed and been able to
> > test it myself on x86 KVM and on the ARM system that motivated the
> > original CONFIG_RTC_SYSTOHC patch.
> > 
> > From all my testing, this patch does not change the existing behavior
> > at all, but provides the base infrastructure to fix individual RTCs
> > one at a time.
> > 
> > There are a few followup patches that will set the set_offset_nsec
> > value for various RTC drivers, and I still have to look at RMK's
> > hrtimer patch, but those are all incremental on top of this.
> > 
> 
> So I'm discovering that this patch made it upstream silently. While it
> somewhat solves the issue for some RTCs, it is not a proper solution for
> most.
> 
> With this patch, set_offset_nsec will be hardcoded in the driver and
> this basically work for the mc146818 but many RTCs are connected on a
> slow bus (let's say i2c) and that bus may have various latencies
> depending on the platform so the value actually depends on the platform
> rather than on the RTC itself.
> 
> As noted by Russell in another thread, there is already a proper
> solution: do it from userspace as hwclock will already handle most
> issues.

That's incorrect.  hwclock does not have the information to know when
it should set the time - that is hardware specific.  Some RTCs require
it set .5s before the second flips over, others require it at other
times.

hwclock has hard-coded the assumption that it's writing to a standard
PC RTC, so it does the .5s thing, which doesn't give good results on
various ARM platforms.

Accurately reading the current time is way simpler - hwclock does this
by watching for the RTC's seconds changing (via the update interrupt
or emulation.)  That's way easier than setting the time.

> I really think that we should simply consider dropping hctosys,
> systohc and update_persistent_clock. Most distributions have been
> handling it from userspace for a long time. Openembedded has a
> startup/shutdown script.

Not every system does though - you have to adjust debian's
configuration for it to happen at shutdown.

However, that's not the point of the kernel updating the RTC time -
the point of the RTC updates while synchronised is to reduce the
disruption that a crash/reboot causes on NTP by allowing the system
time to be restored as close as possible to the real time as possible.
If the system has crashed with your idea, the RTC will not have been
synchronised since who-knows-when, and the RTC could be way out,
especially if the system has been running for more than a month.

> Even better, systemd has a timesyncing daemon (but it doesn't yet do the
> correct offset calculations).

No thanks.  systemd's timesyncing daemon replaces ntpd, so it forces
you to use systemd if you want this facility.  What if you want this
facility but also facilities from ntpd (eg, for synchronising with
a reference clock?)

The solution that Alexander and myself have come up with is, IMHO, the
best solution, even on buses such as I2C buses.  I've a bunch of
follow-up patches that add set_offset_nsec for pcf8583 and armada38x,
export controls for adjusting that value, and for disabling the NTP
update.

The idea behind the patches that export those controls is to allow
set_offset_nsec to be finely adjusted - in order to do that:

1. you need to synchronise the machine's time keeping to a stable
   reference, let ntp settle.

2. disable NTP updates of the RTC, measure the RTC drift over a long
   period (eg, a day) and trim the RTC for minimal drift.

3. enable NTP updates, wait for an update, and measure the offset
   between real time and RTC time, and use that to adjust
   set_offset_nsec.

You only need to do the full procedure if you really care about
accurate time keeping (eg, you're trying to do something that
requires stable time.)  The point is, these patches _allow_ you to
do this if you wish.  Without them, it's completely impossible to
use Linux for accurately timestamped monitoring allocations - the
answer is not "just run ntpd" because if the system time is out,
it takes ntpd several *hours* to stabilise the systems timekeeping.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
