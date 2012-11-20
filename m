From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 15:31:08 +0100
Subject: [GIT PULL v3] core, cpu and gated clocks for mvebu
Message-ID: <1353421876-13759-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike, Jason,

Mike, this should hopefully be the final version of the clk
patches. We would therefore need your comments on it, or if everything
goes well, your formal Acked-by. We would however like to carry those
patches through the Marvell maintainers tree, as we have many other
patches that depend on the clk support.

Jason, if Mike is OK with those patches, then this pull request should
replace the current clk patches you have in your tree.

This patchset combines code from Gregory Clement, Sebastian
Hesselbarth, Andrew Lunn and several fixes from me to implement core
clks, cpu clock and gated clocks on Marvel MVEBU SoCs.

The Armada 370/XP core clock code is a refactored version of the
already submitted and ACKed code from Gregory. It has been made to fit
inside a framework developed by Sebastian which can handle all MVEBU
SoCs. The Armada 370/XP SoCs have more core clocks than the older SoCs, and
the framework needs to handle this. Rather than specify the clock
frequencies in DT, a Sample At Reset register is used, which describes
each core clock frequency.

Armada XP is an SMP processor, with each CPU having its own
clock. Gregory's code for this has been taken as is.

The Armada 370/XP clock source has been converted to the common clock
framework.

Dove, Kirkword, and Armada 370/XP have the ability to gate
clocks to various blocks. A clk-gate clock is created for each of the
gateable clocks on Dove and Kirkwood and Armada 370/XP.

Here is a summary of what the different patches are doing:

 * Patch 1 introduces a clk-core clock driver, that works for all
   MVEBU SoCs. It determines the core clock frequency by reading a
   Sample-at-Reset register, and provides a few core fixed-rate core
   clocks based on those values.

 * Patch 2 introduces a clk-cpu clock driver, which is specific to the
   multi-core Armada XP SoCs. This driver allows to control the
   individiual clock of each CPU.

 * Patch 3 introduces a clk-gating-ctrl driver, which allows to control
   the gatable clocks available on MVEBU SoCs. This patch only
   introduces support for the Dove and Kirkwood SoCs.

 * Patch 4 is an extension of the clk-gating-ctrl driver to support
   the Armada 370 and Armada XP SoCs.

 * Patch 5 integrates the clk framework into Marvell Armada 370/XP by
   adding the needed information in the SoC Device Tree, as well as
   selecting the appropriate Kconfig options.

 * Patch 6 converts the Armada 370/XP clock source driver to use the
   clk framework.

 * Patch 7 integrates the clk framework into Marvell Dove by adding
   the needed information in the SoC Device Tree, as well as selecting
   the appropriate Kconfig options.

 * Patch 8 integrates the clk framework into Marvell Kirkwood by
   adding the needed information in the SoC Device Tree, as well as
   selecting the appropriate Kconfig options.

This code has been tested on:

Kirkwood based evaluation board
Armada 370 based evaluation board
Armada XP based evaluation board

v2 -> v3

  Fix the gating clock driver registration so that it also gets
  registered on Armada 370/XP.

  Refactor a bit the clk-cpu driver by moving the compatible strings
  list into the driver itself, making it more consistent with clk-core
  and clk-gating-ctrl.

  Rename the compatible strings of the clk-core and clk-cpu drivers in
  order to have consistency between all drivers: they all expose a
  '<something>-clock' DT compatible string.

  Rename mvebu_clk_gating_init() to mvebu_gating_clk_init() for
  consistency.

  Fix the clk-cpu driver so that it registers only the clocks for the
  CPUs described in the Device Tree. The Armada XP has 1 core, 2 cores
  and 4 cores variants, and therefore the driver must take this into
  account. The Device Tree data have also been adapted accordingly.

  On Armada XP, ensure that the sata and satalnk gatable clocks have a
  parent->child relationship to make sure that they both get enabled
  when the SATA driver claims the sata clock.

  On Armada 370, mark the gatable 'ddr' clock with the
  CLK_IGNORE_UNUSED flag to ensure that this clock doesn't get
  disabled even if no driver is claiming it.

  The patch set has also been slightly re-organized (order of patches,
  old PATCH 8/9 has been squashed into PATCH 5/8).

