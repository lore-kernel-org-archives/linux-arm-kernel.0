From: bryan.wu@canonical.com (Bryan Wu)
Date: Mon, 13 Jun 2011 14:39:45 +0800
Subject: [PATCH 6/6] arm: footbridge: convert old leds event driver to led
	trigger drivers of EBSA285
In-Reply-To: <1307947185-5159-1-git-send-email-bryan.wu@canonical.com>
References: <1307947185-5159-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <1307947185-5159-7-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/mach-footbridge/Kconfig        |    6 ++
 arch/arm/mach-footbridge/Makefile       |    4 -
 arch/arm/mach-footbridge/ebsa285-leds.c |  139 -------------------------------
 arch/arm/mach-footbridge/ebsa285.c      |   76 +++++++++++++++++-
 4 files changed, 81 insertions(+), 144 deletions(-)
 delete mode 100644 arch/arm/mach-footbridge/ebsa285-leds.c

diff --git a/arch/arm/mach-footbridge/Kconfig b/arch/arm/mach-footbridge/Kconfig
index 46adca0..2a575df 100644
--- a/arch/arm/mach-footbridge/Kconfig
+++ b/arch/arm/mach-footbridge/Kconfig
@@ -52,6 +52,12 @@ config ARCH_EBSA285_HOST
 	select ISA
 	select ISA_DMA
 	select PCI
+	select NEW_LEDS
+	select LEDS_CLASS
+	select LEDS_TRIGGERS
+	select LEDS_TRIGGER_TIMER
+	select LEDS_TRIGGER_HEARTBEAT
+
 	help
 	  Say Y here if you intend to run this kernel on the EBSA285 card
 	  in host ("central function") mode.
diff --git a/arch/arm/mach-footbridge/Makefile b/arch/arm/mach-footbridge/Makefile
index a1756c7..55f5b6d 100644
--- a/arch/arm/mach-footbridge/Makefile
+++ b/arch/arm/mach-footbridge/Makefile
@@ -9,13 +9,9 @@ obj-m			:=
 obj-n			:=
 obj-			:=
 
-leds-$(CONFIG_ARCH_EBSA285) += ebsa285-leds.o
-
 obj-$(CONFIG_ARCH_CATS) += cats.o isa-timer.o
 obj-$(CONFIG_ARCH_EBSA285) += ebsa285.o dc21285-timer.o
 obj-$(CONFIG_ARCH_NETWINDER) += netwinder.o isa-timer.o
 obj-$(CONFIG_ARCH_PERSONAL_SERVER) += personal.o dc21285-timer.o
 
-obj-$(CONFIG_LEDS)	+=$(leds-y)
-
 obj-$(CONFIG_ISA)	+= isa.o isa-rtc.o
