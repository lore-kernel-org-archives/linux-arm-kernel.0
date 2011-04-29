From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 29 Apr 2011 14:59:10 +1200
Subject: [PATCH v3 01/23] at91: Add common devices framework
In-Reply-To: <1304045972-19319-1-git-send-email-ryan@bluewatersys.com>
References: <1304045972-19319-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1304045972-19319-2-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each AT91 variant (AT91RM9200, AT91SAM9260, etc) currently has its own
devices file, which includes the MMIO address, interrupt
configuration, GPIO setup, etc for each device. This results in a large
amount of duplicated code.

This patch introduces a framework for adding shared devices for the
AT91 platform. The subsequent patches in this series replace the
multiple device setup implementations for each device with single
implementations in the new framework.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/Makefile  |    2 +-
 arch/arm/mach-at91/devices.c |   70 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/devices.h |   36 +++++++++++++++++++++
 3 files changed, 107 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-at91/devices.c
 create mode 100644 arch/arm/mach-at91/devices.h

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index a83835e..14962f2 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-obj-y		:= irq.o gpio.o
+obj-y		:= irq.o gpio.o devices.o
 obj-m		:=
 obj-n		:=
 obj-		:=
diff --git a/arch/arm/mach-at91/devices.c b/arch/arm/mach-at91/devices.c
new file mode 100644
index 0000000..6f6e0d5
--- /dev/null
+++ b/arch/arm/mach-at91/devices.c
@@ -0,0 +1,70 @@
+/*
+ * arch/arm/mach-at91/devices.c
+ *
+ *  Copyright (C) 2011 Bluewater Systems
+ *  Copyright (C) 2011 Ryan Mallon <ryan@bluewatersys.com>
+ * 
+ * Based on code from arch/arm/mach-at91/*_devices.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+
+#include "devices.h"
+
+static struct at91_device_table *devices __initdata;
+
+static __init void at91_config_pins(struct at91_pin_config *pins, int nr_pins)
+{
+	int i;
+
+	for (i = 0; i < nr_pins; i++) {		
+		switch (pins[i].mode) {
+		case AT91_PIN_PERIPH_A:
+			at91_set_A_periph(pins[i].pin, pins[i].pullup);
+			break;
+
+		case AT91_PIN_PERIPH_B:
+			at91_set_B_periph(pins[i].pin, pins[i].pullup);
+			break;
+
+		default:
+			/* GPIO */
+			if (pins[i].direction == GPIOF_DIR_OUT)
+				at91_set_gpio_output(pins[i].pin,
+						     pins[i].value);
+			else
+				at91_set_gpio_input(pins[i].pin,
+						    pins[i].pullup);
+			break;
+		}
+	}
+}
+
+static inline void __init init_resource_mem(struct resource *res,
+					    unsigned mmio_base)
+{
+	BUG_ON(res->flags != IORESOURCE_MEM);
+	res->start = mmio_base;
+	res->end  += mmio_base - 1;
+}
+
+static inline void __init init_resource_irq(struct resource *res, int irq)
+{
+	if (irq) {
+		BUG_ON(res->flags != IORESOURCE_IRQ);
+		res->start = irq;
+		res->end   = irq;
+	}
+}
+
+void __init at91_init_devices(struct at91_device_table *device_table)
+{
+	devices = device_table;
+}
diff --git a/arch/arm/mach-at91/devices.h b/arch/arm/mach-at91/devices.h
new file mode 100644
index 0000000..738f736
--- /dev/null
+++ b/arch/arm/mach-at91/devices.h
@@ -0,0 +1,36 @@
+/*
+ * arch/arm/mach-at91/devices.h
+ *
+ *  Copyright (C) 2011 Bluewater Systems
+ *  Copyright (C) 2011 Ryan Mallon <ryan@bluewatersys.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#ifndef _AT91_DEVICES_H
+#define _AT91_DEVICES_H
+
+enum {
+	AT91_PIN_PERIPH_A,
+	AT91_PIN_PERIPH_B,
+	AT91_PIN_GPIO,
+};
+
+struct at91_pin_config {
+	int pin;
+	int mode;
+	int pullup;
+	int direction;
+	int value;
+};
+
+struct at91_device_table {
+};
+
+extern void __init at91_init_devices(struct at91_device_table *device_table);
+
+#endif /* _AT91_DEVICES_H */
-- 
1.7.0.4
