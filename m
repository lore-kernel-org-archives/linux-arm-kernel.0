From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 24 Jul 2017 21:58:55 +0800
Subject: [PATCH v3 00/10] ARM: sun8i: a83t: Add support for MMC controllers
Message-ID: <20170724135905.28855-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v3 of my MMC controller support series.

Changes since v2:

  - Really dropped CCU_FEATURE_MMC_ALWAYS_NEW

  - Simplified SUNXI_CCU_MP_MMC_WITH_MUX_GATE macro

  - Added Maxime's ack for mmc patches

Changes since v1:

  - Fix patches already applied have been dropped

  - V2 now exports sunxi-ng mmc timing mode API functions
    (in case mmc driver is built as a module)

  - Added stub functions for the timing mode API functions,
    in case sunxi-ng clk driver is not enabled

  - Added special class of MP clocks that consider the timing mode
    bit when calculating clock rates

  - Convert A83T MMC2 clock to use special MP_MMC clock

  - Keep feature bits for "has timing mode switch" and "needs new
    timing mode" in the mmc driver separate.

  - Add SoC specific compatible strings for MMC0/1 in the device tree

  - Updated commit message for patch "mmc: sunxi: Support controllers
    that can use both old and new timings"

  - Added acks from Rob


The MMC driver changes have compile time dependencies on the clk driver
changes. What would be a good way to merge this? An immutable branch?

The device tree changes don't depend on anything other than the
"Switch to CCU device tree binding macros" patch from v1. I hope we
can merge those ASAP, so I can send other patches on top of them.


Original cover letter from v1:

This series adds support for the MMC controllers on the A83T. The A83T's
MMC controller adds what they call the "new timing mode". It moves the
MMC clock delay lines into the controller itself. There are some minor
changes to how the clock rate is calculated. The new mode give better
performance and stability for eMMC applications. This mode is only
found on the eMMC facing controller (or MMC2 on this chip).

This mode is also found on the A64, but on that chip, the controller
is fixed to that mode. On the A83t, the user is free to use the old
or new mode, but the new mode is recommended. There are two switches,
one in the clock controller, the other in the MMC controller, that
must be set in tandem.

The main part of this series adds custom functions to the sunxi-ng
clk driver, allowing the MMC driver to query and configure the mode.
The MMC driver can then support timing mode switching, and thus, the
MMC2 controller on the A83t.

The other bits are some related cleanups, and the usual device tree
changes.

Please have a look.


Regards
ChenYu

Chen-Yu Tsai (10):
  clk: sunxi-ng: Add interface to query or configure MMC timing modes.
  clk: sunxi-ng: Add MP_MMC clocks that support MMC timing modes
    switching
  clk: sunxi-ng: a83t: Support new timing mode for mmc2 clock
  mmc: sunxi: Support controllers that can use both old and new timings
  mmc: sunxi: Support MMC DDR52 transfer mode with new timing mode
  mmc: sunxi: Add support for A83T eMMC (MMC2)
  ARM: dts: sun8i: a83t: Add MMC controller device nodes
  ARM: dts: sun8i: a83t: Add pingroup for 8-bit eMMC on mmc2
  ARM: dts: sun8i: a83t: cubietruck-plus: Enable micro-SD card and eMMC
  ARM: dts: sun8i: a83t: h8homlet: Enable micro-SD card and onboard eMMC

 .../devicetree/bindings/mmc/sunxi-mmc.txt          |  1 +
 .../boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts  | 21 ++++++
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts   | 27 +++++++
 arch/arm/boot/dts/sun8i-a83t.dtsi                  | 68 ++++++++++++++++++
 drivers/clk/sunxi-ng/Makefile                      |  1 +
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c              | 10 +--
 drivers/clk/sunxi-ng/ccu_common.h                  |  4 ++
 drivers/clk/sunxi-ng/ccu_mmc_timing.c              | 70 ++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_mp.c                      | 80 +++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_mp.h                      | 30 ++++++++
 drivers/mmc/host/sunxi-mmc.c                       | 83 ++++++++++++++++++----
 include/linux/clk/sunxi-ng.h                       | 35 +++++++++
 12 files changed, 408 insertions(+), 22 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu_mmc_timing.c
 create mode 100644 include/linux/clk/sunxi-ng.h

-- 
2.13.3
