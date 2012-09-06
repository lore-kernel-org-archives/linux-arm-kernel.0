From: robherring2@gmail.com (Rob Herring)
Date: Thu,  6 Sep 2012 15:12:43 -0500
Subject: [PATCH v3 00/12] Initial multi-platform support
Message-ID: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This series enables initial ARM multi-platform support for highbank, mvebu,
socfpga, picoxcell, and vexpress. Multi-platform support is dependent on
some DEBUG_LL and dtb build rules restructuring. This series is also
dependent on my gpio clean-up series posted here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-September/118138.html

New in this version:
- Moved ARCH_MULTIPLATFORM back into choice so converted platforms'
  defconfigs work before and after conversion.
- Added mvebu, socfpga and picoxcell DEBUG_LL support. DEBUG_LL should
  work for all converted platforms.
- Fixed make dtbs.
- Removed all unused headers (timex.h, uncompress.h) and Makefile.boot
- Add ARCH_MULTIPLATFORM depends for XIP found with randconfig builds
- Split out Vexpress to separate patch as now DT board support is always
  enabled.

This series plus gpio clean-up is available here:
git://sources.calxeda.com/kernel/linux.git multi-plat

Rob

Arnd Bergmann (1):
  ARM: vexpress: remove dependency on mach/* headers

Rob Herring (11):
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

 arch/arm/Kconfig                                   |  142 ++++++++----------
 arch/arm/Kconfig.debug                             |   33 +++++
 arch/arm/Makefile                                  |  155 ++++++++++----------
 arch/arm/boot/Makefile                             |    2 +
 arch/arm/boot/compressed/misc.c                    |    6 +
 arch/arm/boot/dts/Makefile                         |   41 ++++++
 arch/arm/include/asm/timex.h                       |    4 +
 .../debug-macro.S => include/debug/highbank.S}     |    6 +-
 arch/arm/include/debug/icedcc.S                    |   90 ++++++++++++
 .../mach/debug-macro.S => include/debug/mvebu.S}   |    3 +-
 .../debug-macro.S => include/debug/picoxcell.S}    |    0
 .../mach/debug-macro.S => include/debug/socfpga.S} |    0
 .../debug-macro.S => include/debug/vexpress.S}     |    0
 arch/arm/kernel/debug.S                            |   87 +----------
 arch/arm/kernel/head.S                             |    4 +-
 arch/arm/mach-at91/Makefile.boot                   |   24 ---
 arch/arm/mach-exynos/Makefile.boot                 |    3 -
 arch/arm/mach-highbank/Kconfig                     |   15 ++
 arch/arm/mach-highbank/Makefile.boot               |    1 -
 arch/arm/mach-highbank/include/mach/timex.h        |    6 -
 arch/arm/mach-highbank/include/mach/uncompress.h   |    9 --
 arch/arm/mach-imx/Makefile.boot                    |    7 -
 arch/arm/mach-kirkwood/Makefile.boot               |   11 --
 arch/arm/mach-lpc32xx/Makefile.boot                |    2 -
 arch/arm/mach-mvebu/Kconfig                        |   10 ++
 arch/arm/mach-mvebu/Makefile                       |    2 +
 arch/arm/mach-mvebu/Makefile.boot                  |    3 -
 arch/arm/mach-mvebu/armada-370-xp.c                |    2 +-
 .../mach-mvebu/{include/mach => }/armada-370-xp.h  |    0
 arch/arm/mach-mvebu/include/mach/timex.h           |   13 --
 arch/arm/mach-mvebu/include/mach/uncompress.h      |   43 ------
 arch/arm/mach-mxs/Makefile.boot                    |    9 --
 arch/arm/mach-picoxcell/Kconfig                    |   14 ++
 arch/arm/mach-picoxcell/Makefile.boot              |    1 -
 arch/arm/mach-picoxcell/common.c                   |    6 +-
 arch/arm/mach-picoxcell/include/mach/hardware.h    |   21 ---
 arch/arm/mach-picoxcell/include/mach/map.h         |   25 ----
 arch/arm/mach-picoxcell/include/mach/timex.h       |   25 ----
 arch/arm/mach-picoxcell/include/mach/uncompress.h  |   21 ---
 .../{include/mach => }/picoxcell_soc.h             |    0
 arch/arm/mach-socfpga/Kconfig                      |   16 ++
 arch/arm/mach-socfpga/Makefile.boot                |    1 -
 arch/arm/mach-socfpga/include/mach/timex.h         |   19 ---
 arch/arm/mach-socfpga/include/mach/uncompress.h    |    9 --
 arch/arm/mach-spear13xx/Makefile.boot              |    3 -
 arch/arm/mach-spear3xx/Makefile.boot               |    4 -
 arch/arm/mach-spear6xx/Makefile.boot               |    2 -
 arch/arm/mach-tegra/Makefile.boot                  |    8 -
 arch/arm/mach-ux500/Makefile.boot                  |    2 -
 arch/arm/mach-vexpress/Kconfig                     |   64 ++++----
 arch/arm/mach-vexpress/Makefile                    |    2 +
 arch/arm/mach-vexpress/Makefile.boot               |   10 --
 arch/arm/mach-vexpress/ct-ca9x4.c                  |    1 +
 arch/arm/mach-vexpress/include/mach/irqs.h         |    2 +
 arch/arm/mach-vexpress/v2m.c                       |    4 -
 arch/arm/plat-versatile/Makefile                   |    2 +
 56 files changed, 423 insertions(+), 572 deletions(-)
 create mode 100644 arch/arm/boot/dts/Makefile
 rename arch/arm/{mach-highbank/include/mach/debug-macro.S => include/debug/highbank.S} (83%)
 create mode 100644 arch/arm/include/debug/icedcc.S
 rename arch/arm/{mach-mvebu/include/mach/debug-macro.S => include/debug/mvebu.S} (86%)
 rename arch/arm/{mach-picoxcell/include/mach/debug-macro.S => include/debug/picoxcell.S} (100%)
 rename arch/arm/{mach-socfpga/include/mach/debug-macro.S => include/debug/socfpga.S} (100%)
 rename arch/arm/{mach-vexpress/include/mach/debug-macro.S => include/debug/vexpress.S} (100%)
 create mode 100644 arch/arm/mach-highbank/Kconfig
 delete mode 100644 arch/arm/mach-highbank/Makefile.boot
 delete mode 100644 arch/arm/mach-highbank/include/mach/timex.h
 delete mode 100644 arch/arm/mach-highbank/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-mvebu/Makefile.boot
 rename arch/arm/mach-mvebu/{include/mach => }/armada-370-xp.h (100%)
 delete mode 100644 arch/arm/mach-mvebu/include/mach/timex.h
 delete mode 100644 arch/arm/mach-mvebu/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-picoxcell/Kconfig
 delete mode 100644 arch/arm/mach-picoxcell/Makefile.boot
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/map.h
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/timex.h
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/uncompress.h
 rename arch/arm/mach-picoxcell/{include/mach => }/picoxcell_soc.h (100%)
 create mode 100644 arch/arm/mach-socfpga/Kconfig
 delete mode 100644 arch/arm/mach-socfpga/Makefile.boot
 delete mode 100644 arch/arm/mach-socfpga/include/mach/timex.h
 delete mode 100644 arch/arm/mach-socfpga/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-vexpress/Makefile.boot

-- 
1.7.9.5
