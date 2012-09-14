From: robherring2@gmail.com (Rob Herring)
Date: Fri, 14 Sep 2012 17:31:56 -0500
Subject: [GIT PULL] ARM initial multi-platform support
Message-ID: <5053B05C.7070801@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Please pull initial multi-platform support. This includes the gpio.h
clean-up that's needed as well. Hopefully it's early enough we will see
a few other platforms converted over for 3.7.

There's a few minor changes from the last version I posted:
- Incorporated Jamie Iles fixes for picoxcell.
- Removed the now unused vexpress uncompress.h and timex.h
- Fixed the multiple adding of mach directories for spear and exynos.
- Fixed orion gpio.h includes breaking dove, kirkwood, and orion5x.

Rob

The following changes since commit 4cbe5a555fa58a79b6ecbb6c531b8bab0650778d:

  Linux 3.6-rc4 (2012-09-01 10:39:58 -0700)

are available in the git repository at:

  git://sources.calxeda.com/kernel/linux.git tags/multi-platform-for-3.7

for you to fetch changes up to 617276307cd4cdb9a95c77efaa3063695af63aa7:

  ARM: vexpress: convert to multi-platform (2012-09-14 12:55:09 -0500)

----------------------------------------------------------------
Enable initial ARM multi-platform support for highbank, mvebu,
socfpga, picoxcell, and vexpress.

Multi-platform support is dependent on mach/gpio.h removal and
restructuring of DEBUG_LL and dtb build rules included in this branch.

