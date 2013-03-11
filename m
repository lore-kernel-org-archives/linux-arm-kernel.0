From: robherring2@gmail.com (Rob Herring)
Date: Mon, 11 Mar 2013 15:04:13 -0500
Subject: [GIT PULL] clocksource cleanup for 3.10
Message-ID: <513E38BD.4080407@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Please pull. This improves the clocksource init to avoid double matching
to the DT device node. The clocksource init function changes are needed
for any other clocksource conversions to CLKSRC_OF, so we need to make
sure any other conversions use this branch (It happens to silently work
without warnings, but there would be a mismatch in function ptrs). I'm
including the twd_smp timer support for CLKSRC_OF here because of the
dependency on this change.

Rob

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:

  git://sources.calxeda.com/kernel/linux.git tags/clksrc-cleanup-for-3.10

for you to fetch changes up to da4a686a2cfb077a8bfc1697f597e7f86235b822:

  ARM: smp_twd: convert to use CLKSRC_OF init (2013-03-11 08:42:08 -0500)

----------------------------------------------------------------
- Add device_node ptr to clocksource init functions
- Add CLKSRC_OF support to twd_smp timer

----------------------------------------------------------------
Rob Herring (4):
      clocksource: add empty version of clocksource_of_init
      clocksource: pass DT node pointer to init functions
      clocksource: tegra20: use the device_node pointer passed to init
      ARM: smp_twd: convert to use CLKSRC_OF init

 arch/arm/Kconfig                    |    1 +
 arch/arm/include/asm/smp_twd.h      |    8 ----
 arch/arm/kernel/smp_twd.c           |   17 ++------
 arch/arm/mach-highbank/highbank.c   |    5 +--
 arch/arm/mach-imx/mach-imx6q.c      |    5 +--
 arch/arm/mach-omap2/timer.c         |    2 +-
 arch/arm/mach-spear13xx/spear13xx.c |    4 +-
 arch/arm/mach-ux500/timer.c         |    3 +-
 arch/arm/mach-vexpress/v2m.c        |    6 +--
 drivers/clocksource/bcm2835_timer.c |   12 +-----
 drivers/clocksource/clksrc-of.c     |    4 +-
 drivers/clocksource/tegra20_timer.c |   73
+++++++++++++----------------------
 drivers/clocksource/vt8500_timer.c  |   14 +------
 include/linux/clocksource.h         |    1 +
 14 files changed, 49 insertions(+), 106 deletions(-)
