From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Nov 2017 10:03:10 +0000
Subject: [PATCH] rtc: Allow rtc drivers to specify the tv_nsec value for
 ntp
In-Reply-To: <20171127201812.GB21126@piout.net>
References: <20171013175433.GA22062@obsidianresearch.com>
 <20171123095456.lkc4nkuzsd2q26mm@piout.net>
 <20171123112338.GN31757@n2100.armlinux.org.uk>
 <20171123120451.v74j3z2c5oodxlud@piout.net>
 <20171123125300.GO31757@n2100.armlinux.org.uk>
 <20171127201812.GB21126@piout.net>
Message-ID: <20171128100309.GS31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 09:18:12PM +0100, Alexandre Belloni wrote:
> On 23/11/2017 at 12:53:00 +0000, Russell King - ARM Linux wrote:
> > systohc is more questionable, and always has been.  The "push it out
> > to userspace" approach has been tried in the past, yet we seem to
> > have it back in the kernel.  IIRC, it was originally decided that
> > rtclib would not support it, and that it was going to be done in
> > userspace.
> > 
> > However, the userspace part never appeared, and instead rtclib
> > eventually gained support for it, because it's what people want to
> > see.
> > 
> > I'm not yet convinced by the "lets push it all into userspace" argument
> > because that's vapourware - and we've been there before.  It's "nice"
> > to state but if no one steps up and does it, it's of no benefit and
> > just results in people carrying local hacks (eg in vendor kernels), or
> > working around those who state it.
> > 
> 
> What I see is that people that care about precisely setting the RTC are
> not using systohc because of the 0.5s offset issue or because it doesn't
> do what they want and instead are using their own userspace tool to set
> the RTC time.

If that is the case, where are these tools?

> They have the right to keep those tools closed if they desire so.
> 
> The necessary ABI for userspace to do the right thing is already there
> and you are going to add a new one.

Sorry, I don't think userspace has the information to do a good job.
The idea of setting the RTC to measure the offset is a hack - it's
something that is going to have to be measured each and every time
that the RTC is set, and would need to be done by a real-time process
to ensure that other system noise does not affect it.

> Also, fixing systohc will not fix the offset for people using hwclock or
> any other tools (e.g. systemd).

As has already been said, Jason's suggestion is to export this
information to userspace so that hwclock can be fixed in a similar
way.  hwclock isn't too relevant to the NTP question though, because
it isn't used while ntpd is running.

> I pretty much prefer trying to fix existing userspace tools or if this
> is not possible have a new tool to handle reading/setting the RTC time.

I suspect that won't happen, because there won't be enough interest
in fixing it.  As I've said, this issue had come up years ago, and
the same suggestions were made at that time.  Here we are today,
still without a userspace tool to do it.  What's different this
time around?

Are you going to put the effort in yourself to solve this problem,
or are you going to leave it to some ghostly apperition to do,
resulting in yet another vapourware tool that never actually
materialises?

I'll repeat that I have no interest in creating such a tool as I
already have a working in-kernel solution that doesn't need me to
create any userspace tooling, and I don't care that it isn't in
mainline.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
