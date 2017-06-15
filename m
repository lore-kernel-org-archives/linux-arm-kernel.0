From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 15 Jun 2017 18:17:58 +0200
Subject: [PATCH v3 0/6] irqchip: meson: add support for the gpio interrupt
 controller
Message-ID: <20170615161804.32658-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for the GPIO interrupt controller found on
Amlogic's meson SoC families.

Unlike what the name suggests, this controller is not part of the SoC
GPIO subsystem. It is a separate controller from which can watch almost
all pads of the SoC and generate and interrupt from it. Some pins, which
are not part of the public datasheet, don't seem to have this capability
though.

Hardware wise, the controller is a 256 to 8 router with filtering block
to select edge or level input and the polarity of the signal.  As there
we can't setup the filtring to generate a signal on both the high and low
polarity, there is no easy way to support IRQ_TYPE_EDGE_BOTH at the
moment

The number of interrupt line routed to the controller depends on the SoC,
and essentially the number of GPIO available on the SoC.

This series has been tested on Amlogic S905-P200 board with the front
panel power button.

This work is derived from the previous work of Carlo Caione [1].

Changes since RFC : [2]
* Remove interrupt property in device tree: the controller cannot generate
  interrupts on its own and is merely routing the interrupt to the GIC,
  therefore it should not use the interrupt property. This data is now
  stored directly in the driver, same as the pinctrl data.
* Improve compatibility checking of meson pinctrl on its interrupt
  parent to activate gpio_to_irq callback
* Drop IRQ_BOTH hack. Need more work to have an acceptable solution for
  this

Changes since v1 : [3]
* Correct mistake in patch 4 when no compatible
  controller is found. Sorry for the inconvenience.

Changes since v2: [4]
* Address Marc's comment on the irqchip driver from v2
* Drop all gpio subsystem related patches. Discussion regarding
  the issue faced will be initiated.

[1] : https://lkml.kernel.org/r/1448987062-31225-1-git-send-email-carlo at caione.org
[2] : https://lkml.kernel.org/r/1475593708-10526-1-git-send-email-jbrunet at baylibre.com
[3] : https://lkml.kernel.org/r/1476871709-8359-1-git-send-email-jbrunet at baylibre.com
[4] : https://lkml.kernel.org/r/1476890480-8884-1-git-send-email-jbrunet at baylibre.com

Jerome Brunet (6):
  dt-bindings: interrupt-controller: add DT binding for meson GPIO
    interrupt controller
  irqchip: meson: add support for gpio interrupt controller
  ARM: meson: enable MESON_IRQ_GPIO in Kconfig for meson8b
  ARM64: meson: enable MESON_IRQ_GPIO in Kconfig
  ARM: dts: meson8b: enable gpio interrupt controller
  ARM64: dts: meson-gx: add gpio interrupt controller

 .../amlogic,meson-gpio-intc.txt                    |  35 ++
 arch/arm/boot/dts/meson.dtsi                       |   9 +
 arch/arm/boot/dts/meson8b.dtsi                     |   6 +
 arch/arm/mach-meson/Kconfig                        |   1 +
 arch/arm64/Kconfig.platforms                       |   1 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |   9 +
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   6 +
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |   6 +
 drivers/irqchip/Kconfig                            |   8 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-meson-gpio.c                   | 407 +++++++++++++++++++++
 11 files changed, 489 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
 create mode 100644 drivers/irqchip/irq-meson-gpio.c

-- 
2.9.4
