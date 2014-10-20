From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 20 Oct 2014 22:10:25 +0800
Subject: [PATCH v2 0/5] clk: sunxi: Add peripheral bus clock support for A80
Message-ID: <1413814230-13735-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series adds support for the basic bus (AHB/APB) clocks used by
peripherals on the A80 SoC. This series is based on my previous A80
bringup series.

The A80 has 5 peripheral related bus clocks, 1 data bus clock, and 1
CCI bus clock. 2 out of 12 PLLs are used to clock these.

Patch 1 adds support for configurable mux masks in sunxi factors clocks.
This was previously hardcoded to a width of 2 bits, or a 0x3 mask.

Patch 2 adds support for the clocks mentioned above.

Patch 3 adds support for the bus gate clocks for the peripheral modules.

Patch 4 selects ARCH_HAS_RESET_CONTROLLER and RESET_CONTROLLER when building
for sun9i so the user does not forget to enable reset controller support.
This was already queued for 3.19, but is included for completeness.

Patch 5 adds the clocks and reset controls to the dtsi.

CPU and specific purpose (audio/video/gpu) PLLs have been left out.
These can be added as the need comes. CPU PLLs (PLL1/2) should probably be
added along with cpufreq support.

Changes since v1:

  - Use round_up / DIV_ROUND_UP in get_pll4_factors


Cheers
ChenYu


Chen-Yu Tsai (5):
  clk: sunxi: make factors clock mux mask configurable
  clk: sunxi: Add support for A80 basic bus clocks
  clk: sunxi: Add support for bus clock gates on Allwinner A80 SoC
  ARM: sunxi: Select ARCH_HAS_RESET_CONTROLLER and RESET_CONTROLLER for
    sun9i
  ARM: dts: sun9i: Add basic clocks and reset controls

 Documentation/devicetree/bindings/clock/sunxi.txt |  10 +
 arch/arm/boot/dts/sun9i-a80.dtsi                  | 177 +++++++++++++-
 arch/arm/mach-sunxi/Kconfig                       |   2 +
 drivers/clk/sunxi/Makefile                        |   1 +
 drivers/clk/sunxi/clk-factors.c                   |   2 +-
 drivers/clk/sunxi/clk-factors.h                   |   3 +-
 drivers/clk/sunxi/clk-mod0.c                      |   1 +
 drivers/clk/sunxi/clk-sun8i-mbus.c                |   1 +
 drivers/clk/sunxi/clk-sun9i-core.c                | 272 ++++++++++++++++++++++
 drivers/clk/sunxi/clk-sunxi.c                     |  32 +++
 10 files changed, 492 insertions(+), 9 deletions(-)
 create mode 100644 drivers/clk/sunxi/clk-sun9i-core.c

-- 
2.1.1
