From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 23:35:43 +0000
Subject: [PATCH 00/13] ARM: spear multiplatform support
Message-ID: <1359156956-32404-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a series I did some time ago but forgot to
send out earlier. I'd like to get this into v3.9,
so please give this a test if you can.

Arnd Bergmann (13):
  ARM: spear13xx: make mach/dma.h local
  ARM: spear: unify mach/generic.h and mach/irqs.h
  ARM: spear: move identical headers to plat-spear/include/mach
  ARM: spear: make spear3xx/6xx mach/spear.h files identical
  ARM: spear: merge Kconfig files
  ARM: spear: move spear.h and misc_regs.h into plat-spear
  ARM: spear: move all files to mach-spear
  ARM: spear: move generic.h and pl080.h into private dir
  ARM: spear: make clock driver independent of headers
  ARM: spear: rename duplicate pl080_plat_data
  ARM: spear: use multiplatform configuration options.
  ARM: spear: adapt defconfig files for multiplatform
  ARM: spear: fix build error in restart.c

 arch/arm/Kconfig                                   |  12 +--
 arch/arm/Makefile                                  |   5 +-
 arch/arm/configs/spear3xx_defconfig                |   2 +
 arch/arm/configs/spear6xx_defconfig                |   1 +
 arch/arm/mach-spear/Kconfig                        | 102 +++++++++++++++++++++
 arch/arm/mach-spear/Makefile                       |  24 +++++
 .../{mach-spear13xx => mach-spear}/Makefile.boot   |   0
 .../include/mach => mach-spear}/generic.h          |  30 +++---
 arch/arm/{mach-spear13xx => mach-spear}/headsmp.S  |   0
 arch/arm/{mach-spear13xx => mach-spear}/hotplug.c  |   0
 .../plat => mach-spear/include/mach}/debug-macro.S |   0
 .../include/mach/irqs.h                            |  22 +++--
 .../include/mach/misc_regs.h                       |   2 +-
 arch/arm/mach-spear/include/mach/spear.h           |  95 +++++++++++++++++++
 .../plat => mach-spear/include/mach}/timex.h       |   0
 .../plat => mach-spear/include/mach}/uncompress.h  |   0
 arch/arm/{plat-spear => mach-spear}/pl080.c        |   0
 .../include/plat => mach-spear}/pl080.h            |   0
 arch/arm/{mach-spear13xx => mach-spear}/platsmp.c  |   2 +-
 arch/arm/{plat-spear => mach-spear}/restart.c      |   5 +-
 .../arm/{mach-spear13xx => mach-spear}/spear1310.c |   4 +-
 .../arm/{mach-spear13xx => mach-spear}/spear1340.c |   5 +-
 .../mach/dma.h => mach-spear/spear13xx-dma.h}      |   0
 .../arm/{mach-spear13xx => mach-spear}/spear13xx.c |   9 +-
 arch/arm/{mach-spear3xx => mach-spear}/spear300.c  |   4 +-
 arch/arm/{mach-spear3xx => mach-spear}/spear310.c  |   4 +-
 arch/arm/{mach-spear3xx => mach-spear}/spear320.c  |   7 +-
 arch/arm/{mach-spear3xx => mach-spear}/spear3xx.c  |  17 ++--
 arch/arm/{mach-spear6xx => mach-spear}/spear6xx.c  |  25 ++---
 arch/arm/{plat-spear => mach-spear}/time.c         |   2 +-
 arch/arm/mach-spear13xx/Kconfig                    |  20 ----
 arch/arm/mach-spear13xx/Makefile                   |  10 --
 arch/arm/mach-spear13xx/include/mach/debug-macro.S |  14 ---
 arch/arm/mach-spear13xx/include/mach/hardware.h    |   1 -
 arch/arm/mach-spear13xx/include/mach/irqs.h        |  20 ----
 arch/arm/mach-spear13xx/include/mach/spear.h       |  54 -----------
 arch/arm/mach-spear13xx/include/mach/timex.h       |  19 ----
 arch/arm/mach-spear13xx/include/mach/uncompress.h  |  19 ----
 arch/arm/mach-spear3xx/Kconfig                     |  26 ------
 arch/arm/mach-spear3xx/Makefile                    |  15 ---
 arch/arm/mach-spear3xx/Makefile.boot               |   3 -
 arch/arm/mach-spear3xx/include/mach/debug-macro.S  |  14 ---
 arch/arm/mach-spear3xx/include/mach/generic.h      |  37 --------
 arch/arm/mach-spear3xx/include/mach/hardware.h     |   1 -
 arch/arm/mach-spear3xx/include/mach/irqs.h         |  19 ----
 arch/arm/mach-spear3xx/include/mach/spear.h        |  60 ------------
 arch/arm/mach-spear3xx/include/mach/timex.h        |  19 ----
 arch/arm/mach-spear3xx/include/mach/uncompress.h   |  19 ----
 arch/arm/mach-spear6xx/Kconfig                     |  10 --
 arch/arm/mach-spear6xx/Makefile                    |   6 --
 arch/arm/mach-spear6xx/Makefile.boot               |   3 -
 arch/arm/mach-spear6xx/include/mach/debug-macro.S  |  14 ---
 arch/arm/mach-spear6xx/include/mach/generic.h      |  23 -----
 arch/arm/mach-spear6xx/include/mach/hardware.h     |   1 -
 arch/arm/mach-spear6xx/include/mach/misc_regs.h    |  22 -----
 arch/arm/mach-spear6xx/include/mach/spear.h        |  46 ----------
 arch/arm/mach-spear6xx/include/mach/timex.h        |  19 ----
 arch/arm/mach-spear6xx/include/mach/uncompress.h   |  19 ----
 arch/arm/plat-spear/Kconfig                        |  46 ----------
 arch/arm/plat-spear/Makefile                       |   9 --
 drivers/clk/spear/spear1310_clock.c                |  64 +++++++------
 drivers/clk/spear/spear1340_clock.c                |  63 +++++++------
 drivers/clk/spear/spear3xx_clock.c                 |  60 +++++++-----
 drivers/clk/spear/spear6xx_clock.c                 |  31 +++----
 64 files changed, 420 insertions(+), 765 deletions(-)
 create mode 100644 arch/arm/mach-spear/Kconfig
 create mode 100644 arch/arm/mach-spear/Makefile
 rename arch/arm/{mach-spear13xx => mach-spear}/Makefile.boot (100%)
 rename arch/arm/{mach-spear13xx/include/mach => mach-spear}/generic.h (58%)
 rename arch/arm/{mach-spear13xx => mach-spear}/headsmp.S (100%)
 rename arch/arm/{mach-spear13xx => mach-spear}/hotplug.c (100%)
 rename arch/arm/{plat-spear/include/plat => mach-spear/include/mach}/debug-macro.S (100%)
 rename arch/arm/{mach-spear6xx => mach-spear}/include/mach/irqs.h (51%)
 rename arch/arm/{mach-spear3xx => mach-spear}/include/mach/misc_regs.h (90%)
 create mode 100644 arch/arm/mach-spear/include/mach/spear.h
 rename arch/arm/{plat-spear/include/plat => mach-spear/include/mach}/timex.h (100%)
 rename arch/arm/{plat-spear/include/plat => mach-spear/include/mach}/uncompress.h (100%)
 rename arch/arm/{plat-spear => mach-spear}/pl080.c (100%)
 rename arch/arm/{plat-spear/include/plat => mach-spear}/pl080.h (100%)
 rename arch/arm/{mach-spear13xx => mach-spear}/platsmp.c (99%)
 rename arch/arm/{plat-spear => mach-spear}/restart.c (90%)
 rename arch/arm/{mach-spear13xx => mach-spear}/spear1310.c (95%)
 rename arch/arm/{mach-spear13xx => mach-spear}/spear1340.c (99%)
 rename arch/arm/{mach-spear13xx/include/mach/dma.h => mach-spear/spear13xx-dma.h} (100%)
 rename arch/arm/{mach-spear13xx => mach-spear}/spear13xx.c (97%)
 rename arch/arm/{mach-spear3xx => mach-spear}/spear300.c (98%)
 rename arch/arm/{mach-spear3xx => mach-spear}/spear310.c (98%)
 rename arch/arm/{mach-spear3xx => mach-spear}/spear320.c (97%)
 rename arch/arm/{mach-spear3xx => mach-spear}/spear3xx.c (90%)
 rename arch/arm/{mach-spear6xx => mach-spear}/spear6xx.c (94%)
 rename arch/arm/{plat-spear => mach-spear}/time.c (99%)
 delete mode 100644 arch/arm/mach-spear13xx/Kconfig
 delete mode 100644 arch/arm/mach-spear13xx/Makefile
 delete mode 100644 arch/arm/mach-spear13xx/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-spear13xx/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-spear13xx/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-spear13xx/include/mach/spear.h
 delete mode 100644 arch/arm/mach-spear13xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-spear13xx/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-spear3xx/Kconfig
 delete mode 100644 arch/arm/mach-spear3xx/Makefile
 delete mode 100644 arch/arm/mach-spear3xx/Makefile.boot
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/generic.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/spear.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-spear6xx/Kconfig
 delete mode 100644 arch/arm/mach-spear6xx/Makefile
 delete mode 100644 arch/arm/mach-spear6xx/Makefile.boot
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/generic.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/misc_regs.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/spear.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/uncompress.h
 delete mode 100644 arch/arm/plat-spear/Kconfig
 delete mode 100644 arch/arm/plat-spear/Makefile

-- 
1.8.0
