From: mesihkilinc@gmail.com (Mesih Kilinc)
Date: Sun, 25 Nov 2018 10:43:02 +0300
Subject: [RFC PATCH v4 00/17] initial support for "suniv" Allwinner new ARM9
 SoC
Message-ID: <cover.1543131714.git.mesihkilinc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the fourth version of RFC patchset for Allwinner ARMv5 F1C100s
SoC. Addressed comments from Maxime Ripard, added Acked-by signatures.

Changes since v3:
- Patch "ARM: Check ARCH_MULTI_V7 to differentiate ARMv5/v7 Allwinner SoCs"
  - Remove CONFIG_ARCH_SUNXI_Vx. Use ARCH_MULTI_Vx to differentiate SoC's
  - Change KConfig ARCH_SUNXI selection: 'select' to 'default'. 
- Patch "irqchip/sun4i: Add a struct to hold global variables"
  - Split irq_sun4i.c changes to 3 patch.
- Patch "pinctrl: sunxi: add support for suniv F1C100s (newer F-series SoCs)"
  - pinctrl-suniv-f1c100s: remove: disable_strict_mode = true
- Patch "ARM: dts: suniv: add initial DTSI file for F1C100s"
  - suniv-f1c100s.dtsi: remove unnecessary componenets.
  - Instead of patching drivers, add original compatible string with 
f1c100s compatibles.
  - Add Acked-by signatures.

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

Thanks!

Mesih Kilinc (17):
  ARM: Check ARCH_MULTI_V7 to differentiate ARMv5/v7 Allwinner SoCs
  dt-bindings: arm: Add new Allwinner ARMv5 F1C100s SoC
  ARM: sunxi: add Allwinner ARMv5 SoCs
  dt-bindings: interrupt-controller: Add suniv interrupt-controller
  irqchip/sun4i: Add a struct to hold global variables
  irqchip/sun4i: Move IC specific register offsets to struct
  irqchip/sun4i: Add support for Allwinner ARMv5 F1C100s
  dt-bindings: timer: Add Allwinner suniv timer
  clocksource: sun4i: add a compatible for suniv
  dt-bindings: pinctrl: Add Allwinner suniv F1C100s pinctrl
  pinctrl: sunxi: add support for suniv F1C100s (newer F-series SoCs)
  dt-bindings: clock: Add Allwinner suniv F1C100s CCU
  clk: sunxi-ng: add support for suniv F1C100s SoC
  dt-bindings: sram: Add Allwinner suniv F1C100s
  dt-bindings: watchdog: Add Allwinner ARMv5 F1C100s wdt
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
 arch/arm/boot/dts/suniv-f1c100s.dtsi               | 147 ++++++
 arch/arm/mach-sunxi/Kconfig                        |  19 +-
 arch/arm/mach-sunxi/sunxi.c                        |  10 +
 drivers/clk/sunxi-ng/Kconfig                       |   5 +
 drivers/clk/sunxi-ng/Makefile                      |   1 +
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c           | 536 +++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h           |  34 ++
 drivers/clocksource/sun4i_timer.c                  |   5 +-
 drivers/irqchip/irq-sun4i.c                        | 106 ++--
 drivers/pinctrl/sunxi/Kconfig                      |   4 +
 drivers/pinctrl/sunxi/Makefile                     |   1 +
 drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c      | 416 ++++++++++++++++
 include/dt-bindings/clock/suniv-ccu-f1c100s.h      |  69 +++
 include/dt-bindings/reset/suniv-ccu-f1c100s.h      |  37 ++
 23 files changed, 1401 insertions(+), 33 deletions(-)
 create mode 100644 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
 create mode 100644 arch/arm/boot/dts/suniv-f1c100s.dtsi
 create mode 100644 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c
 create mode 100644 include/dt-bindings/clock/suniv-ccu-f1c100s.h
 create mode 100644 include/dt-bindings/reset/suniv-ccu-f1c100s.h

-- 
2.7.4
