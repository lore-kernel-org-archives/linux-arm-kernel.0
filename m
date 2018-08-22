From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 Aug 2018 22:41:00 +0200
Subject: [PATCH 00/11] Reform EP93xx GPIO
Message-ID: <20180822204111.9581-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is a spin-off of a patch from Arnd that started to
decouple the EP93xx GPIO driver from the code inside
arch/arm.

The driver needed some modernization and in the end I managed
to convert two of the banks to use GPIOLIB_IRQCHIP and use
a proper irqdomain.

The F bank presents a special problem that I need to think
about, because since there is one IRQ per GPIO line it is
essentially a hierarchical irqdomain.

This was tested on the SIM.ONE where I rigged lines on some
of the GPIOs on a board connector. It's crude but gives
interrupts and behave as expected before and after these
changes, the main visible change being that the hardware
IRQ line on each port appears in /proc/interrupts.

It would be great if some EP93xx users could test this
(especially something using bank F) so I can get it into
shape and merge as a baseline for further refactorings.

Arnd Bergmann (1):
  ARM/gpio: ep93xx: build standalone

Linus Walleij (10):
  gpio: ep93xx: Cut down variable names
  gpio: ep93xx: Switch to SPDX license tag
  gpio: ep93xx: Pass around struct gpio_chip
  gpio: ep93xx: Rename has_debounce to has_irq
  gpio: ep93xx: Properly call the chained IRQ handler
  gpio: ep93xx: Do not pingpong irq numbers
  gpio: ep93xx: Use the hwirq and port
  gpio: ep93xx: Use for_each_set_bit() in IRQ handler
  gpio: ep93xx: Cut gpio_to_irq() usage
  gpio: ep93xx: Switch A and B to use GPIOLIB_IRQCHIP

 arch/arm/mach-ep93xx/core.c |   9 ++
 drivers/gpio/Kconfig        |   1 +
 drivers/gpio/gpio-ep93xx.c  | 297 +++++++++++++++++++++---------------
 3 files changed, 181 insertions(+), 126 deletions(-)

-- 
2.17.1
