From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Nov 2017 12:53:00 +0000
Subject: [PATCH] rtc: Allow rtc drivers to specify the tv_nsec value for
 ntp
In-Reply-To: <20171123120451.v74j3z2c5oodxlud@piout.net>
References: <20171013175433.GA22062@obsidianresearch.com>
 <20171123095456.lkc4nkuzsd2q26mm@piout.net>
 <20171123112338.GN31757@n2100.armlinux.org.uk>
 <20171123120451.v74j3z2c5oodxlud@piout.net>
Message-ID: <20171123125300.GO31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 23, 2017 at 01:04:51PM +0100, Alexandre Belloni wrote:
> (Correcting Jason's email)
> 
> On 23/11/2017 at 11:23:38 +0000, Russell King - ARM Linux wrote:
> > > So I'm discovering that this patch made it upstream silently. While it
> > > somewhat solves the issue for some RTCs, it is not a proper solution for
> > > most.
> > > 
> > > With this patch, set_offset_nsec will be hardcoded in the driver and
> > > this basically work for the mc146818 but many RTCs are connected on a
> > > slow bus (let's say i2c) and that bus may have various latencies
> > > depending on the platform so the value actually depends on the platform
> > > rather than on the RTC itself.
> > > 
> > > As noted by Russell in another thread, there is already a proper
> > > solution: do it from userspace as hwclock will already handle most
> > > issues.
> > 
> > That's incorrect.  hwclock does not have the information to know when
> > it should set the time - that is hardware specific.  Some RTCs require
> > it set .5s before the second flips over, others require it at other
> > times.
> > 
> > hwclock has hard-coded the assumption that it's writing to a standard
> > PC RTC, so it does the .5s thing, which doesn't give good results on
> > various ARM platforms.
> > 
> 
> The 0.5s hardcoding depends on the version of hwclock you use (the
> busybox one doesn't do it anymore).

Right, so it'll be correct for a different set of RTCs and wrong
for others.  So, forget current versions of hwclock, none of them
know how to correctly set the time on all RTCs.  It fundamentally
lacks the information required, because there's no way for it to
know that information at present.

> I thought it was handling it better than that and I was indeed
> incorrect.
> 
> What about setting the time on the RTC once, then using UIE to get the
> offset between the set time and the real time then set the time on the
> RTC again after accounting for the offset. That would work nicely for
> most RTCs.

That could work, but you're looking at making every hwclock based
write take maybe at least two seconds, unless you cache that
information somewhere.  If you cache that, then you end up with a
problem when someone (like I do) copies the rootfs between different
platforms.  Sometimes I copy SD cards.

Sometimes I even NFS boot the same export on different platforms
(but obviously not at the same time.)

> > Accurately reading the current time is way simpler - hwclock does this
> > by watching for the RTC's seconds changing (via the update interrupt
> > or emulation.)  That's way easier than setting the time.
> > 
> > > I really think that we should simply consider dropping hctosys,
> > > systohc and update_persistent_clock. Most distributions have been
> > > handling it from userspace for a long time. Openembedded has a
> > > startup/shutdown script.
> > 
> > Not every system does though - you have to adjust debian's
> > configuration for it to happen at shutdown.
> > 
> > However, that's not the point of the kernel updating the RTC time -
> > the point of the RTC updates while synchronised is to reduce the
> > disruption that a crash/reboot causes on NTP by allowing the system
> > time to be restored as close as possible to the real time as possible.
> > If the system has crashed with your idea, the RTC will not have been
> > synchronised since who-knows-when, and the RTC could be way out,
> > especially if the system has been running for more than a month.
> > 
> 
> But nothing prevents you from using hwclock every 11 minutes from
> userspace. I really don't think this should be done from the kernel.

It's not just about running hwclock every 11 minutes.  It's about
running hwclock when NTP sync'd.  If the local clock is not sync'd
you don't want to be running hwclock, especially if you've trimmed
the RTC.  So merely throwing hwclock -uw into a cron job really
doesn't solve it.

A way around that would be to install adjtimex, so that the kernel's
NTP flags can be read out.  However, that comes with its own set of
problems.

On Debian, installing adjtimex will disrupt the timekeeping because
of the post-install scripts debian runs.  It seems Debian assumes
that if you install something, it has the right to modify the system
timekeeping parameters immediately, screwing up ntpd in the process,
if it's running.  The thought that you're installing adjtimex because
you want to _inspect_ the kernel ntp parameters is not one that
Debian folk appear to have considered as being a reason for installing
the package.

> I really don't think you currently need help from the kernel to do any
> of it (apart from adjusting the oscillator obviously). Nothing currently
> prevents you to keep a set_offset_nsec in userspace so you can actually
> set the time as close as possible to the current time.
> 
> I didn't have time to draft a PoC and that is why I didn't reply on the
> patch yet.
> 
> What I think is needed is a better tool, maybe a daemon, that would
> handle both keeping tabs on the needed offset and handle the oscillator
> trimming as it may need to get back and forth between two close values.
> 
> I still think we need to drop the SYSTOHC and HCTOSYS stuff. I agree it
> can't happen overnight as some people are currently relying on it and
> they need to migrate.
> 
> But having users wondering whether they should keep hwclock or use
> SYSTOHC/HCTOSYS is fucked up as SYSTOHC probably doesn't do what they
> want if they don't use NTP (and so they still need to be able to set
> time from userspace).

Do not go there.  Having run systems with no local RTC, I can tell you
that they're a right pain if system time is not properly set before
userspace starts.  For example, you sometimes can't get a "ps" listing
because a procfs file contains a "btime" of zero, and it complains
and errors out on that.  Other problems have been NFS XIDs which end
up always starting from the same value, so the NFS server thinks they
are being replayed by the client (despite it being an entirely different
kernel being run.)  That still exists if you reboot quickly enough.

So no, removing hctosys would be a big mistake.

systohc is more questionable, and always has been.  The "push it out
to userspace" approach has been tried in the past, yet we seem to
have it back in the kernel.  IIRC, it was originally decided that
rtclib would not support it, and that it was going to be done in
userspace.

However, the userspace part never appeared, and instead rtclib
eventually gained support for it, because it's what people want to
see.

I'm not yet convinced by the "lets push it all into userspace" argument
because that's vapourware - and we've been there before.  It's "nice"
to state but if no one steps up and does it, it's of no benefit and
just results in people carrying local hacks (eg in vendor kernels), or
working around those who state it.

I also don't particularly like the concept of trying to measure the
RTC's time-set offset.  My userspace programs that measure the RTC
offset show that to get to millisecond resolution, it isn't trivial
because of system timing "noise" - you need to calibrate the reading
side first so you can get an estimation of when the RTC second flips.
You'd then need to set the RTC time, and then re-measure when the RTC
second flips, wait for the appropriate system time and then write the
RTC.  You're look at between 2 and 4 seconds for that, and a window
where a perfectly good RTC could be set to an offset time.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
