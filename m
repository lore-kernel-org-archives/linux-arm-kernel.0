From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 19 Oct 2016 17:21:11 +0200
Subject: [PATCH v2 0/9] irqchip: meson: add support for the gpio interrupt
 controller
Message-ID: <1476890480-8884-1-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for the GPIO interrupt controller found
on Amlogic's meson SoC families.

Unlike what the name suggests, this controller is not part of the SoC GPIO
subsystem. It's an indepedent controller which can watch almost all pad of
the SoC and generate and interrupt from it. Some pins, which are not part
of the public datasheet, don't seem to have this capability though.

Hardware wise, the controller is a 256 to 8 multiplexer. It can take up
to 256 input pads and route them to any of 8 GIC's interrupts. There is
also a filter block in the middle to select the appropriate edge or level.

The number of interrupt declared by the irqchip is lowered from 256 to the
actual number of signal routed to the controller on each SoC family. As we
have access to only 8 GIC?s interrupts, these are allocated when an
interrupt is requested from the controller, on a first come, first served
basis.

This series has been tested on Amlogic S905-P200 board with the front
panel power button. Directly passing an IRQ or using gpio_to_irq both work
with this driver.

This work is derived from the previous work of Carlo Caione [1].

Changes since RFC : [2]
 * Remove interrupt property in device tree: the controller cannot generate
   interrupts on its own and is merely routing the interrupt to the GIC,
   therefore it should not use the interrupt property. This data is now
   stored directly in the driver, same as the pinctrl data.

 * Improve compatibility checking of meson pinctrl on its interrupt parent
   to activate gpio_to_irq callback

 * Drop IRQ_BOTH hack. Need more work to have an acceptable solution for
   this

Changes since v1 : [3]
 * Correct mistake in patch 4 when no compatible controller is found. Sorry
   for the inconvenience.

[1] : http://lkml.kernel.org/r/1448987062-31225-1-git-send-email-carlo at caione.org
[2] : http://lkml.kernel.org/r/1475593708-10526-1-git-send-email-jbrunet at baylibre.com
[3] : http://lkml.kernel.org/r/1476871709-8359-1-git-send-email-jbrunet at baylibre.com

Jerome Brunet (9):
  irqchip: meson: add support for gpio interrupt controller
  dt-bindings: interrupt-controller: add DT binding for meson GPIO
    interrupt controller
  pinctrl: meson: update pinctrl data with gpio irq data
  pinctrl: meson: allow gpio to request irq
  dt-bindings: pinctrl: meson: update gpio dt-bindings
  ARM64: meson: enable MESON_IRQ_GPIO in Kconfig
  ARM: meson: enable MESON_IRQ_GPIO in Kconfig for meson8
  ARM64: dts: amlogic: enable gpio interrupt controller on gxbb
  ARM: dts: amlogic: enable gpio interrupt controller on meson8

 .../amlogic,meson-gpio-intc.txt                    |  31 ++
 .../devicetree/bindings/pinctrl/meson,pinctrl.txt  |   4 +
 arch/arm/boot/dts/meson8.dtsi                      |  11 +
 arch/arm/boot/dts/meson8b.dtsi                     |  11 +
 arch/arm/mach-meson/Kconfig                        |   2 +
 arch/arm64/Kconfig.platforms                       |   1 +
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   9 +
 drivers/irqchip/Kconfig                            |   9 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-meson-gpio.c                   | 423 +++++++++++++++++++++
 drivers/pinctrl/Kconfig                            |   2 +
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c         |  24 +-
 drivers/pinctrl/meson/pinctrl-meson.c              |  77 +++-
 drivers/pinctrl/meson/pinctrl-meson.h              |  17 +-
 drivers/pinctrl/meson/pinctrl-meson8.c             |  22 +-
 drivers/pinctrl/meson/pinctrl-meson8b.c            |  34 +-
 16 files changed, 641 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
 create mode 100644 drivers/irqchip/irq-meson-gpio.c

-- 
2.7.4
