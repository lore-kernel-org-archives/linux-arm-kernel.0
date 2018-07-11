From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 11 Jul 2018 11:59:04 +0530
Subject: [GIT PULL 1/3] DaVinci SoC updates for v4.19
Message-ID: <20180711062906.22865-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.19/soc

for you to fetch changes up to 7f69ae7fadd9dbebe563bfc28b993a2bc9c8acf9:

  ARM: davinci: unduplicate aemif support (2018-07-10 15:39:27 +0530)

----------------------------------------------------------------
DaVinci SoC updates for v4.19
-----------------------------

* mach-davinci updates needed to finally move over to common clock framework
* update to use the aemif driver from drivers/memory rather than the
  private implementation available in mach-davinci

For the later item, I have included a branch from David Lechner which
should also get merged through the clk tree. The clk dependencies are
needed for aemif conversion.

----------------------------------------------------------------
Bartosz Golaszewski (13):
      clk: davinci: psc-da850: remove the 'davinci_nand.0" lookup
      clk: davinci: psc-dm365: use two lookup entries for the aemif clock
      clk: davinci: psc-dm644x: use two lookup entries for the aemif clock
      clk: davinci: psc-dm646x: use two lookup entries for the aemif clock
      clk: davinci: psc-da830: add a lookup entry for aemif clock
      ARM: davinci: omapl138-hawk: add aemif & nand support
      ARM: davinci: da850-evm: use aemif platform driver in legacy mode
      ARM: davinci: dm365-evm: use the ti-aemif soc driver
      ARM: davinci: dm644x-evm: use aemif platform driver
      ARM: davinci: da830-evm: use aemif platform driver
      ARM: davinci: dm646x-evm: use aemif platform driver
      ARM: davinci: mityomapl138: use aemif platform driver
      ARM: davinci: unduplicate aemif support

David Lechner (21):
      ARM: davinci: pass clock as parameter to davinci_timer_init()
      ARM: davinci: da830: add new clock init using common clock framework
      ARM: davinci: da850: add new clock init using common clock framework
      ARM: davinci: dm355: add new clock init using common clock framework
      ARM: davinci: dm365: add new clock init using common clock framework
      ARM: davinci: dm644x: add new clock init using common clock framework
      ARM: davinci: dm646x: add new clock init using common clock framework
      ARM: davinci: da8xx: add new USB PHY clock init using common clock framework
      ARM: davinci: da8xx: add new sata_refclk init using common clock framework
      ARM: davinci: remove CONFIG_DAVINCI_RESET_CLOCKS
      ARM: davinci: switch to common clock framework
      ARM: davinci: da830: Remove legacy clock init
      ARM: davinci: da850: Remove legacy clock init
      ARM: davinci: dm355: Remove legacy clock init
      ARM: davinci: dm365: Remove legacy clock init
      ARM: davinci: dm644x: Remove legacy clock init
      ARM: davinci: dm646x: Remove legacy clock init
      ARM: davinci: da8xx: Remove legacy USB and SATA clock init
      ARM: davinci: remove legacy clocks
      ARM: davinci: add device tree support to timer
      ARM: davinci: da8xx-dt: switch to device tree clocks

Sekhar Nori (1):
      Merge branch 'for-sekhar' of https://github.com/dlech/linux into v4.19/soc

 arch/arm/Kconfig                                |   5 +-
 arch/arm/mach-davinci/Kconfig                   |  13 +-
 arch/arm/mach-davinci/Makefile                  |   4 +-
 arch/arm/mach-davinci/aemif.c                   | 218 -------
 arch/arm/mach-davinci/board-da830-evm.c         |  68 ++-
 arch/arm/mach-davinci/board-da850-evm.c         |  95 +--
 arch/arm/mach-davinci/board-dm355-evm.c         |   2 +
 arch/arm/mach-davinci/board-dm355-leopard.c     |   2 +
 arch/arm/mach-davinci/board-dm365-evm.c         |  61 +-
 arch/arm/mach-davinci/board-dm644x-evm.c        |  57 +-
 arch/arm/mach-davinci/board-dm646x-evm.c        |  54 +-
 arch/arm/mach-davinci/board-mityomapl138.c      |  57 +-
 arch/arm/mach-davinci/board-neuros-osd2.c       |   2 +
 arch/arm/mach-davinci/board-omapl138-hawk.c     | 143 ++++-
 arch/arm/mach-davinci/board-sffsdr.c            |   2 +
 arch/arm/mach-davinci/clock.c                   | 745 -----------------------
 arch/arm/mach-davinci/clock.h                   |  76 ---
 arch/arm/mach-davinci/common.c                  |   3 -
 arch/arm/mach-davinci/da830.c                   | 462 ++------------
 arch/arm/mach-davinci/da850.c                   | 778 ++++--------------------
 arch/arm/mach-davinci/da8xx-dt.c                |  66 --
 arch/arm/mach-davinci/davinci.h                 |   8 +
 arch/arm/mach-davinci/devices-da8xx.c           |  43 +-
 arch/arm/mach-davinci/devices.c                 |   1 -
 arch/arm/mach-davinci/dm355.c                   | 406 ++-----------
 arch/arm/mach-davinci/dm365.c                   | 485 ++-------------
 arch/arm/mach-davinci/dm644x.c                  | 344 ++---------
 arch/arm/mach-davinci/dm646x.c                  | 372 ++---------
 arch/arm/mach-davinci/include/mach/clock.h      |   3 -
 arch/arm/mach-davinci/include/mach/common.h     |  11 +-
 arch/arm/mach-davinci/include/mach/da8xx.h      |   6 +-
 arch/arm/mach-davinci/pm_domain.c               |   5 +
 arch/arm/mach-davinci/psc.c                     | 137 -----
 arch/arm/mach-davinci/psc.h                     |  12 -
 arch/arm/mach-davinci/time.c                    |  22 +-
 arch/arm/mach-davinci/usb-da8xx.c               | 242 +-------
 drivers/clk/davinci/psc-da830.c                 |   3 +-
 drivers/clk/davinci/psc-da850.c                 |   3 +-
 drivers/clk/davinci/psc-dm365.c                 |   3 +-
 drivers/clk/davinci/psc-dm644x.c                |   3 +-
 drivers/clk/davinci/psc-dm646x.c                |   3 +-
 include/linux/platform_data/mtd-davinci-aemif.h |   1 -
 42 files changed, 855 insertions(+), 4171 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/aemif.c
 delete mode 100644 arch/arm/mach-davinci/clock.c
 delete mode 100644 arch/arm/mach-davinci/psc.c
