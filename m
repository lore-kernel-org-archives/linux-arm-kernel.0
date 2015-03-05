From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  5 Mar 2015 16:49:45 +0100
Subject: [PATCH v4 0/9] Atmel System Timer cleanups
Message-ID: <1425570594-13124-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set cleans up the system timer driver.

The main goal is to get rid of the mach/ headers dependency. At the same time,
it introduces proper probing and locking (using a regmap) for the watchdog
driver.

This is based on 4.0-rc1 and will have two merge conflicts with my cleanup #1 in
mach-at91/at91rm9200.c

Changes in v4:
 - Added MODULE_* metadata in at91rm9200-reset
 - Proper copyright in at91rm9200-reset
 - Use BIT() in atmel-st.h
 - changed MODULE_ALIAS in at91rm9200_wdt.c

Changes in v3:
 - stop using an mfd and get the syscon directly from the watchdog driver
 - introduce a proper reset driver to handle reset

Changes in v2:
 - cleaned up more includes in the watchdog driver
 - stop using if OF when selecting CLKSRC_OF
 - stop initializing .owner


Alexandre Belloni (9):
  ARM: at91/dt: declare atmel,at91rm9200-st as a syscon
  mfd: syscon: Add atmel system timer registers definition
  watchdog: at91rm9200: use the system timer syscon
  power: reset: Add AT91RM9200 reset driver
  ARM: at91: at91rm9200: remove deprecated arm_pm_restart
  ARM: at91: time: move the system timer driver to drivers/clocksource
  clocksource: atmel-st: properly initialize driver
  clocksource: atmel-st: use syscon/regmap
  ARM: at91: remove useless include

 .../devicetree/bindings/arm/atmel-at91.txt         |   2 +-
 arch/arm/boot/dts/at91rm9200.dtsi                  |   2 +-
 arch/arm/mach-at91/Makefile                        |   2 +-
 arch/arm/mach-at91/at91rm9200.c                    |  19 ----
 arch/arm/mach-at91/generic.h                       |   3 -
 arch/arm/mach-at91/include/mach/at91_st.h          |  61 ------------
 drivers/clocksource/Kconfig                        |   4 +
 drivers/clocksource/Makefile                       |   1 +
 .../clocksource/timer-atmel-st.c                   | 103 ++++++++-------------
 drivers/power/reset/Kconfig                        |   7 ++
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/at91rm9200-reset.c             |  72 ++++++++++++++
 drivers/watchdog/Kconfig                           |   2 +-
 drivers/watchdog/at91rm9200_wdt.c                  |  23 +++--
 include/linux/mfd/syscon/atmel-st.h                |  49 ++++++++++
 15 files changed, 194 insertions(+), 157 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/at91_st.h
 rename arch/arm/mach-at91/at91rm9200_time.c => drivers/clocksource/timer-atmel-st.c (77%)
 create mode 100644 drivers/power/reset/at91rm9200-reset.c
 create mode 100644 include/linux/mfd/syscon/atmel-st.h

-- 
2.1.0
