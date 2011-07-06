From: bryan.wu@canonical.com (Bryan Wu)
Date: Wed,  6 Jul 2011 20:34:30 +0800
Subject: [PATCH 00/17] Introduce a led trigger for CPU activity 
Message-ID: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on Linus Walleij's ARM LED consolidation work, this patchset introduce a
new generic led trigger for CPU not only for ARM but also for others.

For enabling CPU idle event, CPU arch code should call ledtrig_cpu() stub to
trigger idle start or idle end event.

These patches convert old style LED driver in arch/arm to gpio_led or new led
driver interface. Against 3.0-rc6 and build successfully for all the machines.

Bryan Wu (15):
  leds: create a trigger for CPU activity
  arm: at91: convert old leds drivers to gpio_led and led_trigger
    drivers
  mach-ks8695: remove leds driver, since nobody use it
  mach-shark: retire custom LED code
  mach-orion5x: convert custom LED code to gpio_led and LED CPU trigger
  mach-integrator: retire custom LED code
  mach-clps711x: retire custom LED code of P720T machine
  mach-ebsa110: retire custom LED code
  mach-footbridge: retire custom LED code
  mach-pxa: retire custom LED code
  plat-samsung: remove including old leds event API header file
  mach-pnx4008: remove including old leds event API header file
  mach-omap1: retire custom LED code
  mach-sa1100: retire custom LED code
  ARM: use new LEDS CPU trigger stub to replace old one

