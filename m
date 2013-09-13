From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Sep 2013 10:31:42 +0200
Subject: [PATCH 2/7] input: misc: ixp4-beeper: switch to use gpiolib
Message-ID: <1379061102-22279-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform using this beeper has support for gpiolib, so there
is no point to use the custom gpio_line* API. A strange ambiguity
where a line was first set as input and then driven high was
solved by first driving the line high as output and then switch
it to input.

Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi Dmitry, requesting an ACK for this to take it through the
GPIO tree as part of an IXP4 clean-up attempt.
---
 drivers/input/misc/ixp4xx-beeper.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/input/misc/ixp4xx-beeper.c b/drivers/input/misc/ixp4xx-beeper.c
index f34beb2..f14afd0 100644
--- a/drivers/input/misc/ixp4xx-beeper.c
+++ b/drivers/input/misc/ixp4xx-beeper.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
+#include <linux/gpio.h>
 #include <mach/hardware.h>
 
 MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
@@ -35,15 +36,12 @@ static void ixp4xx_spkr_control(unsigned int pin, unsigned int count)
 
 	spin_lock_irqsave(&beep_lock, flags);
 
-	 if (count) {
-		gpio_line_config(pin, IXP4XX_GPIO_OUT);
-		gpio_line_set(pin, IXP4XX_GPIO_LOW);
-
+	if (count) {
+		gpio_direction_output(pin, 0);
 		*IXP4XX_OSRT2 = (count & ~IXP4XX_OST_RELOAD_MASK) | IXP4XX_OST_ENABLE;
 	} else {
-		gpio_line_config(pin, IXP4XX_GPIO_IN);
-		gpio_line_set(pin, IXP4XX_GPIO_HIGH);
-
+		gpio_direction_output(pin, 1);
+		gpio_direction_input(pin);
 		*IXP4XX_OSRT2 = 0;
 	}
 
-- 
1.8.3.1
