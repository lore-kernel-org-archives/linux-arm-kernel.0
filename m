From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sun, 2 Oct 2011 13:47:01 +0200
Subject: [PATCH 0/4] ARM: EXYNOS4: Support generic Power domain framework
	for EXYNOS4210
In-Reply-To: <001701cc80d2$02ee4940$08cadbc0$%kim@samsung.com>
References: <4E4360B2.2060508@samsung.com> <201108140139.46434.rjw@sisk.pl>
	<001701cc80d2$02ee4940$08cadbc0$%kim@samsung.com>
Message-ID: <201110021347.02146.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, October 02, 2011, Kukjin Kim wrote:
> Rafael J. Wysocki wrote:
> > 
> > On Saturday, August 13, 2011, Russell King - ARM Linux wrote:
> > > On Sat, Aug 13, 2011 at 11:24:07PM +0200, Rafael J. Wysocki wrote:
> > > > On Thursday, August 11, 2011, Chanwoo Choi wrote:
> > > > > The following patch set use the generic Power domain Framework
> instead of
> > > > > power domain code depend of Samsung SoC.
> > > > >
> > > > > Chanwoo Choi (4):
> > > > >   ARM: EXYNOS4: Support for generic I/O power domains on EXYNOS4210
> > > > >   ARM: EXYNOS4: Support for generic Clock manipulation PM callbacks
> > > > >   ARM: EXYNOS4: Delete the power-domain code depend on Samsung SoC
> > > > >   ARM: EXYNOS4: Add power domain to use generic Power domain
> Framework
> > > > >
> > > > >  arch/arm/mach-exynos4/Kconfig                      |   10 +-
> > > > >  arch/arm/mach-exynos4/Makefile                     |    4 +-
> > > > >  arch/arm/mach-exynos4/dev-pd.c                     |  139
> --------------
> > > > >  arch/arm/mach-exynos4/include/mach/pm-exynos4210.h |   52 ++++++
> > > > >  arch/arm/mach-exynos4/include/mach/regs-clock.h    |    8 +
> > > > >  arch/arm/mach-exynos4/mach-nuri.c                  |   21 ++-
> > > > >  arch/arm/mach-exynos4/mach-smdkc210.c              |   26 ++-
> > > > >  arch/arm/mach-exynos4/mach-smdkv310.c              |   23 ++-
> > > > >  arch/arm/mach-exynos4/mach-universal_c210.c        |   21 ++-
> > > > >  arch/arm/mach-exynos4/pm-exynos4210.c              |  189
> ++++++++++++++++++++
> > > > >  arch/arm/mach-exynos4/pm-runtime.c                 |   56 ++++++
> > > > >  arch/arm/plat-samsung/Kconfig                      |    8 -
> > > > >  arch/arm/plat-samsung/Makefile                     |    4 -
> > > > >  arch/arm/plat-samsung/include/plat/pd.h            |   30 ---
> > > > >  arch/arm/plat-samsung/pd.c                         |   95
> ----------
> > > > >  15 files changed, 377 insertions(+), 309 deletions(-)
> > > > >  delete mode 100644 arch/arm/mach-exynos4/dev-pd.c
> > > > >  create mode 100644
> arch/arm/mach-exynos4/include/mach/pm-exynos4210.h
> > > > >  create mode 100644 arch/arm/mach-exynos4/pm-exynos4210.c
> > > > >  create mode 100644 arch/arm/mach-exynos4/pm-runtime.c
> > > > >  delete mode 100644 arch/arm/plat-samsung/include/plat/pd.h
> > > > >  delete mode 100644 arch/arm/plat-samsung/pd.c
> > > >
> > > > The patchset looks good to me, but please note that some code it
> > > > is based on will most likely change in 3.2 due to this patchset:
> > > >
> > > > https://lkml.org/lkml/2011/8/8/420
> > >
> > > Err, isn't all that pm_clk stuff just duplicating what the clk API does?
> > 
> > I'm not sure it's duplicating anything.  Maybe it does, but it came into
> > being by moving some code that were duplicated in a few places throughout
> > the ARM and sh trees into one place.
> > 
> > > IOW, drivers _can_ (and should be) calling clk_disable() when they don't
> > > need the clock running.
> > 
> > Drivers may not know about what to do in a given situation.  For example,
> > if the system has power domains, it may be better to switch a power domain
> > off instead of or in addition to disabling the clock and the driver
> usually
> > doesn't know about that.
> > 
> Hmm... Even though each driver cannot know the given situation, the driver
> can know each own clock should be alive or not. I think, if clock gating
> (enable, disable clock) is required, it should be handled in each driver. In
> addition, the clock and power are not always one-on-one match.

If the driver is to be portable and there's no guarantee that the
clocks configuration on all systems it's supposed to be working with will
always be the same, the driver shouldn't handle clocks directly.

Thanks,
Rafael
