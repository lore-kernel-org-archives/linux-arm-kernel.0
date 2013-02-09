From: manabian@gmail.com (Joachim Eastwood)
Date: Sat,  9 Feb 2013 16:54:26 +0100
Subject: [PATCH 0/2] RM9200 EBI write/read interface
Message-ID: <1360425268-29060-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch introduces a EBI (External Bus Interface) read/write
interface for RM9200. This allow to use the real base address
for the SDRAMC on RM9200 and share SDRAMC headers for RM9200
and SAM9.

In the process at91_ramc can now be made private to mach-at91
since the at91_cf driver will use at91_ebi instead.

The ultimate goal is to create a EBI driver for RM9200. This
will make it possible to setup EBI and SMC for external chips.

My board has octal USART which needs SMC to be setup correctly
and this is not currently possible when using DT. Boards with
NOR and NAND flash where SMC is not setup by bootloader will
also benefit from such a driver.

I'm working this EBI driver and its DT bindings right now but
would like some comments on this before I proceed.


Joachim Eastwood (2):
  ARM: at91: create ebi read/write interface for RM9200
  ARM: at91: move at91_ramc.h and clean up includes

 arch/arm/boot/dts/at91rm9200.dtsi                  |  4 +-
 arch/arm/mach-at91/at91_ramc.h                     | 31 +++++++++++
 arch/arm/mach-at91/at91rm9200.c                    |  3 +-
 arch/arm/mach-at91/at91rm9200_devices.c            | 14 ++---
 arch/arm/mach-at91/at91sam9_alt_reset.S            |  2 +-
 arch/arm/mach-at91/at91sam9g45_reset.S             |  2 +-
 arch/arm/mach-at91/board-cpuat91.c                 |  2 -
 arch/arm/mach-at91/board-eco920.c                  |  6 +--
 arch/arm/mach-at91/board-kb9202.c                  |  2 -
 arch/arm/mach-at91/board-picotux200.c              |  3 --
 arch/arm/mach-at91/board-rm9200dk.c                |  2 -
 arch/arm/mach-at91/board-rm9200ek.c                |  2 -
 arch/arm/mach-at91/board-yl-9200.c                 |  4 +-
 arch/arm/mach-at91/generic.h                       |  3 ++
 arch/arm/mach-at91/include/mach/at91_ebi.h         | 20 +++++++
 arch/arm/mach-at91/include/mach/at91_ramc.h        | 32 -----------
 arch/arm/mach-at91/include/mach/at91rm9200.h       |  1 +
 .../arm/mach-at91/include/mach/at91rm9200_sdramc.h | 63 ----------------------
 arch/arm/mach-at91/include/mach/at91sam9_sdramc.h  |  2 +
 arch/arm/mach-at91/pm.c                            |  2 +-
 arch/arm/mach-at91/pm.h                            |  9 ++--
 arch/arm/mach-at91/pm_slowclock.S                  |  2 +-
 arch/arm/mach-at91/setup.c                         | 10 ++++
 drivers/pcmcia/at91_cf.c                           |  6 +--
 24 files changed, 94 insertions(+), 133 deletions(-)
 create mode 100644 arch/arm/mach-at91/at91_ramc.h
 create mode 100644 arch/arm/mach-at91/include/mach/at91_ebi.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91_ramc.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91rm9200_sdramc.h

-- 
1.8.0
