From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 04 Apr 2013 18:36:57 +0200
Subject: [PATCH v4 00/14] ARM: samsung-time: Prepare for multiplatform support
Message-ID: <1365093431-30621-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is an attempt to make the samsung-time clocksource driver ready
for multiplatform kernels. It moves the driver to drivers/clocksource, cleans
it up from uses of static platform-specific definitions, simplifies timer
interrupt handling and adds Device Tree support.

Only samsung-time driver is reworked to use the master driver at this time,
since the PWM driver can be already considered broken at the moment and
needs separate series of several patches to fix and clean it up, which
I am already working on.

Tested on Universal C210 board with Device Tree. Not tested without
Device Tree, since it has been already broken before this series.
Compile tested for other related SoCs.

Changes since v3:
(http://thread.gmane.org/gmane.linux.kernel.samsung-soc/16664/)
 - Changed the design to use common (master) driver for operations that
   can be done from both clocksource and PWM drivers (as suggested by
   Arnd Bergmann) - needed to properly synchronize access to PWM registers
 - Moved handling of PWM prescaler and divider to master driver

Changes since v2:
(http://thread.gmane.org/gmane.linux.kernel.samsung-soc/16158)
 - Addressed comments from Rob Herring and Mark Rutland
 - Removed unused register definitions
 - Replaced samsung,source-timer and samsung,event-timer properties
   with samsung,pwm-outputs property that defines which PWM channels
   are reserved for PWM outputs on particular platform
 - Split non-DT and DT initialization into two functions
 - Fixed a copy paste error

Changes since v1:
(http://thread.gmane.org/gmane.linux.kernel.samsung-soc/16005)
 - Addressed comments from Mark Rutland
 - Documented struct samsung_timer_variant
 - Dropped inactive mail addresses from CC

Tomasz Figa (14):
  ARM: SAMSUNG: Move samsung-time to drivers/clocksource
  clocksource: samsung-time: Drop useless defines from public header
  clocksource: samsung-time: Use local register definitions
  mfd: Add Samsung PWM/timer master driver
  ARM: SAMSUNG: Unify base address definitions of timer block
  ARM: SAMSUNG: Add new PWM platform device
  ARM: SAMSUNG: Set PWM platform data
  clocksource: samsung-time: Use Samsung PWM/timer master driver
  clocksource: samsung-time: Use variant data to get SoC-specific bits
  clocksource: samsung-time: Use master driver to configure dividers
  clocksource: samsung-time: Use clk_prepare_enable
  clocksource: samsung-time: Use master driver to control PWM channels
  clocksource: samsung-time: Move IRQ mask/ack handling to the driver
  ARM: SAMSUNG: Remove unused PWM timer IRQ chip code

 .../devicetree/bindings/pwm/pwm-samsung.txt        |  37 ++
 arch/arm/Kconfig                                   |   1 -
 arch/arm/mach-exynos/common.c                      |  10 +
 arch/arm/mach-exynos/include/mach/irqs.h           |   3 +-
 arch/arm/mach-exynos/include/mach/map.h            |   1 +
 arch/arm/mach-s3c24xx/common.c                     |  10 +
 arch/arm/mach-s3c24xx/include/mach/irqs.h          |   6 +
 arch/arm/mach-s3c24xx/include/mach/map.h           |   2 +
 arch/arm/mach-s3c64xx/common.c                     |  14 +-
 arch/arm/mach-s3c64xx/include/mach/irqs.h          |   8 -
 arch/arm/mach-s3c64xx/include/mach/map.h           |   1 +
 arch/arm/mach-s5p64x0/common.c                     |  10 +
 arch/arm/mach-s5p64x0/include/mach/irqs.h          |   2 -
 arch/arm/mach-s5p64x0/include/mach/map.h           |   1 +
 arch/arm/mach-s5pc100/common.c                     |  10 +
 arch/arm/mach-s5pc100/include/mach/irqs.h          |   2 -
 arch/arm/mach-s5pc100/include/mach/map.h           |   1 +
 arch/arm/mach-s5pv210/common.c                     |  10 +
 arch/arm/mach-s5pv210/include/mach/irqs.h          |   2 -
 arch/arm/mach-s5pv210/include/mach/map.h           |   1 +
 arch/arm/plat-samsung/Kconfig                      |  14 -
 arch/arm/plat-samsung/Makefile                     |   2 -
 arch/arm/plat-samsung/devs.c                       |  33 +-
 arch/arm/plat-samsung/include/plat/devs.h          |   1 +
 arch/arm/plat-samsung/include/plat/irq-vic-timer.h |  13 -
 arch/arm/plat-samsung/include/plat/irqs.h          |   9 -
 arch/arm/plat-samsung/include/plat/samsung-time.h  |  38 +-
 arch/arm/plat-samsung/irq-vic-timer.c              |  98 -----
 arch/arm/plat-samsung/s5p-irq.c                    |   3 -
 arch/arm/plat-samsung/samsung-time.c               | 394 ------------------
 drivers/clocksource/Kconfig                        |   8 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/samsung-time.c                 | 298 ++++++++++++++
 drivers/mfd/Kconfig                                |   3 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/samsung-pwm.c                          | 439 +++++++++++++++++++++
 drivers/pwm/Kconfig                                |   1 +
 include/linux/mfd/samsung-pwm.h                    |  49 +++
 include/linux/platform_data/samsung-pwm.h          |  29 ++
 39 files changed, 983 insertions(+), 583 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-samsung.txt
 delete mode 100644 arch/arm/plat-samsung/include/plat/irq-vic-timer.h
 delete mode 100644 arch/arm/plat-samsung/irq-vic-timer.c
 delete mode 100644 arch/arm/plat-samsung/samsung-time.c
 create mode 100644 drivers/clocksource/samsung-time.c
 create mode 100644 drivers/mfd/samsung-pwm.c
 create mode 100644 include/linux/mfd/samsung-pwm.h
 create mode 100644 include/linux/platform_data/samsung-pwm.h

-- 
1.8.1.5
