From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Sep 2016 17:02:14 +0200
Subject: [GIT PULL] ARM: SoC fixes for 4.8-rc7
Message-ID: <3540775.8TpLndR4mE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 95390e3290e8bf69091116e0d91b9754c0e93a24:

  Merge tag 'sunxi-fixes-for-4.8' of https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux into fixes (2016-09-07 21:25:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to 6408649115cfd73d6807398d04b2ba564db9211e:

  Merge tag 'samsung-fixes-4.8-2' of git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into fixes (2016-09-16 16:29:48 +0200)

----------------------------------------------------------------
ARM: SoC fixes

Here are a couple of bugfixes for v4.8-rc. Most of them have
actually been around for a while this time but for some reason
didn't get applied early on. The shmobile regulator fix is the
only one that isn't completely obvious.

device tree changes:
- archtimer interrupts must be level triggered (multiple platforms)
- fix for USB and MMC clocks on STiH410
- fix split DT repository in case of raspberry-pi 3
- A new use of skeleton.dtsi on arm64 has crept in after that
  was removed.

defconfig updates:
- xilinx vdma has a new Kconfig symbol name
- keystone requires CONFIG_NOP_USB_XCEIV since v4.8-rc1

code fixes:
- fix regulator quirk on shmobile
- suspend-to-ram regression on EXYNOS

maintainer updates:
- Javier Martinez Canillas is now a reviewer for Samsung EXYNOS

----------------------------------------------------------------
Arnd Bergmann (4):
      Merge tag 'renesas-fixes-for-v4.8' of git://git.kernel.org/.../horms/renesas into fixes
      Merge tag 'sti-dt-fixes-for-v4.8-rcs' of git://git.kernel.org/.../pchotard/sti into fixes
      Merge branch 'dt/irq-fix' into fixes
      Merge tag 'samsung-fixes-4.8-2' of git://git.kernel.org/.../krzk/linux into fixes

Fabian Frederick (1):
      ARM: multi_v7_defconfig: update XILINX_VDMA

Ian Campbell (2):
      ARM: dts: Remove use of skeleton.dtsi from bcm283x.dtsi
      ARM64: dts: bcm: Use a symlink to R-Pi dtsi files from arch=arm

Javier Martinez Canillas (2):
      MAINTAINERS: Add myself as reviewer for Samsung Exynos support
      ARM: EXYNOS: Clear OF_POPULATED flag from PMU node in IRQ init callback

Lee Jones (2):
      ARM: dts: STiH410: Handle interconnect clock required by EHCI/OHCI (USB)
      ARM: dts: STiH407-family: Provide interconnect clock for consumption in ST SDHCI

Marc Zyngier (1):
      arm64: dts: Fix broken architected timer interrupt trigger

Roger Quadros (1):
      ARM: keystone: defconfig: Fix USB configuration

Wolfram Sang (1):
      ARM: shmobile: fix regulator quirk for Gen2

 MAINTAINERS                                        |  1 +
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  1 +
 arch/arm/boot/dts/bcm283x.dtsi                     |  3 +-
 arch/arm/boot/dts/stih407-family.dtsi              | 10 ++--
 arch/arm/boot/dts/stih410.dtsi                     | 12 +++--
 arch/arm/configs/keystone_defconfig                |  1 +
 arch/arm/configs/multi_v7_defconfig                |  2 +-
 arch/arm/mach-exynos/suspend.c                     |  6 +++
 arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c | 62 +++++++++-------------
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |  8 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |  8 +--
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |  8 +--
 arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi      |  1 +
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts   |  4 +-
 arch/arm64/boot/dts/broadcom/bcm2837.dtsi          |  2 +-
 .../boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi    |  1 +
 arch/arm64/boot/dts/broadcom/bcm283x.dtsi          |  1 +
 arch/arm64/boot/dts/broadcom/ns2.dtsi              |  8 +--
 arch/arm64/boot/dts/cavium/thunder-88xx.dtsi       |  8 +--
 arch/arm64/boot/dts/exynos/exynos7.dtsi            |  8 +--
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  8 +--
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |  8 +--
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |  8 +--
 .../boot/dts/socionext/uniphier-ph1-ld20.dtsi      |  8 +--
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |  8 +--
 25 files changed, 102 insertions(+), 93 deletions(-)
 create mode 120000 arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi
 create mode 120000 arch/arm64/boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi
 create mode 120000 arch/arm64/boot/dts/broadcom/bcm283x.dtsi
