From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 15 May 2014 19:32:27 +0200
Subject: [PATCH RFC 0/4] Add support for Exynos clock output configuration
Message-ID: <1400175151-27779-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On all Exynos SoCs there is a dedicated CLKOUT pin that allows many of
internal SoC clocks to be output from the SoC. The hardware structure
of CLKOUT related clocks looks as follows:

	CMU	|---> clock0 --------->	|	PMU	|
		|			|		|
    several	|---> clock1 ---------> |	mux	|
    muxes	|			|	+	|---> CLKOUT
    dividers	|       ...		|	gate	|
    and gates	|			|		|
		|---> clockN ---------> |		|

Since the block responsible for handling the pin is PMU, not CMU,
a separate driver, that binds to PMU node is required and acquires
all input clocks by standard DT clock look-up. This way we don't need
any cross-IP block drivers and cross-driver register sharing or
nodes for fake devices.

To represent the PMU mux/gate clock, generic composite clock is registered.

Tested on Odroid U3, with HSIC/USB hub using CLKOUT as reference clock,
with some additional patches.

Depends on:
[PATCHv4 0/4] Enable usbphy and hsotg for exynos4
(http://thread.gmane.org/gmane.linux.kernel.samsung-soc/30631)
for Exynos4210/4x12 PMU DT nodes.

Tomasz Figa (4):
  clk: samsung: exynos4: Add missing DMC clock hierarchy
  clk: samsung: exynos4: Add CLKOUT clock hierarchy
  clk: samsung: Add driver to control CLKOUT line on Exynos SoCs
  ARM: dts: exynos: Update PMU node with CLKOUT related data

 .../devicetree/bindings/arm/samsung/pmu.txt        |  18 +++
 arch/arm/boot/dts/exynos4210.dtsi                  |  10 ++
 arch/arm/boot/dts/exynos4x12.dtsi                  |   7 +
 arch/arm/boot/dts/exynos5250.dtsi                  |   3 +
 arch/arm/boot/dts/exynos5420.dtsi                  |   3 +
 drivers/clk/samsung/Makefile                       |   1 +
 drivers/clk/samsung/clk-exynos4.c                  | 156 +++++++++++++++++++++
 drivers/clk/samsung/exynos-clkout.c                | 107 ++++++++++++++
 include/dt-bindings/clock/exynos4.h                |   6 +
 9 files changed, 311 insertions(+)
 create mode 100644 drivers/clk/samsung/exynos-clkout.c

-- 
1.9.2