diff --git a/arch/arm/mach-footbridge/ebsa285-leds.c b/arch/arm/mach-footbridge/ebsa285-leds.c
deleted file mode 100644
index 4e10090..0000000
--- a/arch/arm/mach-footbridge/ebsa285-leds.c
+++ /dev/null
@@ -1,139 +0,0 @@
-/*
- *  linux/arch/arm/mach-footbridge/ebsa285-leds.c
- *
- *  Copyright (C) 1998-1999 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- * EBSA-285 control routines.
- *
- * The EBSA-285 uses the leds as follows:
- *  - Green - toggles state every 50 timer interrupts
- *  - Amber - On if system is not idle
- *  - Red   - currently unused
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
-static void ebsa285_leds_event(led_event_t evt)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&leds_lock, flags);
-
-	switch (evt) {
-	case led_start:
-		hw_led_state = XBUS_LED_RED | XBUS_LED_GREEN;
-#ifndef CONFIG_LEDS_CPU
-		hw_led_state |= XBUS_LED_AMBER;
-#endif
-		led_state |= LED_STATE_ENABLED;
-		break;
-
-	case led_stop:
-		led_state &= ~LED_STATE_ENABLED;
-		break;
-
-	case led_claim:
-		led_state |= LED_STATE_CLAIMED;
-		hw_led_state = XBUS_LED_RED | XBUS_LED_GREEN | XBUS_LED_AMBER;
-		break;
-
-	case led_release:
-		led_state &= ~LED_STATE_CLAIMED;
-		hw_led_state = XBUS_LED_RED | XBUS_LED_GREEN | XBUS_LED_AMBER;
-		break;
-
-#ifdef CONFIG_LEDS_TIMER
-	case led_timer:
-		if (!(led_state & LED_STATE_CLAIMED))
-			hw_led_state ^= XBUS_LED_GREEN;
-		break;
-#endif
-
-#ifdef CONFIG_LEDS_CPU
-	case led_idle_start:
-		if (!(led_state & LED_STATE_CLAIMED))
-			hw_led_state |= XBUS_LED_AMBER;
-		break;
-
-	case led_idle_end:
-		if (!(led_state & LED_STATE_CLAIMED))
-			hw_led_state &= ~XBUS_LED_AMBER;
-		break;
-#endif
-
-	case led_halted:
-		if (!(led_state & LED_STATE_CLAIMED))
-			hw_led_state &= ~XBUS_LED_RED;
-		break;
-
-	case led_green_on:
-		if (led_state & LED_STATE_CLAIMED)
-			hw_led_state &= ~XBUS_LED_GREEN;
-		break;
-
-	case led_green_off:
-		if (led_state & LED_STATE_CLAIMED)
-			hw_led_state |= XBUS_LED_GREEN;
-		break;
-
-	case led_amber_on:
-		if (led_state & LED_STATE_CLAIMED)
-			hw_led_state &= ~XBUS_LED_AMBER;
-		break;
-
-	case led_amber_off:
-		if (led_state & LED_STATE_CLAIMED)
-			hw_led_state |= XBUS_LED_AMBER;
-		break;
-
-	case led_red_on:
-		if (led_state & LED_STATE_CLAIMED)
-			hw_led_state &= ~XBUS_LED_RED;
-		break;
-
-	case led_red_off:
-		if (led_state & LED_STATE_CLAIMED)
-			hw_led_state |= XBUS_LED_RED;
-		break;
-
-	default:
-		break;
-	}
-
-	if  (led_state & LED_STATE_ENABLED)
-		*XBUS_LEDS = hw_led_state;
-
-	spin_unlock_irqrestore(&leds_lock, flags);
-}
-
-static int __init leds_init(void)
-{
-	if (machine_is_ebsa285())
-		leds_event = ebsa285_leds_event;
-
-	leds_event(led_start);
-
-	return 0;
-}
-
-__initcall(leds_init);
diff --git a/arch/arm/mach-footbridge/ebsa285.c b/arch/arm/mach-footbridge/ebsa285.c
index fc91c85..863347b 100644
--- a/arch/arm/mach-footbridge/ebsa285.c
+++ b/arch/arm/mach-footbridge/ebsa285.c
@@ -7,6 +7,8 @@
 #include <linux/spinlock.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/leds.h>
 
 #include <asm/irq.h>
 #include <asm/mach/pci.h>
@@ -51,6 +53,79 @@ static int __init ebsa285_init_pci(void)
 
 subsys_initcall(ebsa285_init_pci);
 
+/* LEDs */
+struct ebsa285_led {
+	struct led_classdev	cdev;
+	u8			mask;
+};
+
+/*
+ * The triggers lines up below will only be used if the
+ * LED triggers are compiled in.
+ */
+static const struct {
+	const char *name;
+	const char *trigger;
+} ebsa285_leds[] = {
+	{ "ebsa285:amber", "heartbeat", },
+	{ "ebsa285:green", "timer", },
+	{ "ebsa285:red", },
+};
+
+static void ebsa285_led_set(struct led_classdev *cdev,
+			      enum led_brightness b)
+{
+	struct ebsa285_led *led = container_of(cdev,
+						 struct ebsa285_led, cdev);
+
+	if (b != LED_OFF)
+		*XBUS_LEDS |= led->mask;
+	else
+		*XBUS_LEDS &= ~led->mask;
+}
+
+static enum led_brightness ebsa285_led_get(struct led_classdev *cdev)
+{
+	struct ebsa285_led *led = container_of(cdev,
+						 struct ebsa285_led, cdev);
+
+	return (*XBUS_LEDS & led->mask) ? LED_FULL : LED_OFF;
+}
+
+static int __init ebsa285_leds_init(void)
+{
+	int i;
+
+	/* 3 LEDS All ON */
+	*XBUS_LEDS |= XBUS_LED_AMBER | XBUS_LED_GREEN | XBUS_LED_RED;
+	for (i = 0; i < ARRAY_SIZE(ebsa285_leds); i++) {
+		struct ebsa285_led *led;
+
+		led = kzalloc(sizeof(*led), GFP_KERNEL);
+		if (!led)
+			break;
+
+		led->cdev.name = ebsa285_leds[i].name;
+		led->cdev.brightness_set = ebsa285_led_set;
+		led->cdev.brightness_get = ebsa285_led_get;
+		led->cdev.default_trigger = ebsa285_leds[i].trigger;
+		led->mask = BIT(i);
+
+		if (led_classdev_register(NULL, &led->cdev) < 0) {
+			kfree(led);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Since we may have triggers on any subsystem, defer registration
+ * until after subsystem_init.
+ */
+fs_initcall(ebsa285_leds_init);
+
 MACHINE_START(EBSA285, "EBSA285")
 	/* Maintainer: Russell King */
 	.boot_params	= 0x00000100,
@@ -60,4 +135,3 @@ MACHINE_START(EBSA285, "EBSA285")
 	.init_irq	= footbridge_init_irq,
 	.timer		= &footbridge_timer,
 MACHINE_END
-
-- 
1.7.5
