From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Mon, 16 Dec 2013 21:24:11 +0100
Subject: [RFC PATCH 00/10] ARM: at91: move aic driver to drivers/irqchips
Message-ID: <1387225461-6201-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series is a proposal to move AIC driver to the irqchip directory.

It also changes the implementation design of the interrupt controller in
several ways:
 - make use of the generic chip framework whenever possible
 - add support for irq muxing definition to prevent spurious interrupts
   during system startup (see https://lkml.org/lkml/2013/3/8/175)
 - only support dt enabled boards


Best Regards,

Boris

Boris BREZILLON (10):
  genirq: generic chip: export irq_map_generic_chip function
  irqchip: atmel-aic: add new atmel AIC driver
  ARM: at91: introduce OLD_IRQ_AT91 Kconfig option
  ARM: at91: enclose at91_aic_xx calls in
    IS_ENABLED(CONFIG_OLD_IRQ_AT91) blocks
  ARM: at91: make use of the new AIC driver for dt enabled boards
  irqchip: atmel-aic: move binding doc to interrupt-controller
    directory
  irqchip: atmel-aic: document new dt properties and children nodes
  ARM: at91: remove old irq material
  ARM: at91/dt: add new AIC irq mux definitions
  ARM: at91/dt: add new AIC irq mux definitions for sama5 SoCs

 .../devicetree/bindings/arm/atmel-aic.txt          |   41 -
 .../bindings/interrupt-controller/atmel,aic.txt    |   86 ++
 arch/arm/boot/dts/at91sam9x5.dtsi                  |  111 ++-
 arch/arm/boot/dts/sama5d3.dtsi                     |   40 +-
 arch/arm/boot/dts/sama5d3_tcb1.dtsi                |   22 +
 arch/arm/mach-at91/Kconfig                         |   11 +
 arch/arm/mach-at91/Kconfig.non_dt                  |    7 +
 arch/arm/mach-at91/Makefile                        |    3 +-
 arch/arm/mach-at91/board-dt-rm9200.c               |   13 -
 arch/arm/mach-at91/board-dt-sam9.c                 |   14 -
 arch/arm/mach-at91/board-dt-sama5.c                |   13 -
 arch/arm/mach-at91/irq.c                           |  270 +-----
 arch/arm/mach-at91/pm.c                            |   32 +-
 arch/arm/mach-at91/setup.c                         |    3 +-
 drivers/irqchip/Makefile                           |    1 +
 drivers/irqchip/irq-atmel-aic.c                    |  879 ++++++++++++++++++++
 include/linux/irq.h                                |    2 +
 kernel/irq/generic-chip.c                          |    5 +-
 18 files changed, 1189 insertions(+), 364 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/atmel-aic.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
 create mode 100644 drivers/irqchip/irq-atmel-aic.c

-- 
1.7.9.5
