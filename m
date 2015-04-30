From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  1 May 2015 00:10:01 +0800
Subject: [PATCH v2 0/5] ARM: sun9i: Add support for PRCM on Allwinner A80 SoC
Message-ID: <1430410206-4410-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v2 of the Allwinner A80 PRCM support series. Thanks to
Allwinner updating their documents, we can now support the essential
parts of the PRCM.

This series adds support for the Power Reset and Clock Management
module on Allwinner's A80 SoC. The PRCM manages clocks and resets
for the "special" block of peripherals, or the R/RTC block in
earlier SoCs, as well as power domain and resets for various parts
of the SoC, such as the 2 processor clusters, the GPU and others.

The special peripherals include a standby processor core, a timer
block, a watchdog, pin controller, 1 wire interface, PS/2 interface,
a UART, the RSB controller, a DMA controller, a consumer IR receiver
block, 2 I2C controllers, and 2 I2S controllers. We do not have
documents for all the peripherals. Support will be added where
possible.

The first 2 patches add drivers for new clocks.

The 3rd patch adds a compatible string and associated list of sub-
devices to the prcm mfd driver.

The 4th patch adds the PRCM device nodes to the A80 dtsi.

The last patch adds some comments regarding the 2 system oscillators.

Changes since v1:

    - Added missing clock gates based on updated documents

    - Added new cpus clock driver based on updated documents

    - Added pll3 clock placeholder

    - Added comments about 24M & 32k oscillators

Regards
ChenYu


Chen-Yu Tsai (5):
  clk: sunxi: sun6i-apb0: Add support for sun9i A80 apbs gates
  clk: sunxi: support the cpus (cpu special) clock on the Allwinner A80
  mfd: sun6i-prcm: Add support for PRCM found on Allwinner A80 SoC
  ARM: dts: sun9i: Add A80 PRCM clocks and reset control nodes
  ARM: dts: sun9i: Add TODO comments for the main and low power clocks

 Documentation/devicetree/bindings/clock/sunxi.txt  |   2 +
 .../devicetree/bindings/mfd/sun6i-prcm.txt         |   3 +-
 arch/arm/boot/dts/sun9i-a80.dtsi                   |  79 ++++++-
 drivers/clk/sunxi/Makefile                         |   2 +-
 drivers/clk/sunxi/clk-sun6i-apb0-gates.c           |   5 +
 drivers/clk/sunxi/clk-sun9i-cpus.c                 | 243 +++++++++++++++++++++
 drivers/mfd/sun6i-prcm.c                           |  58 +++++
 7 files changed, 389 insertions(+), 3 deletions(-)
 create mode 100644 drivers/clk/sunxi/clk-sun9i-cpus.c

-- 
2.1.4
