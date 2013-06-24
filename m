From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 25 Jun 2013 02:09:06 +0900
Subject: [GIT PULL 1/2] Samsung cleanup PWM for v3.11
Message-ID: <51C87D32.6050607@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit db3824e6bf0b0f421b0d43f08d905935e826a965:

   ARM: SAMSUNG: Remove unused plat/regs-watchdog.h header (2013-06-19 
03:13:18 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-cleanup-2

for you to fetch changes up to 329d2fb35f05bd9255b4618813d534b8192555a4:

   ARM: SAMSUNG: Remove plat/regs-timer.h header (2013-06-25 01:13:49 +0900)

----------------------------------------------------------------
based on tags/samsung-cleanup-1

This cleanup of PWM Samsung is for:
1) moving remaining Samsung platforms to the new clocksource driver
2) removing old clocksource driver
3) adding new multiplatform- and DT-aware PWM driver
4) moving all Samsung platforms to use the new PWM driver
5) removing old PWM driver
6) removing all PWM-related code that is not used anymore

----------------------------------------------------------------
Tomasz Figa (18):
       ARM: SAMSUNG: Unify base address definitions of timer block
       ARM: SAMSUNG: Add new PWM platform device
       ARM: SAMSUNG: Set PWM platform data
       clocksource: samsung_pwm_timer: Cache clocksource register address
       clocksource: samsung_pwm_timer: Do not use clocksource_mmio
       clocksource: samsung_pwm_timer: Handle suspend/resume correctly
       ARM: SAMSUNG: Move all platforms to new clocksource driver
       ARM: SAMSUNG: Remove old samsung-time driver
       ARM: SAMSUNG: Remove unused PWM timer IRQ chip code
       pwm: samsung: Rename to pwm-samsung-legacy
       pwm: Add new pwm-samsung driver
       ARM: SAMSUNG: Rework private data handling in dev-backlight
       ARM: SAMSUNG: Modify board files to use new PWM platform device
       pwm: Remove superseded pwm-samsung-legacy driver
       ARM: SAMSUNG: Remove old PWM timer platform devices
       ARM: SAMSUNG: Remove pwm-clock infrastructure
       ARM: SAMSUNG: Remove remaining uses of plat/regs-timer.h header
       ARM: SAMSUNG: Remove plat/regs-timer.h header

  arch/arm/Kconfig                                   |   6 +-
  arch/arm/mach-s3c24xx/Kconfig                      |   6 -
  arch/arm/mach-s3c24xx/clock-s3c2410.c              |   1 -
  arch/arm/mach-s3c24xx/clock-s3c2412.c              |   1 -
  arch/arm/mach-s3c24xx/clock-s3c2416.c              |   2 -
  arch/arm/mach-s3c24xx/clock-s3c2443.c              |   2 -
  arch/arm/mach-s3c24xx/common.c                     |  27 +
  arch/arm/mach-s3c24xx/include/mach/map.h           |   2 +
  arch/arm/mach-s3c24xx/mach-h1940.c                 |   4 +-
  arch/arm/mach-s3c24xx/mach-rx1950.c                |   5 +-
  arch/arm/mach-s3c64xx/Kconfig                      |   2 -
  arch/arm/mach-s3c64xx/clock.c                      |   2 -
  arch/arm/mach-s3c64xx/common.c                     |  32 +-
  arch/arm/mach-s3c64xx/include/mach/irqs.h          |   8 -
  arch/arm/mach-s3c64xx/include/mach/map.h           |   1 +
  arch/arm/mach-s3c64xx/irq-pm.c                     |   2 -
  arch/arm/mach-s3c64xx/mach-crag6410.c              |   4 +-
  arch/arm/mach-s3c64xx/mach-hmt.c                   |   4 +-
  arch/arm/mach-s3c64xx/mach-smartq.c                |   4 +-
  arch/arm/mach-s3c64xx/mach-smdk6410.c              |   5 +-
  arch/arm/mach-s5p64x0/Kconfig                      |   2 -
  arch/arm/mach-s5p64x0/clock-s5p6440.c              |   2 -
  arch/arm/mach-s5p64x0/clock-s5p6450.c              |   2 -
  arch/arm/mach-s5p64x0/common.c                     |  28 +
  arch/arm/mach-s5p64x0/include/mach/irqs.h          |   2 -
  arch/arm/mach-s5p64x0/include/mach/map.h           |   1 +
  arch/arm/mach-s5p64x0/mach-smdk6440.c              |   5 +-
  arch/arm/mach-s5p64x0/mach-smdk6450.c              |   5 +-
  arch/arm/mach-s5p64x0/pm.c                         |   3 -
  arch/arm/mach-s5pc100/Kconfig                      |   1 -
  arch/arm/mach-s5pc100/clock.c                      |   2 -
  arch/arm/mach-s5pc100/common.c                     |  28 +
  arch/arm/mach-s5pc100/include/mach/irqs.h          |   2 -
  arch/arm/mach-s5pc100/include/mach/map.h           |   1 +
  arch/arm/mach-s5pc100/mach-smdkc100.c              |   5 +-
  arch/arm/mach-s5pv210/Kconfig                      |   1 -
  arch/arm/mach-s5pv210/clock.c                      |   1 -
  arch/arm/mach-s5pv210/common.c                     |  28 +
  arch/arm/mach-s5pv210/include/mach/irqs.h          |   2 -
  arch/arm/mach-s5pv210/include/mach/map.h           |   1 +
  arch/arm/mach-s5pv210/mach-smdkv210.c              |   5 +-
  arch/arm/mach-s5pv210/pm.c                         |  10 -
  arch/arm/plat-samsung/Kconfig                      |  14 -
  arch/arm/plat-samsung/Makefile                     |   3 -
  arch/arm/plat-samsung/dev-backlight.c              |  61 +-
  arch/arm/plat-samsung/devs.c                       |  42 +-
  arch/arm/plat-samsung/include/plat/clock.h         |   4 -
  arch/arm/plat-samsung/include/plat/devs.h          |   1 +
  arch/arm/plat-samsung/include/plat/irq-vic-timer.h |  13 -
  arch/arm/plat-samsung/include/plat/irqs.h          |   9 -
  arch/arm/plat-samsung/include/plat/pwm-clock.h     |  81 ---
  arch/arm/plat-samsung/include/plat/pwm-core.h      |  24 +
  arch/arm/plat-samsung/include/plat/regs-timer.h    | 124 ----
  arch/arm/plat-samsung/include/plat/samsung-time.h  |  23 -
  arch/arm/plat-samsung/irq-vic-timer.c              |  98 ---
  arch/arm/plat-samsung/pwm-clock.c                  | 474 --------------
  arch/arm/plat-samsung/s5p-irq.c                    |   4 -
  arch/arm/plat-samsung/samsung-time.c               | 394 ------------
  drivers/clocksource/samsung_pwm_timer.c            |  84 +--
  drivers/pwm/pwm-samsung.c                          | 694 
