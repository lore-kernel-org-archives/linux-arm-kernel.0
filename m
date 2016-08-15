From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 15 Aug 2016 16:13:10 +0800
Subject: [PATCH v2 0/5] clk: sunxi-ng: Support A31/A31s CCU
Message-ID: <1471248795-17951-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v2 of the sunxi-ng clk driver for A31/A31s CCU, consisting of
the remaining patches that haven't been merged, with some minor changes
addressing review comments. Changelog is inline in each patch.

This series adds support for the A31/A31s CCU (clock control unit) with
the new sunxi-ng binding/driver. This is a near complete driver, with a
few features unimplemented or might need reworking:

  - The HDMI mode of the PLL-MIPI clock is unsupported.

  - The EMAC clock is unimplemented. In the past we modelled this as a
    clock. Unforunately that doesn't work very well. While it is sort
    of a clock control, with clock inverters and delay chains, it also
    controls the interface mode of the EMAC. On later SoCs this register
    is moved out of the CCU, into the system control register range.
    Other platforms consider this a part of the ethernet controller glue
    logic, and map and use it directly as part of the controller bindings.
    I would like to do the same.

  - The A31 has 2 SDRAM clocks and 2 MBUS clocks. As such we can't have
    them all as the DRAM gate clocks' parent. Instead I'm using the MDFS
    clock as their parent. It is unclear what MDFS actually is, but the
    close proximity of the registers to the DRAM bits, and hints about
    this tied to DRAM DVFS suggest this is a common memory bus. If we're
    wrong we can always fix this as the relationship is part of the driver,
    not the binding. Also, all 5 clocks are marked as critical.

Various changes were made to the common (to sunxi-ng) clock types to make
them compatible with the A31/A31s' CCU's design.

Also new is support for clk notifiers for mux clocks. This is needed for
the cpu clock, which should be muxed to the stable main oscillator when
the PLL-CPU clock rate is changed, to avoid any instabilities in the PLL
which result in the CPU crashing. This is similar to what the meson
platform does.


Regards
ChenYu

Chen-Yu Tsai (5):
  clk: sunxi-ng: mux: Add support for mux tables
  clk: sunxi-ng: mux: support fixed pre-dividers on multiple parents
  clk: sunxi-ng: mux: Add clk notifier functions
  clk: sunxi-ng: Add A31/A31s clocks
  ARM: dts: sun6i: switch A31/A31s to new CCU clock bindings

 .../devicetree/bindings/clock/sunxi-ccu.txt        |    3 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  424 ++-----
 drivers/clk/sunxi-ng/Kconfig                       |   10 +
 drivers/clk/sunxi-ng/Makefile                      |    1 +
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c               | 1235 ++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun6i-a31.h               |   72 ++
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c                |    9 +-
 drivers/clk/sunxi-ng/ccu_mux.c                     |   54 +-
 drivers/clk/sunxi-ng/ccu_mux.h                     |   37 +-
 include/dt-bindings/clock/sun6i-a31-ccu.h          |  187 +++
 include/dt-bindings/reset/sun6i-a31-ccu.h          |  106 ++
 11 files changed, 1798 insertions(+), 340 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun6i-a31.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun6i-a31.h
 create mode 100644 include/dt-bindings/clock/sun6i-a31-ccu.h
 create mode 100644 include/dt-bindings/reset/sun6i-a31-ccu.h

-- 
2.8.1
