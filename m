From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 8 Jul 2014 17:11:35 +0300
Subject: [PATCH 6/9] ARM: tegra: Export tegra_powergate_power_on
In-Reply-To: <20140708130501.GC9516@ulmo>
References: <539F691E.5030204@wwwdotorg.org> <20140617121313.GE18816@ulmo>
 <20140617140146.GH3407@tbergstrom-lnx.Nvidia.com>
 <20140617215119.GC24743@mithrandir>
 <20140618121806.GJ3407@tbergstrom-lnx.Nvidia.com>
 <53A1B252.1030204@wwwdotorg.org>
 <20140619080234.GK3407@tbergstrom-lnx.Nvidia.com>
 <53A3096B.1040409@wwwdotorg.org>
 <20140623101441.GU3407@tbergstrom-lnx.Nvidia.com>
 <20140708130501.GC9516@ulmo>
Message-ID: <20140708141135.GC23218@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > 
> > Yes, but the problem is that you also need clocks and reset of other modules
> > in the same domain to safely control the domain's status. Eg: the ISPs, VI and
> > CSI share a domain. VI and CSI are useable without ISP and the ISP lacks
> > public documentation. So it's not unlikely a VI and CSI driver will upstreamed
> > someday which means we would need to control the domain and therefore would
> > need to tell that driver about the ISPs clocks and resets even though the
> > driver doesn't know anything about the ISP hw otherwise.
> 
> Can't we make powergates reference counted so that they don't get
> disabled as long as there are any users? Looking for example at the

We could, but then why not switch to the powerdomain code and make powering
off a domain a NOP until we sorted out the context save/restore or fixed
the framework to allow for suspend without turning off the domains?

> display controller driver, modules don't seem to care overly much about
> the powergate's state except that it needs to be turned on before they
> touch some of the registers.
> 
> From a bit of experimentation it also seems like the sequence encoded
> within tegra_powergate_sequence_power_up() isn't at all necessary. I
> couldn't find an authoritative reference for that either, so I'm tempted
> to conclude that it was simply cargo-culted from the dark-ages.
> 
> So I'm thinking that if we ever move to use power domains for this, we
> may be able to just drop any extra handling (well, we'd need to keep it
> for backwards-compatibility... *sigh*) and let drivers handle the clock
> and reset resources.
> 
> On the other hand, given that we already need to keep the existing code
> for backwards-compatibility, I'm not sure there's a real advantage in
> turning them into power domains, since we'd be adding extra code without
> an clear gains (especially since it seems like we'd need even more code
> to properly handle suspend/resume in drivers that need powergates).
> 

Unless we fix the framework to require context save/restore for suspend.
There is a good reason to do that. context save/restore requires energy
as well, so it's not a given that turning off domains in system suspend
will save power.

Cheers,

Peter.