v1 -> v2
  Moved some patch hunks into the correct patch
  Added armada_ prefix to a number of symbols
  renamed clk_gate to gate_clk
  renamed *-clock-gating to *-gating-clock
  Add gating-clock implementation for Armada 370/XP
  Add Tested-by from Gregory
  Documented required clock property in armada-370-xp-timer.txt

The following changes since commit f4a75d2eb7b1e2206094b901be09adb31ba63681:

  Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)

are available in the git repository at:

  git at github.com:MISL-EBU-System-SW/mainline-public.git tags/marvell-mvebu-clk-3.8

for you to fetch changes up to 1611f872513735ac7105535689c0dd668fbf1c04:

  ARM: Kirkwood: switch to DT clock providers (2012-11-20 14:46:50 +0100)

----------------------------------------------------------------
Marvell MVEBU clk support, for 3.8

----------------------------------------------------------------
Andrew Lunn (1):
      ARM: Kirkwood: switch to DT clock providers

Gregory CLEMENT (4):
      clk: mvebu: add armada-370-xp CPU specific clocks
      clk: mvebu: armada 370/XP add clock gating control provider for DT
      clk: armada-370-xp: add support for clock framework
      clocksource: convert time-armada-370-xp to clk framework

Sebastian Hesselbarth (3):
      clk: mvebu: add mvebu core clocks.
      clk: mvebu: add clock gating control provider for DT
      ARM: dove: switch to DT clock providers

 .../bindings/arm/armada-370-xp-timer.txt           |    1 +
 .../devicetree/bindings/clock/mvebu-core-clock.txt |   47 ++
 .../devicetree/bindings/clock/mvebu-cpu-clock.txt  |   21 +
 .../bindings/clock/mvebu-gated-clock.txt           |  119 ++++
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/armada-370-db.dts                |    4 -
 arch/arm/boot/dts/armada-370-xp.dtsi               |    1 +
 arch/arm/boot/dts/armada-370.dtsi                  |   15 +
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |   12 +
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |   19 +
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |   34 +
 arch/arm/boot/dts/armada-xp.dtsi                   |   20 +
 arch/arm/boot/dts/dove.dtsi                        |   20 +
 arch/arm/boot/dts/kirkwood.dtsi                    |   22 +
 arch/arm/mach-dove/Kconfig                         |    2 +
 arch/arm/mach-dove/common.c                        |   63 +-
 arch/arm/mach-kirkwood/Kconfig                     |    2 +
 arch/arm/mach-kirkwood/board-dt.c                  |   71 +-
 arch/arm/mach-mvebu/Kconfig                        |    4 +
 arch/arm/mach-mvebu/armada-370-xp.c                |    9 +-
 arch/arm/plat-orion/include/plat/common.h          |    1 +
 drivers/clk/Kconfig                                |    2 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/mvebu/Kconfig                          |    8 +
 drivers/clk/mvebu/Makefile                         |    3 +
 drivers/clk/mvebu/clk-core.c                       |  675 ++++++++++++++++++++
 drivers/clk/mvebu/clk-core.h                       |   18 +
 drivers/clk/mvebu/clk-cpu.c                        |  186 ++++++
 drivers/clk/mvebu/clk-cpu.h                        |   22 +
 drivers/clk/mvebu/clk-gating-ctrl.c                |  249 ++++++++
 drivers/clk/mvebu/clk-gating-ctrl.h                |   22 +
 drivers/clk/mvebu/clk.c                            |   27 +
 drivers/clocksource/time-armada-370-xp.c           |   11 +-
 include/linux/clk/mvebu.h                          |   22 +
 34 files changed, 1696 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
 create mode 100644 drivers/clk/mvebu/Kconfig
 create mode 100644 drivers/clk/mvebu/Makefile
 create mode 100644 drivers/clk/mvebu/clk-core.c
 create mode 100644 drivers/clk/mvebu/clk-core.h
 create mode 100644 drivers/clk/mvebu/clk-cpu.c
 create mode 100644 drivers/clk/mvebu/clk-cpu.h
 create mode 100644 drivers/clk/mvebu/clk-gating-ctrl.c
 create mode 100644 drivers/clk/mvebu/clk-gating-ctrl.h
 create mode 100644 drivers/clk/mvebu/clk.c
 create mode 100644 include/linux/clk/mvebu.h
