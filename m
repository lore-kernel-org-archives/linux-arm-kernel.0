From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 07 May 2014 23:09:53 +0200
Subject: [PATCH v2 00/11] Add real clock support for Rockchip's RK3188
Message-ID: <3477211.Gkyeur83TV@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add a clock driver infrastructure for Rockchip SoCs in
general and clock-definitions for the RK3188 in particular.

Due to the lack of any usable documentation of the RK3188 clocks, the
clock tree is based on my own doc [0] collected by analyzing the
clock_data code in current Rockchip kernels. As a result the gathered
data may contain errors. So to prevent API issues with the clock-ids,
the exported ones are currently limited to well understood or really
measured clocks.

The previous attempt to define parts separately in the devicetree did
not really fit with the clock structure, which became apparent with more
knowledge about the clock tree and this new driver framework, heavily
inspired by the Samsung clock driver, fits very well for clock controllers
in Rockchip SoCs.

The whole structure should support Rockchip SoCs at least down to
the RK28xx (ARM9) which all share a very similar setup of their clock
controllers in PLL, divider and gate handling as well as the included
softreset parts.

changes since v1:
- adapt to apply on current clk-next branch
- add saradc clock
- add rk3188a cru, which has a slightly different handling of one
  pll value (bwadj)

[0] https://docs.google.com/document/d/1voaR9Xk3lisCQIG3ThySOSnSHBUequljQYnceFlr53w/edit?usp=sharing

Heiko Stuebner (11):
  clk: divider: add CLK_DIVIDER_READ_ONLY flag
  clk: rockchip: add basic infrastructure
  clk: rockchip: add clock type for pll clocks and pll used on rk3066
  clk: rockchip: add special cpu clock type
  clk: rockchip: add reset controller
  dt-bindings: add documentation for rk3188 clock and reset unit
  clk: rockchip: add clock driver for rk3188 clocks
  ARM: rockchip: Select ARCH_HAS_RESET_CONTROLLER
  ARM: dts: rk3188: add cru node and update device clocks to use it
  ARM: dts: rockchip: move rk3188 core input clocks into main dtsi
  ARM: dts: rockchip: remove the now obsolete rk3188-clocks.dtsi

 .../bindings/clock/rockchip,rk3188-cru.txt         |  74 ++++
 arch/arm/boot/dts/rk3188-clocks.dtsi               | 289 -------------
 arch/arm/boot/dts/rk3188.dtsi                      |  80 +++-
 arch/arm/mach-rockchip/Kconfig                     |   1 +
 drivers/clk/clk-divider.c                          |  10 +-
 drivers/clk/rockchip/Makefile                      |   6 +
 drivers/clk/rockchip/clk-cpu.c                     | 434 +++++++++++++++++++
 drivers/clk/rockchip/clk-pll.c                     | 316 ++++++++++++++
 drivers/clk/rockchip/clk-rk3188.c                  | 479 +++++++++++++++++++++
 drivers/clk/rockchip/clk.c                         | 168 ++++++++
 drivers/clk/rockchip/clk.h                         | 251 +++++++++++
 drivers/clk/rockchip/softrst.c                     | 115 +++++
 include/dt-bindings/clock/rk3188-cru.h             |  81 ++++
 include/linux/clk-provider.h                       |   4 +
 14 files changed, 2013 insertions(+), 295 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.txt
 delete mode 100644 arch/arm/boot/dts/rk3188-clocks.dtsi
 create mode 100644 drivers/clk/rockchip/clk-cpu.c
 create mode 100644 drivers/clk/rockchip/clk-pll.c
 create mode 100644 drivers/clk/rockchip/clk-rk3188.c
 create mode 100644 drivers/clk/rockchip/clk.c
 create mode 100644 drivers/clk/rockchip/clk.h
 create mode 100644 drivers/clk/rockchip/softrst.c
 create mode 100644 include/dt-bindings/clock/rk3188-cru.h

-- 
1.9.0
