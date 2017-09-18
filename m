From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 18 Sep 2017 15:46:08 +0200
Subject: [PATCH v4 0/2] irqchip: meson: add support for the gpio interrupt
 controller
In-Reply-To: <20170918134610.17743-1-jbrunet@baylibre.com>
References: <20170918134610.17743-1-jbrunet@baylibre.com>
Message-ID: <20170918134610.17743-2-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for the GPIO interrupt controller found on
Amlogic's meson SoC families.

Unlike what the name suggests, this controller is not part of the SoC
GPIO subsystem. It is a separate controller which can watch almost all
gpio pads of the SoC and generate and interrupt from it. "Almost" because
there are always exceptions and some specific gpios (TEST_N) lack this
capability.

Hardware wise, the controller is a 256 to 8 router with a filtering block
to select edge or level input and the polarity of the signal. We can't
setup the filtring to generate a signal on both the high and low polarity
so, ATM, IRQ_TYPE_EDGE_BOTH is not supported.

The number of interrupt line routed to the controller depends on the SoC,
and essentially the total number of GPIO available on the different gpio
controllers of the SoC.

This series has been tested on Amlogic S905-P200 board with the front
panel power button. Also tested on the Nanopi-k2 with the ethernet PHY
interrupt pin.

This work is derived from the previous work of Carlo Caione [1].

Changes since RFC : [2]
* Remove interrupt property in device tree: the controller cannot
  generate interrupts on its own and is merely routing the interrupt to
  the GIC, therefore it should not use the interrupt property. This data
  is now stored directly in the driver, same as the pinctrl data.
* Improve compatibility checking of meson pinctrl on its interrupt
  parent to activate gpio_to_irq callback
* Drop IRQ_BOTH hack. Need more work to have an acceptable solution for
  this

Changes since v1 : [3]
* Correct mistake in patch 4 when no compatible
  controller is found. Sorry for the inconvenience.

Changes since v2: [4]
* Address Marc's comment on the irqchip driver from v2
* Drop all gpio subsystem related patches. This will be dealt with
  separately.

Changes since v3: [5]
* Replace "upstream" irq with "channel" irq
* Improve documentation a bit.
* Drop DT patches: these will be sent later on to the DT maintainer
  if/when the driver is accepted.

[1] : https://lkml.kernel.org/r/1448987062-31225-1-git-send-email-carlo at caione.org
[2] : https://lkml.kernel.org/r/1475593708-10526-1-git-send-email-jbrunet at baylibre.com
[3] : https://lkml.kernel.org/r/1476871709-8359-1-git-send-email-jbrunet at baylibre.com
[4] : https://lkml.kernel.org/r/1476890480-8884-1-git-send-email-jbrunet at baylibre.com
[5] : https://lkml.kernel.org/r/20170615161804.32658-1-jbrunet at baylibre.com

Jerome Brunet (2):
  dt-bindings: interrupt-controller: add DT binding for meson GPIO
    interrupt controller
  irqchip: meson: add support for gpio interrupt controller

 .../amlogic,meson-gpio-intc.txt                    |  35 ++
 drivers/irqchip/Kconfig                            |   8 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-meson-gpio.c                   | 414 +++++++++++++++++++++
 4 files changed, 458 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
 create mode 100644 drivers/irqchip/irq-meson-gpio.c

-- 
2.13.5
