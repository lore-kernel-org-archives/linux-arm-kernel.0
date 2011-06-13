From: bryan.wu@canonical.com (Bryan Wu)
Date: Mon, 13 Jun 2011 14:39:44 +0800
Subject: [PATCH 5/6] arm: footbridge: convert old leds event driver to led
	gpio trigger driver of Netwinder
In-Reply-To: <1307947185-5159-1-git-send-email-bryan.wu@canonical.com>
References: <1307947185-5159-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <1307947185-5159-6-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/mach-footbridge/Makefile         |    1 -
 arch/arm/mach-footbridge/netwinder-leds.c |  139 -----------------------------
 arch/arm/mach-footbridge/netwinder.c      |   42 +++++++--
 3 files changed, 33 insertions(+), 149 deletions(-)
 delete mode 100644 arch/arm/mach-footbridge/netwinder-leds.c

diff --git a/arch/arm/mach-footbridge/Makefile b/arch/arm/mach-footbridge/Makefile
index d2172a9..a1756c7 100644
--- a/arch/arm/mach-footbridge/Makefile
+++ b/arch/arm/mach-footbridge/Makefile
@@ -10,7 +10,6 @@ obj-n			:=
 obj-			:=
 
 leds-$(CONFIG_ARCH_EBSA285) += ebsa285-leds.o
-leds-$(CONFIG_ARCH_NETWINDER) += netwinder-leds.o
 
 obj-$(CONFIG_ARCH_CATS) += cats.o isa-timer.o
 obj-$(CONFIG_ARCH_EBSA285) += ebsa285.o dc21285-timer.o
diff --git a/arch/arm/mach-footbridge/netwinder-leds.c b/arch/arm/mach-footbridge/netwinder-leds.c
deleted file mode 100644
index 00269fe..0000000
--- a/arch/arm/mach-footbridge/netwinder-leds.c
+++ /dev/null
@@ -1,139 +0,0 @@
-/*
- *  linux/arch/arm/mach-footbridge/netwinder-leds.c
- *
- *  Copyright (C) 1998-1999 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * NetWinder LED control routines.
- *
- * The Netwinder uses the leds as follows:
- *  - Green - toggles state every 50 timer interrupts
- *  - Red   - On if the system is not idle
- *
- * Changelog:
- *   02-05-1999	RMK	Various cleanups
- */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/spinlock.h>
-
-#include <mach/hardware.h>
-#include <asm/leds.h>
-#include <asm/mach-types.h>
-#include <asm/system.h>
-
-#define LED_STATE_ENABLED	1
-#define LED_STATE_CLAIMED	2
-static char led_state;
-static char hw_led_state;
-
-static DEFINE_SPINLOCK(leds_lock);
-
-static void netwinder_leds_event(led_event_t evt)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&leds_lock, flags);
-
-	switch (evt) {
-	case led_start:
-		led_state |= LED_STATE_ENABLED;
-		hw_led_state = GPIO_GREEN_LED;
-		break;
-
-	case led_stop:
-		led_state &= ~LED_STATE_ENABLED;
-		break;
-
-	case led_claim:
-		led_state |= LED_STATE_CLAIMED;
-		hw_led_state = 0;
-		break;
-
-	case led_release:
-		led_state &= ~LED_STATE_CLAIMED;
-		hw_led_state = 0;
-		break;
-
-#ifdef CONFIG_LEDS_TIMER
-	case led_timer:
-		if (!(led_state & LED_STATE_CLAIMED))
-			hw_led_state ^= GPIO_GREEN_LED;
-		break;
-#endif
-
-#ifdef CONFIG_LEDS_CPU
-	case led_idle_start:
-		if (!(led_state & LED_STATE_CLAIMED))
-			hw_led_state &= ~GPIO_RED_LED;
-		break;
-
-	case led_idle_end:
-		if (!(led_state & LED_STATE_CLAIMED))
-			hw_led_state |= GPIO_RED_LED;
-		break;
-#endif
-
-	case led_halted:
-		if (!(led_state & LED_STATE_CLAIMED))
-			hw_led_state |= GPIO_RED_LED;
-		break;
-
-	case led_green_on:
-		if (led_state & LED_STATE_CLAIMED)
-			hw_led_state |= GPIO_GREEN_LED;
-		break;
-
-	case led_green_off:
-		if (led_state & LED_STATE_CLAIMED)
-			hw_led_state &= ~GPIO_GREEN_LED;
-		break;
-
-	case led_amber_on:
-		if (led_state & LED_STATE_CLAIMED)
-			hw_led_state |= GPIO_GREEN_LED | GPIO_RED_LED;
-		break;
-
-	case led_amber_off:
-		if (led_state & LED_STATE_CLAIMED)
-			hw_led_state &= ~(GPIO_GREEN_LED | GPIO_RED_LED);
-		break;
-
-	case led_red_on:
-		if (led_state & LED_STATE_CLAIMED)
-			hw_led_state |= GPIO_RED_LED;
-		break;
-
-	case led_red_off:
-		if (led_state & LED_STATE_CLAIMED)
-			hw_led_state &= ~GPIO_RED_LED;
-		break;
-
-	default:
-		break;
-	}
-
-	spin_unlock_irqrestore(&leds_lock, flags);
-
-	if  (led_state & LED_STATE_ENABLED) {
-		spin_lock_irqsave(&nw_gpio_lock, flags);
-		nw_gpio_modify_op(GPIO_RED_LED | GPIO_GREEN_LED, hw_led_state);
-		spin_unlock_irqrestore(&nw_gpio_lock, flags);
-	}
-}
-
-static int __init leds_init(void)
-{
-	if (machine_is_netwinder())
-		leds_event = netwinder_leds_event;
-
-	leds_event(led_start);
-
-	return 0;
-}
-
-__initcall(leds_init);
diff --git a/arch/arm/mach-footbridge/netwinder.c b/arch/arm/mach-footbridge/netwinder.c
index c4e5139..62f3eeb 100644
--- a/arch/arm/mach-footbridge/netwinder.c
+++ b/arch/arm/mach-footbridge/netwinder.c
@@ -13,7 +13,9 @@
 #include <linux/io.h>
 #include <linux/spinlock.h>
 #include <linux/pci.h>
