From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  1 Jul 2016 08:42:13 +0200
Subject: [PATCH] gpio: document how to order GPIO controllers
Message-ID: <1467355333-8813-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This uses the same approach that is already used for spi, i2c and
several other controllers to ensure a consistent numbering independent
of probe order. This is in use for several gpio drivers that already now
use of_alias_get_id(np, "gpio").

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

Linus requested such a patch as part of a change that introduces
this mechanism to the gpio-omap driver[1]. IMHO this is better done in a
separate patch, so here it comes.

Best regards
Uwe

[1] http://thread.gmane.org/gmane.linux.kernel.gpio/17399/focus=17629

 Documentation/devicetree/bindings/gpio/gpio.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio.txt b/Documentation/devicetree/bindings/gpio/gpio.txt
index 68d28f62a6f4..5dbacc8f094a 100644
--- a/Documentation/devicetree/bindings/gpio/gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio.txt
@@ -227,6 +227,24 @@ Example of two SOC GPIO banks defined as gpio-controller nodes:
 		#gpio-cells = <2>;
 	};
 
+Usually the GPIO banks in SoCs are ordered, that is there is a dedicated "first
+gpio bank". To fix this ordering in the device tree use aliases starting at 0
+(even if the first bank is called "GPIO1" in the hardware reference).
+This is necessary/handy to ensure deterministical numbering of GPIOs and GPIO
+controllers.
+
+Example of a machine having 4 GPIO banks.
+
+	/ {
+		aliases {
+			...
+			gpio0 = &gpio1;
+			gpio1 = &gpio2;
+			gpio2 = &gpio3;
+			gpio3 = &gpio4;
+		};
+	};
+
 2.1) gpio- and pin-controller interaction
 -----------------------------------------
 
-- 
2.8.1
