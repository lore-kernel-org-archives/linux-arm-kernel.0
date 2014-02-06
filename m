From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 6 Feb 2014 17:08:05 +0100
Subject: [PATCH] backlight: add PWM dependencies
In-Reply-To: <000001cf230c$60ec1ca0$22c455e0$%han@samsung.com>
References: <1391518634-6472-1-git-send-email-linus.walleij@linaro.org>
 <000101cf2307$97a3c770$c6eb5650$%han@samsung.com>
 <000001cf230c$60ec1ca0$22c455e0$%han@samsung.com>
Message-ID: <201402061708.05845.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 February 2014, Jingoo Han wrote:
> In the case of "CONFIG_HAVE_PWM=y && CONFIG_PWM=n", it makes
> the problem.
> 
> The HAVE_PWM symbol is only for legacy platforms that provide
> the PWM API without using the generic framework. PXA looks to
> use the generic PWM framework. Then, how about removing
> "select HAVE_PWM" from PXA as below?
> 

I think this is correct, but we may need additional patches. I notice
that INPUT_MAX8997_HAPTIC and INPUT_PWM_BEEPER have a dependency on
HAVE_PWM at the moment, so those two drivers become impossible
to select after your change.

There is also one use of HAVE_PWM outside of PXA, for ARCH_LPC32XX.
This one seems to have the same problem.

Finally, I have recently encountered a couple of drivers
(BACKLIGHT_LM3630A, BACKLIGHT_LP855X, BACKLIGHT_LP8788) that use
the PWM interfaces but are missing a 'depends on PWM'. This is
strictly speaking a different problem, but we could try to solve
it at the same time.

	Arnd
