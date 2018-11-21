From: mesihkilinc@gmail.com (Mesih Kilinc)
Date: Wed, 21 Nov 2018 21:30:33 +0300
Subject: [RFC PATCH v3 00/17] initial support for "suniv" Allwinner new ARM9
 SoC
Message-ID: <cover.1542824904.git.mesihkilinc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the third version of RFC patchset for Allwinner ARMv5 F1C100s
SoC. Addressed comment from Maxime Ripard and fixed device tree
bindings to not include patterns. Also sram and watchdog compatibles
added for F1C100s.

irqchip code reworked to include a struct to differentiate chips.

Thanks!

Original cover later:

This is the RFC initial patchset for the "new" Allwinner SUNIV ARM9 SoC.

The same die is packaged differently, come with different co-packaged
DRAM or shipped with different SDK; and then made many model names: F23,
F25, F1C100A, F1C100S, F1C200S, F1C500, F1C600, R6, etc. These SoCs all
share a common feature set and are packaged similarly (eLQFP128 for SoCs
without co-packaged DRAM, QFN88 for with DRAM). As their's no
functionality hidden on the QFN88 models (except DRAM interface not
exported), it's not clever to differentiate them. So I will use suniv as
common name of all these SoCs.

As it's the first not ARMv7+ Allwinner SoC to get supported, this
patchset firstly made CONFIG_ARCH_SUNXI a common config item, and let
selectable CONFIG_ARCH_SUNXI_V{5,7} to internally select it. This makes
reusing most work possible. This is PATCH 1~2.

The ARM9 has neither GIC nor arch_timer, like the sun4i/5i Cortex-A8
SoCs. So adapt the IRQ and timer driver used by sun4i/5i to support
suniv. This is PATCH 3~5.

Then it's the common way to support a new SoC -- pinctrl, CCU and
initial DT.

Changes since v2:
- Patch "ARM: sunxi: add Allwinner ARMv5 SoCs"
  - Move SUN4I_TIMER option to ARCH_SUNXI
  - Added help text for MACH_SUNIV
- Patch "irqchip/sun4i: add support for suniv interrupt controller"
  - Defined sunxi_irq_chip_data struct and used it to differentiate
    registers between different chips.
- Patch " ARM: dts: suniv: add initial DTSI file for F1C100s"
  - Removed unnecessary fake clock.
  - Fixed compatible strings.

Changes since v1:
- Patch "ARM: add CONFIG_ARCH_SUNXI_V7 for differentiate ARMv5/v7
  Allwinner SoCs"
  - Instead of using a common bool config use a common menuconfig. 
  - Use ARCH_MULTI_V7 to differentiate V7 SoCs.
  - Addressed comment from Julian Calaby
- Patch "ARM: sunxi: add Allwinner ARMv5 SoCs"
  - Use ARCH_MULTI_V5 to differentiate V5 SoCs.
  - removed "allwinner,suniv" board compatible string
  - Added dt-bindings
- Patch "irqchip/sun4i: add support for suniv interrupt controller"
  - Added dt-bindings
  - Changed "allwinner,suniv-ic" to "allwinner,suniv-f1c100s-ic"
- Patch "clocksource: sun4i: add a compatible for suniv"
  - Added dt-bindings
  - Changed "allwinner,suniv-timer" to "allwinner,suniv-f1c100s-timer"
- Patch "pinctrl: sunxi: add support for suniv F1C100s (newer F-series SoCs)"
  - Added dt-bindings
  - Renamed suniv-pinctrl to suniv-f1c100s-pinctrl
- Patch "clk: sunxi-ng: add support for suniv F1C100s SoC"
  - Added dt-bindings
  - Renamed suniv-ccu to suniv-f1c100s-ccu
- Patch "ARM: suniv: f1c100s: add device tree for Lichee Pi Nano"
  - Addressed comment from Rask Ingemann Lambertsen

Mesih Kilinc (17):
  ARM: add CONFIG_ARCH_SUNXI_V7 for differentiate ARMv5/v7 Allwinner
    SoCs
  dt-bindings: arm: Add new Allwinner ARMv5 F1C100s SoC
  ARM: sunxi: add Allwinner ARMv5 SoCs
  dt-bindings: interrupt-controller: Add suniv interrupt-controller
  irqchip/sun4i: add support for suniv interrupt controller
  dt-bindings: timer: Add Allwinner suniv timer
  clocksource: sun4i: add a compatible for suniv
  dt-bindings: pinctrl: Add Allwinner suniv F1C100s pinctrl
  pinctrl: sunxi: add support for suniv F1C100s (newer F-series SoCs)
  dt-bindings: clock: Add Allwinner suniv F1C100s CCU
  clk: sunxi-ng: add support for suniv F1C100s SoC
  dt-bindings: sram: Add Allwinner suniv F1C100s
  SoC: sunxi: Add support for Allwinner ARMv5 F1C100s sram
  dt-bindings: watchdog: Add Allwinner ARMv5 F1C100s wdt
  watchdog: Add support for Allwinner ARMv5 F1C100s wdt
  ARM: dts: suniv: add initial DTSI file for F1C100s
  ARM: suniv: f1c100s: add device tree for Lichee Pi Nano

 Documentation/devicetree/bindings/arm/sunxi.txt    |   1 +
 .../devicetree/bindings/clock/sunxi-ccu.txt        |   1 +
 .../interrupt-controller/allwinner,sun4i-ic.txt    |   4 +-
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
 .../devicetree/bindings/sram/sunxi-sram.txt        |   4 +
 .../bindings/timer/allwinner,sun4i-timer.txt       |   4 +-
 .../devicetree/bindings/watchdog/sunxi-wdt.txt     |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts  |  26 +
 arch/arm/boot/dts/suniv-f1c100s.dtsi               | 151 ++++++
 arch/arm/mach-sunxi/Kconfig                        |  39 +-
 arch/arm/mach-sunxi/sunxi.c                        |  10 +
 drivers/clk/sunxi-ng/Kconfig                       |   5 +
 drivers/clk/sunxi-ng/Makefile                      |   1 +
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c           | 536 +++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h           |  34 ++
 drivers/clocksource/sun4i_timer.c                  |   5 +-
 drivers/irqchip/irq-sun4i.c                        | 104 ++--
 drivers/pinctrl/sunxi/Kconfig                      |   4 +
 drivers/pinctrl/sunxi/Makefile                     |   1 +
 drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c      | 417 ++++++++++++++++
 drivers/soc/sunxi/sunxi_sram.c                     |   8 +
 drivers/watchdog/sunxi_wdt.c                       |   1 +
 include/dt-bindings/clock/suniv-ccu-f1c100s.h      |  69 +++
 include/dt-bindings/reset/suniv-ccu-f1c100s.h      |  37 ++
 25 files changed, 1425 insertions(+), 41 deletions(-)
 create mode 100644 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
 create mode 100644 arch/arm/boot/dts/suniv-f1c100s.dtsi
 create mode 100644 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c
 create mode 100644 include/dt-bindings/clock/suniv-ccu-f1c100s.h
 create mode 100644 include/dt-bindings/reset/suniv-ccu-f1c100s.h

-- 
2.7.4