++++++++++++++-------
  60 files changed, 760 insertions(+), 1644 deletions(-)
  delete mode 100644 arch/arm/plat-samsung/include/plat/irq-vic-timer.h
  delete mode 100644 arch/arm/plat-samsung/include/plat/pwm-clock.h
  create mode 100644 arch/arm/plat-samsung/include/plat/pwm-core.h
  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-timer.h
  delete mode 100644 arch/arm/plat-samsung/irq-vic-timer.c
  delete mode 100644 arch/arm/plat-samsung/pwm-clock.c
  delete mode 100644 arch/arm/plat-samsung/samsung-time.c

----

Following is my preferred resolution for merge conflicts.

diff --cc arch/arm/plat-samsung/Kconfig
index 3dc5cbe,8863bf3..b21d9d5
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@@ -58,28 -59,6 +57,20 @@@ config S3C_LOWLEVEL_UART_POR
   	  this configuration should be between zero and two. The port
   	  must have been initialised by the boot-loader before use.

  +config SAMSUNG_ATAGS
  +	def_bool n
  +	depends on !ARCH_MULTIPLATFORM
  +	depends on ATAGS
  +	help
  +	   This option enables ATAGS based boot support code for
  +	   Samsung platforms, including static platform devices, legacy
  +	   clock, timer and interrupt initialization, etc.
  +
  +	   Platforms that support only DT based boot need not to select
  +	   this option.
  +
  +if SAMSUNG_ATAGS
  +
- # timer options
-
- config SAMSUNG_HRT
- 	bool
- 	select SAMSUNG_DEV_PWM
- 	help
- 	  Use the High Resolution timer support
-
   # clock options

   config SAMSUNG_CLOCK
