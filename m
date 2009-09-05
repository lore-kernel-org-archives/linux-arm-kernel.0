From: jsgood.yang@samsung.com (=?UTF-8?B?7JaR7KeE7ISx?=)
Date: Sat, 05 Sep 2009 22:30:14 +0900
Subject: [PATCH 08/12] [ARM][S3C6410] Add platform device support for keypad
	driver
Message-ID: <00a801ca2e2d$00429510$00c7bf30$%yang@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch includes platform device information and resources support
for s3c keypad driver.

Signed-off-by: Jinsung Yang <jsgood.yang@samsung.com>
Signed-off-by: Kyeongil Kim <ki0351.kim@samsung.com>
---
 arch/arm/plat-s3c/dev-keypad.c |   66 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-s3c/dev-keypad.c

diff --git a/arch/arm/plat-s3c/dev-keypad.c b/arch/arm/plat-s3c/dev-keypad.c
new file mode 100644
index 0000000..74c5443
--- /dev/null
+++ b/arch/arm/plat-s3c/dev-keypad.c
@@ -0,0 +1,66 @@
+/* linux/arch/arm/plat-s3c/dev-keypad.c
+ *
+ * Base S3C Keypad resource and device definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/irq.h>
+#include <mach/hardware.h>
+#include <mach/map.h>
+
+#include <plat/keypad.h>
+
+static struct resource s3c_keypad_resource[] = {
+	[0] = {
+		.start = S3C_PA_KEYPAD,
+		.end   = S3C_PA_KEYPAD + S3C_SZ_KEYPAD - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_KEYPAD,
+		.end   = IRQ_KEYPAD,
+		.flags = IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device s3c_device_keypad = {
+	.name		= "s3c-keypad",
+	.id		= -1,
+	.num_resources 	= ARRAY_SIZE(s3c_keypad_resource),
+	.resource 	= s3c_keypad_resource,
+};
+EXPORT_SYMBOL(s3c_device_keypad);
+
+static struct s3c_platform_keypad default_keypad_data __initdata = {
+	.nr_rows = 8,
+	.nr_cols = 8,
+	.max_keys = 64,
+	.max_masks = 32,
+	.delay = 50,
+};
+
+void __init s3c_keypad_set_platdata(struct s3c_platform_keypad *pd)
+{
+	struct s3c_platform_keypad *npd;
+
+	if (!pd)
+		pd = &default_keypad_data;
+
+	npd = kmemdup(pd, sizeof(struct s3c_platform_keypad), GFP_KERNEL);
+	if (!npd)
+		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
+
+	s3c_device_keypad.dev.platform_data = npd;
+}
+
-- 
1.6.2.5
