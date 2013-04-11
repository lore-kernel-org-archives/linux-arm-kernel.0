From: robherring2@gmail.com (Rob Herring)
Date: Thu, 11 Apr 2013 15:44:36 -0500
Subject: [GIT PULL] Timer clean-ups for 3.10, Part 2
Message-ID: <516720B4.3000703@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof, Arnd,

Please pull timer clean-ups for arch timer, sp804, and integrator-cp timers.

I've dropped the final patch which moved the sp804 and integrator timers
code to drivers/clocksource until the desired structure is worked out.

Simon, the fixes for shmobile were trivial. Please comment if you see
any issues.

Rob

The following changes since commit 3d5a96582303e28c48699f3faaf920ef7d43e6f2:

  clocksource: make CLOCKSOURCE_OF_DECLARE type safe (2013-03-28
12:01:06 +0100)

are available in the git repository at:

  git://sources.calxeda.com/kernel/linux.git
tags/clksrc-cleanup-for-3.10-part2

for you to fetch changes up to 69a517b2471bcd1c5a175aad82647c1e2c24f08b:

  devtree: add binding documentation for sp804 (2013-04-11 15:11:22 -0500)

----------------------------------------------------------------
This is the 2nd part of ARM timer clean-ups for 3.10. This series has
the following changes:

- Add sched_clock selection logic to select the highest frequency clock
- Use full 64-bit arch timer counter for sched_clock
- Convert arch timer, sp804 and integrator-cp timers to CLKSRC_OF and
adapt all users to use clocksource_of_init

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: make machine_desc->init_time default to clocksource_of_init

Haojian Zhuang (1):
      devtree: add binding documentation for sp804

Rob Herring (13):
      ARM: sched_clock: allow changing to higher frequency counter
      ARM: make sched_clock just call a function pointer
      ARM: arch_timer: use full 64-bit counter for sched_clock
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

 .../devicetree/bindings/timer/arm,sp804.txt        |   29 ++++
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/Makefile                         |    2 +
 arch/arm/boot/dts/integratorcp.dts                 |    6 +-
 arch/arm/boot/dts/versatile-ab.dts                 |   12 ++
 arch/arm/boot/dts/vexpress-v2p-ca9.dts             |    1 +
 arch/arm/common/timer-sp.c                         |  140
+++++++++++++++++---
 arch/arm/include/asm/arch_timer.h                  |   13 +-
 arch/arm/include/asm/hardware/timer-sp.h           |   16 ++-
 arch/arm/include/asm/sched_clock.h                 |    2 +
 arch/arm/kernel/arch_timer.c                       |   29 ++--
 arch/arm/kernel/sched_clock.c                      |   15 ++-
 arch/arm/kernel/time.c                             |    7 +-
 arch/arm/mach-exynos/mach-exynos5-dt.c             |    1 -
 arch/arm/mach-exynos/mct.c                         |    6 -
 arch/arm/mach-highbank/highbank.c                  |   24 +---
 arch/arm/mach-integrator/integrator_cp.c           |   34 -----
 arch/arm/mach-omap2/timer.c                        |    5 +-
 arch/arm/mach-shmobile/board-kzm9d.c               |    1 -
 arch/arm/mach-shmobile/setup-emev2.c               |    1 -
 arch/arm/mach-shmobile/setup-r8a7740.c             |    1 -
 arch/arm/mach-shmobile/setup-sh7372.c              |    1 -
 arch/arm/mach-shmobile/setup-sh73a0.c              |    1 -
 arch/arm/mach-shmobile/timer.c                     |    7 +-
 arch/arm/mach-versatile/core.c                     |   26 ++--
 arch/arm/mach-versatile/versatile_dt.c             |    1 -
 arch/arm/mach-vexpress/v2m.c                       |   21 +--
 arch/arm/mach-virt/virt.c                          |    9 --
 arch/arm64/include/asm/arch_timer.h                |    5 +
 arch/arm64/kernel/time.c                           |    6 +-
 drivers/clocksource/Kconfig                        |    1 +
 drivers/clocksource/arm_arch_timer.c               |   23 ++--
 include/clocksource/arm_arch_timer.h               |    6 -
 include/linux/of.h                                 |    5 +
 34 files changed, 262 insertions(+), 196 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/arm,sp804.txt
