From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Dec 2014 22:42:11 +0100
Subject: [GIT PULL 7/9] ARM: SoC/OMAP GPMC driver cleanup and move for 3.19
In-Reply-To: <4491193.a6KEQb1tZH@wuerfel>
References: <4491193.a6KEQb1tZH@wuerfel>
Message-ID: <6113188.8lGm6IAWL0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 065bd7fe50de5e6d0fd5034cbc87120a558a1219:

  ARM: dts: DRA7: Add aliases for all serial ports (2014-11-12 07:04:37 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/omap-gpmc-for-linus

for you to fetch changes up to 1306b20daa38c1429dabacc9ec8b437cb585e427:

  Merge tag 'omap-for-v3.19/gpmc-move-v2' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into next/omap-gpmc (2014-11-28 23:24:12 +0100)

----------------------------------------------------------------
ARM: SoC/OMAP GPMC driver cleanup and move for 3.19

The GPMC driver has traditionally been considered a part of the
OMAP platform code and tightly interweaved with some of the boards.

With this cleanup, it has finally come to the point where it makes
sense to move it out of arch/arm into drivers/memory, where we already
have other drivers for similar hardware. The cleanups are still
ongoing, with the goal of eventually having a standalone driver
that does not require an interface to architecture code.

This is a separate branch because of dependencies on multiple other
branches, and to keep the drivers changes separate from the normal
cleanups.

----------------------------------------------------------------
Arnd Bergmann (4):
      Merge branch 'omap/dt' into next/omap-gpmc
      Merge tag 'omap-for-v3.19/gpmc-timings' of git://git.kernel.org/.../tmlind/linux-omap into next/omap-gpmc
      Merge tag 'omap-for-v3.19/cleanup-part1' of git://git.kernel.org/.../tmlind/linux-omap into next/omap-gpmc
      Merge tag 'omap-for-v3.19/gpmc-move-v2' of git://git.kernel.org/.../tmlind/linux-omap into next/omap-gpmc

Javier Martinez Canillas (1):
      ARM: OMAP2+: Remove unnecesary include in GPMC driver

Roger Quadros (5):
      ARM: OMAP2+: gpmc: Print error message in set_gpmc_timing_reg()
      ARM: OMAP2+: gpmc: Error out if timings fail in gpmc_probe_generic_child()
      ARM: OMAP2+: gpmc: Always enable A26-A11 for non NAND devices
      ARM: OMAP2+: gpmc: Keep Chip Select disabled while configuring it
      ARM: OMAP2+: gpmc: Sanity check GPMC fck on probe

Tony Lindgren (10):
      ARM: OMAP2+: Fix support for multiple devices on a GPMC chip select
      ARM: OMAP2+: Show bootloader GPMC timings to allow configuring the .dts file
      ARM: OMAP2+: Require proper GPMC timings for devices
      ARM: OMAP2+: Drop legacy code for gpmc-smc91x.c
      Merge branch 'for-v3.19/gpmc-omap' of github.com:rogerq/linux into omap-for-v3.19/gpmc
      ARM: OMAP2+: Drop board file for ti8168evm
      ARM: OMAP2+: Drop board file for 3430sdp
      ARM: OMAP2+: Prepare to move GPMC to drivers by platform data header
      ARM: OMAP2+: Move GPMC initcall to devices.c
      memory: gpmc: Move omap gpmc code to live under drivers

 MAINTAINERS                                        |   8 +
 arch/arm/mach-omap2/Kconfig                        |  18 +-
 arch/arm/mach-omap2/Makefile                       |   8 +-
 arch/arm/mach-omap2/board-3430sdp.c                | 632 ---------------------
 arch/arm/mach-omap2/board-am3517crane.c            |   1 +
 arch/arm/mach-omap2/board-cm-t35.c                 |   3 +-
 arch/arm/mach-omap2/board-cm-t3517.c               |   3 +-
 arch/arm/mach-omap2/board-flash.c                  |   3 +-
 arch/arm/mach-omap2/board-flash.h                  |   1 -
 arch/arm/mach-omap2/board-n8x0.c                   |   2 -
 arch/arm/mach-omap2/board-omap3pandora.c           |   2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c       |  32 +-
 arch/arm/mach-omap2/board-ti8168evm.c              |  62 --
 arch/arm/mach-omap2/devices.c                      |  26 +
 arch/arm/mach-omap2/gpmc-nand.c                    |   3 +-
 arch/arm/mach-omap2/gpmc-nand.h                    |  27 -
 arch/arm/mach-omap2/gpmc-onenand.c                 |   3 +-
 arch/arm/mach-omap2/gpmc-onenand.h                 |  24 -
 arch/arm/mach-omap2/gpmc-smc91x.c                  | 186 ------
 arch/arm/mach-omap2/gpmc-smc91x.h                  |  42 --
 arch/arm/mach-omap2/gpmc.h                         | 227 +-------
 arch/arm/mach-omap2/pm34xx.c                       |   2 +-
 drivers/memory/Kconfig                             |   8 +
 drivers/memory/Makefile                            |   1 +
 .../gpmc.c => drivers/memory/omap-gpmc.c           | 385 ++++++++++---
 include/linux/omap-gpmc.h                          | 199 +++++++
 26 files changed, 553 insertions(+), 1355 deletions(-)