This has been built for all defconfigs, and booted on highbank with
all 5 platforms enabled.

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: vexpress: remove dependency on mach/* headers

Rob Herring (18):
      staging: ste_rmi4: remove gpio.h include
      usb: pxa27x_udc: remove IRQ_USB define
      net: pxaficp_ir: add irq resources
      ARM: pxa: use gpio_to_irq for sharppm_sl
      ARM: shmobile: move custom gpio functions to sh-gpio.h
      ARM: orion: move custom gpio functions to orion-gpio.h
      ARM: make mach/gpio.h headers optional
      ARM: move debug macros to common location
      ARM: highbank: move debug macros to include/debug
      ARM: vexpress: move debug macros to include/debug
      ARM: mvebu: move debug macros to include/debug
      ARM: socfpga: move debug macros to include/debug
      ARM: picoxcell: move debug macros to include/debug
      ARM: move all dtb targets out of Makefile.boot
      ARM: picoxcell: remove dependency on mach/* headers
      ARM: mvebu: move armada-370-xp.h in mach dir
      ARM: initial multiplatform support
      ARM: vexpress: convert to multi-platform

 arch/arm/Kconfig                                   |  163
++++++++++----------
 arch/arm/Kconfig.debug                             |   33 ++++
 arch/arm/Makefile                                  |  150
+++++++++---------
 arch/arm/boot/Makefile                             |    2 +
 arch/arm/boot/compressed/misc.c                    |    6 +
 arch/arm/boot/dts/Makefile                         |   71 +++++++++
 arch/arm/include/asm/gpio.h                        |    2 +
 arch/arm/include/asm/timex.h                       |    4 +
 .../debug-macro.S => include/debug/highbank.S}     |    6 +-
 arch/arm/include/debug/icedcc.S                    |   90 +++++++++++
 .../mach/debug-macro.S => include/debug/mvebu.S}   |    3 +-
 .../debug-macro.S => include/debug/picoxcell.S}    |    4 +-
 .../mach/debug-macro.S => include/debug/socfpga.S} |    0
 .../debug-macro.S => include/debug/vexpress.S}     |    0
 arch/arm/kernel/debug.S                            |   87 +----------
 arch/arm/kernel/head.S                             |    4 +-
 arch/arm/mach-at91/Makefile.boot                   |   24 ---
 arch/arm/mach-dove/include/mach/gpio.h             |    9 --
 arch/arm/mach-dove/irq.c                           |    1 +
 arch/arm/mach-dove/mpp.c                           |    1 +
 arch/arm/mach-ep93xx/include/mach/gpio.h           |    1 -
 arch/arm/mach-exynos/Makefile.boot                 |    3 -
 arch/arm/mach-highbank/Kconfig                     |   15 ++
 arch/arm/mach-highbank/Makefile.boot               |    1 -
 arch/arm/mach-highbank/include/mach/gpio.h         |    1 -
 arch/arm/mach-highbank/include/mach/timex.h        |    6 -
 arch/arm/mach-highbank/include/mach/uncompress.h   |    9 --
 arch/arm/mach-imx/Makefile.boot                    |    7 -
 arch/arm/mach-ixp4xx/include/mach/gpio.h           |    2 -
 arch/arm/mach-kirkwood/Makefile.boot               |   11 --
 arch/arm/mach-kirkwood/include/mach/gpio.h         |    9 --
 arch/arm/mach-kirkwood/irq.c                       |    1 +
 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c       |    1 +
 arch/arm/mach-lpc32xx/Makefile.boot                |    2 -
 arch/arm/mach-msm/include/mach/gpio.h              |    1 -
 arch/arm/mach-mv78xx0/irq.c                        |    1 +
 arch/arm/mach-mvebu/Kconfig                        |   10 ++
 arch/arm/mach-mvebu/Makefile                       |    2 +
 arch/arm/mach-mvebu/Makefile.boot                  |    3 -
 arch/arm/mach-mvebu/armada-370-xp.c                |    2 +-
 .../mach-mvebu/{include/mach => }/armada-370-xp.h  |    0
 arch/arm/mach-mvebu/include/mach/timex.h           |   13 --
 arch/arm/mach-mvebu/include/mach/uncompress.h      |   43 ------
 arch/arm/mach-mxs/Makefile.boot                    |    9 --
 arch/arm/mach-mxs/include/mach/gpio.h              |    1 -
 arch/arm/mach-nomadik/include/mach/gpio.h          |    4 -
 arch/arm/mach-orion5x/d2net-setup.c                |    1 +
 arch/arm/mach-orion5x/dns323-setup.c               |    1 +
 arch/arm/mach-orion5x/include/mach/gpio.h          |    9 --
 arch/arm/mach-orion5x/irq.c                        |    1 +
 arch/arm/mach-orion5x/net2big-setup.c              |    1 +
 arch/arm/mach-picoxcell/Kconfig                    |   14 ++
 arch/arm/mach-picoxcell/Makefile.boot              |    1 -
 arch/arm/mach-picoxcell/common.c                   |   13 +-
 arch/arm/mach-picoxcell/include/mach/gpio.h        |    1 -
 arch/arm/mach-picoxcell/include/mach/hardware.h    |   21 ---
 arch/arm/mach-picoxcell/include/mach/map.h         |   25 ---
 .../mach-picoxcell/include/mach/picoxcell_soc.h    |   25 ---
 arch/arm/mach-picoxcell/include/mach/timex.h       |   25 ---
 arch/arm/mach-picoxcell/include/mach/uncompress.h  |   21 ---
 arch/arm/mach-pxa/devices.c                        |   15 ++
 arch/arm/mach-pxa/sharpsl_pm.c                     |   30 ++--
 arch/arm/mach-realview/include/mach/gpio.h         |    1 -
 arch/arm/mach-shmobile/board-ap4evb.c              |    2 +
 arch/arm/mach-shmobile/board-armadillo800eva.c     |    2 +
 arch/arm/mach-shmobile/board-g4evm.c               |    2 +
 arch/arm/mach-shmobile/board-mackerel.c            |    2 +
 arch/arm/mach-shmobile/pfc-r8a7740.c               |    2 +-
 arch/arm/mach-shmobile/pfc-r8a7779.c               |    2 +-
 arch/arm/mach-shmobile/pfc-sh7367.c                |    2 +-
 arch/arm/mach-shmobile/pfc-sh7372.c                |    2 +-
 arch/arm/mach-shmobile/pfc-sh7377.c                |    2 +-
 arch/arm/mach-shmobile/pfc-sh73a0.c                |    2 +-
 .../{include/mach/gpio.h => sh-gpio.h}             |   14 --
 arch/arm/mach-socfpga/Kconfig                      |   16 ++
 arch/arm/mach-socfpga/Makefile.boot                |    1 -
 arch/arm/mach-socfpga/include/mach/timex.h         |   19 ---
 arch/arm/mach-socfpga/include/mach/uncompress.h    |    9 --
 arch/arm/mach-spear13xx/Makefile.boot              |    3 -
 arch/arm/mach-spear13xx/include/mach/gpio.h        |   19 ---
 arch/arm/mach-spear3xx/Makefile.boot               |    4 -
 arch/arm/mach-spear3xx/include/mach/gpio.h         |   19 ---
 arch/arm/mach-spear6xx/Makefile.boot               |    2 -
 arch/arm/mach-spear6xx/include/mach/gpio.h         |   19 ---
 arch/arm/mach-tegra/Makefile.boot                  |    8 -
 arch/arm/mach-tegra/include/mach/gpio.h            |    1 -
 arch/arm/mach-u300/include/mach/gpio.h             |    1 -
 arch/arm/mach-ux500/Makefile.boot                  |    2 -
 arch/arm/mach-ux500/include/mach/gpio.h            |    5 -
 arch/arm/mach-versatile/include/mach/gpio.h        |    1 -
 arch/arm/mach-vexpress/Kconfig                     |   64 ++++----
 arch/arm/mach-vexpress/Makefile                    |    2 +
 arch/arm/mach-vexpress/Makefile.boot               |   10 --
 arch/arm/mach-vexpress/ct-ca9x4.c                  |    1 +
 arch/arm/mach-vexpress/include/mach/gpio.h         |    1 -
 arch/arm/mach-vexpress/include/mach/irqs.h         |    2 +
 arch/arm/mach-vexpress/include/mach/timex.h        |   23 ---
 arch/arm/mach-vexpress/include/mach/uncompress.h   |   86 -----------
 arch/arm/mach-vexpress/v2m.c                       |    4 -
 arch/arm/mach-vt8500/include/mach/gpio.h           |    1 -
 arch/arm/plat-mxc/include/mach/gpio.h              |    1 -
 arch/arm/plat-orion/gpio.c                         |    2 +-
 .../include/plat/{gpio.h => orion-gpio.h}          |    2 +-
 arch/arm/plat-orion/irq.c                          |    2 +-
 arch/arm/plat-orion/mpp.c                          |    1 +
 arch/arm/plat-spear/include/plat/gpio.h            |    1 -
 arch/arm/plat-versatile/Makefile                   |    2 +
 drivers/net/irda/pxaficp_ir.c                      |   28 ++--
 drivers/sh/pfc/gpio.c                              |    1 +
 .../staging/ste_rmi4/board-mop500-u8500uib-rmi4.c  |    1 -
 drivers/usb/gadget/pxa27x_udc.c                    |    2 +-
 111 files changed, 555 insertions(+), 868 deletions(-)
 create mode 100644 arch/arm/boot/dts/Makefile
 rename arch/arm/{mach-highbank/include/mach/debug-macro.S =>
include/debug/highbank.S} (83%)
 create mode 100644 arch/arm/include/debug/icedcc.S
 rename arch/arm/{mach-mvebu/include/mach/debug-macro.S =>
include/debug/mvebu.S} (86%)
 rename arch/arm/{mach-picoxcell/include/mach/debug-macro.S =>
include/debug/picoxcell.S} (89%)
 rename arch/arm/{mach-socfpga/include/mach/debug-macro.S =>
include/debug/socfpga.S} (100%)
 rename arch/arm/{mach-vexpress/include/mach/debug-macro.S =>
include/debug/vexpress.S} (100%)
 delete mode 100644 arch/arm/mach-dove/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-ep93xx/include/mach/gpio.h
 create mode 100644 arch/arm/mach-highbank/Kconfig
 delete mode 100644 arch/arm/mach-highbank/Makefile.boot
 delete mode 100644 arch/arm/mach-highbank/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-highbank/include/mach/timex.h
 delete mode 100644 arch/arm/mach-highbank/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-msm/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-mvebu/Makefile.boot
 rename arch/arm/mach-mvebu/{include/mach => }/armada-370-xp.h (100%)
 delete mode 100644 arch/arm/mach-mvebu/include/mach/timex.h
 delete mode 100644 arch/arm/mach-mvebu/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-nomadik/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-orion5x/include/mach/gpio.h
 create mode 100644 arch/arm/mach-picoxcell/Kconfig
 delete mode 100644 arch/arm/mach-picoxcell/Makefile.boot
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/map.h
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/picoxcell_soc.h
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/timex.h
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-realview/include/mach/gpio.h
 rename arch/arm/mach-shmobile/{include/mach/gpio.h => sh-gpio.h} (84%)
 create mode 100644 arch/arm/mach-socfpga/Kconfig
 delete mode 100644 arch/arm/mach-socfpga/Makefile.boot
 delete mode 100644 arch/arm/mach-socfpga/include/mach/timex.h
 delete mode 100644 arch/arm/mach-socfpga/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-spear13xx/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-tegra/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-u300/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-vexpress/Makefile.boot
 delete mode 100644 arch/arm/mach-vexpress/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-vexpress/include/mach/timex.h
 delete mode 100644 arch/arm/mach-vexpress/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-vt8500/include/mach/gpio.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/gpio.h
 rename arch/arm/plat-orion/include/plat/{gpio.h => orion-gpio.h} (95%)
 delete mode 100644 arch/arm/plat-spear/include/plat/gpio.h
