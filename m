From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 26 Jun 2014 23:55:38 +0800
Subject: [PATCH v4 0/6] clk: sunxi: fixes, cleanups and A23 basic clocks
Message-ID: <1403798144-32188-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v4 of the sun8i clock series, which adds basic clock
support for the A23 SoC. It is based on my initial sun8i bring
up series [1]. This series was split up from the original A23
series [2]. Yet to come are more clocks, reset controllers,
prcm, pinctrl, and mmc.

The first patch fixes the reworked clock protection code merged in
3.16-rc1, which unintentionally made clock gates unprotectable.

The second patch moves the remaining "ahb_sdram" clock to the
protected clock list, now that it works.

The third patch adds support for factor clocks that have an N factor
not starting from 0. This is found on some PLLs in A31/A23.

The fourth patch adds table-based dividers for div clocks, as some
clocks, such as apb0 divider on sun4/5/7i, apb1 on sun6/8i and axi
on sun8i.

The fifth patch adds support for the basic clocks in the A23, just
PLL1 for cpus, and the system bus clocks and gates.

The last patch adds the DT nodes for the newly added clocks, and
updates clock phandles for existing peripherals, the uarts.

Originally I intended for patch 1 to be merged as a fix for 3.16.
However, the only user of the affected code, sun6i's "ahb1_sdram"
clock, doesn't seem to result in any runtime issues. So this whole
series can go into 3.17.


Related changes since v3:

  - Dropped fields with default values from sun8i_a23_axi_div_data
  - Added Maxime's Acked-by
  - Fixed incorrect compatible string for axi clock node
  - Updated clock phandles for uarts in dtsi

Related changes since v2:

  - Rewrote factor clocks to support any (0~255) N factor starting value

Related changes since v1:

  - Added "clk: sunxi: Add support for table-based divider clocks"
  - Added table-based divider axi clock
  - Fixed incorrectly squashed fixups


Cheers
ChenYu


  [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/265211.html
  [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/259097.html

Chen-Yu Tsai (6):
  clk: sunxi: register clock gates with clkdev
  clk: sunxi: move "ahb_sdram" to protected clock list
  clk: sunxi: Support factor clocks with N factor starting not from 0
  clk: sunxi: Add support for table-based divider clocks
  clk: sunxi: Add A23 clocks support
  ARM: sun8i: Add basic clock nodes to the DTSI

 Documentation/devicetree/bindings/clock/sunxi.txt |   5 +
 arch/arm/boot/dts/sun8i-a23.dtsi                  | 125 +++++++++++++++++++++-
 drivers/clk/sunxi/clk-factors.c                   |   2 +-
 drivers/clk/sunxi/clk-factors.h                   |   1 +
 drivers/clk/sunxi/clk-sunxi.c                     | 119 ++++++++++++++++++--
 5 files changed, 237 insertions(+), 15 deletions(-)

-- 
2.0.0
