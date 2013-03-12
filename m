From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Mar 2013 17:46:43 +0100
Subject: [PATCH v2 00/13] ARM: spear multiplatform support
Message-ID: <1363106816-9603-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the second time I post the SPEAr multiplatform patches.
It did not work out for 3.9, mostly because of conflicts against
patches in the DMA tree, but also because I did not push very
hard for these. The patches are basically unchanged now, just
some context differences since I rebased them on top of 3.9-rc2.

I'm adding them to the arm-soc tree for 3.10 now. If there are
any bugs, let's fix them on top of this branch. It would be
good to get some more testing on the branch though.

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
  ARM: spear: fix build error in restart.c
  ARM: spear: enable spear13xx in multi_v7_defconfig

 arch/arm/Kconfig                                   |  12 +-
 arch/arm/Makefile                                  |   5 +-
 arch/arm/configs/multi_v7_defconfig                |   9 +
 arch/arm/configs/spear3xx_defconfig                |   2 +
 arch/arm/configs/spear6xx_defconfig                |   1 +
 arch/arm/mach-spear/Kconfig                        | 103 +++++
 arch/arm/mach-spear/Makefile                       |  24 ++
 arch/arm/mach-spear/Makefile.boot                  |   3 +
 arch/arm/mach-spear/generic.h                      |  59 +++
 arch/arm/mach-spear/headsmp.S                      |  47 +++
 arch/arm/mach-spear/hotplug.c                      | 103 +++++
 arch/arm/mach-spear/include/mach/debug-macro.S     |  36 ++
 arch/arm/mach-spear/include/mach/irqs.h            |  35 ++
 arch/arm/mach-spear/include/mach/misc_regs.h       |  22 ++
 arch/arm/mach-spear/include/mach/spear.h           |  95 +++++
 arch/arm/mach-spear/include/mach/timex.h           |  19 +
 arch/arm/mach-spear/include/mach/uncompress.h      |  42 ++
 arch/arm/mach-spear/pl080.c                        |  78 ++++
 arch/arm/mach-spear/pl080.h                        |  21 +
 arch/arm/mach-spear/platsmp.c                      | 130 +++++++
 arch/arm/mach-spear/restart.c                      |  34 ++
 arch/arm/mach-spear/spear1310.c                    |  96 +++++
 arch/arm/mach-spear/spear1340.c                    | 193 +++++++++
 arch/arm/mach-spear/spear13xx-dma.h                | 128 ++++++
 arch/arm/mach-spear/spear13xx.c                    | 184 +++++++++
 arch/arm/mach-spear/spear300.c                     | 220 +++++++++++
 arch/arm/mach-spear/spear310.c                     | 262 +++++++++++++
 arch/arm/mach-spear/spear320.c                     | 277 +++++++++++++
 arch/arm/mach-spear/spear3xx.c                     | 116 ++++++
 arch/arm/mach-spear/spear6xx.c                     | 431 +++++++++++++++++++++
 arch/arm/mach-spear/time.c                         | 245 ++++++++++++
 arch/arm/mach-spear13xx/Kconfig                    |  20 -
 arch/arm/mach-spear13xx/Makefile                   |  10 -
 arch/arm/mach-spear13xx/Makefile.boot              |   3 -
 arch/arm/mach-spear13xx/headsmp.S                  |  47 ---
 arch/arm/mach-spear13xx/hotplug.c                  | 103 -----
 arch/arm/mach-spear13xx/include/mach/debug-macro.S |  14 -
 arch/arm/mach-spear13xx/include/mach/dma.h         | 128 ------
 arch/arm/mach-spear13xx/include/mach/generic.h     |  51 ---
 arch/arm/mach-spear13xx/include/mach/hardware.h    |   1 -
 arch/arm/mach-spear13xx/include/mach/irqs.h        |  20 -
 arch/arm/mach-spear13xx/include/mach/spear.h       |  54 ---
 arch/arm/mach-spear13xx/include/mach/timex.h       |  19 -
 arch/arm/mach-spear13xx/include/mach/uncompress.h  |  19 -
 arch/arm/mach-spear13xx/platsmp.c                  | 130 -------
 arch/arm/mach-spear13xx/spear1310.c                |  98 -----
 arch/arm/mach-spear13xx/spear1340.c                | 192 ---------
 arch/arm/mach-spear13xx/spear13xx.c                | 183 ---------
 arch/arm/mach-spear3xx/Kconfig                     |  26 --
 arch/arm/mach-spear3xx/Makefile                    |  15 -
 arch/arm/mach-spear3xx/Makefile.boot               |   3 -
 arch/arm/mach-spear3xx/include/mach/debug-macro.S  |  14 -
 arch/arm/mach-spear3xx/include/mach/generic.h      |  36 --
 arch/arm/mach-spear3xx/include/mach/hardware.h     |   1 -
 arch/arm/mach-spear3xx/include/mach/irqs.h         |  19 -
 arch/arm/mach-spear3xx/include/mach/misc_regs.h    |  22 --
 arch/arm/mach-spear3xx/include/mach/spear.h        |  60 ---
 arch/arm/mach-spear3xx/include/mach/timex.h        |  19 -
 arch/arm/mach-spear3xx/include/mach/uncompress.h   |  19 -
 arch/arm/mach-spear3xx/spear300.c                  | 220 -----------
 arch/arm/mach-spear3xx/spear310.c                  | 262 -------------
 arch/arm/mach-spear3xx/spear320.c                  | 276 -------------
 arch/arm/mach-spear3xx/spear3xx.c                  | 113 ------
 arch/arm/mach-spear6xx/Kconfig                     |  10 -
 arch/arm/mach-spear6xx/Makefile                    |   6 -
 arch/arm/mach-spear6xx/Makefile.boot               |   3 -
 arch/arm/mach-spear6xx/include/mach/debug-macro.S  |  14 -
 arch/arm/mach-spear6xx/include/mach/generic.h      |  23 --
 arch/arm/mach-spear6xx/include/mach/hardware.h     |   1 -
 arch/arm/mach-spear6xx/include/mach/irqs.h         |  25 --
 arch/arm/mach-spear6xx/include/mach/misc_regs.h    |  22 --
 arch/arm/mach-spear6xx/include/mach/spear.h        |  46 ---
 arch/arm/mach-spear6xx/include/mach/timex.h        |  19 -
 arch/arm/mach-spear6xx/include/mach/uncompress.h   |  19 -
 arch/arm/mach-spear6xx/spear6xx.c                  | 430 --------------------
 arch/arm/plat-spear/Kconfig                        |  47 ---
 arch/arm/plat-spear/Makefile                       |   9 -
 arch/arm/plat-spear/include/plat/debug-macro.S     |  36 --
 arch/arm/plat-spear/include/plat/pl080.h           |  21 -
 arch/arm/plat-spear/include/plat/timex.h           |  19 -
 arch/arm/plat-spear/include/plat/uncompress.h      |  42 --
 arch/arm/plat-spear/pl080.c                        |  78 ----
 arch/arm/plat-spear/restart.c                      |  33 --
 arch/arm/plat-spear/time.c                         | 245 ------------
 drivers/clk/spear/spear1310_clock.c                |  64 ++-
 drivers/clk/spear/spear1340_clock.c                |  63 ++-
 drivers/clk/spear/spear3xx_clock.c                 |  60 +--
 drivers/clk/spear/spear6xx_clock.c                 |  31 +-
 88 files changed, 3130 insertions(+), 3465 deletions(-)
 create mode 100644 arch/arm/mach-spear/Kconfig
 create mode 100644 arch/arm/mach-spear/Makefile
 create mode 100644 arch/arm/mach-spear/Makefile.boot
 create mode 100644 arch/arm/mach-spear/generic.h
 create mode 100644 arch/arm/mach-spear/headsmp.S
 create mode 100644 arch/arm/mach-spear/hotplug.c
 create mode 100644 arch/arm/mach-spear/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-spear/include/mach/irqs.h
 create mode 100644 arch/arm/mach-spear/include/mach/misc_regs.h
 create mode 100644 arch/arm/mach-spear/include/mach/spear.h
 create mode 100644 arch/arm/mach-spear/include/mach/timex.h
 create mode 100644 arch/arm/mach-spear/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-spear/pl080.c
 create mode 100644 arch/arm/mach-spear/pl080.h
 create mode 100644 arch/arm/mach-spear/platsmp.c
 create mode 100644 arch/arm/mach-spear/restart.c
 create mode 100644 arch/arm/mach-spear/spear1310.c
 create mode 100644 arch/arm/mach-spear/spear1340.c
 create mode 100644 arch/arm/mach-spear/spear13xx-dma.h
 create mode 100644 arch/arm/mach-spear/spear13xx.c
 create mode 100644 arch/arm/mach-spear/spear300.c
 create mode 100644 arch/arm/mach-spear/spear310.c
 create mode 100644 arch/arm/mach-spear/spear320.c
 create mode 100644 arch/arm/mach-spear/spear3xx.c
 create mode 100644 arch/arm/mach-spear/spear6xx.c
 create mode 100644 arch/arm/mach-spear/time.c
 delete mode 100644 arch/arm/mach-spear13xx/Kconfig
 delete mode 100644 arch/arm/mach-spear13xx/Makefile
 delete mode 100644 arch/arm/mach-spear13xx/Makefile.boot
 delete mode 100644 arch/arm/mach-spear13xx/headsmp.S
 delete mode 100644 arch/arm/mach-spear13xx/hotplug.c
 delete mode 100644 arch/arm/mach-spear13xx/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-spear13xx/include/mach/dma.h
 delete mode 100644 arch/arm/mach-spear13xx/include/mach/generic.h
 delete mode 100644 arch/arm/mach-spear13xx/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-spear13xx/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-spear13xx/include/mach/spear.h
 delete mode 100644 arch/arm/mach-spear13xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-spear13xx/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-spear13xx/platsmp.c
 delete mode 100644 arch/arm/mach-spear13xx/spear1310.c
 delete mode 100644 arch/arm/mach-spear13xx/spear1340.c
 delete mode 100644 arch/arm/mach-spear13xx/spear13xx.c
 delete mode 100644 arch/arm/mach-spear3xx/Kconfig
 delete mode 100644 arch/arm/mach-spear3xx/Makefile
 delete mode 100644 arch/arm/mach-spear3xx/Makefile.boot
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/generic.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/misc_regs.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/spear.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-spear3xx/spear300.c
 delete mode 100644 arch/arm/mach-spear3xx/spear310.c
 delete mode 100644 arch/arm/mach-spear3xx/spear320.c
 delete mode 100644 arch/arm/mach-spear3xx/spear3xx.c
 delete mode 100644 arch/arm/mach-spear6xx/Kconfig
 delete mode 100644 arch/arm/mach-spear6xx/Makefile
 delete mode 100644 arch/arm/mach-spear6xx/Makefile.boot
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/generic.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/misc_regs.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/spear.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-spear6xx/spear6xx.c
 delete mode 100644 arch/arm/plat-spear/Kconfig
 delete mode 100644 arch/arm/plat-spear/Makefile
 delete mode 100644 arch/arm/plat-spear/include/plat/debug-macro.S
 delete mode 100644 arch/arm/plat-spear/include/plat/pl080.h
 delete mode 100644 arch/arm/plat-spear/include/plat/timex.h
 delete mode 100644 arch/arm/plat-spear/include/plat/uncompress.h
 delete mode 100644 arch/arm/plat-spear/pl080.c
 delete mode 100644 arch/arm/plat-spear/restart.c
 delete mode 100644 arch/arm/plat-spear/time.c

-- 
1.8.1.2
