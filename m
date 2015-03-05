From: tony@atomide.com (Tony Lindgren)
Date: Thu, 5 Mar 2015 10:49:53 -0800
Subject: [PATCH 1/4] ARM: OMAP2+: omap_hwmod: Introduce ti,no-init dt
 property
In-Reply-To: <alpine.DEB.2.02.1503051815590.5613@utopia.booyaka.com>
References: <1425561211-31003-1-git-send-email-d-gerlach@ti.com>
 <1425561211-31003-2-git-send-email-d-gerlach@ti.com>
 <alpine.DEB.2.02.1503051815590.5613@utopia.booyaka.com>
Message-ID: <20150305184952.GF13520@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [150305 10:16]:
> On Thu, 5 Mar 2015, Dave Gerlach wrote:
> 
> > Introduce a dt property, ti,no-init, that prevents hwmod initialization.
> > Even if a dt node is marked as disabled, hwmod still at least enables
> > the hwmod and programs the sysconfig before attempting to idle it at
> > boot. If an IP has been disabled by the hardware configuration on a
> > platform, this will cause a hang due to writing to inactive registers.
> > This property prevents that from happening by marking the hwmod as
> > _HWMOD_STATE_DISABLED during init.
> 
> I'm kind of wondering if hwmod should even touch a device if it's marked 
> as disabled in the DT.  Tony, what do you think?

Well nothing happens if a device is status = "disabled". No dev entry
gets created for it at all and hwmod won't have any data for the device
populated. The only way hwmod code could see that device if the device
gets it's data from the legacy omap_hwmod_*_data.c instead of DT.

So maybe the comments in the $subject patch are incorrect for that?

What we really should have is also status = "incomplete" where the
dev entry gets created, but the driver never probes. This would be for
devices that are still there within the SoC, but not pinned out for
the board in question.

We still may need also ti,no-init too for devices that we don't want
hwmod to do anything with, for example in secure mode if some blocks
are not available to Linux at all. I believe that's what's going on with
n900 crypto accelerators for example.

Regards,

Tony
