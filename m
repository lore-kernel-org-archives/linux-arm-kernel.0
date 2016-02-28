From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Sun, 28 Feb 2016 21:26:10 +0200
Subject: [PATCH/RFC v2 00/11] ARM/arm64: renesas: Add SYSC PM Domain DT
 Support
In-Reply-To: <2939018.LGDkKsjeJ3@avalon>
References: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
 <CAMuHMdWxHWfghHM5xLVPdDcun5bQPVJKBQ69ZAa6TszDFD+XBw@mail.gmail.com>
 <2939018.LGDkKsjeJ3@avalon>
Message-ID: <4841673.3GCjGElFcY@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Here's an update.

On Sunday 28 February 2016 17:04:47 Laurent Pinchart wrote:
> On Sunday 28 February 2016 09:55:32 Geert Uytterhoeven wrote:
> > On Sat, Feb 27, 2016 at 2:53 AM, Laurent Pinchart wrote:
> >> After rebasing this series on top of Simon's latest devel branch, I'm
> >> experiencing hard system freezes when using the VSP.
> > 
> > Is this due to the rebasing? Did it work in
> > renesas-drivers-2016-02-16-v4.5-rc4 or
> > renesas-drivers-2016-02-23-v4.5-rc5?
> 
> I thought it was, but after further investigations I've been unable to get
> it working at all even on my older branches, so I think the problem has
> always been there.
> 
> >> What makes the problem curious is that PM runtime works fine when the
> >> VSP instances are probed, the A3VP power domain is turned on and off
> >> correctly for each instance. However, after booting the system, if I try
> >> to RPM resume the device, the system hangs.
> >> 
> >> I've traced this (using printk debugging) down to the SYSCISCR write in
> >> rcar_sysc_power(). The value written is 0x00000200, which corresponds to
> >> the A3VP power domain, and the resume request completion wait loop
> >> doesn't time out.
> > 
> > So the second write to SYSCISCR in that function locks up the system?
> 
> Correct, and only after the kernel has booted, there's a bunch of calls to
> rcar_sysc_power() to enable/disable the A3VP power domain at boot time when
> the vsp devices are probed, and those don't cause any issue.

I've investigated the problem further, and realized the freeze was caused by 
writing to the PWRONCR_OFFS register, not the SYSCISCR register. It doesn't 
occur immediately though, I had to put longer delays between the register 
writes to locate the faulty one.

Furthermore, I've also realized that commenting out the A3SH power domain from 
DT seemed to fix the problem. Unused power domains are powered off at the end 
of the boot sequence, and it looks like powering A3SH there somehow messes up 
the SYSC and hangs the system the next time a power domain is turned on.

Given that the latest version of the datasheet doesn't document the A3SH power 
domain it would probably be a good idea to remove it, at least until we can 
get more information from the hardware team.

-- 
Regards,

Laurent Pinchart
