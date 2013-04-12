From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 12 Apr 2013 21:17:16 +0200
Subject: [PATCH v5 00/14] ARM: samsung-time: Prepare for multiplatform support
Message-ID: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is an attempt to make the samsung-time clocksource driver ready
for multiplatform kernels. It moves the driver to drivers/clocksource, cleans
it up from uses of static platform-specific definitions, simplifies timer
interrupt handling and adds Device Tree support.

The samsung_pwm clocksource driver is made the master driver, which
exposes a single function to the PWM driver to get required data. Only
samsung-time driver is reworked to use the master driver at this time,
since the PWM driver can be already considered broken at the moment and
needs separate series of several patches to fix and clean it up, which
I am already working on.

Tested on Universal C210 board with Device Tree. Not tested without
Device Tree, since it has been already broken before this series.
Compile tested for other related SoCs.

Changes since v4:
(http://thread.gmane.org/gmane.linux.kernel.samsung-soc/17464)
 - Changed the design again - now clocksource driver is considered the master
   and exports a single function to get access to things like base address,
   hardware variant information, shared spinlock for register access
   synchronization and interrupt numbers
 - Renamed the clocksource driver to samsung_pwm
 - Cleaned up the code a bit more
 - Added clocksource_of_init support

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
  clocksource: samsung-pwm: Clean up platform header
  clocksource: samsung-pwm: Add infrastructure to share PWM hardware
  ARM: SAMSUNG: Unify base address definitions of timer block
  ARM: SAMSUNG: Add new PWM platform device
  ARM: SAMSUNG: Set PWM platform data
  clocksource: samsung-pwm: Use platform data to setup the clocksource
  clocksource: samsung-pwm: Synchronize register accesses
  clocksource: samsung-pwm: Move IRQ mask/ack handling to the driver
  ARM: SAMSUNG: Remove unused PWM timer IRQ chip code
  clocksource: samsung-pwm: Configure dividers directly
  clocksource: samsung-pwm: Do not use static mapping of registers
  clocksource: samsung-pwm: Drop unnecessary includes
  clocksource: samsung-pwm: Prepare for clocksource_of_init

 .../devicetree/bindings/pwm/pwm-samsung.txt        |  43 ++
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
 arch/arm/plat-samsung/irq-vic-timer.c              |  98 ----
 arch/arm/plat-samsung/s5p-irq.c                    |   3 -
 arch/arm/plat-samsung/samsung-time.c               | 394 -------------
 drivers/clocksource/Kconfig                        |   7 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/samsung_pwm.c                  | 636 +++++++++++++++++++++
 include/clocksource/samsung_pwm.h                  |  45 ++
 34 files changed, 849 insertions(+), 583 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-samsung.txt
 delete mode 100644 arch/arm/plat-samsung/include/plat/irq-vic-timer.h
 delete mode 100644 arch/arm/plat-samsung/irq-vic-timer.c
 delete mode 100644 arch/arm/plat-samsung/samsung-time.c
 create mode 100644 drivers/clocksource/samsung_pwm.c
 create mode 100644 include/clocksource/samsung_pwm.h

-- 
1.8.1.5
