From: jg1.han@samsung.com (Jingoo Han)
Date: Mon, 10 Feb 2014 10:07:20 +0900
Subject: [PATCH 0/7] Remove HAVE_PWM config option
Message-ID: <003901cf25fc$73002790$590076b0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HAVE_PWM symbol is only for legacy platforms that provide
the PWM API without using the generic framework, while PWM symbol
is used for PWM drivers using the generic PWM framework.

I looked at all HAVE_PWMs in the latest mainline kernel 3.14-rc1.
Three platforms are still using HAVE_PWM as below:

1. ARM - PXA
  ./arch/arm/mach-pxa/Kconfig

2. ARM - NXP LPC32XX
  ./arch/arm/Kconfig
  config ARCH_LPC32XX
  	select HAVE_PWM

3. MIPS - Ingenic JZ4740 based machines
  ./arch/mips/Kconfig
  config MACH_JZ4740
  	select HAVE_PWM

However, the legacy PWM drivers for PXA, LPC32XX, and JZ474 were
already moved to the generic PWM framework.
  ./drivers/pwm/pwm-pxa.c
  ./drivers/pwm/pwm-lpc32xx.c
  ./drivers/pwm/pwm-jz4740.c

In conclusion, HAVE_PWM should be removed, because HAVE_PWM is
NOT required anymore.

Jingoo Han (7):
      ARM: pxa: don't select HAVE_PWM
      ARM: lpc32xx: don't select HAVE_PWM
      ARM: remove HAVE_PWM config option
      MIPS: jz4740: don't select HAVE_PWM
      Input: max8997_haptic: remove HAVE_PWM dependencies
      Input: pwm-beepe: remove HAVE_PWM dependencies
      pwm: don't use IS_ENABLED(CONFIG_HAVE_PWM)

 arch/arm/Kconfig           |    4 ----
 arch/arm/mach-pxa/Kconfig  |   15 ---------------
 arch/mips/Kconfig          |    1 -
 drivers/input/misc/Kconfig |    4 ++--
 include/linux/pwm.h        |    2 +-
 5 files changed, 3 insertions(+), 23 deletions(-)

I would like to merge these patches as below:

1. Through arm-soc tree
  [PATCH 1/7] ARM: pxa: don't select HAVE_PWM
  [PATCH 2/7] ARM: lpc32xx: don't select HAVE_PWM
  [PATCH 3/7] ARM: remove HAVE_PWM config option

2. Through MIPS tree
  [PATCH 4/7] MIPS: jz4740: don't select HAVE_PWM

3. Through Input tree
  [PATCH 5/7] Input: max8997_haptic: remove HAVE_PWM dependencies
  [PATCH 6/7] Input: pwm-beepe: remove HAVE_PWM dependencies

4. Through PWM tree
  [PATCH 7/7] pwm: don't use IS_ENABLED(CONFIG_HAVE_PWM)

After merging these patches, all HAVE_PWM will be removed from
the mainline kernel. Thank you. :-)

Best regards,
Jingoo Han
