From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 12 Dec 2015 22:49:19 +0100
Subject: [GIT PULL] ARM: SoC fixes for 4.4-rc, part 2
Message-ID: <1866325.QW27jj5BaL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 31ade3b83e1821da5fbb2f11b5b3d4ab2ec39db8:

  Linux 4.4-rc3 (2015-11-29 18:58:26 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to 7f4c977849d494a1ff173fbc226b69192ec02c90:

  Merge tag 'imx-fixes-4.4-2' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into fixes (2015-12-11 16:14:34 -0800)

----------------------------------------------------------------
ARM: SoC fixes for 4.4-rc

Here are a bunch of small bug fixes for various ARM platforms, nothing
really sticks out this week, most of either fixes bugs in code that was
just added in 4.4, or that has been broken for many years without anyone
noticing.

at91/sama5d2
- fix sama5de hardware setup of sd/mmc interface
- proper selection of pinctrl drivers. PIO4 is necessary for sama5d2

berlin
- fix incorrect clock input for SDIO

exynos
- Fix potential NULL pointer dereference in Exynos PMU driver.

imx
- Fix vf610 SAI clock configuration bug which is discovered by
  the newly added master mode support in SAI audio driver.
- Fix buggy L2 cache latency values in vf610 device trees, which may
  cause system hang when cpu runs at a higher frequency.

ixp4xx
- fix prototypes for readl/writel functions

ls2080a
- use little-endian register access for GPIO and SDHCI

omap
- Fix clock source for ARM TWD and global timers on am437x
- Always select REGULATOR_FIXED_VOLTAGE for omap2+ instead of
  when MACH_OMAP3_PANDORA is selected
- Fix SPI DMA handles for dm816x as only some were mapped
- Fix up mbox cells for dm816x to make mailbox usable

pxa
- use PWM lookup table for all ezx machines

s3c24xx
- Remove incorrect __init annotation from s3c24xx cpufreq driver structures.

versatile
- fix PCI IRQ mapping on Versatile PB

----------------------------------------------------------------
Arnd Bergmann (7):
      cpufreq: s3c24xx: Do not mark s3c2410_plls_add as __init
      ARM: ixp4xx: fix read{b,w,l} return types
      Merge tag 'samsung-fixes-4.4' of https://git.kernel.org/.../krzk/linux into fixes
      Merge tag 'at91-4.4-fixes-2' of git://git.kernel.org/.../abelloni/linux into fixes
      Merge tag 'berlin-fixes-for-4.4-rc1-1' of git://git.infradead.org/users/hesselba/linux-berlin into fixes
      ARM: pxa: use PWM lookup table for all machines
      Merge tag 'omap-for-v4.4/fixes-rc4' of git://git.kernel.org/.../tmlind/linux-omap into fixes

Grygorii Strashko (2):
      ARM: OMAP2+: enable REGULATOR_FIXED_VOLTAGE
      ARM: dts: am4372: fix clock source for arm twd and global timers

Guillaume Delbergue (1):
      irqchip/versatile-fpga: Fix PCI IRQ mapping on Versatile PB

Jisheng Zhang (2):
      ARM: dts: berlin: correct BG2Q's sdhci2 2nd clock
      ARM: dts: berlin: add 2nd clock for BG2Q sdhci0 and sdhci1

Kevin Hilman (1):
      Merge tag 'imx-fixes-4.4-2' of git://git.kernel.org/.../shawnguo/linux into fixes

Li Yang (1):
      dt-bindings: define little-endian property for QorIQ GPIO

Liu Gang (1):
      ls2080a/dts: Add little endian property for GPIO IP block

Ludovic Desroches (1):
      ARM: at91: fix pinctrl driver selection

Neil Armstrong (2):
      ARM: dts: add dm816x missing #mbox-cells
      ARM: dts: add dm816x missing spi DT dma handles

Nicolas Ferre (1):
      ARM: at91/dt: add always-on to 1.8V regulator

Pankaj Dubey (1):
      ARM: EXYNOS: Fix potential NULL pointer access in exynos_sys_powerdown_conf

Stefan Agner (3):
      ARM: imx: clk-vf610: fix SAI clock tree
      ARM: dts: vf610: fix clock definition for SAI2
      ARM: dts: vf610: use reset values for L2 cache latencies

yangbo lu (1):
      ARM64: dts: ls2080a: fix eSDHC endianness

 Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt |  4 ++++
 arch/arm/boot/dts/am4372.dtsi                           |  4 ++--
 arch/arm/boot/dts/am43xx-clocks.dtsi                    |  8 ++++++++
 arch/arm/boot/dts/at91-sama5d2_xplained.dts             |  1 +
 arch/arm/boot/dts/berlin2q.dtsi                         |  8 +++++---
 arch/arm/boot/dts/dm816x.dtsi                           |  8 ++++++--
 arch/arm/boot/dts/vf610-colibri.dtsi                    |  5 -----
 arch/arm/boot/dts/vf610.dtsi                            |  2 +-
 arch/arm/boot/dts/vfxxx.dtsi                            |  6 ++++--
 arch/arm/mach-at91/Kconfig                              |  6 +++++-
 arch/arm/mach-at91/pm.c                                 |  7 ++++++-
 arch/arm/mach-exynos/pmu.c                              |  6 +++++-
 arch/arm/mach-ixp4xx/include/mach/io.h                  | 12 ++++++------
 arch/arm/mach-omap2/Kconfig                             |  2 +-
 arch/arm/mach-pxa/ezx.c                                 |  5 +++++
 arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c            |  2 +-
 arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c            |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi          |  5 +++++
 drivers/clk/imx/clk-vf610.c                             |  8 ++++----
 drivers/cpufreq/s3c24xx-cpufreq.c                       |  2 +-
 drivers/irqchip/irq-versatile-fpga.c                    |  5 +++++
 21 files changed, 76 insertions(+), 32 deletions(-)
