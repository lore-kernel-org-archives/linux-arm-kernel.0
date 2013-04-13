From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sat, 13 Apr 2013 12:13:14 +0800
Subject: [GIT PULL] [for 3.10] pull request from armsoc/dt branch in pxa git
 tree
Message-ID: <CAN1soZxcmHMABTGi6FBtXysmY0TwWx7cdEvf1_ycHv2RtCLcpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd & Olof,

Please help to pull armsoc/dt branch from pxa git tree. These patches
are used to enable hi3xxx SoC
and they're depend on Rob's clock source patches.

Regards
Haojian

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:

  git://github.com/hzhuang1/linux.git armsoc/dt

for you to fetch changes up to 280aab1bbd0521381cba7aa942db388b15cec6bd:

  ARM: config: append arch hi3xxx into multi defconfig (2013-04-13
11:54:04 +0800)

----------------------------------------------------------------
Arnd Bergmann (2):
      clocksource: make CLOCKSOURCE_OF_DECLARE type safe
      ARM: make machine_desc->init_time default to clocksource_of_init

Haojian Zhuang (6):
      devtree: add binding documentation for sp804
      ARM: debug: support debug ll on hisilicon soc
      clk: hi3xxx: add clock support
      ARM: hi3xxx: add board support with device tree
      ARM: hi3xxx: enable hi4511 with device tree
      ARM: config: append arch hi3xxx into multi defconfig

Rob Herring (17):
      clocksource: add empty version of clocksource_of_init
      clocksource: pass DT node pointer to init functions
      clocksource: tegra20: use the device_node pointer passed to init
      ARM: smp_twd: convert to use CLKSRC_OF init
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

 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt |   10 +
 Documentation/devicetree/bindings/clock/hisilicon.txt         |   73 +++++
 Documentation/devicetree/bindings/timer/arm,sp804.txt         |   29 ++
 arch/arm/Kconfig                                              |    4 +
 arch/arm/Kconfig.debug                                        |   15 ++
 arch/arm/Makefile                                             |    1 +
 arch/arm/boot/dts/Makefile                                    |    3 +
 arch/arm/boot/dts/hi3620.dtsi                                 | 1155
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/hi4511.dts                                  |  738
++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/integratorcp.dts                            |    6 +-
 arch/arm/boot/dts/versatile-ab.dts                            |   12 +
 arch/arm/boot/dts/vexpress-v2p-ca9.dts                        |    1 +
 arch/arm/common/timer-sp.c                                    |  140 ++++++++--
 arch/arm/configs/multi_v7_defconfig                           |    1 +
 arch/arm/include/asm/arch_timer.h                             |   13 +-
 arch/arm/include/asm/hardware/timer-sp.h                      |   16 +-
 arch/arm/include/asm/sched_clock.h                            |    2 +
 arch/arm/include/asm/smp_twd.h                                |    8 -
 arch/arm/include/debug/hisilicon.S                            |   30 +++
 arch/arm/kernel/arch_timer.c                                  |   29 +-
 arch/arm/kernel/sched_clock.c                                 |   15 +-
 arch/arm/kernel/smp_twd.c                                     |   17 +-
 arch/arm/kernel/time.c                                        |    7 +-
 arch/arm/mach-exynos/mach-exynos5-dt.c                        |    1 -
 arch/arm/mach-exynos/mct.c                                    |    6 -
 arch/arm/mach-hi3xxx/Kconfig                                  |   13 +
 arch/arm/mach-hi3xxx/Makefile                                 |    5 +
 arch/arm/mach-hi3xxx/hi3xxx.c                                 |   45 ++++
 arch/arm/mach-highbank/highbank.c                             |   27 +-
 arch/arm/mach-imx/mach-imx6q.c                                |    5 +-
 arch/arm/mach-integrator/integrator_cp.c                      |   34 ---
 arch/arm/mach-omap2/timer.c                                   |    7 +-
 arch/arm/mach-shmobile/board-kzm9d.c                          |    1 -
 arch/arm/mach-shmobile/setup-emev2.c                          |    1 -
 arch/arm/mach-shmobile/setup-r8a7740.c                        |    1 -
 arch/arm/mach-shmobile/setup-sh7372.c                         |    1 -
 arch/arm/mach-shmobile/setup-sh73a0.c                         |    1 -
 arch/arm/mach-shmobile/timer.c                                |    7 +-
 arch/arm/mach-spear13xx/spear13xx.c                           |    4 +-
 arch/arm/mach-ux500/timer.c                                   |    3 +-
 arch/arm/mach-versatile/core.c                                |   26 +-
 arch/arm/mach-versatile/versatile_dt.c                        |    1 -
 arch/arm/mach-vexpress/v2m.c                                  |   25 +-
 arch/arm/mach-virt/virt.c                                     |    9 -
 arch/arm64/include/asm/arch_timer.h                           |    5 +
 arch/arm64/kernel/time.c                                      |    6 +-
 drivers/clk/Makefile                                          |    1 +
 drivers/clk/clk-hi3xxx.c                                      |  643
++++++++++++++++++++++++++++++++++++++++++++
 drivers/clocksource/Kconfig                                   |    1 +
 drivers/clocksource/arm_arch_timer.c                          |   23 +-
 drivers/clocksource/bcm2835_timer.c                           |   12 +-
 drivers/clocksource/clksrc-of.c                               |    5 +-
 drivers/clocksource/tegra20_timer.c                           |   73 ++---
 drivers/clocksource/vt8500_timer.c                            |   16 +-
 include/clocksource/arm_arch_timer.h                          |    6 -
 include/linux/clocksource.h                                   |   12 +-
 include/linux/of.h                                            |    5 +
 57 files changed, 3053 insertions(+), 303 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
 create mode 100644 Documentation/devicetree/bindings/clock/hisilicon.txt
 create mode 100644 Documentation/devicetree/bindings/timer/arm,sp804.txt
 create mode 100644 arch/arm/boot/dts/hi3620.dtsi
 create mode 100644 arch/arm/boot/dts/hi4511.dts
 create mode 100644 arch/arm/include/debug/hisilicon.S
 create mode 100644 arch/arm/mach-hi3xxx/Kconfig
 create mode 100644 arch/arm/mach-hi3xxx/Makefile
 create mode 100644 arch/arm/mach-hi3xxx/hi3xxx.c
 create mode 100644 drivers/clk/clk-hi3xxx.c
