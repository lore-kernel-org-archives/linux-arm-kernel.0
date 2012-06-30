From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sat, 30 Jun 2012 14:08:55 +0200
Subject: [PATCH 03/10] ARM: S3C24XX: Convert QT2410 board file to the gpiolib
 API
In-Reply-To: <1341058142-30438-1-git-send-email-sylvester.nawrocki@gmail.com>
References: <1341058142-30438-1-git-send-email-sylvester.nawrocki@gmail.com>
Message-ID: <1341058142-30438-4-git-send-email-sylvester.nawrocki@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace SoC specific GPIO functions with the gpiolib API. The LED
gpio is freed right after it is configured so it can be acquired
in the s3c24xx_led driver.

This change is required for converting the s3c24xx_led driver
to the gpiolib API.

Cc: laforge at openmoko.org
Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
---
This change was only compile tested. If there is someone still
using this board please provide a "Tested-by" tag.
---
 arch/arm/mach-s3c24xx/mach-qt2410.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-qt2410.c b/arch/arm/mach-s3c24xx/mach-qt2410.c
index b868ddd..678bbca 100644
--- a/arch/arm/mach-s3c24xx/mach-qt2410.c
+++ b/arch/arm/mach-s3c24xx/mach-qt2410.c
@@ -47,7 +47,6 @@
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
-#include <mach/regs-gpio.h>
 #include <mach/leds-gpio.h>
 #include <mach/regs-lcd.h>
 #include <plat/regs-serial.h>
@@ -325,8 +324,9 @@ static void __init qt2410_machine_init(void)
 	}
 	s3c24xx_fb_set_platdata(&qt2410_fb_info);
 
-	s3c_gpio_cfgpin(S3C2410_GPB(0), S3C2410_GPIO_OUTPUT);
-	s3c2410_gpio_setpin(S3C2410_GPB(0), 1);
+	/* set initial state of the LED GPIO */
+	WARN_ON(gpio_request_one(S3C2410_GPB(0), GPIOF_OUT_INIT_HIGH, NULL));
+	gpio_free(S3C2410_GPB(0));
 
 	s3c24xx_udc_set_platdata(&qt2410_udc_cfg);
 	s3c_i2c0_set_platdata(NULL);
-- 
1.7.4.1
