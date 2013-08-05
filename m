From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 5 Aug 2013 12:12:19 -0400
Subject: [PATCH 0/8] clk: keystone: Add common clock drivers and PM bus
Message-ID: <1375719147-7578-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Series is an attempt to add the clock drivers for Keystone SOCs
based on common clock framework. A PLL drivers taking care of
SOC PLLs and a gate control driver taking clock management for
the IPs. The current Keystone based SOCs don' support dynamic power
management usecases like DVFS, SOC ilde etc and hence most of the
usage is limited to enabling clocks and finding the current clock
rate etc. Future SOCs will start supporting some of these dynamic
power saving features.

The series also contains the PM Bus driver which makes use of
pm_clk infrastructure of the PM core. This SOC doesn't need
the clocks to be enabled very early in the boot and hence the
clock initialsation is left to the subsystem_init() level. The
series is cooked up based on downstream work done by Murali K
but I ended up mostly rewriting it.

Based on to of Mike's dt binding series [1] and tested on Keystone2
EVM with I2C, UART and SPI driver enabled in the build.

Santosh Shilimkar (8):
  clk: keystone: add Keystone PLL clock driver
  clk: keystone: Add gate control clock driver
  clk: keystone: common clk driver initialization
  clk: keystone: Build Keystone clock drivers
  ARM: dts: keystone: Add clock tree data to devicetree
  ARM: dts: keystone: Add clock phandle to UART nodes
  ARM: keystone: Enable and initialise clock drivers
  ARM: keystone: add PM bus support for clock management

 .../devicetree/bindings/clock/keystone-gate.txt    |   30 +
 .../devicetree/bindings/clock/keystone-pll.txt     |   36 +
 arch/arm/boot/dts/keystone-clocks.dtsi             |  824 ++++++++++++++++++++
 arch/arm/boot/dts/keystone.dts                     |    4 +
 arch/arm/mach-keystone/Kconfig                     |    1 +
 drivers/bus/Makefile                               |    2 +
 drivers/bus/keystone_pm_bus.c                      |   68 ++
 drivers/clk/Kconfig                                |    7 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/keystone/Makefile                      |    1 +
 drivers/clk/keystone/clk.c                         |   34 +
 drivers/clk/keystone/gate.c                        |  306 ++++++++
 drivers/clk/keystone/pll.c                         |  197 +++++
 include/linux/clk/keystone.h                       |   20 +
 14 files changed, 1531 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/keystone-gate.txt
 create mode 100644 Documentation/devicetree/bindings/clock/keystone-pll.txt
 create mode 100644 arch/arm/boot/dts/keystone-clocks.dtsi
 create mode 100644 drivers/bus/keystone_pm_bus.c
 create mode 100644 drivers/clk/keystone/Makefile
 create mode 100644 drivers/clk/keystone/clk.c
 create mode 100644 drivers/clk/keystone/gate.c
 create mode 100644 drivers/clk/keystone/pll.c
 create mode 100644 include/linux/clk/keystone.h

Regards,
Santosh
[1] https://lkml.org/lkml/2013/6/21/35
-- 
1.7.9.5
