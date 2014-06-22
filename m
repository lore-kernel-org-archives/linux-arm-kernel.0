From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 22 Jun 2014 22:41:45 +0200
Subject: [PATCH v4 00/13] Clock support for rk3066,rk3188 and rk3288
Message-ID: <1808429.dNxms7FR7U@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds a clock driver infrastructure for Rockchip SoCs in
general and clock-definitions for the RK3188 and RK3288 in particular.

The previous attempt to define parts separately in the devicetree did
not really fit with the clock structure, which became apparent with more
knowledge about the clock tree.

The whole structure should support Rockchip SoCs at least down to
the RK28xx (ARM9) which all share a very similar setup of their clock
controllers in PLL, divider and gate handling as well as the included
softreset parts.

A big change is the move from declaring all mux/dividers/gates individually
to declaring them as composite clock branches, making the code better
readable and making it possible to keep clocks together in a more natural
order.

The changes under drivers/clk apply cleanly to clk-next but the changes
in arm/boot/dts require patches from arm-soc, so in the unlikely case of
this making it in before the merge window the dts patches should go
through arm-soc (or should do so anyway, as they do not directly depend
on the drivers/clk changes)

changes since v3:
- add rk3288 clock controller
- add reset controller ids
- fix some incorrect values in rk3188-cru and export some more clocks
- fold new rk3066 clock tree into the rk3188 one, as can be easily seen
  the differences are not really big between them
- expand the composite fix description to highlight the underlying issue
changes since v2:
- drop the special cpuclk type until coordinated range changes
  matured, as mentioned in the Samsung cpufreq thread.
- add the patch from Boris BREZILLON that reenables correct rate
  calculations in composite clocks
- change pll handling to better handle the pll output mux and also
  the enabling/disabling of the pll clock
- change core code to handle composite clock branches instead of
  individual basic clock definitions
- use the newly defined GRF syscon instead of mapping a grf register
  individually
changes since v1:
- adapt to apply on current clk-next branch
- add saradc clock
- add rk3188a cru, which has a slightly different handling of one
  pll value (bwadj)

Boris BREZILLON (1):
  clk: composite: support determine_rate using rate_ops->round_rate +
    mux_ops->set_parent

Heiko Stuebner (12):
  clk: composite: allow read-only clocks
  clk: rockchip: add basic infrastructure for clock branches
  clk: rockchip: add clock type for pll clocks and pll used on rk3066
  clk: rockchip: add reset controller
  dt-bindings: add documentation for rk3188 clock and reset unit
  clk: rockchip: add clock driver for rk3188 and rk3066 clocks
  ARM: rockchip: Select ARCH_HAS_RESET_CONTROLLER
  ARM: dts: rockchip: add cru nodes and update device clocks to use it
  ARM: dts: rockchip: move oscillator input clock into main dtsi
  arm: dts: rockchip: remove obsolete clock gate definitions
  clk: rockchip: add clock controller for rk3288
  dt-bindings: add documentation for rk3288 cru

 .../bindings/clock/rockchip,rk3188-cru.txt         |  61 ++
 .../bindings/clock/rockchip,rk3288-cru.txt         |  61 ++
 .../devicetree/bindings/clock/rockchip.txt         |   3 +
 arch/arm/boot/dts/rk3066a-clocks.dtsi              | 299 ---------
 arch/arm/boot/dts/rk3066a.dtsi                     |  30 +-
 arch/arm/boot/dts/rk3188-clocks.dtsi               | 289 ---------
 arch/arm/boot/dts/rk3188.dtsi                      |  19 +-
 arch/arm/boot/dts/rk3xxx.dtsi                      |  22 +-
 arch/arm/mach-rockchip/Kconfig                     |   1 +
 drivers/clk/clk-composite.c                        |  60 +-
 drivers/clk/rockchip/Makefile                      |   6 +
 drivers/clk/rockchip/clk-pll.c                     | 431 +++++++++++++
 drivers/clk/rockchip/clk-rk3188.c                  | 672 +++++++++++++++++++
 drivers/clk/rockchip/clk-rk3288.c                  | 717 +++++++++++++++++++++
 drivers/clk/rockchip/clk.c                         | 237 +++++++
 drivers/clk/rockchip/clk.h                         | 347 ++++++++++
 drivers/clk/rockchip/softrst.c                     | 115 ++++
 include/dt-bindings/clock/rk3066a-cru.h            |  35 +
 include/dt-bindings/clock/rk3188-cru-common.h      | 249 +++++++
 include/dt-bindings/clock/rk3188-cru.h             |  51 ++
 include/dt-bindings/clock/rk3288-cru.h             | 278 ++++++++
 21 files changed, 3365 insertions(+), 618 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt
 delete mode 100644 arch/arm/boot/dts/rk3066a-clocks.dtsi
 delete mode 100644 arch/arm/boot/dts/rk3188-clocks.dtsi
 create mode 100644 drivers/clk/rockchip/clk-pll.c
 create mode 100644 drivers/clk/rockchip/clk-rk3188.c
 create mode 100644 drivers/clk/rockchip/clk-rk3288.c
 create mode 100644 drivers/clk/rockchip/clk.c
 create mode 100644 drivers/clk/rockchip/clk.h
 create mode 100644 drivers/clk/rockchip/softrst.c
 create mode 100644 include/dt-bindings/clock/rk3066a-cru.h
 create mode 100644 include/dt-bindings/clock/rk3188-cru-common.h
 create mode 100644 include/dt-bindings/clock/rk3188-cru.h
 create mode 100644 include/dt-bindings/clock/rk3288-cru.h

-- 
1.9.0
