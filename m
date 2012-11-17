From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 15:22:21 +0100
Subject: [PATCH v2 0/9]  core, cpu and gated clocks for mvebu
Message-ID: <1353162150-522-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset combines code from Gregory Clement, Sebastian
Hesselbarth and myself to implement core clks, cpu clock and gated
clocks on Marvel MVEBU SoCs.

The Armada 370/XP core clock code is a refactored version of the
already submitted and ACKed code from Gregory. It has been made to fit
inside a framework developed by Sebastian which can handle all MVEBU
SoCs. The Armada 370/XP SoCs have more core clocks than the older SoCs, and
the framework needs to handle this. Rather than specify the clock
frequencies in DT, a Sample At Reset register is used, which describes
each core clock frequency.

Armada XP is an SMP processor, with each CPU having its own
clock. Gregories code for this has been taken as is.

The Armada 370/XP clock source has been converted to the common clock
framework.

Dove, Kirkword, and Armada 370/XP have the ability to gate
clocks to various blocks. A clk-gate clock is created for each of the
gateable clocks on Dove and Kirkwood and Armada 370/XP.

This code has been tested on:

Kirkwood based QNAP TS219
Armada 370 based mirabox
Armada XP based OpenBlocks
Dove based Cubox.

v1 -> v2
  Moved some patch hunks into the correct patch
  Added armada_ prefix to a number of symbols
  renamed clk_gate to gate_clk
  renamed *-clock-gating to *-gating-clock
  Add gating-clock implementation for Armada 370/XP
  Add Tested-by from Gregory
  Documented required clock property in armada-370-xp-timer.txt

Andrew Lunn (1):
  ARM: Kirkwood: switch to DT clock providers

Gregory CLEMENT (5):
  clk: mvebu: add armada-370-xp CPU specific clocks
  clk: armada-370-xp: add support for clock framework
  clocksource: convert time-armada-370-xp to clk framework
  clk: mvebu: armada 370/XP add clock gating control provider for DT
  arm: mvebu: armada 370/XP adding clock gating support: dt binding

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
 arch/arm/boot/dts/armada-xp.dtsi                   |   49 ++
 arch/arm/boot/dts/dove.dtsi                        |   20 +
 arch/arm/boot/dts/kirkwood.dtsi                    |   22 +
 arch/arm/mach-dove/Kconfig                         |    2 +
 arch/arm/mach-dove/common.c                        |   64 +-
 arch/arm/mach-kirkwood/Kconfig                     |    2 +
 arch/arm/mach-kirkwood/board-dt.c                  |   72 ++-
 arch/arm/mach-mvebu/Kconfig                        |    4 +
 arch/arm/mach-mvebu/armada-370-xp.c                |    9 +-
 arch/arm/plat-orion/include/plat/common.h          |    1 +
 drivers/clk/Kconfig                                |    2 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/mvebu/Kconfig                          |    8 +
 drivers/clk/mvebu/Makefile                         |    3 +
 drivers/clk/mvebu/clk-core.c                       |  675 ++++++++++++++++++++
 drivers/clk/mvebu/clk-core.h                       |   18 +
 drivers/clk/mvebu/clk-cpu.c                        |  155 +++++
 drivers/clk/mvebu/clk-cpu.h                        |   18 +
 drivers/clk/mvebu/clk-gating-ctrl.c                |  238 +++++++
 drivers/clk/mvebu/clk.c                            |   37 ++
 drivers/clocksource/time-armada-370-xp.c           |   11 +-
 include/linux/clk/mvebu.h                          |   23 +
 30 files changed, 1605 insertions(+), 38 deletions(-)
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
 create mode 100644 drivers/clk/mvebu/clk.c
 create mode 100644 include/linux/clk/mvebu.h

-- 
1.7.10.4
