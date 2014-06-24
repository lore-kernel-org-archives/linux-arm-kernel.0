From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 24 Jun 2014 18:08:23 +0200
Subject: [PATCH v2 0/4] Add support for Exynos clock output configuration
Message-ID: <1403626107-12073-1-git-send-email-t.figa@samsung.com>
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

Changes since v1:
(http://www.spinics.net/lists/arm-kernel/msg333276.html)
 - rebased onto next-20140624,
 - fixed #clock-cells values in exynos5250.dtsi and exynos5420.dtsi,
 - temporarily removed ISP CLKOUT clocks on Exynos4x12, until ISP clock
   domain handling gets fixed in Exynos4 clock driver.
Changes since RFC v1:
(https://lkml.org/lkml/2014/5/15/506)
 - rebased onto v5 of "Enable usbphy and hsotg for exynos4" series and
   current HEAD of samsung-clk tree,
 - added handling of suspend/resume in the driver,
 - added missing CPU clocks on Exynos4,
 - added CLK_SET_RATE_PARENT to CMU CLKOUT gates on Exynos4,
 - fixed bit field width on Exynos4,
 - added CLKOUT CMU registers of Exynos4 to save/restore list,
 - added CLK_SET_RATE_PARENT and CLK_SET_RATE_NO_REPARENT to clkout clock,
 - changed the binding to use 1-cell clock specifier to allow extension
   with further PMU clocks in future, if needed.

Tomasz Figa (4):
  clk: samsung: exynos4: Add missing CPU/DMC clock hierarchy
  clk: samsung: exynos4: Add CLKOUT clock hierarchy
  clk: samsung: Add driver to control CLKOUT line on Exynos SoCs
  ARM: dts: exynos: Update PMU node with CLKOUT related data

 .../devicetree/bindings/arm/samsung/pmu.txt        |  30 ++++
 arch/arm/boot/dts/exynos4210.dtsi                  |  10 ++
 arch/arm/boot/dts/exynos4x12.dtsi                  |   7 +
 arch/arm/boot/dts/exynos5250.dtsi                  |   3 +
 arch/arm/boot/dts/exynos5420.dtsi                  |   3 +
 drivers/clk/samsung/Makefile                       |   1 +
 drivers/clk/samsung/clk-exynos-clkout.c            | 153 +++++++++++++++++++
 drivers/clk/samsung/clk-exynos4.c                  | 166 ++++++++++++++++++++-
 include/dt-bindings/clock/exynos4.h                |   5 +
 9 files changed, 374 insertions(+), 4 deletions(-)
 create mode 100644 drivers/clk/samsung/clk-exynos-clkout.c

-- 
1.9.3
