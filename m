From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Thu, 28 Jun 2018 11:57:35 +0200
Subject: [PATCH v3 00/13] ARM: davinci: remove duplicate aemif support
Message-ID: <20180628095748.4462-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series moves all aemif/nand users to using the ti-aemif platform
driver located in drivers/memory instead of the older API located in
mach-davinci.

First five patches add necessary changes to the clock driver. Next
seven convert the board files to using the ti-aemif driver. Last patch
removes now dead code.

v1 -> v2:
- added missing clock lookups for ti-aemif where needed
- removed an unnecessary davinci_nand clock lookup from psc-da850
- moved the .id field initialization of aemif platform devices next to .name
- tweaked the commit message for the last patch

v2 -> v3:
- in patch 6: change the davinci_nand device's id to -1 and keep the
  includes sorted

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

 arch/arm/mach-davinci/Makefile                |   2 +-
 arch/arm/mach-davinci/aemif.c                 | 218 ------------------
 arch/arm/mach-davinci/board-da830-evm.c       |  56 ++++-
 arch/arm/mach-davinci/board-da850-evm.c       |  93 ++++----
 arch/arm/mach-davinci/board-dm365-evm.c       |  59 +++--
 arch/arm/mach-davinci/board-dm644x-evm.c      |  55 +++--
 arch/arm/mach-davinci/board-dm646x-evm.c      |  52 ++++-
 arch/arm/mach-davinci/board-mityomapl138.c    |  55 +++--
 arch/arm/mach-davinci/board-omapl138-hawk.c   | 132 +++++++++++
 drivers/clk/davinci/psc-da830.c               |   3 +-
 drivers/clk/davinci/psc-da850.c               |   3 +-
 drivers/clk/davinci/psc-dm365.c               |   3 +-
 drivers/clk/davinci/psc-dm644x.c              |   3 +-
 drivers/clk/davinci/psc-dm646x.c              |   3 +-
 .../linux/platform_data/mtd-davinci-aemif.h   |   1 -
 15 files changed, 407 insertions(+), 331 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/aemif.c

-- 
2.17.1
