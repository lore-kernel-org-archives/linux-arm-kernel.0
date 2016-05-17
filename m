From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 May 2016 00:21:11 +0200
Subject: [GIT PULL 2/7] ARM: SoC platform updates for v4.7
In-Reply-To: <8749147.ztcb6kVhye@wuerfel>
References: <8749147.ztcb6kVhye@wuerfel>
Message-ID: <3208173.oSXZ3kL0Xa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit bf16200689118d19de1b8d2a3c314fc21f5dc7bb:

  Linux 4.6-rc3 (2016-04-10 17:58:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-soc

for you to fetch changes up to b54891be1a7785de7ec0e5c1fc9ba597713d22a8:

  Merge tag 'v4.6-next-kconfig' of https://github.com/mbgg/linux-mediatek into next/soc (2016-05-09 16:31:16 +0200)

----------------------------------------------------------------
ARM: SoC platform updates for v4.7

We get support for three new 32-bit SoC platforms this time. The amount
of changes in arch/arm for any of them is miniscule, as all the
interesting code is in device driver subsystems (irqchip, clk, pinctrl,
...) these days. I'm listing them here, as the addition of the Kconfig
statement is the main relevant milestone for a new platform. In each
case, some drivers are are shared with existing platforms, while
other drivers are added for v4.7 as well, or come in a later release.

- The Aspeed platform is probably the most interesting one, this is
  what most whitebox servers use as their baseboard management
  controller. We get support for the very common ast2400 and ast2500
  SoCs. The OpenBMC project focuses on this chip, and the LWN
  article about their ELC 2016 presentation at
  https://lwn.net/Articles/683320/ triggered the submission, but the
  code comes from IBM's OpenPOWER team rather than the team at
  Facebook. There are still a lot more drivers that need to get added
  over time, and I hope both teams can work together on that.

- OXNAS is an old platform for Network Attached Storage devices
  from Oxford Semiconductor. There are models with ARM10 (!) and
  ARM11MPCore cores, but for now, we only support the original ARM9
  based versions.
  The product lineup was subsequently part of PLX, Avago and now the
  new Broadcom Ltd. https://wiki.openwrt.org/doc/hardware/soc/soc.oxnas
  has some more information.

- V2M-MPS2 is a prototyping platform from ARM for their Cortex-M
  cores and is related to the existing Realview / Versatile Express
  lineup, but without MMU. We now support various NOMMU platforms,
  so adding a new one is fairly straightforward.
  http://infocenter.arm.com/help/topic/com.arm.doc.100112_0100_03_en/
  has detailed information about the platform.

Other noteworthy updates:

- Work on LPC32xx has resumed, and Vladimir Zapolskiy and Sylvain Lemieux
  are now maintaining the platform. This is an older ARM9 based
  platform from NXP (not Freescale), but it remains in use in embedded
  markets.

- Kevin Hilman is now co-maintaining the Amlogic Meson platform for both
  32-bit and 64-bit ARM, and started contributing some patches.

- As is often the case, work on the OMAP platforms makes up the bulk of
  the actual SoC code changes in arch/arm, but there isn't a lot of
  that either.

----------------------------------------------------------------
Anna-Maria Gleixner (1):
      ARM: OMAP2+: wakeupgen: Add comment for unhandled FROZEN transitions

Arnd Bergmann (11):
      Merge tag 'davinci-for-v4.7/soc' of git://git.kernel.org/.../nsekhar/linux-davinci into next/soc
      Merge tag 'renesas-soc-for-v4.7' of git://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'ox810se-arm-v4.6-rc3' of https://github.com/superna9999/linux into next/soc
      Merge tag 'omap-for-v4.7/soc-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'lpc32xx-soc-4.7' of git://github.com/vzapolskiy/linux-lpc32xx into next/soc
      Merge tag 'davinci-for-v4.7/soc-part2' of git://git.kernel.org/.../nsekhar/linux-davinci into next/soc
      Merge tag 'mvebu-soc-4.7-1' of git://git.infradead.org/linux-mvebu into next/soc
      Merge tag 'imx-soc-4.7' of git://git.kernel.org/.../shawnguo/linux into next/soc
      Merge tag 'davinci-for-v4.7/doc' of git://git.kernel.org/.../nsekhar/linux-davinci into next/soc
      Merge tag 'aspeed-for-4.7-arch' of https://github.com/shenki/linux into next/soc
      Merge tag 'v4.6-next-kconfig' of https://github.com/mbgg/linux-mediatek into next/soc

David Lechner (7):
      ARM: davinci: simplify call to of populate
      ARM: davinci: remove unused DA8XX_NUM_UARTS
      ARM: davinci: use IRQCHIP_DECLARE for cp_intc
      ARM: davinci: da8xx: move usb code to new file
      ARM: davinci: clk: add set_parent callback for mux clocks
      ARM: davinci: Move clock init after ioremap.
      ARM: davinci: da850: use clk->set_parent for async3

Erin Lo (1):
      ARM: mediatek: Add MT2701 config options for mediatek SoCs.

Geert Uytterhoeven (2):
      ARM: shmobile: timer: Fix preset_lpj leading to too short delays
      ARM: shmobile: timer: Drop support for Cortex A8

Joel Stanley (1):
      arm: Add Aspeed machine

Jonas Rabenstein (1):
      ARM: OMAP2+: remove redundant multiplatform checks

Keerthy (1):
      ARM: DRA7: clockdomain: Implement timer workaround for errata i874

Kevin Hilman (1):
      MAINTAINERS: ARM/Amlogic: add co-maintainer, misc. updates

Lee Jones (3):
      MAINTAINERS: Add ST's CPUFreq driver to the STI file list
      MAINTAINERS: Add ST's Remote Processor Driver to ARM/STI ARCHITECTURE
      ARM: STi: Update platform level menuconfig 'help'

Lokesh Vutla (4):
      ARM: OMAP2+: hwmod: Fix updating of sysconfig register
      ARM: OMAP2+: hwmod: RTC: Add lock and unlock functions
      ARM: DRA7: RTC: Add lock and unlock functions
      ARM: AMx3xx: RTC: Add lock and unlock functions

Ludovic Desroches (2):
      ARM: at91: use chipid device for soc detection
      ARM: at91/soc: reference the whole sama5d2 family

Masahiro Yamada (1):
      ARM: uniphier: correct the call order of of_node_put()

Neil Armstrong (3):
      irqchip: versatile-fpga: add new compatible for OX810SE SoC
      ARM: Add new mach-oxnas
      MAINTAINERS: add maintainer entry for ARM/OXNAS platform

Nishanth Menon (3):
      ARM: OMAP: DRA7: powerdomain data: Erratum i892 workaround: Disable core INA
      ARM: OMAP: DRA7: powerdomain data: Fix "ON" state for memories
      ARM: OMAP: DRA7: powerdomain data: Remove wrong OSWR capability

Olof Johansson (2):
      Merge tag 'at91-soc' of git://git.kernel.org/.../nferre/linux-at91 into next/soc
      Merge tag 'sti-soc-for-v4.7-1' of git://git.kernel.org/.../mcoquelin/sti into next/soc

Peter Ujfalusi (1):
      ARM: DRA7: hwmod: Add data for McASP1/2/4/5/6/7/8

Petr Kulhavy (1):
      ARM: DaVinci USB: removed deprecated properties from MUSB config

Sebastian Andrzej Siewior (1):
      ARM: imx: always use TWD on IMX6Q

Sekhar Nori (1):
      MAINTAINERS: fix stale TI DaVinci entries

Sjoerd Simons (2):
      ARM: dts: r8a7791: Don't disable referenced optional clocks
      Revert "ARM: dts: porter: Enable SCIF_CLK frequency and pins"

Stephen Boyd (3):
      ARM: mv78xx0: Remove CLK_IS_ROOT
      ARM: orion5x: Remove CLK_IS_ROOT
      ARM: dove: Remove CLK_IS_ROOT

Suman Anna (2):
      ARM: DRA7: hwmod: Add data for GPTimer 12
      ARM: OMAP2+: hwmod: fix _idle() hwmod state sanity check sequence

Sylvain Lemieux (1):
      ARM: lpc32xx: remove reboot header file

Tony Lindgren (1):
      Merge tag 'for-v4.7/omap-hwmod-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v4.7/soc

Vignesh R (1):
      ARM: OMAP2+: DRA7: Add hwmod entries for PWMSS

Vladimir Murzin (2):
      ARM: vexpress/mps2: introduce MPS2 platform
      MAINTAINERS: Update ARM Versatile Express platform entry

Vladimir Zapolskiy (5):
      ARM: lpc32xx: remove leftovers of legacy clock source and provider drivers
      ARM: lpc32xx: remove duplicate const on lpc32xx_auxdata_lookup
      MAINTAINERS: move ARM/NXP LPC32xx record to ARM section
      MAINTAINERS: add new maintainers of NXP LPC32xx SoC
      MAINTAINERS: add ARM/NXP LPC32XX SoC specific drivers to the section

 .../devicetree/bindings/arm/atmel-at91.txt         |   4 +
 MAINTAINERS                                        |  48 ++-
 arch/arm/Kconfig                                   |  16 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/r8a7791-koelsch.dts              |   1 +
 arch/arm/boot/dts/r8a7791-porter.dts               |  14 +-
 arch/arm/boot/dts/r8a7791.dtsi                     |   5 +-
 arch/arm/mach-aspeed/Kconfig                       |  30 ++
 arch/arm/mach-at91/sama5.c                         |  20 +-
 arch/arm/mach-at91/soc.c                           |  81 ++++-
 arch/arm/mach-at91/soc.h                           |  12 +-
 arch/arm/mach-davinci/Makefile                     |   4 +-
 arch/arm/mach-davinci/clock.c                      |  21 +-
 arch/arm/mach-davinci/clock.h                      |   1 +
 arch/arm/mach-davinci/common.c                     |   6 -
 arch/arm/mach-davinci/cp_intc.c                    |   3 +
 arch/arm/mach-davinci/da830.c                      |   2 +
 arch/arm/mach-davinci/da850.c                      |  83 ++---
 arch/arm/mach-davinci/da8xx-dt.c                   |  17 +-
 arch/arm/mach-davinci/dm355.c                      |   1 +
 arch/arm/mach-davinci/dm365.c                      |   1 +
 arch/arm/mach-davinci/dm644x.c                     |   1 +
 arch/arm/mach-davinci/dm646x.c                     |   1 +
 arch/arm/mach-davinci/usb-da8xx.c                  | 107 ++++++
 arch/arm/mach-davinci/usb.c                        |  89 -----
 arch/arm/mach-dove/common.c                        |   3 +-
 arch/arm/mach-imx/Kconfig                          |   2 +-
 arch/arm/mach-lpc32xx/common.c                     |  95 ------
 arch/arm/mach-lpc32xx/common.h                     |  24 +-
 arch/arm/mach-lpc32xx/phy3250.c                    |   2 +-
 arch/arm/mach-mediatek/Kconfig                     |   4 +
 arch/arm/mach-mv78xx0/common.c                     |   3 +-
 arch/arm/mach-omap2/Makefile                       |   2 +-
 arch/arm/mach-omap2/clockdomains7xx_data.c         |   2 +-
 arch/arm/mach-omap2/omap-wakeupgen.c               |   5 +
 arch/arm/mach-omap2/omap_hwmod.c                   |  20 +-
 arch/arm/mach-omap2/omap_hwmod.h                   |   2 +
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |   2 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          | 364 ++++++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_reset.c             |  65 ++++
 arch/arm/mach-omap2/powerdomains7xx_data.c         |  82 ++---
 arch/arm/mach-omap2/soc.h                          | 140 ++------
 arch/arm/mach-orion5x/common.c                     |   3 +-
 arch/arm/mach-oxnas/Kconfig                        |  24 ++
 arch/arm/mach-shmobile/timer.c                     |  56 ++--
 arch/arm/mach-sti/Kconfig                          |   9 +-
 arch/arm/mach-uniphier/platsmp.c                   |   4 +-
 arch/arm/mach-vexpress/Makefile                    |   4 +-
 arch/arm/mach-vexpress/Makefile.boot               |   3 +
 arch/arm/mach-vexpress/v2m-mps2.c                  |  21 ++
 drivers/irqchip/irq-versatile-fpga.c               |   1 +
 51 files changed, 957 insertions(+), 554 deletions(-)
 create mode 100644 arch/arm/mach-aspeed/Kconfig
 create mode 100644 arch/arm/mach-davinci/usb-da8xx.c
 create mode 100644 arch/arm/mach-oxnas/Kconfig
 create mode 100644 arch/arm/mach-vexpress/Makefile.boot
 create mode 100644 arch/arm/mach-vexpress/v2m-mps2.c
