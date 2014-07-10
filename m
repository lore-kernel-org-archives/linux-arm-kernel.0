From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 10 Jul 2014 19:14:15 +0200
Subject: [PATCH v4 0/7] ARM: at91: move aic driver to drivers/irqchips
Message-ID: <1405012462-766-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series moves the AIC driver to the irqchip directory and make use of
the generic chip framework whenever possible.

This driver only support DT boards (all legacy board files should be soon
replaced by their DT versions).

Since the last version AIC and AIC5 code have been split and common
functions have been moved to irq-atmel-aic-common.c.
I know there is not much code in this file and it could have been
duplicated in AIC and AIC5 drivers, but I'm planning to add more common
stuff soon (AIC irq fixups previously done in
arch/arm/mach-at91/sysirq_mask.c).

Jason, if everybody is fine with this version could you share a topic
branch  containing patch 1 to 3 with Nicolas ?

Thanks.

Best Regards,

Boris

Changes since v3:
 - split AIC and AIC5 code

Changes since v2:
 - remove irq line muxing definition
 - rework Kconfig options

Changes since v1:
 - rework the irq-mux bindings


Boris BREZILLON (7):
  genirq: generic chip: export irq_map_generic_chip function
  irqchip: atmel-aic: move binding doc to interrupt-controller directory
  irqchip: atmel-aic: Add atmel AIC/AIC5 drivers
  ARM: at91: introduce OLD_IRQ_AT91 Kconfig option
  ARM: at91: enclose at91_aic_xx calls in
    IS_ENABLED(CONFIG_OLD_IRQ_AT91) blocks
  ARM: at91: make use of the new AIC driver for dt enabled boards
  ARM: at91: remove old irq material

 .../atmel,aic.txt}                                 |   0
 arch/arm/mach-at91/Kconfig                         |  17 +-
 arch/arm/mach-at91/Kconfig.non_dt                  |   6 +
 arch/arm/mach-at91/Makefile                        |   3 +-
 arch/arm/mach-at91/board-dt-rm9200.c               |  13 -
 arch/arm/mach-at91/board-dt-sam9.c                 |  13 -
 arch/arm/mach-at91/board-dt-sama5.c                |  13 -
 arch/arm/mach-at91/irq.c                           | 270 +---------------
 arch/arm/mach-at91/pm.c                            |  32 +-
 arch/arm/mach-at91/setup.c                         |   3 +-
 drivers/irqchip/Kconfig                            |  14 +
 drivers/irqchip/Makefile                           |   2 +
 drivers/irqchip/irq-atmel-aic-common.c             | 207 +++++++++++++
 drivers/irqchip/irq-atmel-aic-common.h             |  35 +++
 drivers/irqchip/irq-atmel-aic.c                    | 247 +++++++++++++++
 drivers/irqchip/irq-atmel-aic5.c                   | 341 +++++++++++++++++++++
 include/linux/irq.h                                |   2 +
 kernel/irq/generic-chip.c                          |   5 +-
 18 files changed, 896 insertions(+), 327 deletions(-)
 rename Documentation/devicetree/bindings/{arm/atmel-aic.txt => interrupt-controller/atmel,aic.txt} (100%)
 create mode 100644 drivers/irqchip/irq-atmel-aic-common.c
 create mode 100644 drivers/irqchip/irq-atmel-aic-common.h
 create mode 100644 drivers/irqchip/irq-atmel-aic.c
 create mode 100644 drivers/irqchip/irq-atmel-aic5.c

-- 
1.8.3.2
