From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 24 Mar 2016 17:49:57 +0100
Subject: [PATCH v3 00/18] Add Initial support for PLX Technology OX810SE
Message-ID: <1458838215-23314-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This serie adds initial support (IRQ, Timer, GPIO, Reset, Serial, Clocks) for
the PLX Technology OX810SE used in the well-known Western Digital My Book
World Edition Network Attached Storage device.

Extended support for SATA, DMA and Ethernet will come in further patches.

Upstream support for following devices like the OX820SE is welcome !

v3 changes :
 - use SoC specific compatible for interrupt controller
 - use SoC specific compatible for dual timers, cleanup up width management
 - full rewrite of pinctrl and gpio based on the pic32 code
 - empty arm/arm/mach-oxnas/Makefile removal
 - dtsi update with timer&irq compatible and pinctrl rewrite

v2 changes : http://lkml.kernel.org/r/1457519060-6038-1-git-send-email-narmstrong at baylibre.com
- switch all compatible string to oxsemi,ox820se
- add oxsemi to prefixes
- switch to versatile-fpga interrupt controller with new compatible
- switch to sp804 timer with new timer width property
- cleanup of mach-oxnas (removal of generic oxnas.c)
- cleanup of standard clock to a platform driver

v1 : http://lkml.kernel.org/r/1457005210-18485-1-git-send-email-narmstrong at baylibre.com

Neil Armstrong (18):
  clocksource: sp804: Add support for OX810SE 24bit timer width
  dt-bindings: timer: sp804: add new compatible for OX810SE SoC
  irqchip: versatile-fpga: add new compatible for OX810SE SoC
  dt-bindings: irq: arm,versatile-fpga: add compatible string for
    OX810SE SoC
  dt-bindings: vendor-prefixes: Add PLX Technology
  dt-bindings: Add Oxford Semiconductors to vendor prefixes
  reset: Add PLX Technology Reset Controller driver
  dt-bindings: Add PLX Technology Reset Controller bindings
  clk: Add PLX Technology OXNAS Standard Clocks
  dt-bindings: Add PLX Technology OXNAS Standard Clocks bindings
  pinctrl: Add PLX Technology OXNAS pinctrl and gpio driver
  dt-bindings: Add PLX Technology OXNAS pinctrl and gpio bindings
  arm: Add new mach-oxnas
  arm: Add build support for mach-oxnas
  arm: boot: dts: Add PLX Technology OX810SE dtsi
  dt-bindings: Add OXNAS bindings
  dt-bindings: Add Western Digital to vendor prefixes
  arm: boot: dts: Add Western Digital My Book World Edition device tree

 Documentation/devicetree/bindings/arm/oxnas.txt    |   9 +
 .../devicetree/bindings/clock/plxtech,stdclk.txt   |  35 +
 .../devicetree/bindings/gpio/gpio_oxnas.txt        |  47 ++
 .../arm,versatile-fpga-irq.txt                     |   2 +-
 .../bindings/pinctrl/plxtech,pinctrl.txt           |  57 ++
 .../devicetree/bindings/reset/plxtech,reset.txt    |  58 ++
 .../devicetree/bindings/timer/arm,sp804.txt        |   2 +-
 .../devicetree/bindings/vendor-prefixes.txt        |   5 +-
 arch/arm/Kconfig                                   |   2 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/ox810se.dtsi                     | 336 +++++++++
 arch/arm/boot/dts/wd-mbwe.dts                      | 112 +++
 arch/arm/mach-oxnas/Kconfig                        |  25 +
 drivers/clk/Kconfig                                |   6 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-oxnas.c                            | 202 +++++
 drivers/clocksource/timer-sp804.c                  |  40 +-
 drivers/irqchip/irq-versatile-fpga.c               |   1 +
 drivers/pinctrl/Kconfig                            |  11 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-oxnas.c                    | 837 +++++++++++++++++++++
 drivers/reset/Kconfig                              |   3 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-oxnas.c                        | 136 ++++
 include/clocksource/timer-sp804.h                  |  11 +-
 25 files changed, 1921 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/oxnas.txt
 create mode 100644 Documentation/devicetree/bindings/clock/plxtech,stdclk.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/plxtech,pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/reset/plxtech,reset.txt
 create mode 100644 arch/arm/boot/dts/ox810se.dtsi
 create mode 100644 arch/arm/boot/dts/wd-mbwe.dts
 create mode 100644 arch/arm/mach-oxnas/Kconfig
 create mode 100644 drivers/clk/clk-oxnas.c
 create mode 100644 drivers/pinctrl/pinctrl-oxnas.c
 create mode 100644 drivers/reset/reset-oxnas.c

-- 
1.9.1
