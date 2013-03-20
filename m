From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Mar 2013 12:41:11 +0100
Subject: [PATCH 0/8] SIRF multiplatform support
Message-ID: <1363779679-16880-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here goes another one. Since the SIRF platforms are relatively new and
clean, they are easy to convert to multiplatform, so I did that and
fixed up a few other things in the process as well.

Barry, could you test these and report back if everything still works
for you?

Thomas, John, Linus: Are you ok with the irqchip/clocksource/pinctrl
changes?

Arnd Bergmann (8):
  pinctrl: sirf: convert to linear irq domain
  ARM: sirf: fix prima2 interrupt lookup
  ARM: sirf: move irq driver to drivers/irqchip
  ARM: sirf: enable sparse IRQ
  ARM: sirf: move debug-macro.S to include/debug/sirf.S
  ARM: sirf: use clocksource_of infrastructure
  ARM: sirf: enable multiplatform support
  ARM: sirf: enable support in multi_v7_defconfig

 arch/arm/Kconfig                                   |  16 ---
 arch/arm/Kconfig.debug                             |   1 +
 arch/arm/configs/multi_v7_defconfig                |   6 +
 .../include/mach/uart.h => include/debug/sirf.S}   |  29 +++--
 arch/arm/mach-prima2/Kconfig                       |  12 ++
 arch/arm/mach-prima2/Makefile                      |   4 +-
 arch/arm/mach-prima2/common.c                      |  24 ++--
 arch/arm/mach-prima2/common.h                      |   4 +-
 arch/arm/mach-prima2/include/mach/clkdev.h         |  15 ---
 arch/arm/mach-prima2/include/mach/debug-macro.S    |  29 -----
 arch/arm/mach-prima2/include/mach/entry-macro.S    |  22 ----
 arch/arm/mach-prima2/include/mach/hardware.h       |  15 ---
 arch/arm/mach-prima2/include/mach/irqs.h           |  17 ---
 arch/arm/mach-prima2/include/mach/map.h            |  18 ---
 arch/arm/mach-prima2/include/mach/timex.h          |  14 ---
 arch/arm/mach-prima2/include/mach/uncompress.h     |  41 -------
 arch/arm/mach-prima2/irq.c                         | 129 ---------------------
 arch/arm/mach-prima2/lluart.c                      |  14 ++-
 arch/arm/mach-prima2/platsmp.c                     |   1 -
 drivers/clocksource/Makefile                       |   2 +
 .../clocksource}/timer-marco.c                     |  25 +---
 .../clocksource}/timer-prima2.c                    |  42 ++-----
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-sirfsoc.c                      | 123 ++++++++++++++++++++
 drivers/pinctrl/pinctrl-sirf.c                     |  10 +-
 25 files changed, 210 insertions(+), 404 deletions(-)
 rename arch/arm/{mach-prima2/include/mach/uart.h => include/debug/sirf.S} (55%)
 delete mode 100644 arch/arm/mach-prima2/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-prima2/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-prima2/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-prima2/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-prima2/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-prima2/include/mach/map.h
 delete mode 100644 arch/arm/mach-prima2/include/mach/timex.h
 delete mode 100644 arch/arm/mach-prima2/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-prima2/irq.c
 rename {arch/arm/mach-prima2 => drivers/clocksource}/timer-marco.c (94%)
 rename {arch/arm/mach-prima2 => drivers/clocksource}/timer-prima2.c (90%)
 create mode 100644 drivers/irqchip/irq-sirfsoc.c

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>


-- 
1.8.1.2
