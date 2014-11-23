From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 23 Nov 2014 12:33:19 +0800
Subject: [PATCH v4 0/6] clk: sun6i: Unify AHB1 clock and fix rate calculation
Message-ID: <1416717205-15406-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v4 of the sun6i AHB1 clock unification series. This series
unifies the mux and divider parts of the AHB1 clock found on sun6i
and sun8i, while also adding support for the pre-divider on the
PLL6 input.

The rate calculation logic must factor in which parent it is using to
calculate the rate, to decide whether to use the pre-divider or not.
This is beyond the original factors clk design in sunxi. To avoid
feature bloat, this is implemented as a seperate composite clk.

The new clock driver is registered with a separate OF_CLK_DECLARE.
As it shares its register with the APB1 div clock, thus shares the same
spinlock, it cannot reside in a separate file.

This series also fixes up the PLL6 clock. Those patches were merged
and are included for completeness.

Changes since v3:

  - Moved AHB1 clock driver to the front of clk-sunxi.c

Changes since v2:

  - Rebased onto the following patches

    clk: sunxi: Removed unused/incorrect sun6i-a31-apb2-clk driver
    ARM: dts: sunxi: Use sun4i-a10-apb1-clk for sun6i/sun8i apb2 clocks.
    ARM: dts: sunxi: unify APB1 clock
    clk: sunxi: unify APB1 clock
    ARM: dts: sun6i: Re-parent ahb1_mux to pll6 as required by dma controller

  - Dropped

    ARM: dts: sun6i: Add required ahb1 clock parent and rates for dma controller

    as it is superseded by the re-parent patch from above.

  - Expand clock bindings to include output names for PLL6

  - Use of_io_request_and_map

  - Drop ahb1 rate setting in DTS

  - Whitespace and comment style cleanups

Changes since v1:

  - Dropped "clk: sunxi: Add post clk divider for factor clocks"

  - Added "clk: sunxi: Specify number of child clocks for divs clocks"

  - Reworked the PLL6 clock into a divs clock with 2 outputs.
    This matches the style of PLL6 on the other sunxi platforms.

  - Dropped "dmaengine: sun6i: Remove obsolete clk muxing code".
    Already merged.

The contents of this series are as follows:

Patch 1 makes the number of outputs on divs clocks configurable.

Patch 2 changes PLL6 into a divs clock with 2 outputs, 1 the normal PLL6
and 1 at double the clock rate. This patch also fixes rate calculation
error, due to one of the factor values starting from 1, instead of 0.

Patch 3 updates the DT with the new multiple output PLL6.

Patch 4 adds the unified AHB1 clock driver.

Patch 5 and 6 unify the AHB1 clock nodes on sun6i and sun8i respectively.


Cheers
ChenYu

Chen-Yu Tsai (6):
  clk: sunxi: Specify number of child clocks for divs clocks
  clk: sunxi: Implement A31 PLL6 as a divs clock for 2x output
  ARM: sun6i: DT: Add PLL6 multiple outputs
  clk: sunxi: unify sun6i AHB1 clock with proper PLL6 pre-divider
  ARM: dts: sun6i: Unify ahb1 clock nodes
  ARM: dts: sun8i: Unify ahb1 clock nodes

 Documentation/devicetree/bindings/clock/sunxi.txt |  21 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                  |  40 ++--
 arch/arm/boot/dts/sun8i-a23.dtsi                  |  12 +-
 drivers/clk/sunxi/clk-sunxi.c                     | 247 ++++++++++++++++++++--
 4 files changed, 269 insertions(+), 51 deletions(-)

-- 
2.1.3
