From: robherring2@gmail.com (Rob Herring)
Date: Mon,  1 Apr 2013 17:21:10 -0500
Subject: [PATCH v2 00/13] ARM arch,
 sp804 and integrator timer CLKSRC_OF support
Message-ID: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This series add device-tree support using CLKSRC_OF for initialization
of arm/arm64 architected timers, integrator ap and cp timers, and sp804
timers. The timer code for integrator and sp804 is moved to
drivers/clocksource. The common DT based initialization of sp804 is
supported on highbank, versatile-ab and vexpress. The DT init support is
newly added for versatile-ab.

This series is dependent on my CLKSRC_OF clean-up in arm-soc and my
sched_clock selection series[1]. The full series is available here:

git://sources.calxeda.com/kernel/linux.git arm-timers
http://sources.calxeda.com/gitweb/?p=kernel/linux.git;a=shortlog;h=refs/heads/arm-timers

Changes in v2:
- Rework sp804 init to be more readable as to which timer is initialized
  for which function (clksrc or clkevt).
- Drop patch removing TIMER_CTRL clearing which is still needed for non-DT
  init cases.
- Add TIMER_CTRL to DT init functions. Even if the timer is unused as
  clksrc or clkevt, it is disabled.
- Extract only clocksource_of_init call from Arnd's default machine desc
  patch

Rob

[1] http://www.spinics.net/lists/arm-kernel/msg234566.html


Arnd Bergmann (1):
  ARM: make machine_desc->init_time default to clocksource_of_init

Haojian Zhuang (1):
  devtree: add binding documentation for sp804

Rob Herring (11):
  ARM: convert arm/arm64 arch timer to use CLKSRC_OF init
  OF: add empty of_device_is_available for !OF
  ARM: timer-sp: convert to use CLKSRC_OF init
  ARM: highbank: use OF init for sp804 timer
  ARM: vexpress: remove sp804 OF init
  ARM: dts: vexpress: disable CA9 core tile sp804 timer
  ARM: vexpress: remove extra timer-sp control register clearing
  ARM: versatile: add versatile dtbs to dtbs target
  ARM: versatile: use OF init for sp804 timer
  ARM: integrator-cp: convert use CLKSRC_OF for timer init
  ARM: move sp804 and integrator timers to drivers/clocksource

 .../devicetree/bindings/timer/arm,sp804.txt        |   29 +++
 arch/arm/Kconfig                                   |    5 -
 arch/arm/boot/dts/Makefile                         |    2 +
 arch/arm/boot/dts/integratorcp.dts                 |    6 +-
 arch/arm/boot/dts/versatile-ab.dts                 |   12 ++
 arch/arm/boot/dts/vexpress-v2p-ca9.dts             |    1 +
 arch/arm/common/Makefile                           |    1 -
 arch/arm/include/asm/arch_timer.h                  |   13 +-
 arch/arm/include/asm/hardware/timer-sp.h           |   15 --
 arch/arm/kernel/arch_timer.c                       |   17 +-
 arch/arm/kernel/time.c                             |    7 +-
 arch/arm/mach-exynos/mach-exynos5-dt.c             |    1 -
 arch/arm/mach-exynos/mct.c                         |    6 -
 arch/arm/mach-highbank/highbank.c                  |   24 +--
 arch/arm/mach-integrator/Kconfig                   |    1 +
 arch/arm/mach-integrator/integrator_ap.c           |  170 +-----------------
 arch/arm/mach-integrator/integrator_cp.c           |   39 +---
 arch/arm/mach-omap2/timer.c                        |    5 +-
 arch/arm/mach-realview/core.c                      |    5 +-
 arch/arm/mach-shmobile/board-kzm9d.c               |    1 -
 arch/arm/mach-shmobile/include/mach/common.h       |    1 -
 arch/arm/mach-shmobile/setup-emev2.c               |    1 -
 arch/arm/mach-shmobile/setup-r8a7740.c             |    1 -
 arch/arm/mach-shmobile/setup-sh7372.c              |    1 -
 arch/arm/mach-shmobile/setup-sh73a0.c              |    1 -
 arch/arm/mach-shmobile/timer.c                     |    6 -
 arch/arm/mach-versatile/core.c                     |   30 ++--
 arch/arm/mach-versatile/versatile_dt.c             |    1 -
 arch/arm/mach-vexpress/ct-ca9x4.c                  |    4 +-
 arch/arm/mach-vexpress/v2m.c                       |   25 +--
 arch/arm/mach-virt/virt.c                          |    9 -
 arch/arm64/include/asm/arch_timer.h                |    5 +
 arch/arm64/kernel/time.c                           |    6 +-
 drivers/clocksource/Kconfig                        |   13 ++
 drivers/clocksource/Makefile                       |    2 +
 drivers/clocksource/arm_arch_timer.c               |   23 +--
 drivers/clocksource/integrator_ap_timer.c          |  189 ++++++++++++++++++++
 .../arm/common => drivers/clocksource}/timer-sp.c  |  144 +++++++++++++--
 include/clocksource/arm_arch_timer.h               |    6 -
 .../hardware => include/clocksource}/arm_timer.h   |    4 +-
 include/clocksource/integrator_ap_timer.h          |    7 +
 include/clocksource/timer-sp.h                     |   23 +++
 include/linux/of.h                                 |    5 +
 43 files changed, 470 insertions(+), 397 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/arm,sp804.txt
 delete mode 100644 arch/arm/include/asm/hardware/timer-sp.h
 create mode 100644 drivers/clocksource/integrator_ap_timer.c
 rename {arch/arm/common => drivers/clocksource}/timer-sp.c (58%)
 rename {arch/arm/include/asm/hardware => include/clocksource}/arm_timer.h (93%)
 create mode 100644 include/clocksource/integrator_ap_timer.h
 create mode 100644 include/clocksource/timer-sp.h

-- 
1.7.10.4
