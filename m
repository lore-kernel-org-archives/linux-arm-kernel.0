From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 23 Nov 2017 13:04:51 +0100
Subject: [PATCH] rtc: Allow rtc drivers to specify the tv_nsec value for
 ntp
In-Reply-To: <20171123112338.GN31757@n2100.armlinux.org.uk>
References: <20171013175433.GA22062@obsidianresearch.com>
 <20171123095456.lkc4nkuzsd2q26mm@piout.net>
 <20171123112338.GN31757@n2100.armlinux.org.uk>
Message-ID: <20171123120451.v74j3z2c5oodxlud@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Correcting Jason's email)

On 23/11/2017 at 11:23:38 +0000, Russell King - ARM Linux wrote:
> > So I'm discovering that this patch made it upstream silently. While it
> > somewhat solves the issue for some RTCs, it is not a proper solution for
> > most.
> > 
> > With this patch, set_offset_nsec will be hardcoded in the driver and
> > this basically work for the mc146818 but many RTCs are connected on a
> > slow bus (let's say i2c) and that bus may have various latencies
> > depending on the platform so the value actually depends on the platform
> > rather than on the RTC itself.
> > 
> > As noted by Russell in another thread, there is already a proper
> > solution: do it from userspace as hwclock will already handle most
> > issues.
> 
> That's incorrect.  hwclock does not have the information to know when
> it should set the time - that is hardware specific.  Some RTCs require
> it set .5s before the second flips over, others require it at other
> times.
> 
> hwclock has hard-coded the assumption that it's writing to a standard
> PC RTC, so it does the .5s thing, which doesn't give good results on
> various ARM platforms.
> 

The 0.5s hardcoding depends on the version of hwclock you use (the
busybox one doesn't do it anymore).

I thought it was handling it better than that and I was indeed
incorrect.

What about setting the time on the RTC once, then using UIE to get the
offset between the set time and the real time then set the time on the
RTC again after accounting for the offset. That would work nicely for
most RTCs.

> Accurately reading the current time is way simpler - hwclock does this
> by watching for the RTC's seconds changing (via the update interrupt
> or emulation.)  That's way easier than setting the time.
> 
> > I really think that we should simply consider dropping hctosys,
> > systohc and update_persistent_clock. Most distributions have been
> > handling it from userspace for a long time. Openembedded has a
> > startup/shutdown script.
> 
> Not every system does though - you have to adjust debian's
> configuration for it to happen at shutdown.
> 
> However, that's not the point of the kernel updating the RTC time -
> the point of the RTC updates while synchronised is to reduce the
> disruption that a crash/reboot causes on NTP by allowing the system
> time to be restored as close as possible to the real time as possible.
> If the system has crashed with your idea, the RTC will not have been
> synchronised since who-knows-when, and the RTC could be way out,
> especially if the system has been running for more than a month.
> 

But nothing prevents you from using hwclock every 11 minutes from
userspace. I really don't think this should be done from the kernel.

Even better, from userspace you can actually chose the time interval you
want. To me, this all seems to be policy encoded in the kernel.

> > Even better, systemd has a timesyncing daemon (but it doesn't yet do the
> > correct offset calculations).
> 
> No thanks.  systemd's timesyncing daemon replaces ntpd, so it forces
> you to use systemd if you want this facility.  What if you want this
> facility but also facilities from ntpd (eg, for synchronising with
> a reference clock?)
> 
> The solution that Alexander and myself have come up with is, IMHO, the
> best solution, even on buses such as I2C buses.  I've a bunch of
> follow-up patches that add set_offset_nsec for pcf8583 and armada38x,
> export controls for adjusting that value, and for disabling the NTP
> update.
> 
> The idea behind the patches that export those controls is to allow
> set_offset_nsec to be finely adjusted - in order to do that:
> 
> 1. you need to synchronise the machine's time keeping to a stable
>    reference, let ntp settle.
> 
> 2. disable NTP updates of the RTC, measure the RTC drift over a long
>    period (eg, a day) and trim the RTC for minimal drift.
> 
> 3. enable NTP updates, wait for an update, and measure the offset
>    between real time and RTC time, and use that to adjust
>    set_offset_nsec.
> 
> You only need to do the full procedure if you really care about
> accurate time keeping (eg, you're trying to do something that
> requires stable time.)  The point is, these patches _allow_ you to
> do this if you wish.  Without them, it's completely impossible to
> use Linux for accurately timestamped monitoring allocations - the
> answer is not "just run ntpd" because if the system time is out,
> it takes ntpd several *hours* to stabilise the systems timekeeping.
> 

I really don't think you currently need help from the kernel to do any
of it (apart from adjusting the oscillator obviously). Nothing currently
prevents you to keep a set_offset_nsec in userspace so you can actually
set the time as close as possible to the current time.

I didn't have time to draft a PoC and that is why I didn't reply on the
patch yet.

What I think is needed is a better tool, maybe a daemon, that would
handle both keeping tabs on the needed offset and handle the oscillator
trimming as it may need to get back and forth between two close values.

I still think we need to drop the SYSTOHC and HCTOSYS stuff. I agree it
can't happen overnight as some people are currently relying on it and
they need to migrate.

But having users wondering whether they should keep hwclock or use
SYSTOHC/HCTOSYS is fucked up as SYSTOHC probably doesn't do what they
want if they don't use NTP (and so they still need to be able to set
time from userspace).

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
