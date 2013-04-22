From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 22 Apr 2013 16:27:22 +0100
Subject: [RFC PATCH v2 00/13] ARM: DT cpu bindings updates
Message-ID: <1366644455-16550-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is an update of a previous posting:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/163310.html

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

Patch #2-13, along with some kernel fixes related to DT parsing function,
update the cpu node bindings and in kernel dts files to cope with legacy,
current and upcoming ARM systems.

In-kernel device tree source files are updated to comply with the latest
specification, so thorough testing is required in order to validate all
changes on all affected ARM systems, in particular systems with exotic
MPIDR configurations that are likely to break with the changes provided.

Code relying on the reg property size to be 4-bytes will break when
dtb compiled for 64-bit kernels are used to boot a 32-bit system so
kernel code relying on that (bogus) assumption must be updated properly.

Lorenzo Pieralisi (13):
  ARM: DT: kernel: move temporary cpu map stack array to static data
  ARM: mach-mv78xx0: cpus/cpu node dts updates
  ARM: mach-at91: cpus/cpu node dts updates
  ARM: mach-exynos: cpus/cpu nodes dts updates
  ARM: mach-imx: cpus/cpu nodes dts updates
  ARM: mach-lpc32xx: cpus/cpu nodes dts updates
  ARM: mach-omap2: cpus/cpu nodes dts updates
  ARM: mach-picoxcell: cpus/cpu nodes dts updates
  ARM: mach-shmobile: cpus/cpu nodes dts updates
  ARM: mach-spear: cpus/cpu nodes dts updates
  ARM: mach-sunxi: cpus/cpu nodes dts updates
  ARM: mach-vt8500: cpus/cpu nodes dts updates
  ARM: DT: kernel: DT cpu node bindings update

 Documentation/devicetree/bindings/arm/cpus.txt | 378 ++++++++++++++++++++++---
 arch/arm/boot/dts/armada-370-xp.dtsi           |   1 +
 arch/arm/boot/dts/at91sam9260.dtsi             |   2 +-
 arch/arm/boot/dts/at91sam9263.dtsi             |   2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi             |   2 +-
 arch/arm/boot/dts/at91sam9n12.dtsi             |   2 +-
 arch/arm/boot/dts/exynos5440.dtsi              |   7 +
 arch/arm/boot/dts/imx23.dtsi                   |   2 +-
 arch/arm/boot/dts/imx28.dtsi                   |   2 +-
 arch/arm/boot/dts/lpc32xx.dtsi                 |   2 +-
 arch/arm/boot/dts/omap3.dtsi                   |   4 +
 arch/arm/boot/dts/omap4.dtsi                   |   5 +
 arch/arm/boot/dts/omap5.dtsi                   |   5 +
 arch/arm/boot/dts/picoxcell-pc3x2.dtsi         |   2 +-
 arch/arm/boot/dts/picoxcell-pc3x3.dtsi         |   2 +-
 arch/arm/boot/dts/r8a7740.dtsi                 |   3 +
 arch/arm/boot/dts/sh7372.dtsi                  |   4 +
 arch/arm/boot/dts/spear3xx.dtsi                |   2 +-
 arch/arm/boot/dts/spear600.dtsi                |   2 +-
 arch/arm/boot/dts/sunxi.dtsi                   |   4 +
 arch/arm/boot/dts/wm8505.dtsi                  |   2 +-
 arch/arm/kernel/devtree.c                      |  85 ++++--
 22 files changed, 431 insertions(+), 89 deletions(-)

-- 
1.7.12
