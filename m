From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  4 Jan 2018 22:37:46 +0800
Subject: [PATCH v2 0/8] ARM: sun9i: SMP support with Multi-Cluster Power
 Management
Message-ID: <20180104143754.2425-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v2 of my sun9i SMP support with MCPM series which was started
over two years ago [1]. We've tried to implement PSCI for both the A80
and A83T. Results were not promising. The issue is that these two chips
have a broken security extensions implementation. If a specific bit is
not burned in its e-fuse, most if not all security protections don't
work [2]. Even worse, non-secure access to the GIC become secure. This
requires a crazy workaround in the GIC driver which probably doesn't work
in all cases [3].

Nicolas mentioned that the MCPM framework is likely overkill in our
case [4]. However the framework does provide cluster/core state tracking
and proper sequencing of cache related operations. We could rework
the code to use standard smp_ops, but I would like to actually get
a working version in first.

Much of the sunxi-specific MCPM code is derived from Allwinner code and
documentation, with some references to the other MCPM implementations,
as well as the Cortex's Technical Reference Manuals for the power
sequencing info.

One major difference compared to other platforms is we currently do not
have a standalone PMU or other embedded firmware to do the actually power
sequencing. All power/reset control is done by the kernel. Nicolas
mentioned that a new optional callback should be added in cases where the
kernel has to do the actual power down [5]. For now however I'm using a
dedicated single thread workqueue. CPU and cluster power off work is
queued from the .{cpu,cluster}_powerdown_prepare callbacks. This solution
is somewhat heavy, as I have a total of 10 static work structs. It might
also be a bit racy, as nothing prevents the system from bringing a core
back before the asynchronous work shuts it down. This would likely
happen under a heavily loaded system with a scheduler that brings cores
in and out of the system frequently. In simple use-cases it performs OK.

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
[4] http://www.spinics.net/lists/arm-kernel/msg434160.html
[5] http://www.spinics.net/lists/arm-kernel/msg434408.html

Chen-Yu Tsai (8):
  ARM: sun9i: Support SMP on A80 with Multi-Cluster Power Management
    (MCPM)
  ARM: dts: sun9i: Add CCI-400 device nodes for A80
  ARM: dts: sun9i: Add CPUCFG device node for A80 dtsi
  ARM: dts: sun9i: Add PRCM device node for the A80 dtsi
  ARM: sun9i: mcpm: Support CPU/cluster power down and hotplugging for
    cpu1~7
  dt-bindings: ARM: sunxi: Document A80 SoC secure SRAM usage by SMP
    hotplug
  ARM: sun9i: mcpm: Support cpu0 hotplug
  ARM: dts: sun9i: Add secure SRAM node used for MCPM SMP hotplug

 .../devicetree/bindings/arm/sunxi/smp-sram.txt     |  44 ++
 arch/arm/boot/dts/sun9i-a80.dtsi                   |  75 +++
 arch/arm/mach-sunxi/Kconfig                        |   2 +
 arch/arm/mach-sunxi/Makefile                       |   1 +
 arch/arm/mach-sunxi/mcpm.c                         | 633 +++++++++++++++++++++
 5 files changed, 755 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/sunxi/smp-sram.txt
 create mode 100644 arch/arm/mach-sunxi/mcpm.c

-- 
2.15.1
