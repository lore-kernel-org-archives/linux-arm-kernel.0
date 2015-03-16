From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 16 Mar 2015 17:42:06 +0100
Subject: [GIT PULL] at91: cleanup for 4.1 #3
Message-ID: <1426524126-29068-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

This batch deals with the at91rm9200 System Timer. It is a complete re-work by
Alexandre to make it use modern kernel infrastructure and move its features to
proper drivers. I stacked it on top of cleanup to lower the risk of conflict
and above all to be sure that it'll be merged before multi-platform. And you
know... well, it's the last step needed before switching to multi-platform!

Thanks, best regards,

The following changes since commit 598e085590fc5ac1fecff00e842a8a6c2ae010e5:

  ARM: at91: remove old setup (2015-03-13 18:01:10 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-cleanup3

for you to fetch changes up to 8590ca655a19f9e124b52bfbf28f14eb16a05bec:

  ARM: at91: remove useless include (2015-03-16 17:03:08 +0100)

----------------------------------------------------------------
Third batch of cleanup for 4.1:
- System Timer (ST) for at91rm9200 re-work (syscon/regmap):
  - watchdog
  - restart handler
  - timer as a proper clocksource
  => remove mach dependency + cleanup

----------------------------------------------------------------
Alexandre Belloni (10):
      ARM: at91/dt: declare atmel,at91rm9200-st as a syscon
      mfd: syscon: Add atmel system timer registers definition
      watchdog: at91rm9200: use the system timer syscon
      watchdog: at91rm9200: implement restart handler
      ARM: at91: at91rm9200: remove deprecated arm_pm_restart
      ARM: at91: properly initialize timer
      ARM: at91: time: move the system timer driver to drivers/clocksource
      clocksource: atmel-st: use syscon/regmap
      clocksource: atmel-st: remove mach/hardware dependency
      ARM: at91: remove useless include

 .../devicetree/bindings/arm/atmel-at91.txt         |   4 +-
 arch/arm/boot/dts/at91rm9200.dtsi                  |   6 +-
 arch/arm/mach-at91/Kconfig                         |   1 +
 arch/arm/mach-at91/Makefile                        |   2 +-
 arch/arm/mach-at91/at91rm9200.c                    |  19 ----
 arch/arm/mach-at91/generic.h                       |   3 -
 arch/arm/mach-at91/include/mach/at91_st.h          |  61 -----------
 drivers/clocksource/Kconfig                        |   4 +
 drivers/clocksource/Makefile                       |   1 +
 .../clocksource/timer-atmel-st.c                   | 117 ++++++++-------------
 drivers/watchdog/Kconfig                           |   2 +-
 drivers/watchdog/at91rm9200_wdt.c                  |  61 +++++++++--
 include/linux/mfd/syscon/atmel-st.h                |  49 +++++++++
 13 files changed, 164 insertions(+), 166 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/at91_st.h
 rename arch/arm/mach-at91/at91rm9200_time.c => drivers/clocksource/timer-atmel-st.c (73%)
 create mode 100644 include/linux/mfd/syscon/atmel-st.h

-- 
Nicolas Ferre
