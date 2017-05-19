From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 19 May 2017 15:06:06 +0800
Subject: [PATCH v4 0/6] clk: sunxi-ng: Add support for A83T CCU
Message-ID: <20170519070612.32159-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v4 of my A83T CCU series. This is for 4.13.

Changes since v3:

  - Dropped predivider for new timing mode on mmc2 clock. Replaced with
    a TODO note for new timing mode support. This is the last trace of
    new timing mode code.

  - Simplified PLL_CPUx clocks into multiplier clocks, just like we did
    for the A80. At probe time the extra P dividers are forced to /1.
    These P dividers should only be used for clock rates under 288 MHz,
    and never used by the boot loader or the BSP kernel.

Changes since v2:

  - Dropped patches "clk: Provide option to query hardware for clk phase"
    and "clk: sunxi-ng: Add class of phase clocks supporting MMC new timing
    modes".
    
  - Dropped support for MMC new timing mode. This will be added later with
    MMC support. The goal for this series is to get clk support for the A83t
    in. This is long overdue.

  - Explicitly include ccu_mux.h and select SUNXI_CCU_MUX

Changes since v1:

  - Dropped two patches that were merged

  - Added clk core flag to disable caching of clock phases

  - Added support for multiple variable pre-dividers

  - Merged "pll-periph-ahb1" pre-divider clock into "ahb1" clock
    with multiple variable pre-dividers

  - Introduced new class of phase clocks that return -ENOTSUPP
    when the clock is in new timing mode

  - Force mmc2 clock to new timing mode

  - Added back mmc2 output and sample clocks

  - Fixed bit ops for forcing audio PLL configuration

  - Added requirement for "losc" clock in device tree binding

  - Stripped leading 0 in device node name

  - Updated subject prefixes for various patches

Patch 1 adds a compatible string for the A83T CCU to the sunxi-ccu
bindings.

Patch 2 adds support for multiple variable pre-dividers to the sunxi-ng
mux class.

Patch 3 adds the driver for the A83T CCU.

Patch 4 adds the CCU device nodes, and fixes up any existing clock
phandles in the dtsi, without using the macros.

Patch 5 sets the clock accuracy for the main oscillator.

Patch 6 is for the next -rc2, switch the clock indices from raw numbers
to macros we introduced with the driver. This will be updated if more
peripherals are introduced in the same cycle.

Let me know what you think.

Cover letter excerpt from v1:

This is yet another series that adds support for the A83T CCU.
The A83T CCU has a mix of new styled (like the A80) clocks at
old (like A3x) offsets. Some differences include:

  - D1/D2 style PLL clocks
  - divisible audio module clocks
  - new timing mode for mmc2 module clock


Regards
ChenYu


Chen-Yu Tsai (6):
  dt-bindings: clock: sunxi-ccu: Add compatible string for A83T CCU
  clk: sunxi-ng: Support multiple variable pre-dividers
  clk: sunxi-ng: Add driver for A83T CCU
  ARM: sun8i: a83t: Add CCU device nodes
  ARM: sun8i: a83t: Set clock accuracy for 24MHz oscillator
  ARM: sun8i: a83t: Switch to CCU device tree binding macros

 .../devicetree/bindings/clock/sunxi-ccu.txt        |   2 +
 arch/arm/boot/dts/sun8i-a83t.dtsi                  |  19 +-
 drivers/clk/sunxi-ng/Kconfig                       |  11 +
 drivers/clk/sunxi-ng/Makefile                      |   1 +
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c              |  10 +-
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c               |  10 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c               |  10 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c               |  10 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c              | 922 +++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.h              |  64 ++
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c                |  10 +-
 drivers/clk/sunxi-ng/ccu-sun8i-r.c                 |  10 +-
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c               |  10 +-
 drivers/clk/sunxi-ng/ccu_mux.c                     |  15 +-
 drivers/clk/sunxi-ng/ccu_mux.h                     |  13 +-
 include/dt-bindings/clock/sun8i-a83t-ccu.h         | 140 ++++
 include/dt-bindings/reset/sun8i-a83t-ccu.h         |  98 +++
 17 files changed, 1306 insertions(+), 49 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-a83t.h
 create mode 100644 include/dt-bindings/clock/sun8i-a83t-ccu.h
 create mode 100644 include/dt-bindings/reset/sun8i-a83t-ccu.h

-- 
2.11.0
