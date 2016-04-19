From: tony@atomide.com (Tony Lindgren)
Date: Tue, 19 Apr 2016 12:51:47 -0700
Subject: [GIT PULL] omap fixes against v4.6-rc2
In-Reply-To: <20160419145400.GC5995@atomide.com>
References: <20160408191854.GZ16484@atomide.com>
 <20160419145400.GC5995@atomide.com>
Message-ID: <20160419195147.GE5973@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [160419 07:55]:
> * Tony Lindgren <tony@atomide.com> [160408 12:22]:
> >       ARM: OMAP: Catch callers of revision information prior to it being populated
> 
> And this one causes bogus runtime warnings with other SoCs
> as reported by Guenter Roeck. I'll revert this and post
> an updated pull request shortly.

And below is the updated pull request with just the above
commit reverted.

Regards,

Tony

8< -------------------
The following changes since commit 9735a22799b9214d17d3c231fe377fc852f042e9:

  Linux 4.6-rc2 (2016-04-03 09:09:40 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.6/fixes-rc2-v2-signed

for you to fetch changes up to 3d51ae172d759198b2e47e104c31a92d20d17927:

  Revert "ARM: OMAP: Catch callers of revision information prior to it being populated" (2016-04-19 08:01:05 -0700)

----------------------------------------------------------------
Fixes for omaps against v4.6-rc2, mostly to fix suspend for beagle-x15
that broke when we added runtime based SoC revision detection earlier.

It seems suspend worked earlier as things were only partially initialized,
while now we initialize things properly for dra7.

Note that the "ARM: OMAP: Catch callers of revision information prior
to it being populated" had to be reverted as it caused bogus warnings
for other SoCs because omap initcalls bail out based on revision being
set to 0 for other SoCs. These initcalls will mostly just disappear
when we drop support for omap3 legacy booting.

Also included is a fix for dra7 sys_32k_ck clock source that is not
enabled on boot making system fall back to using emulated clock.

----------------------------------------------------------------
Keerthy (1):
      ARM: dts: dra7: Correct clock tree for sys_32k_ck

Nishanth Menon (3):
      ARM: OMAP: DRA7: wakeupgen: Skip SAR save for wakeupgen
      ARM: OMAP: DRA7: Provide proper class to omap2_set_globals_tap
      ARM: OMAP: Catch callers of revision information prior to it being populated

Tony Lindgren (1):
      Revert "ARM: OMAP: Catch callers of revision information prior to it being populated"

 arch/arm/boot/dts/dra7xx-clocks.dtsi | 18 +++++++++++++++++-
 arch/arm/mach-omap2/io.c             |  3 ++-
 arch/arm/mach-omap2/omap-wakeupgen.c |  7 +++++++
 3 files changed, 26 insertions(+), 2 deletions(-)
