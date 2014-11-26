From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 26 Nov 2014 15:16:51 +0800
Subject: [PATCH resend v4 0/3] clk: sun6i: Unify AHB1 clock and fix rate
 calculation
Message-ID: <1416986214-4861-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is a resend of v4 of the sun6i AHB1 clock unification series.
This includes only the 3 patches not yet merged.

This series unifies the mux and divider parts of the AHB1 clock found
on sun6i and sun8i, while also adding support for the pre-divider on the
PLL6 input.

The rate calculation logic must factor in which parent it is using to
calculate the rate, to decide whether to use the pre-divider or not.
This is beyond the original factors clk design in sunxi. To avoid
feature bloat, this is implemented as a separate composite clk.

The new clock driver is registered with a separate OF_CLK_DECLARE.
As it shares its register with the APB1 div clock, thus shares the same
spinlock, it cannot reside in a separate file.


The contents of this series are as follows:

Patch 1 adds the unified AHB1 clock driver.

Patch 2 and 3 unify the AHB1 clock nodes on sun6i and sun8i respectively.

Changes since v3:

  - Moved AHB1 clock driver to the front of clk-sunxi.c
  
  - Dropped the following patches that were merged already:

      clk: sunxi: Specify number of child clocks for divs clocks
      clk: sunxi: Implement A31 PLL6 as a divs clock for 2x output
      ARM: sun6i: DT: Add PLL6 multiple outputs

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


Cheers
ChenYu

Chen-Yu Tsai (3):
  clk: sunxi: unify sun6i AHB1 clock with proper PLL6 pre-divider
  ARM: dts: sun6i: Unify ahb1 clock nodes
  ARM: dts: sun8i: Unify ahb1 clock nodes

 Documentation/devicetree/bindings/clock/sunxi.txt |   2 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                  |  14 +-
 arch/arm/boot/dts/sun8i-a23.dtsi                  |  12 +-
 drivers/clk/sunxi/clk-sunxi.c                     | 208 ++++++++++++++++++++++
 4 files changed, 214 insertions(+), 22 deletions(-)

-- 
2.1.3
