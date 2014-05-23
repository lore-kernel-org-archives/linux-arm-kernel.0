From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 23 May 2014 21:32:15 +0200
Subject: [PATCH v3 00/11] Add real clock support for Rockchip's RK3188
Message-ID: <1621067.VASjIdzoSl@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add a clock driver infrastructure for Rockchip SoCs in
general and clock-definitions for the RK3188 in particular.

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

This series depends on the patch adding the CLK_DIVIDER_READ_ONLY flag
Thomas Abraham reposted today.

The changes under drivers/clk apply cleanly to clk-next but the changes
in arm/boot/dts require patches from arm-soc, so in the unlikely case of
this making it in before the merge window the dts patches should go
through arm-soc (or should do so anyway, as they do not directly depend
on the drivers/clk changes)

@Max: due to the quite deep changes I didn't keep your tags, so re-tag
please if you feel they're still appropriate :-)


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

Heiko Stuebner (10):
  clk: composite: allow read-only clocks
  clk: rockchip: add basic infrastructure for clock branches
  clk: rockchip: add clock type for pll clocks and pll used on rk3066
  clk: rockchip: add reset controller
  dt-bindings: add documentation for rk3188 clock and reset unit
  clk: rockchip: add clock driver for rk3188 clocks
  ARM: rockchip: Select ARCH_HAS_RESET_CONTROLLER
  ARM: dts: rk3188: add cru node and update device clocks to use it
  ARM: dts: rockchip: move rk3188 core input clocks into main dtsi
  ARM: dts: rockchip: remove the now obsolete rk3188-clocks.dtsi

 .../bindings/clock/rockchip,rk3188-cru.txt         |  59 +++
 arch/arm/boot/dts/rk3188-clocks.dtsi               | 289 -----------
 arch/arm/boot/dts/rk3188.dtsi                      |  59 ++-
 arch/arm/mach-rockchip/Kconfig                     |   1 +
 drivers/clk/clk-composite.c                        |  60 ++-
 drivers/clk/rockchip/Makefile                      |   5 +
 drivers/clk/rockchip/clk-pll.c                     | 430 ++++++++++++++++
 drivers/clk/rockchip/clk-rk3188.c                  | 561 +++++++++++++++++++++
 drivers/clk/rockchip/clk.c                         | 238 +++++++++
 drivers/clk/rockchip/clk.h                         | 339 +++++++++++++
 drivers/clk/rockchip/softrst.c                     | 115 +++++
 include/dt-bindings/clock/rk3188-cru.h             |  78 +++
 12 files changed, 1933 insertions(+), 301 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.txt
 delete mode 100644 arch/arm/boot/dts/rk3188-clocks.dtsi
 create mode 100644 drivers/clk/rockchip/clk-pll.c
 create mode 100644 drivers/clk/rockchip/clk-rk3188.c
 create mode 100644 drivers/clk/rockchip/clk.c
 create mode 100644 drivers/clk/rockchip/clk.h
 create mode 100644 drivers/clk/rockchip/softrst.c
 create mode 100644 include/dt-bindings/clock/rk3188-cru.h

-- 
1.9.0
