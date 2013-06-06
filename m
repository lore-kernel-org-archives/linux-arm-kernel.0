From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Thu, 6 Jun 2013 21:07:58 +0200
Subject: [PATCH v2 0/8] arm: add basic support for Rockchip Cortex-A9 SoCs
Message-ID: <201306062107.58875.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Second version of basic Rockchip A9 support.


Changes since v1:
- addressed Linus Walleij's comments to the pinctrl driver, including the
  move to generic pinconfig (hopefully I did catch all)
- renamed the clocks to use the SoC name of the initial user
  as suggested by Olof Johansson
- fixed the uart address, found by Arnd Bergmann
- address Arnd's comments on the board file (use of_clk_init and friends,
  remove map_io, use real soc names)
- removed Makefile.boot as suggested by Thomas Petazzoni


Dependencies:
- the irqdomain support for the generic_irq from Thomas Gleixner is required
  by the pinctrl driver, which is strangely not in linux-next, only in tip.git
- "mmc: dw_mmc: Add support DW SD/MMC driver on SOCFPGA" moves the
  SDMMC_CMD_USE_HOLD_REG constant into the common header, which is required
  on these Rockchip SoCs 
- the db_apb_timer enhancements sent separately
- the pinctrl-generic option for pin-default pulls, sent today


Heiko Stuebner (8):
  clk: flag to use upper half of the register as change indicator
  clk: divider: add flag to limit possible dividers to even numbers
  mmc: dw_mmc-pltfm: remove static from dw_mci_pltfm_remove
  mmc: dw_mmc-pltfm: add Rockchip variant
  pinctrl: add pinctrl driver for Rockchip SoCs
  clk: add basic Rockchip rk3066a clock support
  arm: add debug uarts for rockchip rk29xx and rk3xxx series
  arm: add basic support for Rockchip RK3066a boards

 .../bindings/pinctrl/rockchip,pinctrl.txt          |   97 ++
 arch/arm/Kconfig                                   |    2 +
 arch/arm/Kconfig.debug                             |   34 +
 arch/arm/Makefile                                  |    1 +
 arch/arm/boot/dts/rk3066a-clocks.dtsi              |  460 +++++++
 arch/arm/boot/dts/rk3066a.dtsi                     |  359 +++++
 arch/arm/include/debug/rockchip.S                  |   42 +
 arch/arm/mach-rockchip/Kconfig                     |   17 +
 arch/arm/mach-rockchip/Makefile                    |    1 +
 arch/arm/mach-rockchip/rockchip.c                  |   54 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-divider.c                          |   29 +-
 drivers/clk/clk-gate.c                             |   24 +-
 drivers/clk/clk-mux.c                              |   15 +-
 drivers/clk/rockchip/Makefile                      |    6 +
 drivers/clk/rockchip/clk-rockchip-pll.c            |  131 ++
 drivers/clk/rockchip/clk-rockchip-pll.h            |   19 +
 drivers/clk/rockchip/clk-rockchip.c                |  313 +++++
 drivers/mmc/host/dw_mmc-pltfm.c                    |   48 +-
 drivers/pinctrl/Kconfig                            |    6 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-rockchip.c                 | 1364 ++++++++++++++++++++
 include/dt-bindings/pinctrl/rockchip.h             |   37 +
 include/linux/clk-provider.h                       |   18 +
 24 files changed, 3053 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
 create mode 100644 arch/arm/boot/dts/rk3066a-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/rk3066a.dtsi
 create mode 100644 arch/arm/include/debug/rockchip.S
 create mode 100644 arch/arm/mach-rockchip/Kconfig
 create mode 100644 arch/arm/mach-rockchip/Makefile
 create mode 100644 arch/arm/mach-rockchip/rockchip.c
 create mode 100644 drivers/clk/rockchip/Makefile
 create mode 100644 drivers/clk/rockchip/clk-rockchip-pll.c
 create mode 100644 drivers/clk/rockchip/clk-rockchip-pll.h
 create mode 100644 drivers/clk/rockchip/clk-rockchip.c
 create mode 100644 drivers/pinctrl/pinctrl-rockchip.c
 create mode 100644 include/dt-bindings/pinctrl/rockchip.h

-- 
1.7.2.3
