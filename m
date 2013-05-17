From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 17 May 2013 16:20:43 +0100
Subject: [RFC PATCH v4 00/18] ARM: DT cpu bindings updates
Message-ID: <1368804061-4421-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is an update of a previous posting:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/165219.html

v4 changes:

- Replaced WARN* with pr_warn
- Removed tmp_map in arm_dt_init_cpu_maps()
- Rebased against 3.10-rc1
- Patched additional atmel and sunxi dts files
- Removed BUG_ON on !bootcpu_valid, now flagged up as an error
- Added code to reset invalid entries in cpu_logical_map after DT parsing

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

Patch #1-#2 of this series are fixes and are included to have a clean patch
series and should get reviewed and merged separately.

Patch #3-18, along with some kernel fixes related to DT parsing function,
update the cpu node bindings and in kernel dts files to cope with legacy,
current and upcoming ARM systems.

In-kernel device tree source files are updated to comply with the latest
specification, so thorough testing is required in order to validate all
changes on all affected ARM systems, in particular systems with exotic
MPIDR configurations that are likely to break with the changes provided.

Code relying on the reg property size to be 4-bytes must be updated so that
dtbs compiled for 64-bit kernels can also be used to boot a 32-bit system.

Lorenzo Pieralisi (18):
  ARM: kernel: fix arm_dt_init_cpu_maps() to skip non-cpu nodes
  ARM: kernel: fix __cpu_logical_map default initialization
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

 Documentation/devicetree/bindings/arm/cpus.txt | 459 ++++++++++++++++++++++---
 arch/arm/boot/dts/am33xx.dtsi                  |   4 +
 arch/arm/boot/dts/armada-370-xp.dtsi           |   4 +
 arch/arm/boot/dts/at91rm9200.dtsi              |   6 +-
 arch/arm/boot/dts/at91sam9260.dtsi             |   8 +-
 arch/arm/boot/dts/at91sam9263.dtsi             |   8 +-
 arch/arm/boot/dts/at91sam9g45.dtsi             |   8 +-
 arch/arm/boot/dts/at91sam9n12.dtsi             |   8 +-
 arch/arm/boot/dts/at91sam9x5.dtsi              |   8 +-
 arch/arm/boot/dts/exynos5440.dtsi              |   4 +
 arch/arm/boot/dts/imx23.dtsi                   |   8 +-
 arch/arm/boot/dts/imx28.dtsi                   |   8 +-
 arch/arm/boot/dts/imx6dl.dtsi                  |   2 +
 arch/arm/boot/dts/imx6q.dtsi                   |   4 +
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
 arch/arm/boot/dts/sama5d3.dtsi                 |   2 +
 arch/arm/boot/dts/sh7372.dtsi                  |   5 +
 arch/arm/boot/dts/spear13xx.dtsi               |   2 +
 arch/arm/boot/dts/spear3xx.dtsi                |   8 +-
 arch/arm/boot/dts/spear600.dtsi                |   8 +-
 arch/arm/boot/dts/sun4i-a10.dtsi               |   2 +
 arch/arm/boot/dts/sun5i-a13.dtsi               |   2 +
 arch/arm/include/asm/cputype.h                 |   2 +
 arch/arm/include/asm/smp_plat.h                |   2 +-
 arch/arm/kernel/devtree.c                      | 149 ++++----
 arch/arm/kernel/setup.c                        |   2 +-
 35 files changed, 646 insertions(+), 139 deletions(-)

-- 
1.8.2.2
