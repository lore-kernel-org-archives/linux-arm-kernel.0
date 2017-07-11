From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Tue, 11 Jul 2017 18:56:17 +0800
Subject: [PATCH V2 00/10] add clock driver for Spreadtrum platforms
Message-ID: <20170711105627.20526-1-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a rewrite of Spreadtrum's original clock driver[1] according to the
comments[2] from Stephen Boyd.

This series adds Spreadtrum clock support together with its binding
documentation and devicetree data.

Any comments would be greatly appreciated.

Thanks,
Chunyan

Changes from V1 (https://lkml.org/lkml/2017/6/17/356):
* Address Stephen's comments:
  - Switch to use platform device driver instead of the DT probing mechanism.
  - Move the common clock macro out from vendor directory, but need to remove those
    overlap code from other vendors (such as sunxi-ng) once this gets merged.
  - Add support to be built as a module.
  - Add 'sprd_' prefix for all spin locks used in these drivers.
  - Mark input parameter of sprd_x with const.
  - Remove unreasonable dependencies to CONFIG_64BIT.
  - Add readl() after writing the same register.
  - Remove CLK_IS_BASIC which is no longer used.
  - Remove unnecessary CLK_IGNORE_UNUSED when defining a clock.
  - Change to expose all clock index.
  - Use clk_ instead of ccu.
  - Add Kconfig for sprd clocks.
  - Move the fixed clocks out from the soc node.
  - Switch to use 64-bit math in pll driver instead of 32-bit math.
* Revise binding documentation according to dt modification.
* Rename sc9860.c to sc9860-clk.c


[1] https://lwn.net/Articles/722739/
[2] https://www.spinics.net/lists/arm-kernel/msg582017.html


Chunyan Zhang (10):
  drivers: move clock common macros out from vendor directories
  dt-bindings: Add Spreadtrum clock binding documentation
  clk: sprd: Add common infrastructure
  clk: sprd: add gate clock support
  clk: sprd: add mux clock support
  clk: sprd: add divider clock support
  clk: sprd: add composite clock support
  clk: sprd: add adjustable pll support
  clk: sprd: add clocks support for SC9860
  arm64: dts: add clocks for SC9860

 Documentation/devicetree/bindings/clock/sprd.txt |   36 +
 arch/arm64/boot/dts/sprd/sc9860.dtsi             |   22 +
 arch/arm64/boot/dts/sprd/whale2.dtsi             |    3 +-
 drivers/clk/Kconfig                              |    1 +
 drivers/clk/Makefile                             |    1 +
 drivers/clk/clk_common.h                         |   60 +
 drivers/clk/sprd/Kconfig                         |   14 +
 drivers/clk/sprd/Makefile                        |   11 +
 drivers/clk/sprd/common.c                        |   83 ++
 drivers/clk/sprd/common.h                        |   56 +
 drivers/clk/sprd/composite.c                     |   64 +
 drivers/clk/sprd/composite.h                     |   47 +
 drivers/clk/sprd/div.c                           |   98 ++
 drivers/clk/sprd/div.h                           |   77 +
 drivers/clk/sprd/gate.c                          |  104 ++
 drivers/clk/sprd/gate.h                          |   58 +
 drivers/clk/sprd/mux.c                           |   86 ++
 drivers/clk/sprd/mux.h                           |   63 +
 drivers/clk/sprd/pll.c                           |  236 +++
 drivers/clk/sprd/pll.h                           |  133 ++
 drivers/clk/sprd/sc9860-clk.c                    | 1726 ++++++++++++++++++++++
 include/dt-bindings/clock/sprd,sc9860-clk.h      |  375 +++++
 22 files changed, 3352 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd.txt
 create mode 100644 drivers/clk/clk_common.h
 create mode 100644 drivers/clk/sprd/Kconfig
 create mode 100644 drivers/clk/sprd/Makefile
 create mode 100644 drivers/clk/sprd/common.c
 create mode 100644 drivers/clk/sprd/common.h
 create mode 100644 drivers/clk/sprd/composite.c
 create mode 100644 drivers/clk/sprd/composite.h
 create mode 100644 drivers/clk/sprd/div.c
 create mode 100644 drivers/clk/sprd/div.h
 create mode 100644 drivers/clk/sprd/gate.c
 create mode 100644 drivers/clk/sprd/gate.h
 create mode 100644 drivers/clk/sprd/mux.c
 create mode 100644 drivers/clk/sprd/mux.h
 create mode 100644 drivers/clk/sprd/pll.c
 create mode 100644 drivers/clk/sprd/pll.h
 create mode 100644 drivers/clk/sprd/sc9860-clk.c
 create mode 100644 include/dt-bindings/clock/sprd,sc9860-clk.h

-- 
2.7.4
