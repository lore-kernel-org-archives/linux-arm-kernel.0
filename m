From: wens@csie.org (Chen-Yu Tsai)
Date: Sat,  6 Sep 2014 18:47:21 +0800
Subject: [PATCH 0/7] clk: sun6i: Unify AHB1 clock and fix rate calculation
Message-ID: <1410000448-9999-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series unifies the mux and divider parts of the AHB1 clock found
on sun6i and sun8i, while also adding support for the pre-divider on
the PLL6 input.

The rate calculation logic must factor in which parent it is using to
calculate the rate, to decide whether to use the pre-divider or not.
This is beyond the original factors clk design in sunxi. To avoid
feature bloat, this is implemented as a seperate composite clk.

The new clock driver is registered with a separate OF_CLK_DECLARE.
This is done so that assigned-clocks* properties on the clk provider
node can actually work. The clock framework arranges the clock setup
order by checking whether all clock parents are available, by checking
the node matching OF_CLK_DECLARE.

However, the sunxi clk driver is based on the root node compatible,
has no defined dependencies (parents), and is setup before the fixed-rate
clocks. Thus when the ahb1 clock is added, all parents have rate = 0.
There is no way to calculate the required clock factors to set a default
clock rate under these circumstances. This happens when we set the
defaults in the clock node (provider), rather than a clock consumer.

I can think of 2 ways to solve the dependency issue, but neither is
pretty. One would be to move the root fixed-rate clocks into the sunxi
clk driver. The other would be separating all the clocks into individual
OF_CLK_DECLARE statements, which adds a lot of boilerplate code.


The contents of this series are as follows:

Patch 1 adds support for a fixed divider on the output of factor clocks,
which is used by the next patch.

Patch 2 fixes PLL6 rate calculation error, due to one of the factor values
starting from 1, instead of 0. It also adds the /2 divider on the output.

Patch 3 adds the unified AHB1 clock driver.

Patch 4 and 5 unify the AHB1 clock nodes on sun6i and sun8i respectively.

Patch 6 sets the default parent and clock rate for AHB1, as required by
the DMA controller. Curiously I did not require this when I tried dmatest
on my A31 Hummingbird.

Patch 7 removes the clk_set_parent calls from the sun6i-dma driver, as
it no longer works, and is replaced by the previous patch.


Suggestions are more than welcome.


Cheers
ChenYu


Chen-Yu Tsai (7):
  clk: sunxi: Add post clk divider for factor clocks
  clk: sunxi: Fix PLL6 calculation on sun6i
  clk: sunxi: unify sun6i AHB1 clock with proper PLL6 pre-divider
  ARM: dts: sun8i: Unify ahb1 clock nodes
  ARM: dts: sun6i: Unify ahb1 clock nodes
  ARM: dts: sun6i: Add required ahb1 clock parent and rates for dma
    controller
  dmaengine: sun6i: Remove obsolete clk muxing code

 Documentation/devicetree/bindings/clock/sunxi.txt |   2 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                  |  17 +-
 arch/arm/boot/dts/sun8i-a23.dtsi                  |  12 +-
 drivers/clk/sunxi/clk-factors.c                   |   3 +
 drivers/clk/sunxi/clk-factors.h                   |   1 +
 drivers/clk/sunxi/clk-sunxi.c                     | 215 +++++++++++++++++++++-
 drivers/dma/sun6i-dma.c                           |  23 ---
 7 files changed, 227 insertions(+), 46 deletions(-)

-- 
2.1.0
