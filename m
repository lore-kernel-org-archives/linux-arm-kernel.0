From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 14 Nov 2018 13:01:31 +0000
Subject: [PATCH V6 0/9] clk: add imx7ulp clk support
Message-ID: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series intends to add imx7ulp clk support.

i.MX7ULP Clock functions are under joint control of the System
Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
modules, and Core Mode Controller (CMC)1 blocks

The clocking scheme provides clear separation between M4 domain
and A7 domain. Except for a few clock sources shared between two
domains, such as the System Oscillator clock, the Slow IRC (SIRC),
and and the Fast IRC clock (FIRCLK), clock sources and clock
management are separated and contained within each domain.

M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.

Note: this series only adds A7 clock domain support as M4 clock
domain will be handled by M4 seperately.

Change Log:
v5->v6:
 * move gatable divider from common divider to imx specfic folder(suggested by Michael)
 * a small update of PATCH 9 for ddr/firc/dpll/sosc clocks to use divider table
v4->v5:
 * rename to clk-composite-7ulp.c as we have another
   clk-composite-8m.c, function name also changed accordingly
 * binding doc updated with adding input clocks for PCC module
v3->v4:
 * update after changing scg and pcc into separete nodes according to
   Rob's suggestion
v2->v3:
 * Patch 1 changed on: 1) split normal and gate ops 2) fix the possible racy
   Others no changes.

v1->v2:
 * add enable/disable for the type of CLK_DIVIDER_ZERO_GATE dividers
 * use clk_hw apis to register clocks
 * use of_clk_add_hw_provider
 * split the clocks register process into two parts: early part for possible
   timers clocks registered by CLK_OF_DECLARE_DRIVER and the later part for
   the left normal peripheral clocks registered by a platform driver.

Dong Aisheng (9):
  clk: imx: add gatable clock divider support
  clk: fractional-divider: add CLK_FRAC_DIVIDER_ZERO_BASED flag support
  clk: imx: add pllv4 support
  clk: imx: add pfdv2 support
  clk: imx: add imx7ulp composite clk support
  dt-bindings: clock: add imx7ulp clock binding doc
  clk: imx: make mux parent strings const
  clk: imx: implement new clk_hw based APIs
  clk: imx: add imx7ulp clk driver

 .../devicetree/bindings/clock/imx7ulp-clock.txt    | 104 ++++++++++
 drivers/clk/clk-fractional-divider.c               |  10 +
 drivers/clk/imx/Makefile                           |   7 +-
 drivers/clk/imx/clk-busy.c                         |   2 +-
 drivers/clk/imx/clk-composite-7ulp.c               |  85 ++++++++
 drivers/clk/imx/clk-divider-gate.c                 | 219 ++++++++++++++++++++
 drivers/clk/imx/clk-fixup-mux.c                    |   2 +-
 drivers/clk/imx/clk-imx7ulp.c                      | 220 +++++++++++++++++++++
 drivers/clk/imx/clk-pfdv2.c                        | 201 +++++++++++++++++++
 drivers/clk/imx/clk-pllv4.c                        | 182 +++++++++++++++++
 drivers/clk/imx/clk.c                              |  22 +++
 drivers/clk/imx/clk.h                              |  96 ++++++++-
 include/dt-bindings/clock/imx7ulp-clock.h          | 109 ++++++++++
 include/linux/clk-provider.h                       |   8 +
 14 files changed, 1257 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
 create mode 100644 drivers/clk/imx/clk-composite-7ulp.c
 create mode 100644 drivers/clk/imx/clk-divider-gate.c
 create mode 100644 drivers/clk/imx/clk-imx7ulp.c
 create mode 100644 drivers/clk/imx/clk-pfdv2.c
 create mode 100644 drivers/clk/imx/clk-pllv4.c
 create mode 100644 include/dt-bindings/clock/imx7ulp-clock.h

-- 
2.7.4
