From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 08 Oct 2016 02:29:43 +0200
Subject: [GIT PULL 1/8] ARM: SoC cleanups for v4.9
In-Reply-To: <3637015.LRn5VyhPVM@wuerfel>
References: <3637015.LRn5VyhPVM@wuerfel>
Message-ID: <1943879.l2iBNmR8MC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 3eab887a55424fc2c27553b7bfe32330df83f7b8:

  Linux 4.8-rc4 (2016-08-28 15:04:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-cleanup

for you to fetch changes up to e13688fe618881dd407a68dfbd2295d70b21a445:

  ARM: select PCI_DOMAINS config from ARCH_MULTIPLATFORM (2016-09-21 22:45:13 +0200)

----------------------------------------------------------------
ARM: SoC cleanups for v4.9

The cleanups for v4.9 are a little larger that usual, but thankfully
that is almost exclusively due to removing a significant number of
files that have become obsolete after the still ongoing conversion
of old board files to devicetree.

- for mach-omap2, which is still the largest platform in arch/arm/,
  the conversion to DT is finally complete after the Nokia N900 is
  now fully supported there, along with the omap3 LDP, and we can
  remove those two board files.
  If no regressions are found, another large cleanup for the platform
  will happen as a follow-up, removing dead code and restructuring
  the platform based on being DT-only.

- In mach-imx, similar work is ongoing, but has not come that far.
  This time, we remove the obsolete board file for the i.MX1
  generation, which like i.MX25, i.MX5, i.MX6, and i.MX7 is now DT-only.
  The remaining board files are for i.MX2 and i.MX3 machines
  based on old ARM926 or ARM1136 cores that should work with DT
  in principle.

- realview has just been converted from board files to DT, and a lot
  of code gets removed in the process. This is the last
  ARM/Keil/Versatile derived platform that was still using board
  files, the other ones being integrator, versatile and vexpress.
  We can probably merge the remaining code into a single directory
  in the near future.

- clps711x had completed the conversion in v4.8, but we accidentally
  left the files in place that should have been deleted then.

Conflicts: two files deleted here have been modified upstream,
the changes can be discarded.

----------------------------------------------------------------
Alexander Kurz (2):
      ARM: i.MX31 iomux: remove plain duplicates
      ARM: i.MX31 iomux: remove duplicates with alternate name

Alexander Shiyan (4):
      ARM: i.MX: Remove i.MX1 Armadeus APF9328 board support
      ARM: i.MX: Remove i.MX1 Synertronixx SCB9328 board support
      ARM: i.MX: Remove i.MX1 non-DT support
      ARM: i.MX: Move SOC_IMX1 into 'Device tree only'

Arnd Bergmann (5):
      Merge tag 'realview-broomstick-sweep' of git://git.kernel.org/.../linusw/linux-integrator into next/cleanup
      ARM: clps711x: remove extraneous files
      Merge tag 'omap-for-v4.8/legacy-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/cleanup
      Merge tag 'omap-for-v4.9/soc-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/cleanup
      Merge tag 'imx-cleanup-4.9' of git://git.kernel.org/.../shawnguo/linux into next/cleanup

Fabian Frederick (1):
      ARM: imx: remove platform-mxc_rnga

Javier Martinez Canillas (3):
      ARM: OMAP1: use IS_ENABLED() instead of checking for built-in or module
      ARM: OMAP2+: use IS_ENABLED() instead of checking for built-in or module
      ARM: imx: use IS_ENABLED() instead of checking for built-in or module

Kishon Vijay Abraham I (2):
      ARM: stop *MIGHT_HAVE_PCI* config from being selected redundantly
      ARM: select PCI_DOMAINS config from ARCH_MULTIPLATFORM

Linus Walleij (2):
      ARM: realview: delete the RealView board files
      ARM: realview: imply device tree boot

Lothar Wa?mann (1):
      ARM: mxs: remove obsolete startup code for TX28

Martin Kaiser (1):
      ARM: imx: (trivial) fix typo and grammar

Tony Lindgren (3):
      Merge remote-tracking branch 'peter/peter/for-4.8_omapdss_part1' into omap-for-v4.8/legacy
      ARM: OMAP2+: Drop legacy board file for n900
      ARM: OMAP2+: Drop legacy board file for LDP

Vladimir Murzin (2):
      ARM: imx: no need to select SMP_ON_UP explicitly
      ARM: realview: no need to select SMP_ON_UP explicitly

 arch/arm/Kconfig                              |    4 +-
 arch/arm/configs/imx_v4_v5_defconfig          |    3 +-
 arch/arm/configs/multi_v4t_defconfig          |    4 +-
 arch/arm/mach-at91/Kconfig                    |    1 -
 arch/arm/mach-axxia/Kconfig                   |    2 -
 arch/arm/mach-clps711x/Makefile.boot          |    0
 arch/arm/mach-clps711x/board-autcpu12.c       |  275 ------
 arch/arm/mach-clps711x/board-cdb89712.c       |  147 ---
 arch/arm/mach-clps711x/board-clep7312.c       |   45 -
 arch/arm/mach-clps711x/board-edb7211.c        |  188 ----
 arch/arm/mach-clps711x/board-p720t.c          |  373 -------
 arch/arm/mach-clps711x/common.c               |   65 --
 arch/arm/mach-clps711x/common.h               |   23 -
 arch/arm/mach-clps711x/devices.c              |  149 ---
 arch/arm/mach-clps711x/devices.h              |   12 -
 arch/arm/mach-cns3xxx/Kconfig                 |    1 -
 arch/arm/mach-exynos/Kconfig                  |    2 -
 arch/arm/mach-imx/Kconfig                     |   52 +-
 arch/arm/mach-imx/Makefile                    |    7 +-
 arch/arm/mach-imx/common.h                    |    5 -
 arch/arm/mach-imx/devices-imx1.h              |   30 -
 arch/arm/mach-imx/devices/Makefile            |    1 -
 arch/arm/mach-imx/devices/devices-common.h    |   12 -
 arch/arm/mach-imx/devices/platform-imx-fb.c   |    5 -
 arch/arm/mach-imx/devices/platform-imx-i2c.c  |    5 -
 arch/arm/mach-imx/devices/platform-imx-uart.c |   37 -
 arch/arm/mach-imx/devices/platform-spi_imx.c  |    9 -
 arch/arm/mach-imx/hardware.h                  |    3 +-
 arch/arm/mach-imx/iomux-mx1.h                 |  155 ---
 arch/arm/mach-imx/iomux-mx3.h                 |   34 -
 arch/arm/mach-imx/mach-apf9328.c              |  148 ---
 arch/arm/mach-imx/{imx1-dt.c => mach-imx1.c}  |   23 +-
 arch/arm/mach-imx/mach-kzm_arm11_01.c         |    6 +-
 arch/arm/mach-imx/mach-pcm037.c               |    2 +-
 arch/arm/mach-imx/mach-scb9328.c              |  143 ---
 arch/arm/mach-imx/mm-imx1.c                   |   67 --
 arch/arm/mach-imx/mx1.h                       |  172 ----
 arch/arm/mach-integrator/Kconfig              |    1 -
 arch/arm/mach-keystone/Kconfig                |    2 -
 arch/arm/mach-mxs/mach-mxs.c                  |   77 --
 arch/arm/mach-omap1/board-h2-mmc.c            |    2 +-
 arch/arm/mach-omap1/board-h2.c                |    2 +-
 arch/arm/mach-omap1/board-h3-mmc.c            |    2 +-
 arch/arm/mach-omap1/board-h3.c                |    2 +-
 arch/arm/mach-omap1/board-htcherald.c         |    4 +-
 arch/arm/mach-omap1/board-innovator.c         |    4 +-
 arch/arm/mach-omap1/board-nokia770.c          |    4 +-
 arch/arm/mach-omap1/board-sx1-mmc.c           |    2 +-
 arch/arm/mach-omap1/devices.c                 |   10 +-
 arch/arm/mach-omap1/fb.c                      |    2 +-
 arch/arm/mach-omap1/include/mach/usb.h        |    2 +-
 arch/arm/mach-omap1/mmc.h                     |    2 +-
 arch/arm/mach-omap1/usb.c                     |    6 +-
 arch/arm/mach-omap2/Kconfig                   |   12 -
 arch/arm/mach-omap2/Makefile                  |    4 -
 arch/arm/mach-omap2/board-flash.c             |   10 +-
 arch/arm/mach-omap2/board-flash.h             |   11 +-
 arch/arm/mach-omap2/board-ldp.c               |  430 --------
 arch/arm/mach-omap2/board-n8x0.c              |    5 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c  | 1312 -------------------------
 arch/arm/mach-omap2/board-rx51-video.c        |   67 --
 arch/arm/mach-omap2/board-rx51.c              |  141 ---
 arch/arm/mach-omap2/board-rx51.h              |   11 -
 arch/arm/mach-omap2/common-board-devices.c    |    3 +-
 arch/arm/mach-omap2/devices.c                 |    7 +-
 arch/arm/mach-omap2/drm.c                     |    2 +-
 arch/arm/mach-omap2/fb.c                      |    2 +-
 arch/arm/mach-omap2/gpmc-smsc911x.h           |    2 +-
 arch/arm/mach-omap2/hsmmc.c                   |    2 +-
 arch/arm/mach-omap2/hsmmc.h                   |    2 +-
 arch/arm/mach-omap2/twl-common.c              |    3 +-
 arch/arm/mach-realview/Kconfig                |   72 +-
 arch/arm/mach-realview/Makefile               |   12 +-
 arch/arm/mach-realview/board-eb.h             |   94 --
 arch/arm/mach-realview/board-pb1176.h         |   81 --
 arch/arm/mach-realview/board-pb11mp.h         |   96 --
 arch/arm/mach-realview/board-pba8.h           |   71 --
 arch/arm/mach-realview/board-pbx.h            |  106 --
 arch/arm/mach-realview/core.c                 |  404 --------
 arch/arm/mach-realview/core.h                 |   58 --
 arch/arm/mach-realview/hardware.h             |   40 -
 arch/arm/mach-realview/hotplug.h              |    1 +
 arch/arm/mach-realview/irqs-eb.h              |  114 ---
 arch/arm/mach-realview/irqs-pb1176.h          |   77 --
 arch/arm/mach-realview/irqs-pb11mp.h          |   97 --
 arch/arm/mach-realview/irqs-pba8.h            |   71 --
 arch/arm/mach-realview/irqs-pbx.h             |   87 --
 arch/arm/mach-realview/platform.h             |  247 -----
 arch/arm/mach-realview/platsmp-dt.c           |    3 +-
 arch/arm/mach-realview/platsmp.c              |   86 --
 arch/arm/mach-realview/realview_eb.c          |  492 ----------
 arch/arm/mach-realview/realview_pb1176.c      |  395 --------
 arch/arm/mach-realview/realview_pb11mp.c      |  385 --------
 arch/arm/mach-realview/realview_pba8.c        |  307 ------
 arch/arm/mach-realview/realview_pbx.c         |  402 --------
 arch/arm/mach-shmobile/Kconfig                |    1 -
 arch/arm/mach-spear/Kconfig                   |    1 -
 arch/arm/mach-versatile/Kconfig               |    1 -
 drivers/clk/imx/clk-imx1.c                    |   46 +-
 drivers/irqchip/Makefile                      |    2 +-
 drivers/mtd/maps/Kconfig                      |    2 +-
 101 files changed, 105 insertions(+), 8106 deletions(-)
 delete mode 100644 arch/arm/mach-clps711x/Makefile.boot
 delete mode 100644 arch/arm/mach-clps711x/board-autcpu12.c
 delete mode 100644 arch/arm/mach-clps711x/board-cdb89712.c
 delete mode 100644 arch/arm/mach-clps711x/board-clep7312.c
 delete mode 100644 arch/arm/mach-clps711x/board-edb7211.c
 delete mode 100644 arch/arm/mach-clps711x/board-p720t.c
 delete mode 100644 arch/arm/mach-clps711x/common.c
 delete mode 100644 arch/arm/mach-clps711x/common.h
 delete mode 100644 arch/arm/mach-clps711x/devices.c
 delete mode 100644 arch/arm/mach-clps711x/devices.h
 delete mode 100644 arch/arm/mach-imx/devices-imx1.h
 delete mode 100644 arch/arm/mach-imx/iomux-mx1.h
 delete mode 100644 arch/arm/mach-imx/mach-apf9328.c
 rename arch/arm/mach-imx/{imx1-dt.c => mach-imx1.c} (63%)
 delete mode 100644 arch/arm/mach-imx/mach-scb9328.c
 delete mode 100644 arch/arm/mach-imx/mm-imx1.c
 delete mode 100644 arch/arm/mach-imx/mx1.h
 delete mode 100644 arch/arm/mach-omap2/board-ldp.c
 delete mode 100644 arch/arm/mach-omap2/board-rx51-peripherals.c
 delete mode 100644 arch/arm/mach-omap2/board-rx51-video.c
 delete mode 100644 arch/arm/mach-omap2/board-rx51.c
 delete mode 100644 arch/arm/mach-omap2/board-rx51.h
 delete mode 100644 arch/arm/mach-realview/board-eb.h
 delete mode 100644 arch/arm/mach-realview/board-pb1176.h
 delete mode 100644 arch/arm/mach-realview/board-pb11mp.h
 delete mode 100644 arch/arm/mach-realview/board-pba8.h
 delete mode 100644 arch/arm/mach-realview/board-pbx.h
 delete mode 100644 arch/arm/mach-realview/core.c
 delete mode 100644 arch/arm/mach-realview/core.h
 delete mode 100644 arch/arm/mach-realview/hardware.h
 create mode 100644 arch/arm/mach-realview/hotplug.h
 delete mode 100644 arch/arm/mach-realview/irqs-eb.h
 delete mode 100644 arch/arm/mach-realview/irqs-pb1176.h
 delete mode 100644 arch/arm/mach-realview/irqs-pb11mp.h
 delete mode 100644 arch/arm/mach-realview/irqs-pba8.h
 delete mode 100644 arch/arm/mach-realview/irqs-pbx.h
 delete mode 100644 arch/arm/mach-realview/platform.h
 delete mode 100644 arch/arm/mach-realview/platsmp.c
 delete mode 100644 arch/arm/mach-realview/realview_eb.c
 delete mode 100644 arch/arm/mach-realview/realview_pb1176.c
 delete mode 100644 arch/arm/mach-realview/realview_pb11mp.c
 delete mode 100644 arch/arm/mach-realview/realview_pba8.c
 delete mode 100644 arch/arm/mach-realview/realview_pbx.c
