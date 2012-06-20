From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 20 Jun 2012 13:56:36 +0100
Subject: [PATCH 00/15] Device Tree related re-works and clean-ups
Message-ID: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The next in a long line of Device Tree enablement of ST-Ericsson
related devices. In this patch-set we see the AB8500 obtain a its
own IRQ domain, some major code deletions surrounding regulator
register initialisation and a fairly major change in the way we
register MFD devices when Device Tree is enabled.

After this patch-set is applied on top of the previous one (some
patches are still to be Acked and dragged into the correct trees)
the boot log on Snowball is clean and /proc/interrupts appears to
have the right idea.

 .../devicetree/bindings/gpio/gpio-nmk.txt          |    2 +-
 arch/arm/boot/dts/db8500.dtsi                      |   18 +-
 arch/arm/kernel/perf_event_v7.c                    |   12 +-
 arch/arm/mach-ux500/board-mop500-regulators.c      |  176 --------------
 arch/arm/mach-ux500/board-mop500-regulators.h      |    2 -
 arch/arm/mach-ux500/board-mop500.c                 |   22 --
 arch/arm/mach-ux500/cpu-db8500.c                   |    3 +-
 drivers/i2c/busses/i2c-nomadik.c                   |   90 +++++++-
 drivers/input/misc/ab8500-ponkey.c                 |    6 -
 drivers/mfd/Kconfig                                |    1 +
 drivers/mfd/ab8500-core.c                          |  218 +++++++++---------
 drivers/mfd/ab8500-debugfs.c                       |   12 +-
 drivers/mfd/ab8500-gpadc.c                         |    6 -
 drivers/mfd/ab8500-sysctrl.c                       |    6 -
 drivers/mfd/db8500-prcmu.c                         |   29 ++-
 drivers/mfd/mfd-core.c                             |   31 ++-
 drivers/misc/ab8500-pwm.c                          |    6 -
 drivers/pinctrl/pinctrl-nomadik.c                  |    4 +-
 drivers/regulator/ab8500.c                         |  240 --------------------
 drivers/regulator/db8500-prcmu.c                   |    6 -
 drivers/rtc/rtc-ab8500.c                           |    7 -
 drivers/usb/otg/ab8500-usb.c                       |    6 -
 include/linux/mfd/abx500/ab8500.h                  |    8 +-
 include/linux/mfd/core.h                           |    1 +
 include/linux/regulator/ab8500.h                   |   12 -
 25 files changed, 282 insertions(+), 642 deletions(-)
