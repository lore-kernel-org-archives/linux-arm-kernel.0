From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 20 Jan 2018 07:17:26 +0800
Subject: [RFC PATCH 0/9] initial support for "suniv" Allwinner new ARM9 SoC
Message-ID: <20180119231735.61504-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

Icenowy Zheng (9):
  ARM: add CONFIG_ARCH_SUNXI_V7 for differentiate ARMv5/v7 Allwinner
    SoCs
  ARM: sunxi: add Allwinner ARMv5 SoCs
  irqchip/sun4i: add support for suniv interrupt controller
  clocksource: sun4i: add a compatible for suniv
  clocksource/drivers/sun4i: register as sched_clock on suniv
  pinctrl: sunxi: add support for suniv (newer F-series SoCs)
  clk: sunxi-ng: add support for suniv SoC
  ARM: dts: suniv: add initial DTSI file for suniv and F1C100s
  ARM: suniv: f1c100s: add device tree for Lichee Pi Nano

 arch/arm/boot/dts/Makefile                        |   2 +
 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts |  27 ++
 arch/arm/boot/dts/suniv-f1c100s.dtsi              |   6 +
 arch/arm/boot/dts/suniv.dtsi                      | 157 +++++++
 arch/arm/configs/multi_v7_defconfig               |   2 +-
 arch/arm/configs/sunxi_defconfig                  |   2 +-
 arch/arm/mach-sunxi/Kconfig                       |  27 +-
 arch/arm/mach-sunxi/Makefile                      |   3 +-
 arch/arm/mach-sunxi/sunxi_v5.c                    |  22 +
 drivers/clk/sunxi-ng/Kconfig                      |   5 +
 drivers/clk/sunxi-ng/Makefile                     |   1 +
 drivers/clk/sunxi-ng/ccu-suniv.c                  | 536 ++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-suniv.h                  |  34 ++
 drivers/clocksource/sun4i_timer.c                 |   5 +-
 drivers/irqchip/irq-sun4i.c                       |  43 +-
 drivers/pinctrl/sunxi/Kconfig                     |   4 +
 drivers/pinctrl/sunxi/Makefile                    |   1 +
 drivers/pinctrl/sunxi/pinctrl-suniv.c             | 417 +++++++++++++++++
 include/dt-bindings/clock/suniv-ccu.h             |  69 +++
 include/dt-bindings/reset/suniv-ccu.h             |  37 ++
 20 files changed, 1389 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
 create mode 100644 arch/arm/boot/dts/suniv-f1c100s.dtsi
 create mode 100644 arch/arm/boot/dts/suniv.dtsi
 create mode 100644 arch/arm/mach-sunxi/sunxi_v5.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-suniv.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-suniv.h
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-suniv.c
 create mode 100644 include/dt-bindings/clock/suniv-ccu.h
 create mode 100644 include/dt-bindings/reset/suniv-ccu.h

-- 
2.14.2
