From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Fri, 19 Jan 2018 21:11:00 +0800
Subject: [PATCH V3 00/10] clk: add imx7ulp clk support
Message-ID: <1516367470-24340-1-git-send-email-aisheng.dong@nxp.com>
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

Dong Aisheng (10):
  clk: clk-divider: add CLK_DIVIDER_ZERO_GATE clk support
  clk: fractional-divider: add CLK_FRAC_DIVIDER_ZERO_BASED flag support
  clk: imx: add pllv4 support
  clk: imx: add pfdv2 support
  clk: imx: add composite clk support
  dt-bindings: clock: add imx7ulp clock binding doc
  clk: imx: make mux parent strings const
  clk: imx: implement new clk_hw based APIs
  clk: imx: add imx7ulp clk driver
  add imx7ulp support

 .../devicetree/bindings/clock/imx7ulp-clock.txt    |  62 ++++++
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/imx7ulp-evk.dts                  |  87 ++++++++
 arch/arm/boot/dts/imx7ulp.dtsi                     | 202 ++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig               |  16 +-
 arch/arm/mach-imx/Kconfig                          |   9 +
 arch/arm/mach-imx/Makefile                         |   1 +
 arch/arm/mach-imx/common.h                         |   1 +
 arch/arm/mach-imx/cpu.c                            |   3 +
 arch/arm/mach-imx/mach-imx7ulp.c                   |  37 ++++
 arch/arm/mach-imx/mxc.h                            |   1 +
 arch/arm/mach-imx/pm-imx7ulp.c                     |  32 +++
 drivers/clk/clk-divider.c                          | 152 ++++++++++++++
 drivers/clk/clk-fractional-divider.c               |  10 +
 drivers/clk/imx/Makefile                           |   6 +-
 drivers/clk/imx/clk-busy.c                         |   2 +-
 drivers/clk/imx/clk-composite.c                    |  90 ++++++++
 drivers/clk/imx/clk-fixup-mux.c                    |   2 +-
 drivers/clk/imx/clk-imx7ulp.c                      | 232 +++++++++++++++++++++
 drivers/clk/imx/clk-pfdv2.c                        | 207 ++++++++++++++++++
 drivers/clk/imx/clk-pllv4.c                        | 188 +++++++++++++++++
 drivers/clk/imx/clk.c                              |  22 ++
 drivers/clk/imx/clk.h                              |  92 +++++++-
 include/dt-bindings/clock/imx7ulp-clock.h          | 108 ++++++++++
 include/linux/clk-provider.h                       |  17 ++
 25 files changed, 1561 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
 create mode 100644 arch/arm/boot/dts/imx7ulp-evk.dts
 create mode 100644 arch/arm/boot/dts/imx7ulp.dtsi
 create mode 100644 arch/arm/mach-imx/mach-imx7ulp.c
 create mode 100644 arch/arm/mach-imx/pm-imx7ulp.c
 create mode 100644 drivers/clk/imx/clk-composite.c
 create mode 100644 drivers/clk/imx/clk-imx7ulp.c
 create mode 100644 drivers/clk/imx/clk-pfdv2.c
 create mode 100644 drivers/clk/imx/clk-pllv4.c
 create mode 100644 include/dt-bindings/clock/imx7ulp-clock.h

-- 
2.7.4
