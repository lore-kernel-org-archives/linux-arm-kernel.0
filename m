From: mylene.josserand@bootlin.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Mon, 19 Feb 2018 09:18:30 +0100
Subject: [PATCH v3 0/7] Add SMP support on sun8i-a83t
Message-ID: <20180219081837.15482-1-mylene.josserand@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

This is a V3 of my series that adds SMP support for Allwinner sun8i-a83t.
Based on sunxi's tree, sunxi/for-next branch.

Changes since v2:
    - Rebased my modifications according to new Chen-Yu Tsai's patch series
    that adds SMP support for sun9i-a80 (without MCPM).
    - Split the device-tree patches into 3 patches for CPUCFG, R_CPUCFG
    and PRCM registers.
    - The hotplug of CPU0 is currently not working (even after trying what
    Allwinner's code is doing) so remove the possibility of disabling
    this CPU. Created a new patch for it.

Changes since v1:
    - Add Chen Yu's patch in my series (see path 01)
    - Add new compatibles for prcm and cpucfg registers for sun8i-a83t.
    Create two functions to separate the DT parsing of sun9i-a80 and
    sun8i-a83t.
    - Thanks to Maxime's review: order device tree's nodes according
    to physical addresses, remove unused label and fix registers' sizes.
    Update the commit log and commit title of my last patch (see
    patch 05).

Patch 01: Convert the sunxi SMP driver to add support for A83T.
This SoC has a bit flip that needs to be handled.
Patch 02-03-04: Add registers nodes (prcm, cpucfg and r_cpucfg) needed
for SMP bringup.
Patch 05: Add CCI-400 node for a83t.
Patch 06: Fix the use of virtual timers that hangs the kernel in
case of SMP support.
Patch 07: Remove the possibility to disable the CPU0 because it is
currently not working for sun8i-a83t.

If you have any remarks/questions, let me know.
Thank you in advance,
Myl?ne

Myl?ne Josserand (7):
  ARM: sun8i: smp: Add support for A83T
  ARM: dts: sun8i: Add CPUCFG device node for A83T dtsi
  ARM: dts: sun8i: Add PRCM device node for the A83T dtsi
  ARM: dts: sun8i: Add R_CPUCFG device node for the A83T dtsi
  arm: dts: sun8i: a83t: Add CCI-400 node
  arm: dts: sun8i: a83t: Fix undefined offset with virtual timer
  ARM: sun8i: smp: Remove the disabling of CPU0

 arch/arm/boot/dts/sun8i-a83t.dtsi |  57 +++++++++
 arch/arm/mach-sunxi/Kconfig       |   2 +-
 arch/arm/mach-sunxi/mc_smp.c      | 245 +++++++++++++++++++++++++++++++-------
 3 files changed, 260 insertions(+), 44 deletions(-)

-- 
2.11.0
