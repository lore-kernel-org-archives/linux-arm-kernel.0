From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Oct 2015 15:46:40 +0200
Subject: [PATCH 00/13] Device Tree support for RealView PB11MPCore
Message-ID: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set gives an almost feature-complete device tree boot
on the ARM PM11MPCore platform.

Remains to be done before deleting the board files:

- Flash protection: the board has flash protection through the
  system controller. Last time I tried to fix this I fried the
  flash on my PB1176 so I don't know if I dare to mess with this
  before I've recovered that board (which need to happen using
  JTAG and old Windows).

- CLCD: how the stuff merged for Vexpress device tree CLCD works
  is a mystery to me, and ideally the whole shebang should be
  rewritten to use DRM/KMS. But I guess I can fix it up some
  time.

The patches may have some rough edges but basically this is how
I imagine we should make this work. Most of the code will be
reusable for RealView PBx, EB and probably for tidying up some
of the Vexpress stuff as well.

Linus Walleij (13):
  ARM: add some L220 DT settings
  ARM: add DT bindings for the ARM11MPCore CPU cluster
  irqchips: fix ARM11MPCore GIC bindings
  irqchip/gic: support RealView variant setup
  irqchip/gic: assign irqchip dynamically
  clk: versatile-icst: convert to use regmap
  clk: versatile-icst: refactor to allocate regmap separately
  clk: add ARM syscon ICST device tree bindings
  clk: versatile-icst: add device tree support
  soc: versatile: add support for the PB11MPCore
  ARM: realview: select SP810 and ICST for the DT variant
  ARM: realview: add an DT SMP boot method
  ARM: realview: add device tree for PB11MPCore

 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 Documentation/devicetree/bindings/arm/gic.txt      |   3 +-
 Documentation/devicetree/bindings/arm/l2cc.txt     |  10 +-
 Documentation/devicetree/bindings/arm/scu.txt      |   3 +
 .../devicetree/bindings/clock/arm-syscon-icst.txt  |  40 ++
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/arm-realview-pb11mp.dts          | 681 +++++++++++++++++++++
 arch/arm/mach-realview/Kconfig                     |   4 +
 arch/arm/mach-realview/Makefile                    |   2 +-
 arch/arm/mach-realview/platsmp-dt.c                |  91 +++
 arch/arm/mm/cache-l2x0.c                           |  15 +
 drivers/clk/versatile/Kconfig                      |   1 +
 drivers/clk/versatile/clk-icst.c                   | 191 +++++-
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-gic-realview.c                 |  39 ++
 drivers/irqchip/irq-gic-realview.h                 |   5 +
 drivers/irqchip/irq-gic.c                          |  43 +-
 drivers/soc/versatile/soc-realview.c               |   4 +
 18 files changed, 1082 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/arm-syscon-icst.txt
 create mode 100644 arch/arm/boot/dts/arm-realview-pb11mp.dts
 create mode 100644 arch/arm/mach-realview/platsmp-dt.c
 create mode 100644 drivers/irqchip/irq-gic-realview.c
 create mode 100644 drivers/irqchip/irq-gic-realview.h

-- 
2.4.3