Linus Walleij (2):
  mach-realview: retire custom LED code
  mach-versatile: retire custom LED code

 arch/arm/Kconfig                               |   70 ++-----
 arch/arm/configs/orion5x_defconfig             |    1 +
 arch/arm/include/asm/leds.h                    |   50 ----
 arch/arm/kernel/Makefile                       |    1 -
 arch/arm/kernel/leds.c                         |  119 ----------
 arch/arm/kernel/process.c                      |    6 +-
 arch/arm/kernel/time.c                         |   17 --
 arch/arm/mach-at91/board-cap9adk.c             |   21 ++-
 arch/arm/mach-at91/board-csb337.c              |    3 -
 arch/arm/mach-at91/board-ecbat91.c             |   18 ++-
 arch/arm/mach-at91/board-eco920.c              |   23 ++-
 arch/arm/mach-at91/board-kafa.c                |   17 ++-
 arch/arm/mach-at91/board-kb9202.c              |   23 ++-
 arch/arm/mach-at91/board-rm9200dk.c            |    3 -
 arch/arm/mach-at91/board-rm9200ek.c            |    3 -
 arch/arm/mach-at91/board-sam9-l9260.c          |   23 ++-
 arch/arm/mach-at91/board-sam9261ek.c           |    3 -
 arch/arm/mach-at91/board-yl-9200.c             |    3 -
 arch/arm/mach-at91/include/mach/board.h        |    1 -
 arch/arm/mach-at91/leds.c                      |  105 ---------
 arch/arm/mach-clps711x/Kconfig                 |    5 +
 arch/arm/mach-clps711x/Makefile                |    2 -
 arch/arm/mach-clps711x/include/mach/time.h     |    2 -
 arch/arm/mach-clps711x/p720t-leds.c            |   67 ------
 arch/arm/mach-clps711x/p720t.c                 |   57 +++++
 arch/arm/mach-clps711x/time.c                  |    1 -
 arch/arm/mach-ebsa110/Makefile                 |    4 +-
 arch/arm/mach-ebsa110/leds.c                   |   77 ++++---
 arch/arm/mach-footbridge/Kconfig               |   16 ++
 arch/arm/mach-footbridge/Makefile              |    4 -
 arch/arm/mach-footbridge/ebsa285-leds.c        |  139 -----------
 arch/arm/mach-footbridge/ebsa285.c             |   76 ++++++
 arch/arm/mach-footbridge/include/mach/system.h |    1 -
 arch/arm/mach-footbridge/netwinder-hw.c        |  102 +++++++--
 arch/arm/mach-footbridge/netwinder-leds.c      |  139 -----------
 arch/arm/mach-integrator/Makefile              |    3 +-
 arch/arm/mach-integrator/core.c                |    1 -
 arch/arm/mach-integrator/leds.c                |  147 ++++++------
 arch/arm/mach-ks8695/Makefile                  |    3 -
 arch/arm/mach-ks8695/devices.c                 |   21 --
 arch/arm/mach-ks8695/include/mach/devices.h    |    5 -
 arch/arm/mach-ks8695/leds.c                    |   93 --------
 arch/arm/mach-omap1/Kconfig                    |   21 ++
 arch/arm/mach-omap1/Makefile                   |    8 -
 arch/arm/mach-omap1/board-h2.c                 |   34 +++-
 arch/arm/mach-omap1/board-h3.c                 |   34 +++-
 arch/arm/mach-omap1/board-osk.c                |   33 +++
 arch/arm/mach-omap1/leds-h2p2-debug.c          |  167 --------------
 arch/arm/mach-omap1/leds-innovator.c           |   99 --------
 arch/arm/mach-omap1/leds-osk.c                 |  115 ----------
 arch/arm/mach-omap1/leds.c                     |   69 ------
 arch/arm/mach-omap1/leds.h                     |    3 -
 arch/arm/mach-omap1/time.c                     |    1 -
 arch/arm/mach-omap1/timer32k.c                 |    1 -
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c   |    1 -
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c    |    1 -
 arch/arm/mach-orion5x/rd88f5182-setup.c        |   74 ++----
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c   |    1 -
 arch/arm/mach-pnx4008/time.c                   |    1 -
 arch/arm/mach-pxa/Kconfig                      |   17 ++
 arch/arm/mach-pxa/Makefile                     |    8 -
 arch/arm/mach-pxa/idp.c                        |   76 ++++++
 arch/arm/mach-pxa/leds-idp.c                   |  116 ----------
 arch/arm/mach-pxa/leds-lubbock.c               |  125 ----------
 arch/arm/mach-pxa/leds-mainstone.c             |  120 ----------
 arch/arm/mach-pxa/leds.c                       |   32 ---
 arch/arm/mach-pxa/leds.h                       |   13 -
 arch/arm/mach-pxa/lubbock.c                    |   90 ++++++++
 arch/arm/mach-pxa/mainstone.c                  |   89 +++++++
 arch/arm/mach-realview/core.c                  |   39 ----
 arch/arm/mach-realview/core.h                  |    2 -
 arch/arm/mach-realview/realview_eb.c           |    4 -
 arch/arm/mach-realview/realview_pb1176.c       |    4 -
 arch/arm/mach-realview/realview_pb11mp.c       |    4 -
 arch/arm/mach-realview/realview_pba8.c         |    4 -
 arch/arm/mach-realview/realview_pbx.c          |    4 -
 arch/arm/mach-sa1100/Kconfig                   |   29 +++
 arch/arm/mach-sa1100/Makefile                  |   10 -
 arch/arm/mach-sa1100/assabet.c                 |   75 ++++++
 arch/arm/mach-sa1100/badge4.c                  |   30 +++
 arch/arm/mach-sa1100/cerf.c                    |   42 ++++
 arch/arm/mach-sa1100/hackkit.c                 |   32 +++
 arch/arm/mach-sa1100/lart.c                    |   26 ++
 arch/arm/mach-sa1100/leds-assabet.c            |  114 ---------
 arch/arm/mach-sa1100/leds-badge4.c             |  111 ---------
 arch/arm/mach-sa1100/leds-cerf.c               |  110 ---------
 arch/arm/mach-sa1100/leds-hackkit.c            |  112 ---------
 arch/arm/mach-sa1100/leds-lart.c               |  101 --------
 arch/arm/mach-sa1100/leds-simpad.c             |  100 --------
 arch/arm/mach-sa1100/leds.c                    |   52 -----
 arch/arm/mach-sa1100/leds.h                    |   14 --
 arch/arm/mach-sa1100/simpad.c                  |   48 ++++
 arch/arm/mach-shark/Makefile                   |    4 +-
 arch/arm/mach-shark/core.c                     |    1 -
 arch/arm/mach-shark/leds.c                     |  222 +++++++-----------
 arch/arm/mach-versatile/core.c                 |   42 ----
 arch/arm/plat-omap/Kconfig                     |    9 +-
 arch/arm/plat-omap/debug-leds.c                |  292 ++++++------------------
 arch/arm/plat-samsung/time.c                   |    1 -
 arch/arm/plat-versatile/Kconfig                |    6 +-
 arch/arm/plat-versatile/leds.c                 |   13 +-
 drivers/leds/Kconfig                           |   10 +
 drivers/leds/Makefile                          |    1 +
 drivers/leds/ledtrig-cpu.c                     |  144 ++++++++++++
 include/linux/leds.h                           |   15 ++
 105 files changed, 1532 insertions(+), 3119 deletions(-)
 delete mode 100644 arch/arm/include/asm/leds.h
 delete mode 100644 arch/arm/kernel/leds.c
 delete mode 100644 arch/arm/mach-clps711x/p720t-leds.c
 delete mode 100644 arch/arm/mach-footbridge/ebsa285-leds.c
 delete mode 100644 arch/arm/mach-footbridge/netwinder-leds.c
 delete mode 100644 arch/arm/mach-ks8695/leds.c
 delete mode 100644 arch/arm/mach-omap1/leds-h2p2-debug.c
 delete mode 100644 arch/arm/mach-omap1/leds-innovator.c
 delete mode 100644 arch/arm/mach-omap1/leds-osk.c
 delete mode 100644 arch/arm/mach-omap1/leds.c
 delete mode 100644 arch/arm/mach-omap1/leds.h
 delete mode 100644 arch/arm/mach-pxa/leds-idp.c
 delete mode 100644 arch/arm/mach-pxa/leds-lubbock.c
 delete mode 100644 arch/arm/mach-pxa/leds-mainstone.c
 delete mode 100644 arch/arm/mach-pxa/leds.c
 delete mode 100644 arch/arm/mach-pxa/leds.h
 delete mode 100644 arch/arm/mach-sa1100/leds-assabet.c
 delete mode 100644 arch/arm/mach-sa1100/leds-badge4.c
 delete mode 100644 arch/arm/mach-sa1100/leds-cerf.c
 delete mode 100644 arch/arm/mach-sa1100/leds-hackkit.c
 delete mode 100644 arch/arm/mach-sa1100/leds-lart.c
 delete mode 100644 arch/arm/mach-sa1100/leds-simpad.c
 delete mode 100644 arch/arm/mach-sa1100/leds.c
 delete mode 100644 arch/arm/mach-sa1100/leds.h
 create mode 100644 drivers/leds/ledtrig-cpu.c

-- 
1.7.5
