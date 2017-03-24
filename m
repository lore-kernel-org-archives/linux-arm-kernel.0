From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Mar 2017 21:49:38 +0100
Subject: ARM: SoC fixes for v4.11
Message-ID: <5824770.M7D6WMTEoQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4495c08e84729385774601b5146d51d9e5849f81:

  Linux 4.11-rc2 (2017-03-12 14:47:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 0fa974b8b6106e053595e5481ef6fdbf5c60b457:

  Merge tag 'arm-soc/for-4.11/devicetree-arm64-fixes' of http://github.com/Broadcom/stblinux into fixes (2017-03-24 17:51:50 +0100)

----------------------------------------------------------------
ARM: SoC fixes for v4.11

- A couple of OMAP 4.11 regression fixes, including a boot regression for
  SmartReflex, hypervisor mode in thumb2 mode, and reference counting of
  device nodes

- A fix for cpu_idle on at91

- Minor DT fixes on across several platforms:
  sunxi, bcm53xx, at91, nsp, ns2, ux500, omap

- A fix to correct an API change in the reset controllers

----------------------------------------------------------------
Arnd Bergmann (2):
      Merge tag 'arm-soc/for-4.11/devicetree-fixes-2' of http://github.com/Broadcom/stblinux into fixes
      Merge tag 'arm-soc/for-4.11/devicetree-arm64-fixes' of http://github.com/Broadcom/stblinux into fixes

Fabio Estevam (1):
      ARM: dts: imx6sx-udoo-neo: Fix reboot hang

Florian Fainelli (1):
      ARM: dts: sun7i: lamobo-r1: Fix CPU port RGMII settings

Guenter Roeck (2):
      ARM: OMAP2+: Fix device node reference counts
      ARM: OMAP2+: Release device node after it is no longer needed.

Icenowy Zheng (1):
      ARM: sun8i: a23/a33: drop bl_en_pin GPIO pinmux in reference design DTSI

Jon Mason (5):
      ARM: dts: BCM5301X: Fix UARTs on bcm953012k
      ARM: dts: BCM5301X: Fix memory start address
      ARM: dts: BCM5301X: Correct GIC_PPI interrupt flags
      ARM: dts: NSP: GPIO reboot open-source
      arm64: dts: NS2: Add dma-coherent to relevant DT entries

Ladislav Michl (2):
      ARM: OMAP2+: gpmc-onenand: propagate error on initialization failure
      ARM: OMAP2+: Remove legacy gpmc-nand.c

Linus Walleij (1):
      ARM: dts: add the AB8500 clocks to the device tree

Matthijs van Duin (1):
      ARM: OMAP5 / DRA7: Fix HYP mode boot for thumb2 build

Maxime Ripard (1):
      ARM: sun8i: Fix the mali clock rate

Nicolas Ferre (1):
      ARM: at91: pm: cpu_idle: switch DDR to power-down mode

Olof Johansson (6):
      Merge tag 'arm-soc/for-4.11/devicetree-fixes' of http://github.com/Broadcom/stblinux into fixes
      Merge tag 'omap-for-v4.11/fixes-rc1-v2' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'imx-fixes-4.11' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'sunxi-fixes-for-4.11' of https://git.kernel.org/.../mripard/linux into fixes
      Merge tag 'reset-fixes-for-4.11' of git://git.pengutronix.de/git/pza/linux into fixes
      Merge tag 'at91-ab-4.11-fixes' of git://git.kernel.org/.../abelloni/linux into fixes

Philipp Zabel (1):
      reset: fix optional reset_control_get stubs to return NULL

Romain Izard (1):
      Revert "ARM: at91/dt: sama5d2: Use new compatible for ohci node"

Sekhar Nori (1):
      ARM: dts: am57xx-idk: tpic2810 is on I2C bus, not SPI

Teresa Remmet (1):
      ARM: dts: am335x-pcm953: Fix legacy wakeup source binding

Tony Lindgren (5):
      ARM: OMAP3: Fix smartreflex platform data regression
      Merge branch 'omap-for-v4.10/fixes' into omap-for-v4.11/fixes
      ARM: omap2plus_defconfig: Enable INPUT_MOUSEDEV as loadable modules
      Merge branch 'gpio-key-wakeup-fix' into omap-for-v4.11/fixes
      Merge tag 'v4.11-rc1' into omap-for-v4.11/fixes

 arch/arm/boot/dts/am335x-pcm-953.dtsi              |   4 +-
 arch/arm/boot/dts/am57xx-idk-common.dtsi           |  14 +-
 arch/arm/boot/dts/bcm5301x.dtsi                    |   4 +-
 arch/arm/boot/dts/bcm953012k.dts                   |   5 +-
 arch/arm/boot/dts/bcm958522er.dts                  |   1 +
 arch/arm/boot/dts/bcm958525er.dts                  |   1 +
 arch/arm/boot/dts/bcm958525xmc.dts                 |   1 +
 arch/arm/boot/dts/bcm958622hr.dts                  |   1 +
 arch/arm/boot/dts/bcm958623hr.dts                  |   1 +
 arch/arm/boot/dts/bcm958625hr.dts                  |   1 +
 arch/arm/boot/dts/bcm988312hr.dts                  |   1 +
 arch/arm/boot/dts/imx6sx-udoo-neo.dtsi             |   5 -
 arch/arm/boot/dts/sama5d2.dtsi                     |   2 +-
 arch/arm/boot/dts/ste-dbx5x0.dtsi                  |  19 +++
 arch/arm/boot/dts/ste-href.dtsi                    |   9 --
 arch/arm/boot/dts/ste-snowball.dts                 |   9 --
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts          |   2 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |   2 +-
 .../boot/dts/sun8i-reference-design-tablet.dtsi    |   7 -
 arch/arm/configs/omap2plus_defconfig               |   1 +
 arch/arm/mach-at91/pm.c                            |  18 ++-
 arch/arm/mach-omap2/Makefile                       |   3 -
 arch/arm/mach-omap2/gpmc-nand.c                    | 154 ---------------------
 arch/arm/mach-omap2/gpmc-onenand.c                 |  10 +-
 arch/arm/mach-omap2/omap-headsmp.S                 |   3 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  45 ++++--
 arch/arm64/boot/dts/broadcom/ns2.dtsi              |  11 ++
 drivers/memory/omap-gpmc.c                         |   4 +-
 include/linux/omap-gpmc.h                          |  16 +--
 include/linux/reset.h                              |   9 +-
 30 files changed, 122 insertions(+), 241 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/gpmc-nand.c
