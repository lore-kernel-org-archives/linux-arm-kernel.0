From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 15 May 2014 17:58:39 +0100
Subject: [GIT PULL] vexpress: defconfig update for 3.13
Message-ID: <1400173119.29434.4.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd, Kevin, Olof,

The series went through the a couple of review cycles (with the latest
here: thread.gmane.org/gmane.linux.ports.arm.kernel/320572/) and got set
of acks from almost all relevant subsystem maintainers.

The following changes since commit d6d211db37e75de2ddc3a4f979038c40df7cc79c:

  Linux 3.15-rc5 (2014-05-09 13:10:52 -0700)

are available in the git repository at:

  git://git.linaro.org/people/pawel.moll/linux.git tags/vexpress/updates-for-3.16

for you to fetch changes up to 6b2c31c71d6fa8896c5f3f2354d790a5bd3f0a1e:

  ARM: vexpress: move HBI check to sysreg driver (2014-05-15 17:02:21 +0100)

----------------------------------------------------------------
ARM Versatile Express updates for 3.16

This series reworks VE's platform configuration infrastructure by:

- making it possible to instantiate selected devices from the
  Device Tree, prior to massive population,
- converting custom "func" API into standard "regmap",
- splitting the existing MFD driver into smaller ones and placing
  them into relevant directories.

The common clock framework driver can now be selected individually
(mostly for arm64 sake, where some of them are not used at all).

It also simplifies the machine code, by:

- moving the shed clock info clocksource driver,
- simplifying SMP operations to base them entirely of the DT data,
- moving platform ID checks into relevant driver.

----------------------------------------------------------------
Pawel Moll (8):
      of: Keep track of populated platform devices
      mfd: vexpress: Convert custom func API to regmap
      mfd: syscon: Add platform data with a regmap config name
      mfd: vexpress: Define the device as MFD cells
      clk: versatile: Split config options for sp810 and vexpress_osc
      clocksource: Sched clock source for Versatile Express
      ARM: vexpress: Simplify SMP operations for DT-powered system
      ARM: vexpress: move HBI check to sysreg driver

Sudeep KarkadaNagesha (1):
      ARM: vexpress: remove redundant vexpress_dt_cpus_num to get cpu count

 .../devicetree/bindings/arm/vexpress-sysreg.txt    |  79 ++-
 Documentation/devicetree/bindings/arm/vexpress.txt |  15 +-
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi            |  76 ++-
 arch/arm/boot/dts/vexpress-v2m.dtsi                |  76 ++-
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |   5 +-
 arch/arm/mach-vexpress/core.h                      |   3 +-
 arch/arm/mach-vexpress/ct-ca9x4.c                  |  10 +-
 arch/arm/mach-vexpress/platsmp.c                   | 187 ++-----
 arch/arm/mach-vexpress/v2m.c                       |  82 +--
 arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi       |   2 +-
 drivers/bus/Kconfig                                |   9 +
 drivers/bus/Makefile                               |   2 +
 drivers/bus/vexpress-config.c                      | 202 ++++++++
 drivers/clk/Kconfig                                |   9 +-
 drivers/clk/versatile/Kconfig                      |  26 +
 drivers/clk/versatile/Makefile                     |   5 +-
 drivers/clk/versatile/clk-vexpress-osc.c           |  96 ++--
 drivers/clocksource/Kconfig                        |  11 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/versatile.c                    |  40 ++
 drivers/hwmon/vexpress.c                           |  17 +-
 drivers/mfd/Kconfig                                |  15 +-
 drivers/mfd/Makefile                               |   2 +-
 drivers/mfd/syscon.c                               |   4 +
 drivers/mfd/vexpress-config.c                      | 287 -----------
 drivers/mfd/vexpress-sysreg.c                      | 554 ++++++---------------
 drivers/misc/Kconfig                               |   9 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/vexpress-syscfg.c                     | 324 ++++++++++++
 drivers/of/platform.c                              |  74 ++-
 drivers/power/reset/vexpress-poweroff.c            |  16 +-
 drivers/regulator/vexpress.c                       |  50 +-
 include/linux/of.h                                 |   7 +
 include/linux/of_platform.h                        |   5 +
 include/linux/platform_data/syscon.h               |   8 +
 include/linux/vexpress.h                           |  94 +---
 36 files changed, 1253 insertions(+), 1150 deletions(-)
 create mode 100644 drivers/bus/vexpress-config.c
 create mode 100644 drivers/clk/versatile/Kconfig
 create mode 100644 drivers/clocksource/versatile.c
 delete mode 100644 drivers/mfd/vexpress-config.c
 create mode 100644 drivers/misc/vexpress-syscfg.c
 create mode 100644 include/linux/platform_data/syscon.h
