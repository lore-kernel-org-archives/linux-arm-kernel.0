From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Nov 2014 10:32:55 +0100
Subject: [PATCH 3/4] ARM: integrator: move core module LED to device tree
In-Reply-To: <1415871176-11368-1-git-send-email-linus.walleij@linaro.org>
References: <1415871176-11368-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1415871176-11368-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This gets rid of the custom LED driver in the Integrator directory
altogether and switches us over to using the syscon LEDs for this.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/integrator.dtsi | 10 +++++
 arch/arm/mach-integrator/Makefile |  2 +-
 arch/arm/mach-integrator/leds.c   | 80 ---------------------------------------
 3 files changed, 11 insertions(+), 81 deletions(-)
 delete mode 100644 arch/arm/mach-integrator/leds.c

diff --git a/arch/arm/boot/dts/integrator.dtsi b/arch/arm/boot/dts/integrator.dtsi
index 5d27087d5248..28e38f8c6b0f 100644
--- a/arch/arm/boot/dts/integrator.dtsi
+++ b/arch/arm/boot/dts/integrator.dtsi
@@ -8,6 +8,16 @@
 	core-module at 10000000 {
 		compatible = "arm,core-module-integrator", "syscon";
 		reg = <0x10000000 0x200>;
+
+		/* Use core module LED to indicate CPU load */
+		led at 0c.0 {
+			compatible = "register-bit-led";
+			offset = <0x0c>;
+			mask = <0x01>;
+			label = "integrator:core_module";
+			linux,default-trigger = "cpu0";
+			default-state = "on";
+		};
 	};
 
 	ebi at 12000000 {
diff --git a/arch/arm/mach-integrator/Makefile b/arch/arm/mach-integrator/Makefile
index ec759ded7b60..1ebe45356b09 100644
--- a/arch/arm/mach-integrator/Makefile
+++ b/arch/arm/mach-integrator/Makefile
@@ -4,7 +4,7 @@
 
 # Object file lists.
 
-obj-y					:= core.o lm.o leds.o
+obj-y					:= core.o lm.o
 obj-$(CONFIG_ARCH_INTEGRATOR_AP)	+= integrator_ap.o
 obj-$(CONFIG_ARCH_INTEGRATOR_CP)	+= integrator_cp.o
 
diff --git a/arch/arm/mach-integrator/leds.c b/arch/arm/mach-integrator/leds.c
deleted file mode 100644
index 56f243744b98..000000000000
--- a/arch/arm/mach-integrator/leds.c
+++ /dev/null
@@ -1,80 +0,0 @@
-/*
- * Driver for the 4 user LEDs found on the Integrator AP/CP baseboard
- * Based on Versatile and RealView machine LED code
- *
- * License terms: GNU General Public License (GPL) version 2
- * Author: Bryan Wu <bryan.wu@canonical.com>
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/slab.h>
-#include <linux/leds.h>
-
-#include "hardware.h"
-#include "cm.h"
-
-#if defined(CONFIG_NEW_LEDS) && defined(CONFIG_LEDS_CLASS)
-
-struct integrator_led {
-	struct led_classdev	cdev;
-};
-
-/*
- * The triggers lines up below will only be used if the
- * LED triggers are compiled in.
- */
-static const struct {
-	const char *name;
-	const char *trigger;
-} integrator_leds[] = {
-	{ "integrator:core_module", "cpu0", },
-};
-
-static void cm_led_set(struct led_classdev *cdev,
-			      enum led_brightness b)
-{
-	if (b != LED_OFF)
-		cm_control(CM_CTRL_LED, CM_CTRL_LED);
-	else
-		cm_control(CM_CTRL_LED, 0);
-}
-
-static enum led_brightness cm_led_get(struct led_classdev *cdev)
-{
-	u32 reg = cm_get();
-
-	return (reg & CM_CTRL_LED) ? LED_FULL : LED_OFF;
-}
-
-static int __init integrator_leds_init(void)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(integrator_leds); i++) {
-		struct integrator_led *led;
-
-		led = kzalloc(sizeof(*led), GFP_KERNEL);
-		if (!led)
-			break;
-
-		led->cdev.name = integrator_leds[i].name;
-		led->cdev.brightness_set = cm_led_set;
-		led->cdev.brightness_get = cm_led_get;
-		led->cdev.default_trigger = integrator_leds[i].trigger;
-
-		if (led_classdev_register(NULL, &led->cdev) < 0) {
-			kfree(led);
-			break;
-		}
-	}
-
-	return 0;
-}
-
-/*
- * Since we may have triggers on any subsystem, defer registration
- * until after subsystem_init.
- */
-fs_initcall(integrator_leds_init);
-#endif
-- 
1.9.3
