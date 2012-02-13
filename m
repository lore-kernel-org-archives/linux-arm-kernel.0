From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 13 Feb 2012 15:43:00 +0100
Subject: [PATCH 0/9] ARM: at91: irqdomain and device tree for AIC and GPIO
Message-ID: <1329144189-4535-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds irqdomain and device tree support for both the
interrupt and GPIO controllers of AT91 SoC.

The series has already been sent some time ago but has been
reworked to address Rob and Grant comments. The reworked patches
are marked with corresponding "vX" tags...

The series can go on top of Grant's patch series and depends on it:
"[PATCH v3 00/25] irq_domain generalization and refinement".

It also depends on the material already sent for at91 (base, pm_cleanup,
device-board, 9x5 branches on arm-soc).

The 3.3-rc3 is needed if you whish to test them (ioremap fix by Russell).

The USB driver modification will need a "Acked-by" from someone at linux-usb.

Note that I have remove all "Acked-by" form first round as the patches are
deeply modified.

All this is available here:
git://github.com/at91linux/linux-at91.git  nfe/at91-3.4-base2+3.3-rc3+irqdomain+aic_gpio6

Nicolas Ferre (9):
      ARM: at91/aic: add irq domain and device tree support
      ARM: at91/snapper9260: move gpio_to_irq out of structure initialization
      ARM/USB: at91/ohci-at91: remove the use of irq_to_gpio
      ARM: at91/gpio: change comments and one variable name
      ARM: at91/gpio: add irqdomain and DT support
      ARM: at91/gpio: non-DT builds do not have gpio_chip.of_node field
      ARM: at91/gpio: add .to_irq gpio_chip handler
      ARM: at91/gpio: remove the static specification of gpio_chip.base
      ARM: at91/board-dt: remove AIC irq domain from board file

 .../devicetree/bindings/arm/atmel-aic.txt          |   38 +++
 .../devicetree/bindings/gpio/gpio_atmel.txt        |   20 ++
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/at91sam9g20.dtsi                 |   48 +++-
 arch/arm/boot/dts/at91sam9g45.dtsi                 |   66 ++++-
 arch/arm/mach-at91/board-dt.c                      |    8 -
 arch/arm/mach-at91/board-snapper9260.c             |   10 +-
 arch/arm/mach-at91/gpio.c                          |  287 +++++++++++++++-----
 arch/arm/mach-at91/include/mach/gpio.h             |   12 -
 arch/arm/mach-at91/include/mach/irqs.h             |    3 +-
 arch/arm/mach-at91/irq.c                           |   74 ++++-
 drivers/usb/host/ohci-at91.c                       |    5 +-
 12 files changed, 453 insertions(+), 119 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/atmel-aic.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio_atmel.txt