-
+#include <linux/leds.h>
+#include <linux/gpio.h>
+#include <linux/platform_device.h>
 
 #include <asm/irq.h>
 #include <asm/mach/pci.h>
@@ -30,13 +32,6 @@
 #define GP1_IO_BASE		0x338
 #define GP2_IO_BASE		0x33a
 
-
-#ifdef CONFIG_LEDS
-#define DEFAULT_LEDS	0
-#else
-#define DEFAULT_LEDS	GPIO_GREEN_LED
-#endif
-
 /*
  * Winbond WB83977F accessibility stuff
  */
@@ -606,6 +601,33 @@ static void __init rwa010_init(void)
 	rwa010_soundblaster_reset();
 }
 
+/* LEDs */
+static struct gpio_led nw_gpio_leds[] = {
+        {
+                .name                   = "netwinder::led_red",
+                .default_trigger        = "heartbeat",
+                .gpio                   = GPIO_RED_LED,
+        },
+        {
+                .name                   = "netwinder::led_green",
+                .default_trigger        = "timer",
+                .gpio                   = GPIO_GREEN_LED,
+        },
+};
+
+static struct gpio_led_platform_data nw_gpio_led_info = {
+        .leds           = nw_gpio_leds,
+        .num_leds       = ARRAY_SIZE(nw_gpio_leds),
+};
+
+static struct platform_device nw_leds_gpio = {
+        .name   = "leds-gpio",
+        .id     = -1,
+        .dev    = {
+                .platform_data  = &nw_gpio_led_info,
+        },
+};
+
 /*
  * Initialise any other hardware after we've got the PCI bus
  * initialised.  We may need the PCI bus to talk to this other
@@ -621,8 +643,10 @@ static int __init nw_hw_init(void)
 		rwa010_init();
 
 		spin_lock_irqsave(&nw_gpio_lock, flags);
-		nw_gpio_modify_op(GPIO_RED_LED|GPIO_GREEN_LED, DEFAULT_LEDS);
+		nw_gpio_modify_op(GPIO_RED_LED|GPIO_GREEN_LED, 0);
 		spin_unlock_irqrestore(&nw_gpio_lock, flags);
+
+		platform_device_register(&nw_leds_gpio);
 	}
 	return 0;
 }
-- 
1.7.5
