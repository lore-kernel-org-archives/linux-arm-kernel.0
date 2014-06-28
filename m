From: thierry.reding@gmail.com (Thierry Reding)
Date: Sat, 28 Jun 2014 22:40:26 +0200
Subject: [RFC 1/4] ARM: tegra: Move SoC drivers to drivers/soc/tegra
In-Reply-To: <53AEF81D.3080408@ti.com>
References: <1403888329-24755-1-git-send-email-thierry.reding@gmail.com>
 <53ADAA1C.70407@ti.com> <20140627232757.GB26184@ulmo>
 <53AEF81D.3080408@ti.com>
Message-ID: <20140628204025.GA16415@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 28, 2014 at 01:15:09PM -0400, Santosh Shilimkar wrote:
> On Friday 27 June 2014 07:27 PM, Thierry Reding wrote:
[...]
> > drivers/power seems to be exclusively battery charger drivers. The pm.c,
> > pm-*.c and sleep-*.S set up suspend/resume. That doesn't seem to belong
> > in drivers/base/power either.
> >
> It does have AVS PM code as well and also home for power controller
> code. Similar efforts are happening on OMAP [1] to move the PM code
> under drivers/power/*

Quite frankly that doesn't sound any better than putting that code into
drivers/soc. If there is no common framework for a set of drivers, then
I don't see what improvement we get by putting all of them together. If
anything it makes things more chaotic because we sprinkle random driver
bits across the whole tree rather than keeping them together.

That sounds a lot like a dumping ground to me.

According to the MAINTAINERS file, drivers/power is:

	POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS

and that's just not what the Tegra PM code is. That said, it may have
been a little premature to move this code out of arch/arm/mach-tegra,
and I think I'll revisit at a later point.

> > pmc.c implements various routines to access the power management
> > controller, some of which is needed by suspend/resume, some of it is
> > needed by SMP. powergate.c implements a subset of the PMC that needs to
> > be exported to drivers to enable power partitions on the SoC. I'm not
> > aware of subsystems that deal with this kind of driver.
> >
> Please see above.

Like I said, I don't see what business suspend/resume related code has
in drivers/power. What we're talking about here really is functionality
very specific to Tegra. Also some of that code needs to be run at very
early points in the boot process, so we can't reasonably turn it into a
proper driver anyway.

Also, the real win we get from moving code out into drivers/ is if we
can provide a common framework for them. I don't see how we can possibly
do that for this code since there simply isn't enough commonality
between SoCs. At the same time we now have a situation where both 32-bit
and 64-bit variants of some SoCs share some of the same hardware at the
very low level and since we don't have mach-* directories for 64-bit ARM
and shouldn't be duplicating code either, we need to find a new home for
this type of code. drivers/soc seemed to fit perfectly well.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140628/8cdfdb3a/attachment.sig>
