From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 24 Nov 2015 17:32:11 +0800
Subject: [PATCH v3 0/5] ARM: sun9i: Add Allwinner A80 PRCM clock/reset support
Message-ID: <1448357536-26613-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v3 of the Allwinner A80 PRCM support series. v3 moves away
from the mfd approach, and just lists the various controls directly
under the "clocks" and "soc" nodes.

Changes since v2:

    - Move away from mfd approach and directly list the clock and
      reset controls as first class devices.

    - Use the new clk-simple-gates driver for the apbs clock gates.

    - Update clk code to use struct clk_request.

    - Add 1wire clk node.

    - Use GENMASK and always use shifted bitmasks in cpus clk driver.

Changes since v1:

    - Added missing clock gates based on updated documents

    - Added new cpus clock driver based on updated documents

    - Added pll3 clock placeholder

    - Added comments about 24M & 32k oscillators

The series adds support for the Power Reset and Clock Management
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

Patch 1 adds CLK_OF_DECLARE support for sun8i-a23-apb0-clk driver.
This driver was used with the mfd approach for the A23/A33 PRCM. As
such it is a platform device driver.

Patch 2 adds a new compatible string for the apbs gates to the
clk-simple-gates driver.

Patch 3 adds a new driver for the cpus clock.

Patch 4 adds the various supported clock and reset control device nodes
to the A80 dtsi.

Patch 5 adds some TODO comments regarding the 2 system oscillators.

Regards
ChenYu

Chen-Yu Tsai (5):
  clk: sunxi: Add CLK_OF_DECLARE support for sun8i-a23-apb0-clk driver
  clk: sunxi: Add sun9i A80 apbs gates support
  clk: sunxi: Add sun9i A80 cpus (cpu special) clock support
  ARM: dts: sun9i: Add A80 PRCM clocks and reset control nodes
  ARM: dts: sun9i: Add TODO comments for the main and low power clocks

 Documentation/devicetree/bindings/clock/sunxi.txt |   2 +
 arch/arm/boot/dts/sun9i-a80.dtsi                  |  97 ++++++++-
 drivers/clk/sunxi/Makefile                        |   5 +-
 drivers/clk/sunxi/clk-simple-gates.c              |   2 +
 drivers/clk/sunxi/clk-sun8i-apb0.c                |  43 ++++
 drivers/clk/sunxi/clk-sun9i-cpus.c                | 240 ++++++++++++++++++++++
 6 files changed, 386 insertions(+), 3 deletions(-)
 create mode 100644 drivers/clk/sunxi/clk-sun9i-cpus.c

-- 
2.6.2
