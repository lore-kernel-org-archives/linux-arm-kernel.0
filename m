From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 1 Jul 2014 10:51:44 +0300
Subject: [RFC 1/4] ARM: tegra: Move SoC drivers to drivers/soc/tegra
In-Reply-To: <20140630192121.GA32594@mithrandir>
References: <1403888329-24755-1-git-send-email-thierry.reding@gmail.com>
 <53AEF81D.3080408@ti.com> <20140628204025.GA16415@ulmo>
 <7497427.LQy8pJts8f@wuerfel> <20140630192121.GA32594@mithrandir>
Message-ID: <20140701075144.GX3679@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 09:21:22PM +0200, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Mon, Jun 30, 2014 at 09:20:30AM +0200, Arnd Bergmann wrote:
> > On Saturday 28 June 2014 22:40:26 Thierry Reding wrote:
> > > > > pmc.c implements various routines to access the power management
> > > > > controller, some of which is needed by suspend/resume, some of it is
> > > > > needed by SMP. powergate.c implements a subset of the PMC that needs to
> > > > > be exported to drivers to enable power partitions on the SoC. I'm not
> > > > > aware of subsystems that deal with this kind of driver.
> > > > >
> > > > Please see above.
> > > 
> > > Like I said, I don't see what business suspend/resume related code has
> > > in drivers/power. What we're talking about here really is functionality
> > > very specific to Tegra. Also some of that code needs to be run at very
> > > early points in the boot process, so we can't reasonably turn it into a
> > > proper driver anyway.
> > 
> > I believe the powergate.c stuff can be changed into pm_domain code, but
> > we don't have a good subsystem with generic DT bindings yet, so that
> > may need some more groundwork first. drivers/power or a subdirectory
> > of that may end up being the right place though.
> 
> So I ended up implementing the powergates as generic_pm_domain, but that
> breaks existing drivers currently. The reason is that generic_pm_domains
> are automatically turned off on suspend and turned back on on resume. On
> Tegra if a partition is powered off then the whole module looses state
> and would need to be completely reinitialized. None of the drivers
> currently support that and I'm also not sure if it's really what we want
> since it means for example redetecting links and reenumerating devices
> on PCI, or probing display outputs in DRM. That's going to take a lot of
> time and may not be appropriate for suspend-to-RAM.
> 
> Unfortunately I haven't found a way to force a domain to remain powered
> during suspend/resume.

If we make power off a NOP until LP0 gets implemented? Then device state
will have to be saved/restored.

Cheers,

Peter.
