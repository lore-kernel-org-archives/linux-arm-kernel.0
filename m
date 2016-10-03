From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon,  3 Oct 2016 10:09:04 +0200
Subject: [PATCH v3 0/9] arm64: Allwinner A64 support based on sunxi-ng
Message-ID: <20161003080913.24197-1-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

As it was in the first iteration, this is the A64 support based on the
new sunxi-ng clock framework.

The support for it is quite minimal at the moment, but it should be
fairly easy to add new devices, as most of the design is shared with
older SoCs.

Let me know what you think,
Maxime

Changes from v2:
  - Added pull-ups on the Pine64 i2c bus
  - Removed the PMU since it doesn't work
  - Refactored the sunxi-ng framework to deal with the specifities of
    the A64 CCU, especially in terms of minimum factors.
  - Fixed a few things in the CCU driver: added CLK_SET_RATE PARENT
    flags, fixed some mux width, etc.
  - Converted the CCU driver to a platform driver
  - Added the DRAM reset line
  - Added IDs for the USB muxes (even though we're not using them yet)

Changes from v1:
  - Split the A64 CCU support out of the H3 driver
  - Added the PMU support
  - Removed the clocks node
  - Rebased on top of current sunxi/clk-for-4.9 branch

Andre Przywara (3):
  arm64: dts: add Allwinner A64 SoC .dtsi
  Documentation: devicetree: add vendor prefix for Pine64
  arm64: dts: add Pine64 support

Maxime Ripard (6):
  clk: sunxi-ng: Rename the internal structures
  clk: sunxi-ng: Remove the use of rational computations
  clk: sunxi-ng: Finish to convert to structures for arguments
  clk: sunxi-ng: Add minimums for all the relevant structures and clocks
  clk: sunxi-ng: Implement minimum for multipliers
  clk: sunxi-ng: Add A64 clocks

 Documentation/devicetree/bindings/arm/sunxi.txt    |   1 +
 .../devicetree/bindings/clock/sunxi-ccu.txt        |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   1 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/allwinner/Makefile             |   5 +
 .../boot/dts/allwinner/sun50i-a64-pine64-plus.dts  |  50 ++
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  74 ++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 263 ++++++
 drivers/clk/sunxi-ng/Kconfig                       |  14 +-
 drivers/clk/sunxi-ng/Makefile                      |   1 +
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c              | 918 +++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-a64.h              |  72 ++
 drivers/clk/sunxi-ng/ccu_div.h                     |   6 +-
 drivers/clk/sunxi-ng/ccu_frac.c                    |  12 +-
 drivers/clk/sunxi-ng/ccu_frac.h                    |  14 +-
 drivers/clk/sunxi-ng/ccu_mp.h                      |   4 +-
 drivers/clk/sunxi-ng/ccu_mult.c                    |  33 +-
 drivers/clk/sunxi-ng/ccu_mult.h                    |  17 +-
 drivers/clk/sunxi-ng/ccu_nk.c                      |  43 +-
 drivers/clk/sunxi-ng/ccu_nk.h                      |   4 +-
 drivers/clk/sunxi-ng/ccu_nkm.c                     |  45 +-
 drivers/clk/sunxi-ng/ccu_nkm.h                     |   6 +-
 drivers/clk/sunxi-ng/ccu_nkmp.c                    |  55 +-
 drivers/clk/sunxi-ng/ccu_nkmp.h                    |   8 +-
 drivers/clk/sunxi-ng/ccu_nm.c                      |  58 +-
 drivers/clk/sunxi-ng/ccu_nm.h                      |   6 +-
 include/dt-bindings/clock/sun50i-a64-ccu.h         | 134 +++
 include/dt-bindings/reset/sun50i-a64-ccu.h         |  98 +++
 29 files changed, 1824 insertions(+), 121 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/Makefile
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-a64.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-a64.h
 create mode 100644 include/dt-bindings/clock/sun50i-a64-ccu.h
 create mode 100644 include/dt-bindings/reset/sun50i-a64-ccu.h

-- 
2.9.3
