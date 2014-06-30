From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Jun 2014 09:20:30 +0200
Subject: [RFC 1/4] ARM: tegra: Move SoC drivers to drivers/soc/tegra
In-Reply-To: <20140628204025.GA16415@ulmo>
References: <1403888329-24755-1-git-send-email-thierry.reding@gmail.com>
 <53AEF81D.3080408@ti.com> <20140628204025.GA16415@ulmo>
Message-ID: <7497427.LQy8pJts8f@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 28 June 2014 22:40:26 Thierry Reding wrote:
> > > pmc.c implements various routines to access the power management
> > > controller, some of which is needed by suspend/resume, some of it is
> > > needed by SMP. powergate.c implements a subset of the PMC that needs to
> > > be exported to drivers to enable power partitions on the SoC. I'm not
> > > aware of subsystems that deal with this kind of driver.
> > >
> > Please see above.
> 
> Like I said, I don't see what business suspend/resume related code has
> in drivers/power. What we're talking about here really is functionality
> very specific to Tegra. Also some of that code needs to be run at very
> early points in the boot process, so we can't reasonably turn it into a
> proper driver anyway.

I believe the powergate.c stuff can be changed into pm_domain code, but
we don't have a good subsystem with generic DT bindings yet, so that
may need some more groundwork first. drivers/power or a subdirectory
of that may end up being the right place though.

> Also, the real win we get from moving code out into drivers/ is if we
> can provide a common framework for them. I don't see how we can possibly
> do that for this code since there simply isn't enough commonality
> between SoCs. At the same time we now have a situation where both 32-bit
> and 64-bit variants of some SoCs share some of the same hardware at the
> very low level and since we don't have mach-* directories for 64-bit ARM
> and shouldn't be duplicating code either, we need to find a new home for
> this type of code. drivers/soc seemed to fit perfectly well.

For the low-level stuff yes, but I agree with Santosh there needs to be
some more work trying to split out individual high-level drivers.

There are two common patterns for the interface between the low-level
register access and the more high-level stuff:  you can either use
a "syscon" driver that just exports a struct regmap and that gets referenced
from other drivers using a phandle in their device nodes, or you have
a driver in drivers/soc that exports a somewhat higher-level interface
and comes with its own header file that gets included by other drivers.
At the moment, the syscon/regmap variant can only be used once device
drivers are loaded, but there is some broad agreement that it should
be changed to allow calling syscon_regmap_lookup_by_phandle() at
early boot using just DT accessors.

	Arnd
