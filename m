From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 13 Jul 2014 12:46:22 -0700
Subject: [PATCH v5 00/14] Clock support for rk3066,rk3188 and rk3288
In-Reply-To: <156042792.J76K6jxIGl@diego>
References: <156042792.J76K6jxIGl@diego>
Message-ID: <20140713194622.9850.99668@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Heiko St?bner (2014-07-02 16:53:24)
> This series adds a clock driver infrastructure for Rockchip SoCs in
> general and clock-definitions for the RK3188 and RK3288 in particular.
> 
> Apart from the arch/arm patches included here, there are some more
> in the waiting line, like adding the i2c nodes and possibly the pwm, i2s
> and spi nodes if the relevant drivers get accepted, where the ids
> defined in the dt-binding headers are needed.
> 
> So if the whole thing is acceptable could we either offer a branch
> from the clk-tree that can get merged or take the whole series through
> the arm tree?

Heiko,

This version looks good. I've pushed a branch with all 14 of these
patches based on 3.16-rc3 to the clk tree. See:

git://git.linaro.org/people/mike.turquette/linux.git clk-rockchip

If everyone is OK to merge that stable branch then I will merge
clk-rockchip into clk-next and we're all good. If the arm-soc guys want
to carve it up a bit further or handle it in a different way then we can
do that. I've Cc'd arm-soc for clarification.

Regards,
Mike

> 
> 
> changes since v4.2:
> - fix uninitialized compiler warning in patch4
> - add cleanup patch for clk-composite from Mike Turquette
> - fix some softrst-issues in patch6
> changes since v4.1:
> - forgot the From override, Boris is the original author
> changes since v4:
> - address comments from Gabriel Fernandez
>   - use abs()
>   - init best_rate
> changes since v3:
> - add rk3288 clock controller
> - add reset controller ids
> - fix some incorrect values in rk3188-cru and export some more clocks
> - fold new rk3066 clock tree into the rk3188 one, as can be easily seen
>   the differences are not really big between them
> - expand the composite fix description to highlight the underlying issue
> changes since v2:
> - drop the special cpuclk type until coordinated range changes
>   matured, as mentioned in the Samsung cpufreq thread.
> - add the patch from Boris BREZILLON that reenables correct rate
>   calculations in composite clocks
> - change pll handling to better handle the pll output mux and also
>   the enabling/disabling of the pll clock
> - change core code to handle composite clock branches instead of
>   individual basic clock definitions
> - use the newly defined GRF syscon instead of mapping a grf register
>   individually
> changes since v1:
> - adapt to apply on current clk-next branch
> - add saradc clock
> - add rk3188a cru, which has a slightly different handling of one
>   pll value (bwadj)
> 
> Boris BREZILLON (1):
>   clk: composite: support determine_rate using rate_ops->round_rate +
>     mux_ops->set_parent
> 
> Heiko Stuebner (12):
>   clk: composite: allow read-only clocks
>   clk: rockchip: add basic infrastructure for clock branches
>   clk: rockchip: add clock type for pll clocks and pll used on rk3066
>   clk: rockchip: add reset controller
>   dt-bindings: add documentation for rk3188 clock and reset unit
>   clk: rockchip: add clock driver for rk3188 and rk3066 clocks
>   dt-bindings: add documentation for rk3288 cru
>   clk: rockchip: add clock controller for rk3288
>   ARM: rockchip: Select ARCH_HAS_RESET_CONTROLLER
>   ARM: dts: rockchip: add cru nodes and update device clocks to use it
>   ARM: dts: rockchip: move oscillator input clock into main dtsi
>   arm: dts: rockchip: remove obsolete clock gate definitions
> 
> Mike Turquette (1):
>   clk: composite: improve rate_hw sanity check logic
> 
>  .../bindings/clock/rockchip,rk3188-cru.txt         |  61 ++
>  .../bindings/clock/rockchip,rk3288-cru.txt         |  61 ++
>  .../devicetree/bindings/clock/rockchip.txt         |   3 +
>  arch/arm/boot/dts/rk3066a-clocks.dtsi              | 299 ---------
>  arch/arm/boot/dts/rk3066a.dtsi                     |  30 +-
>  arch/arm/boot/dts/rk3188-clocks.dtsi               | 289 ---------
>  arch/arm/boot/dts/rk3188.dtsi                      |  19 +-
>  arch/arm/boot/dts/rk3xxx.dtsi                      |  22 +-
>  arch/arm/mach-rockchip/Kconfig                     |   1 +
>  drivers/clk/clk-composite.c                        |  79 ++-
>  drivers/clk/rockchip/Makefile                      |   6 +
>  drivers/clk/rockchip/clk-pll.c                     | 431 +++++++++++++
>  drivers/clk/rockchip/clk-rk3188.c                  | 672 +++++++++++++++++++
>  drivers/clk/rockchip/clk-rk3288.c                  | 717 +++++++++++++++++++++
>  drivers/clk/rockchip/clk.c                         | 244 +++++++
>  drivers/clk/rockchip/clk.h                         | 347 ++++++++++
>  drivers/clk/rockchip/softrst.c                     | 118 ++++
>  include/dt-bindings/clock/rk3066a-cru.h            |  35 +
>  include/dt-bindings/clock/rk3188-cru-common.h      | 249 +++++++
>  include/dt-bindings/clock/rk3188-cru.h             |  51 ++
>  include/dt-bindings/clock/rk3288-cru.h             | 278 ++++++++
>  21 files changed, 3386 insertions(+), 626 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt
>  delete mode 100644 arch/arm/boot/dts/rk3066a-clocks.dtsi
>  delete mode 100644 arch/arm/boot/dts/rk3188-clocks.dtsi
>  create mode 100644 drivers/clk/rockchip/clk-pll.c
>  create mode 100644 drivers/clk/rockchip/clk-rk3188.c
>  create mode 100644 drivers/clk/rockchip/clk-rk3288.c
>  create mode 100644 drivers/clk/rockchip/clk.c
>  create mode 100644 drivers/clk/rockchip/clk.h
>  create mode 100644 drivers/clk/rockchip/softrst.c
>  create mode 100644 include/dt-bindings/clock/rk3066a-cru.h
>  create mode 100644 include/dt-bindings/clock/rk3188-cru-common.h
>  create mode 100644 include/dt-bindings/clock/rk3188-cru.h
>  create mode 100644 include/dt-bindings/clock/rk3288-cru.h
> 
> -- 
> 1.9.0
> 
> 
