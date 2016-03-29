From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Tue, 29 Mar 2016 17:35:47 -0300
Subject: [PATCH 1/3] leds: trigger: Introduce a kernel panic LED trigger
In-Reply-To: <1459283749-22451-1-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1459283749-22451-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Message-ID: <1459283749-22451-2-git-send-email-ezequiel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit introduces a new LED trigger which allows to configure
a LED to blink on a kernel panic (through panic_blink).

Notice that currently the Openmoko FreeRunner (GTA02) mach code
sets panic_blink to blink a hard-coded LED. The new trigger is
meant to introduce a generic mechanism to achieve this.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/leds/trigger/Kconfig         |  7 +++++++
 drivers/leds/trigger/Makefile        |  1 +
 drivers/leds/trigger/ledtrig-panic.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)
 create mode 100644 drivers/leds/trigger/ledtrig-panic.c

diff --git a/drivers/leds/trigger/Kconfig b/drivers/leds/trigger/Kconfig
index 5bda6a9b56bb..554f5bfbeced 100644
--- a/drivers/leds/trigger/Kconfig
+++ b/drivers/leds/trigger/Kconfig
@@ -108,4 +108,11 @@ config LEDS_TRIGGER_CAMERA
 	  This enables direct flash/torch on/off by the driver, kernel space.
 	  If unsure, say Y.
 
+config LEDS_TRIGGER_PANIC
+	bool "LED Panic Trigger"
+	depends on LEDS_TRIGGERS
+	help
+	  This allows LEDs to be configured to blink on a kernel panic.
+	  If unsure, say Y.
+
 endif # LEDS_TRIGGERS
diff --git a/drivers/leds/trigger/Makefile b/drivers/leds/trigger/Makefile
index 1abf48dacf7e..547bf5c80e52 100644
--- a/drivers/leds/trigger/Makefile
+++ b/drivers/leds/trigger/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_LEDS_TRIGGER_CPU)		+= ledtrig-cpu.o
 obj-$(CONFIG_LEDS_TRIGGER_DEFAULT_ON)	+= ledtrig-default-on.o
 obj-$(CONFIG_LEDS_TRIGGER_TRANSIENT)	+= ledtrig-transient.o
 obj-$(CONFIG_LEDS_TRIGGER_CAMERA)	+= ledtrig-camera.o
+obj-$(CONFIG_LEDS_TRIGGER_PANIC)	+= ledtrig-panic.o
diff --git a/drivers/leds/trigger/ledtrig-panic.c b/drivers/leds/trigger/ledtrig-panic.c
new file mode 100644
index 000000000000..627b350c5ec3
--- /dev/null
+++ b/drivers/leds/trigger/ledtrig-panic.c
@@ -0,0 +1,30 @@
+/*
+ * Kernel Panic LED Trigger
+ *
+ * Copyright 2016 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/leds.h>
+
+static struct led_trigger *trigger;
+
+static long led_panic_blink(int state)
+{
+	led_trigger_event(trigger, state ? LED_FULL : LED_OFF);
+	return 0;
+}
+
+static int __init ledtrig_panic_init(void)
+{
+	led_trigger_register_simple("panic", &trigger);
+	panic_blink = led_panic_blink;
+	return 0;
+}
+device_initcall(ledtrig_panic_init);
-- 
2.7.0
