From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 15 Jun 2012 11:09:05 +0200
Subject: [PATCH v2 0/7] ARM: at91: add sparse irq support and introduce aic5
Message-ID: <1339751352-24296-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches introduces AIC5 support with the goal to have only one
kernel image for all SOCs. That's why sparse irq support was added.
AIC5 can manage up to 128 irq lines. It introduces a new register map and
a source select register to select the IRQ line we want to configure.

v2 changes:
- add Jean-Christophe patches since my patches are based on abd there have
not been submitted yet
- I missed some machine descriptors in the first version, it
is corrected with this new one.
- correct sparse irq support and remove mach/irqs.h.
- correct issue on AIC5 support (missing allocation).

Jean-Christophe PLAGNIOL-VILLARD (2):
  ARM: at91: aic add dt support for external irqs
  ARM: at91: add of default irq priorities support

Ludovic Desroches (5):
  ARM: at91: at91 based machines specify their own irq handler at run
    time
  ARM: at91: fix irq_alloc_descs parameters for sparse irq
  ARM: at91: sparse irq support
  ARM: at91: remove mach/irqs.h
  ARM: at91: add AIC5 support

 .../devicetree/bindings/arm/atmel-aic.txt          |    3 +
 arch/arm/boot/dts/at91sam9260.dtsi                 |   35 ++
 arch/arm/boot/dts/at91sam9263.dtsi                 |   35 ++
 arch/arm/boot/dts/at91sam9g45.dtsi                 |   35 ++
 arch/arm/boot/dts/at91sam9x5.dtsi                  |   35 ++
 arch/arm/mach-at91/Kconfig                         |    2 +
 arch/arm/mach-at91/at91rm9200.c                    |    1 +
 arch/arm/mach-at91/at91sam9260.c                   |    1 +
 arch/arm/mach-at91/at91sam9261.c                   |    1 +
 arch/arm/mach-at91/at91sam9263.c                   |    1 +
 arch/arm/mach-at91/at91sam9g45.c                   |    1 +
 arch/arm/mach-at91/at91sam9rl.c                    |    1 +
 arch/arm/mach-at91/at91sam9x5.c                    |   44 ---
 arch/arm/mach-at91/at91x40.c                       |    1 +
 arch/arm/mach-at91/board-1arm.c                    |    3 +
 arch/arm/mach-at91/board-afeb-9260v1.c             |    3 +
 arch/arm/mach-at91/board-cam60.c                   |    3 +
 arch/arm/mach-at91/board-carmeva.c                 |    3 +
 arch/arm/mach-at91/board-cpu9krea.c                |    3 +
 arch/arm/mach-at91/board-cpuat91.c                 |    3 +
 arch/arm/mach-at91/board-csb337.c                  |    3 +
 arch/arm/mach-at91/board-csb637.c                  |    3 +
 arch/arm/mach-at91/board-dt.c                      |    2 +
 arch/arm/mach-at91/board-eb01.c                    |    3 +
 arch/arm/mach-at91/board-eb9200.c                  |    3 +
 arch/arm/mach-at91/board-ecbat91.c                 |    3 +
 arch/arm/mach-at91/board-eco920.c                  |    3 +
 arch/arm/mach-at91/board-flexibity.c               |    3 +
 arch/arm/mach-at91/board-foxg20.c                  |    3 +
 arch/arm/mach-at91/board-gsia18s.c                 |    3 +
 arch/arm/mach-at91/board-kafa.c                    |    3 +
 arch/arm/mach-at91/board-kb9202.c                  |    3 +
 arch/arm/mach-at91/board-neocore926.c              |    3 +
 arch/arm/mach-at91/board-pcontrol-g20.c            |    3 +
 arch/arm/mach-at91/board-picotux200.c              |    3 +
 arch/arm/mach-at91/board-qil-a9260.c               |    3 +
 arch/arm/mach-at91/board-rm9200dk.c                |    3 +
 arch/arm/mach-at91/board-rm9200ek.c                |    3 +
 arch/arm/mach-at91/board-rsi-ews.c                 |    3 +
 arch/arm/mach-at91/board-sam9-l9260.c              |    3 +
 arch/arm/mach-at91/board-sam9260ek.c               |    3 +
 arch/arm/mach-at91/board-sam9261ek.c               |    3 +
 arch/arm/mach-at91/board-sam9263ek.c               |    3 +
 arch/arm/mach-at91/board-sam9g20ek.c               |    5 +
 arch/arm/mach-at91/board-sam9m10g45ek.c            |    3 +
 arch/arm/mach-at91/board-sam9rlek.c                |    3 +
 arch/arm/mach-at91/board-snapper9260.c             |    3 +
 arch/arm/mach-at91/board-stamp9g20.c               |    5 +
 arch/arm/mach-at91/board-usb-a926x.c               |    7 +
 arch/arm/mach-at91/board-yl-9200.c                 |    3 +
 arch/arm/mach-at91/generic.h                       |    2 +
 arch/arm/mach-at91/gpio.c                          |    1 +
 arch/arm/mach-at91/include/mach/at91_aic.h         |   30 ++
 arch/arm/mach-at91/include/mach/entry-macro.S      |   27 --
 arch/arm/mach-at91/include/mach/irqs.h             |   41 --
 arch/arm/mach-at91/irq.c                           |  404 +++++++++++++++++---
 arch/arm/mach-at91/pm.c                            |    1 +
 57 files changed, 655 insertions(+), 162 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-at91/include/mach/irqs.h

-- 
1.7.5.4
