From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 27 Nov 2017 21:18:12 +0100
Subject: [PATCH] rtc: Allow rtc drivers to specify the tv_nsec value for
 ntp
In-Reply-To: <20171123125300.GO31757@n2100.armlinux.org.uk>
References: <20171013175433.GA22062@obsidianresearch.com>
 <20171123095456.lkc4nkuzsd2q26mm@piout.net>
 <20171123112338.GN31757@n2100.armlinux.org.uk>
 <20171123120451.v74j3z2c5oodxlud@piout.net>
 <20171123125300.GO31757@n2100.armlinux.org.uk>
Message-ID: <20171127201812.GB21126@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/11/2017 at 12:53:00 +0000, Russell King - ARM Linux wrote:
> On Thu, Nov 23, 2017 at 01:04:51PM +0100, Alexandre Belloni wrote:
> > What about setting the time on the RTC once, then using UIE to get the
> > offset between the set time and the real time then set the time on the
> > RTC again after accounting for the offset. That would work nicely for
> > most RTCs.
> 
> That could work, but you're looking at making every hwclock based
> write take maybe at least two seconds, unless you cache that
> information somewhere.  If you cache that, then you end up with a
> problem when someone (like I do) copies the rootfs between different
> platforms.  Sometimes I copy SD cards.
> 
> Sometimes I even NFS boot the same export on different platforms
> (but obviously not at the same time.)
> 

I don't think it is really an issue to have setting the RTC time take a
few seconds.

[...]

> > But nothing prevents you from using hwclock every 11 minutes from
> > userspace. I really don't think this should be done from the kernel.
> 
> It's not just about running hwclock every 11 minutes.  It's about
> running hwclock when NTP sync'd.  If the local clock is not sync'd
> you don't want to be running hwclock, especially if you've trimmed
> the RTC.  So merely throwing hwclock -uw into a cron job really
> doesn't solve it.
> 

Yes and I would hope userspace knows that it is using NTP to sync the
local clock...

> A way around that would be to install adjtimex, so that the kernel's
> NTP flags can be read out.  However, that comes with its own set of
> problems.
> 
> On Debian, installing adjtimex will disrupt the timekeeping because
> of the post-install scripts debian runs.  It seems Debian assumes
> that if you install something, it has the right to modify the system
> timekeeping parameters immediately, screwing up ntpd in the process,
> if it's running.  The thought that you're installing adjtimex because
> you want to _inspect_ the kernel ntp parameters is not one that
> Debian folk appear to have considered as being a reason for installing
> the package.
> 

Aren't those mainly userspace/integration problems that should be fixed
in Debian?

> > I really don't think you currently need help from the kernel to do any
> > of it (apart from adjusting the oscillator obviously). Nothing currently
> > prevents you to keep a set_offset_nsec in userspace so you can actually
> > set the time as close as possible to the current time.
> > 
> > I didn't have time to draft a PoC and that is why I didn't reply on the
> > patch yet.
> > 
> > What I think is needed is a better tool, maybe a daemon, that would
> > handle both keeping tabs on the needed offset and handle the oscillator
> > trimming as it may need to get back and forth between two close values.
> > 
> > I still think we need to drop the SYSTOHC and HCTOSYS stuff. I agree it
> > can't happen overnight as some people are currently relying on it and
> > they need to migrate.
> > 
> > But having users wondering whether they should keep hwclock or use
> > SYSTOHC/HCTOSYS is fucked up as SYSTOHC probably doesn't do what they
> > want if they don't use NTP (and so they still need to be able to set
> > time from userspace).
> 
> Do not go there.  Having run systems with no local RTC, I can tell you
> that they're a right pain if system time is not properly set before
> userspace starts.  For example, you sometimes can't get a "ps" listing
> because a procfs file contains a "btime" of zero, and it complains
> and errors out on that.  Other problems have been NFS XIDs which end
> up always starting from the same value, so the NFS server thinks they
> are being replayed by the client (despite it being an entirely different
> kernel being run.)  That still exists if you reboot quickly enough.
> 
> So no, removing hctosys would be a big mistake.
> 

Ok, that is a good point to keep hctosys.


> systohc is more questionable, and always has been.  The "push it out
> to userspace" approach has been tried in the past, yet we seem to
> have it back in the kernel.  IIRC, it was originally decided that
> rtclib would not support it, and that it was going to be done in
> userspace.
> 
> However, the userspace part never appeared, and instead rtclib
> eventually gained support for it, because it's what people want to
> see.
> 
> I'm not yet convinced by the "lets push it all into userspace" argument
> because that's vapourware - and we've been there before.  It's "nice"
> to state but if no one steps up and does it, it's of no benefit and
> just results in people carrying local hacks (eg in vendor kernels), or
> working around those who state it.
> 

What I see is that people that care about precisely setting the RTC are
not using systohc because of the 0.5s offset issue or because it doesn't
do what they want and instead are using their own userspace tool to set
the RTC time.

They have the right to keep those tools closed if they desire so.

The necessary ABI for userspace to do the right thing is already there
and you are going to add a new one.

Also, fixing systohc will not fix the offset for people using hwclock or
any other tools (e.g. systemd).

I pretty much prefer trying to fix existing userspace tools or if this
is not possible have a new tool to handle reading/setting the RTC time.

> I also don't particularly like the concept of trying to measure the
> RTC's time-set offset.  My userspace programs that measure the RTC
> offset show that to get to millisecond resolution, it isn't trivial
> because of system timing "noise" - you need to calibrate the reading
> side first so you can get an estimation of when the RTC second flips.
> You'd then need to set the RTC time, and then re-measure when the RTC
> second flips, wait for the appropriate system time and then write the
> RTC.  You're look at between 2 and 4 seconds for that, and a window
> where a perfectly good RTC could be set to an offset time.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
