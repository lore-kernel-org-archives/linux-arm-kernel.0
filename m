From: jochen@scram.de (Jochen Friedrich)
Date: Fri, 29 Apr 2011 17:16:55 +0200
Subject: [PATCHv4 2.6.40 4/4] ARM: simpad: replace ARM specific LED code
In-Reply-To: <1304090215-7457-1-git-send-email-jochen@scram.de>
References: <1304090215-7457-1-git-send-email-jochen@scram.de>
Message-ID: <1304090215-7457-5-git-send-email-jochen@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the legacy ARM LED code for simpad devices and
register a stadard LED platform device using GPIO line
instead.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/arm/mach-sa1100/Makefile      |    1 -
 arch/arm/mach-sa1100/leds-simpad.c |   97 ------------------------------------
 arch/arm/mach-sa1100/leds.c        |    2 -
 arch/arm/mach-sa1100/leds.h        |    1 -
 arch/arm/mach-sa1100/simpad.c      |   28 ++++++++++
 5 files changed, 28 insertions(+), 101 deletions(-)
 delete mode 100644 arch/arm/mach-sa1100/leds-simpad.c

diff --git a/arch/arm/mach-sa1100/Makefile b/arch/arm/mach-sa1100/Makefile
index 41252d2..0063178 100644
--- a/arch/arm/mach-sa1100/Makefile
+++ b/arch/arm/mach-sa1100/Makefile
@@ -45,7 +45,6 @@ obj-$(CONFIG_SA1100_PLEB)		+= pleb.o
 obj-$(CONFIG_SA1100_SHANNON)		+= shannon.o
 
 obj-$(CONFIG_SA1100_SIMPAD)		+= simpad.o
-led-$(CONFIG_SA1100_SIMPAD)		+= leds-simpad.o
 
 # LEDs support
 obj-$(CONFIG_LEDS) += $(led-y)
diff --git a/arch/arm/mach-sa1100/leds-simpad.c b/arch/arm/mach-sa1100/leds-simpad.c
deleted file mode 100644
index d25784c..0000000
--- a/arch/arm/mach-sa1100/leds-simpad.c
+++ /dev/null
@@ -1,97 +0,0 @@
-/*
- * linux/arch/arm/mach-sa1100/leds-simpad.c
- *
- * Author: Juergen Messerer <juergen.messerer@siemens.ch>
- */
-#include <linux/init.h>
-
-#include <mach/hardware.h>
-#include <asm/leds.h>
-#include <asm/system.h>
-#include <mach/simpad.h>
-
-#include "leds.h"
-
-
-#define LED_STATE_ENABLED	1
-#define LED_STATE_CLAIMED	2
-
-static unsigned int led_state;
-static unsigned int hw_led_state;
-
-#define	LED_GREEN	(1)
-#define	LED_MASK	(1)
-
-void simpad_leds_event(led_event_t evt)
-{
-	switch (evt)
-	{
-	case led_start:
-	        hw_led_state = LED_GREEN;
-		led_state = LED_STATE_ENABLED;
-		break;
-
-	case led_stop:
-		led_state &= ~LED_STATE_ENABLED;
-		break;
-
-	case led_claim:
-		led_state |= LED_STATE_CLAIMED;
-		hw_led_state = LED_GREEN;
-		break;
-
-	case led_release:
-		led_state &= ~LED_STATE_CLAIMED;
-		hw_led_state = LED_GREEN;
-		break;
-
-#ifdef CONFIG_LEDS_TIMER
-	case led_timer:
-		if (!(led_state & LED_STATE_CLAIMED))
-			hw_led_state ^= LED_GREEN;
-		break;
-#endif
-
-#ifdef CONFIG_LEDS_CPU
-	case led_idle_start:
-		break;
-
-	case led_idle_end:
-		break;
-#endif
-
-	case led_halted:
-		break;
-
-	case led_green_on:
-		if (led_state & LED_STATE_CLAIMED)
-			hw_led_state |= LED_GREEN;
-		break;
-
-	case led_green_off:
-		if (led_state & LED_STATE_CLAIMED)
-			hw_led_state &= ~LED_GREEN;
-		break;
-
-	case led_amber_on:
-		break;
-
-	case led_amber_off:
-		break;
-
-	case led_red_on:
-		break;
-
-	case led_red_off:
-		break;
-
-	default:
-		break;
-	}
-
-	if  (led_state & LED_STATE_ENABLED)
-		simpad_set_cs3_bit(LED2_ON);
-	else 
-		simpad_clear_cs3_bit(LED2_ON);
-}
-
diff --git a/arch/arm/mach-sa1100/leds.c b/arch/arm/mach-sa1100/leds.c
index bbfe197..5fe71a0 100644
--- a/arch/arm/mach-sa1100/leds.c
+++ b/arch/arm/mach-sa1100/leds.c
@@ -42,8 +42,6 @@ sa1100_leds_init(void)
 		leds_event = adsbitsy_leds_event;
 	if (machine_is_pt_system3())
 		leds_event = system3_leds_event;
-	if (machine_is_simpad())
-		leds_event = simpad_leds_event; /* what about machine registry? including led, apm... -zecke */
 
 	leds_event(led_start);
 	return 0;
diff --git a/arch/arm/mach-sa1100/leds.h b/arch/arm/mach-sa1100/leds.h
index 68cc9f7..776b602 100644
--- a/arch/arm/mach-sa1100/leds.h
+++ b/arch/arm/mach-sa1100/leds.h
@@ -11,4 +11,3 @@ extern void pfs168_leds_event(led_event_t evt);
 extern void graphicsmaster_leds_event(led_event_t evt);
 extern void adsbitsy_leds_event(led_event_t evt);
 extern void system3_leds_event(led_event_t evt);
-extern void simpad_leds_event(led_event_t evt);
diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index d1a13bb..b9c8e39 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -31,6 +31,7 @@
 #include <linux/ioport.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
+#include <linux/leds.h>
 #include <linux/i2c-gpio.h>
 
 #include "generic.h"
@@ -295,6 +296,32 @@ static struct platform_device simpad_polled_keys = {
 };
 
 /*
+ * GPIO LEDs
+ */
+
+static struct gpio_led simpad_leds[] = {
+	{
+		.name = "power",
+		.gpio = SIMPAD_CS3_LED2_ON,
+		.active_low = 0,
+		.default_trigger = "default-on",
+	},
+};
+
+static struct gpio_led_platform_data simpad_led_data = {
+	.num_leds = 1,
+	.leds = simpad_leds,
+};
+
+static struct platform_device simpad_gpio_leds = {
+	.name = "leds-gpio",
+	.id = 0,
+	.dev = {
+		.platform_data = &simpad_led_data,
+	},
+};
+
+/*
  * i2c
  */
 static struct i2c_gpio_platform_data simpad_i2c_data = {
@@ -324,6 +351,7 @@ static struct platform_device *devices[] __initdata = {
 	&simpad_keys,
 	&simpad_polled_keys,
 	&simpad_mq200fb,
+	&simpad_gpio_leds,
 	&simpad_i2c,
 };
 
-- 
1.7.4.1
