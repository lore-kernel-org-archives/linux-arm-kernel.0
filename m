From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 22 Jun 2011 19:33:03 +0200
Subject: [PATCH 1/3] leds: create a trigger for ARM CPU activity
Message-ID: <1308763983-24749-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Attempting to consolidate the ARM LED code, this removes the
custom RealView LED trigger code to turn LEDs on and off in
response to CPU activity and replace it with a standard trigger.
It uses the existing kernel hooks deep inside <asm/leds.h> to
get CPU activity.

Cc: Bryan Wu <bryan.wu@canonical.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/leds/Kconfig           |   15 +++++
 drivers/leds/Makefile          |    1 +
 drivers/leds/ledtrig-arm-cpu.c |  114 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+), 0 deletions(-)
 create mode 100644 drivers/leds/ledtrig-arm-cpu.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 713d43b..f725ae2 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -446,6 +446,21 @@ config LEDS_TRIGGER_BACKLIGHT
 
 	  If unsure, say N.
 
+# Notice that this uses the CONFIG_LEDS i.e. the "old" LEDS
+config LEDS_TRIGGER_ARM_CPU
+	bool "LED ARM CPU Trigger"
+	depends on LEDS_TRIGGERS && ARM
+	select LEDS
+	select LEDS_CPU
+	default y if ARCH_REALVIEW
+	default y if ARCH_VERSATILE
+	help
+	  This allows LEDs to be controlled by active ARM CPUs. This
+	  shows the active CPUs across an array of LEDs so you can see
+	  what CPUs are active on the system at any given moment.
+
+	  If unsure, say N.
+
 config LEDS_TRIGGER_GPIO
 	tristate "LED GPIO Trigger"
 	depends on LEDS_TRIGGERS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index bbfd2e3..a32a99c 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -53,4 +53,5 @@ obj-$(CONFIG_LEDS_TRIGGER_IDE_DISK)	+= ledtrig-ide-disk.o
 obj-$(CONFIG_LEDS_TRIGGER_HEARTBEAT)	+= ledtrig-heartbeat.o
 obj-$(CONFIG_LEDS_TRIGGER_BACKLIGHT)	+= ledtrig-backlight.o
 obj-$(CONFIG_LEDS_TRIGGER_GPIO)		+= ledtrig-gpio.o
+obj-$(CONFIG_LEDS_TRIGGER_ARM_CPU)	+= ledtrig-arm-cpu.o
 obj-$(CONFIG_LEDS_TRIGGER_DEFAULT_ON)	+= ledtrig-default-on.o
diff --git a/drivers/leds/ledtrig-arm-cpu.c b/drivers/leds/ledtrig-arm-cpu.c
new file mode 100644
index 0000000..7776d61
--- /dev/null
+++ b/drivers/leds/ledtrig-arm-cpu.c
@@ -0,0 +1,114 @@
+/*
+ * ledtrig-arm-cpu.c - LED trigger based on ARM CPU activity
+ *
+ * Copyright 2011 Linus Walleij <linus.walleij@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/leds.h>
+#include <linux/slab.h>
+#include <linux/percpu.h>
+#include <asm/leds.h>
+#include "leds.h"
+
+struct arm_cpu_trig_data {
+	struct led_classdev *led;
+};
+
+static DEFINE_PER_CPU(struct arm_cpu_trig_data *, arm_cpu_triggers);
+
+void arm_cpu_leds_event(led_event_t ledevt)
+{
+	struct arm_cpu_trig_data *trigdata = __get_cpu_var(arm_cpu_triggers);
+
+	if (!trigdata)
+		return;
+
+	/* Locate the correct CPU LED */
+
+	switch (ledevt) {
+	case led_halted:
+	case led_idle_start:
+		/* Will turn the LED off */
+		if (trigdata->led)
+			led_set_brightness(trigdata->led, LED_OFF);
+		break;
+
+	case led_idle_end:
+		/* Will turn the LED on, max brightness */
+		if (trigdata->led)
+			led_set_brightness(trigdata->led,
+					   trigdata->led->max_brightness);
+		break;
+
+	default:
+		/* Will leave the LED as it is */
+		break;
+	}
+}
+
+static void arm_cpu_trig_activate_cpu(void *data)
+{
+	struct arm_cpu_trig_data *arm_cpu_data;
+	struct led_classdev *led = data;
+	int my_cpu = smp_processor_id();
+	unsigned long target_cpu = (unsigned long) led->trigger_data;
+
+	if (target_cpu != my_cpu)
+		return;
+
+	arm_cpu_data = kzalloc(sizeof(*arm_cpu_data), GFP_KERNEL);
+	if (!arm_cpu_data)
+		return;
+
+	dev_info(led->dev, "led %s indicate activity on CPU %d\n",
+		 led->name, my_cpu);
+
+	arm_cpu_data->led = led;
+	__get_cpu_var(arm_cpu_triggers) = arm_cpu_data;
+}
+
+static void arm_cpu_trig_activate(struct led_classdev *led)
+{
+	on_each_cpu(arm_cpu_trig_activate_cpu, led, 1);
+
+	/* Hook into ARM core kernel event callback */
+	leds_event = arm_cpu_leds_event;
+}
+
+static void arm_cpu_trig_deactivate(struct led_classdev *led)
+{
+	struct arm_cpu_trig_data *arm_cpu_data = led->trigger_data;
+
+	if (arm_cpu_data)
+		kfree(arm_cpu_data);
+}
+
+static struct led_trigger arm_cpu_led_trigger = {
+	.name		= "arm-cpu",
+	.activate	= arm_cpu_trig_activate,
+	.deactivate	= arm_cpu_trig_deactivate,
+};
+
+static int __init arm_cpu_trig_init(void)
+{
+	return led_trigger_register(&arm_cpu_led_trigger);
+}
+module_init(arm_cpu_trig_init);
+
+static void __exit arm_cpu_trig_exit(void)
+{
+	led_trigger_unregister(&arm_cpu_led_trigger);
+}
+module_exit(arm_cpu_trig_exit);
+
+MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
+MODULE_DESCRIPTION("ARM CPU LED trigger");
+MODULE_LICENSE("GPL");
-- 
1.7.3.2
