From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 23 Apr 2013 17:46:21 +0200
Subject: [PATCH v3 00/13] ARM: EXYNOS: Fix Universal C210 support
Message-ID: <1366731994-7478-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series intends to fix support for Universal C210 board in mainline.
Main difference from other boards based on Exynos 4210 is that hardware
revision of the SoC used on Universal C210 does not support MCT timers
and legacy PWM timers must be used instead.

First (and the biggest) part of the series deals with cleaning up and
fixing the samsung_pwm_timer clocksource driver, that was posted
recently by Arnd. In addition the driver is prepared to share the
hardware with PWM driver that will be reworked later, since it is not
a component crucial for system operation.

Second part fixes ATAGS support of Exynos 4210 rev0 SoC, which needs
different timer initialization, using the new samsung_pwm_timer driver.

Third and last part adds Device Tree-based support for Universal C210
board by providing device tree sources for it.

On Universal C210 board, both with and without DT:

Tested-by: Tomasz Figa <t.figa@samsung.com>

Tomasz Figa (13):
  Documentation: Add device tree bindings for Samsung PWM timers
  clocksource: samsung_pwm_timer: Let platforms select the driver
  clocksource: samsung_pwm_timer: Make PWM spinlock global
  clocksource: samsung_pwm_timer: Keep all driver data in a structure
  clocksource: samsung_pwm_timer: Drop unused samsung_pwm struct
  clocksource: samsung_pwm_timer: Add support for non-DT platforms
  clocksource: samsung_pwm_timer: Use proper clockevents max_delta
  clocksource: samsung_pwm_timer: Correct programming of clock events
  clocksource: samsung_pwm_timer: Work around rounding errors in
    clockevents core
  ARM: SAMSUNG: Do not register legacy timer interrupts on Exynos
  ARM: EXYNOS: Fix support of Exynos4210 rev0 SoC
  ARM: dts: exynos4: Add node for PWM device
  ARM: dts: exynos4210: Add basic dts file for universal_c210 board

 .../devicetree/bindings/pwm/pwm-samsung.txt        |  43 +++
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/exynos4.dtsi                     |   8 +
 arch/arm/boot/dts/exynos4210-universal_c210.dts    | 352 +++++++++++++++++++++
 arch/arm/mach-exynos/Kconfig                       |   3 +-
 arch/arm/mach-exynos/common.c                      |  45 ++-
 arch/arm/mach-exynos/common.h                      |   2 +
 arch/arm/mach-exynos/mach-universal_c210.c         |   5 +-
 arch/arm/plat-samsung/Kconfig                      |   4 +-
 drivers/clocksource/Kconfig                        |   3 +-
 drivers/clocksource/samsung_pwm_timer.c            | 215 +++++++------
 include/clocksource/samsung_pwm.h                  |  11 +-
 12 files changed, 561 insertions(+), 131 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-samsung.txt
 create mode 100644 arch/arm/boot/dts/exynos4210-universal_c210.dts

-- 
1.8.2.1
