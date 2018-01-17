From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 17 Jan 2018 16:46:46 +0800
Subject: [PATCH v4 0/8] ARM: sun9i: SMP and CPU hotplug support
Message-ID: <20180117084654.8234-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v4 of my sun9i SMP/hotplug support series which was started
over two years ago [1]. We've tried to implement PSCI for both the A80
and A83T. Results were not promising. The issue is that these two chips
have a broken security extensions implementation. If a specific bit is
not burned in its e-fuse, most if not all security protections don't
work [2]. Even worse, non-secure access to the GIC become secure. This
requires a crazy workaround in the GIC driver which probably doesn't work
in all cases [3].

Version 3 completely did away with the MCPM framework, instead just
implementing a set of smp_ops. Most of the code from the previous
version was reused, so the structure still has some traces of MCPM.
As our hardware has CCI-400, we still need some sort of MMU/cache
disabled trampoline code to enable cache coherency. Code for this
was adapted from the MCPM framework. This and the entry code are done
in inline assembly. Most of the other sunxi-specific code is derived
from Allwinner code and documentation, with some references to the
other MCPM implementations, as well as the Cortex's Technical Reference
Manuals for the power sequencing stuff.

In version 4, all traces of MCPM have been removed, except in the
comments for atttributing code sources. Thumb2 mode is also fixed.
It failed due to an unaligned word access.

Hope we can get this version merged. A83T SMP support will be built on
it.

Regards
ChenYu

Changes since v3:
  - Renamed all "MCPM" occurrences to "MC_SMP", as the MCPM framework
    is no longer used
  - Thumb2 mode fixed

Changes since v2:
  - Do away with the MCPM framework, directly implement smp_ops
  - Some debug messages were clarified
  - New ARCH_SUNXI_MCPM Kconfig symbol for this feature

Changes since v1:

  - Leading zeroes for device node addresses removed
  - Added device tree binding for SMP SRAM
  - Simplified Kconfig options
  - Switched to SPDX license identifier
  - Map CPU to device tree node and check compatible to see if it's
    Cortex-A15 or Cortex-A7
  - Fix incorrect CPUCFG cluster status macro that prevented cluster
    0 L2 cache WFI detection
  - Fixed reversed bit for turning off cluster
  - Put cluster in reset before turning off power (or it hangs)
  - Added dedicated workqueue for turning off power to cpus and clusters
  - Request CPUCFG and SRAM MMIO ranges
  - Some comments fixed or added
  - Some debug messages added

[1] http://www.spinics.net/lists/arm-kernel/msg418350.html
[2] https://lists.denx.de/pipermail/u-boot/2017-June/294637.html
[3] https://github.com/wens/linux/commit/c48654c1f737116e7a7660183c8c74fa91970528

Chen-Yu Tsai (8):
  ARM: sun9i: Support SMP bring-up on A80
  ARM: dts: sun9i: Add CCI-400 device nodes for A80
  ARM: dts: sun9i: Add CPUCFG device node for A80 dtsi
  ARM: dts: sun9i: Add PRCM device node for the A80 dtsi
  ARM: sun9i: smp: Support CPU/cluster power down and hotplugging for
    cpu1~7
  dt-bindings: ARM: sunxi: Document A80 SoC secure SRAM usage by SMP
    hotplug
  ARM: sun9i: smp: Support cpu0 hotplug
  ARM: dts: sun9i: Add secure SRAM node used for SMP hotplug

 .../devicetree/bindings/arm/sunxi/smp-sram.txt     |  44 ++
 arch/arm/boot/dts/sun9i-a80.dtsi                   |  75 ++
 arch/arm/mach-sunxi/Kconfig                        |   7 +
 arch/arm/mach-sunxi/Makefile                       |   1 +
 arch/arm/mach-sunxi/mc_smp.c                       | 791 +++++++++++++++++++++
 5 files changed, 918 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/sunxi/smp-sram.txt
 create mode 100644 arch/arm/mach-sunxi/mc_smp.c

-- 
2.15.1
