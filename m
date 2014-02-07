From: jg1.han@samsung.com (Jingoo Han)
Date: Fri, 07 Feb 2014 12:05:41 +0900
Subject: [PATCH] backlight: add PWM dependencies
In-Reply-To: <201402061708.05845.arnd@arndb.de>
References: <1391518634-6472-1-git-send-email-linus.walleij@linaro.org>
 <000101cf2307$97a3c770$c6eb5650$%han@samsung.com>
 <000001cf230c$60ec1ca0$22c455e0$%han@samsung.com>
 <201402061708.05845.arnd@arndb.de>
Message-ID: <000d01cf23b1$7c1f8de0$745ea9a0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, February 07, 2014 1:08 AM, Arnd Bergmann wrote:
> On Thursday 06 February 2014, Jingoo Han wrote:
> > In the case of "CONFIG_HAVE_PWM=y && CONFIG_PWM=n", it makes
> > the problem.
> >
> > The HAVE_PWM symbol is only for legacy platforms that provide
> > the PWM API without using the generic framework. PXA looks to
> > use the generic PWM framework. Then, how about removing
> > "select HAVE_PWM" from PXA as below?
> >
> 
> I think this is correct, but we may need additional patches. I notice
> that INPUT_MAX8997_HAPTIC and INPUT_PWM_BEEPER have a dependency on
> HAVE_PWM at the moment, so those two drivers become impossible
> to select after your change.
> 
> There is also one use of HAVE_PWM outside of PXA, for ARCH_LPC32XX.
> This one seems to have the same problem.

I looked at all HAVE_PWMs in the latest mainline kernel 3.14-rc1.

1. ARM - PXA
  ./arch/arm/mach-pxa/Kconfig

2. ARM - NXP LPC32XX
  ./arc ARM - PXA h/arm/Kconfig
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

How about the following?

  [PATCH 1/7] ARM: pxa: don't select HAVE_PWM
  [PATCH 2/7] ARM: lpc32xx: don't select HAVE_PWM
  [PATCH 3/7] ARM: remove HAVE_PWM config option
  [PATCH 4/7] MIPS: jz4740: don't select HAVE_PWM
  [PATCH 5/7] Input: max8997_haptic: remove HAVE_PWM dependencies
  [PATCH 6/7] Input: pwm-beepe: remove HAVE_PWM dependencies
  [PATCH 7/7] pwm: don't use IS_ENABLED(CONFIG_HAVE_PWM)

I would like to merge it through PWM tree.
After merging these patches, all HAVE_PWM will be removed from
the mainline kernel. Thank you. :-)

Best regards,
Jingoo Han

> 
> Finally, I have recently encountered a couple of drivers
> (BACKLIGHT_LM3630A, BACKLIGHT_LP855X, BACKLIGHT_LP8788) that use
> the PWM interfaces but are missing a 'depends on PWM'. This is
> strictly speaking a different problem, but we could try to solve
> it at the same time.
> 
> 	Arnd
