From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 24 Apr 2013 18:28:05 +0100
Subject: [RFC PATCH v3 00/17] ARM: DT cpu bindings updates
Message-ID: <1366824502-19729-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is an update of a previous posting:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/164587.html

v3 changes:

- More dts fixes of in-kernel dts
- Defined ARM v8 behaviour with different cpus node #address-cells
- Added pre ARM11 processors suffixes in the cpu node compatible list
- Reordered series
- Reworded #address-cells definition
- Added ARM v8 - cores running on AArch32 bindings example
- Moved WARN* calls on one line to prevent grepping issues

v2 changes:

- Reworded DT cpu bindings
- Split the set, with per-mach specific dts updates
- Updated cpu node compatible string list
- Defined behaviour of OS running on v8 in AArch32

The introduction of DT cpus/cpu bindings for ARM requires well established
rules to enforce the reg property definition for 32-bit and 64-bit ARM
processors, inclusive of legacy and current uniprocessor/SMP systems.

ARM 64 bit architecture also requires dtb compiled for 64-bit configurations
to be reused for kernels running in 32 bit mode, so the cpus/cpu bindings
specification must be made compliant to cope with this configuration.

Patch #1 of this series is a fix and is included to have a clean patch
series and should get reviewed and merged separately.

Patch #2-17, along with some kernel fixes related to DT parsing function,
update the cpu node bindings and in kernel dts files to cope with legacy,
current and upcoming ARM systems.

In-kernel device tree source files are updated to comply with the latest
specification, so thorough testing is required in order to validate all
changes on all affected ARM systems, in particular systems with exotic
MPIDR configurations that are likely to break with the changes provided.

Code relying on the reg property size to be 4-bytes must be updated so that
dtbs compiled for 64-bit kernels can also be used to boot a 32-bit system.

Lorenzo Pieralisi (17):
  ARM: DT: kernel: move temporary cpu map stack array to static data
  Documentation: devicetree: arm: cpus/cpu nodes bindings updates
  ARM: dts: am33xx: cpus/cpu nodes dts updates
  ARM: dts: armada-370-xp: cpus/cpu node dts updates
  ARM: dts: at91: cpus/cpu node dts updates
  ARM: dts: exynos5440: cpus/cpu nodes dts updates
  ARM: dts: imx: cpus/cpu nodes dts updates
  ARM: dts: lpc32xx: cpus/cpu nodes dts updates
  ARM: dts: omap: cpus/cpu nodes dts updates
  ARM: dts: picoxcell: cpus/cpu nodes dts updates
  ARM: dts: prima2: cpus/cpu node dts updates
  ARM: dts: pxa2xx: cpus/cpu nodes dts updates
  ARM: dts: r8a7740: cpus/cpu nodes dts updates
  ARM: dts: sh7372: cpus/cpu nodes dts updates
  ARM: dts: spear: cpus/cpu nodes dts updates
  ARM: dts: sunxi: cpus/cpu nodes dts updates
  ARM: DT: kernel: DT cpus/cpu node bindings update

 Documentation/devicetree/bindings/arm/cpus.txt | 457 ++++++++++++++++++++++---
 arch/arm/boot/dts/am33xx.dtsi                  |   4 +
 arch/arm/boot/dts/armada-370-xp.dtsi           |   4 +
 arch/arm/boot/dts/at91rm9200.dtsi              |   6 +-
 arch/arm/boot/dts/at91sam9260.dtsi             |   8 +-
 arch/arm/boot/dts/at91sam9263.dtsi             |   8 +-
 arch/arm/boot/dts/at91sam9g45.dtsi             |   8 +-
 arch/arm/boot/dts/at91sam9n12.dtsi             |   8 +-
 arch/arm/boot/dts/at91sam9x5.dtsi              |   8 +-
 arch/arm/boot/dts/exynos5440.dtsi              |  11 +
 arch/arm/boot/dts/imx23.dtsi                   |   8 +-
 arch/arm/boot/dts/imx28.dtsi                   |   8 +-
 arch/arm/boot/dts/imx6dl.dtsi                  |   2 +
 arch/arm/boot/dts/imx6q.dtsi                   |   1 +
 arch/arm/boot/dts/lpc32xx.dtsi                 |   8 +-
 arch/arm/boot/dts/omap2.dtsi                   |   6 +-
 arch/arm/boot/dts/omap3.dtsi                   |   5 +
 arch/arm/boot/dts/omap4.dtsi                   |   7 +
 arch/arm/boot/dts/omap5.dtsi                   |   7 +
 arch/arm/boot/dts/picoxcell-pc3x2.dtsi         |   8 +-
 arch/arm/boot/dts/picoxcell-pc3x3.dtsi         |   8 +-
 arch/arm/boot/dts/prima2.dtsi                  |   2 +
 arch/arm/boot/dts/pxa2xx.dtsi                  |   7 +-
 arch/arm/boot/dts/r8a7740.dtsi                 |   4 +
 arch/arm/boot/dts/sh7372.dtsi                  |   5 +
 arch/arm/boot/dts/spear13xx.dtsi               |   2 +
 arch/arm/boot/dts/spear3xx.dtsi                |   8 +-
 arch/arm/boot/dts/spear600.dtsi                |   8 +-
 arch/arm/boot/dts/sunxi.dtsi                   |   5 +
 arch/arm/kernel/devtree.c                      |  81 +++--
 30 files changed, 602 insertions(+), 110 deletions(-)

-- 
1.7.12
