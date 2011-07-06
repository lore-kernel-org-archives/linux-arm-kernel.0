From: bryan.wu@canonical.com (Bryan Wu)
Date: Wed,  6 Jul 2011 20:34:40 +0800
Subject: [PATCH 10/17] mach-ebsa110: retire custom LED code
In-Reply-To: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <1309955687-19365-11-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/Kconfig               |    4 ++
 arch/arm/mach-ebsa110/Makefile |    4 +--
 arch/arm/mach-ebsa110/leds.c   |   77 +++++++++++++++++++++++----------------
 3 files changed, 50 insertions(+), 35 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 066009a..2a37079 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -350,6 +350,10 @@ config ARCH_EBSA110
 	select ISA
 	select NO_IOPORT
 	select ARCH_USES_GETTIMEOFFSET
+	select NEW_LEDS
+	select LEDS_CLASS
+	select LEDS_TRIGGERS
+	select LEDS_TRIGGER_HEARTBEAT
 	help
 	  This is an evaluation board for the StrongARM processor available
 	  from Digital. It has limited hardware on-board, including an
diff --git a/arch/arm/mach-ebsa110/Makefile b/arch/arm/mach-ebsa110/Makefile
index 6520ac8..935e4af 100644
--- a/arch/arm/mach-ebsa110/Makefile
+++ b/arch/arm/mach-ebsa110/Makefile
@@ -4,9 +4,7 @@
 
 # Object file lists.
 
-obj-y			:= core.o io.o
+obj-y			:= core.o io.o leds.o
 obj-m			:=
 obj-n			:=
 obj-			:=
-
-obj-$(CONFIG_LEDS)	+= leds.o
diff --git a/arch/arm/mach-ebsa110/leds.c b/arch/arm/mach-ebsa110/leds.c
index 6a6ea57..a09f0e3 100644
--- a/arch/arm/mach-ebsa110/leds.c
+++ b/arch/arm/mach-ebsa110/leds.c
@@ -1,51 +1,64 @@
 /*
- *  linux/arch/arm/mach-ebsa110/leds.c
+ * Driver for the LED found on the EBSA110 machine
+ * Based on Versatile and RealView machine LED code
  *
- *  Copyright (C) 1998 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *  EBSA-110 LED control routines.  We use the led as follows:
- *
- *   - Red - toggles state every 50 timer interrupts
+ * License terms: GNU General Public License (GPL) version 2
+ * Author: Bryan Wu <bryan.wu@canonical.com>
  */
-#include <linux/module.h>
-#include <linux/spinlock.h>
+#include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/leds.h>
 
 #include <mach/hardware.h>
-#include <asm/leds.h>
-#include <asm/system.h>
-#include <asm/mach-types.h>
-
-static spinlock_t leds_lock;
 
-static void ebsa110_leds_event(led_event_t ledevt)
+static void ebsa110_led_set(struct led_classdev *cdev,
+			      enum led_brightness b)
 {
-	unsigned long flags;
+	u8 reg = __raw_readb(SOFT_BASE);
 
-	spin_lock_irqsave(&leds_lock, flags);
+	if (b != LED_OFF)
+		reg |= 0x80;
+	else
+		reg &= ~0x80;
 
-	switch(ledevt) {
-	case led_timer:
-		*(volatile unsigned char *)SOFT_BASE ^= 128;
-		break;
+	__raw_writeb(reg, SOFT_BASE);
+}
 
-	default:
-		break;
-	}
+static enum led_brightness ebsa110_led_get(struct led_classdev *cdev)
+{
+	u8 reg = __raw_readb(SOFT_BASE);
 
-	spin_unlock_irqrestore(&leds_lock, flags);
+	return (reg & 0x80) ? LED_FULL : LED_OFF;
 }
 
-static int __init leds_init(void)
+static int __init ebsa110_leds_init(void)
 {
-	if (machine_is_ebsa110())
-		leds_event = ebsa110_leds_event;
+
+	struct led_classdev *cdev;
+	int ret;
+
+	cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
+	if (!cdev)
+		return -ENOMEM;
+
+	cdev->name = "ebsa110:0";
+	cdev->brightness_set = ebsa110_led_set;
+	cdev->brightness_get = ebsa110_led_get;
+	cdev->default_trigger = "heartbeat";
+
+	ret = led_classdev_register(NULL, cdev);
+	if (ret	< 0) {
+		kfree(cdev);
+		return ret;
+	}
 
 	return 0;
 }
 
-__initcall(leds_init);
+/*
+ * Since we may have triggers on any subsystem, defer registration
+ * until after subsystem_init.
+ */
+fs_initcall(ebsa110_leds_init);
-- 
1.7.5
