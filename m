From: konkers@android.com (Erik Gilling)
Date: Mon, 14 Jun 2010 14:10:27 -0700
Subject: [PATCH v3 11/11] [ARM] tegra: add panel support to harmony board files
In-Reply-To: <1276549827-2688-11-git-send-email-konkers@android.com>
References: <1271198563-10424-1-git-send-email-konkers@android.com>
	<1276549827-2688-1-git-send-email-konkers@android.com>
	<1276549827-2688-2-git-send-email-konkers@android.com>
	<1276549827-2688-3-git-send-email-konkers@android.com>
	<1276549827-2688-4-git-send-email-konkers@android.com>
	<1276549827-2688-5-git-send-email-konkers@android.com>
	<1276549827-2688-6-git-send-email-konkers@android.com>
	<1276549827-2688-7-git-send-email-konkers@android.com>
	<1276549827-2688-8-git-send-email-konkers@android.com>
	<1276549827-2688-9-git-send-email-konkers@android.com>
	<1276549827-2688-10-git-send-email-konkers@android.com>
	<1276549827-2688-11-git-send-email-konkers@android.com>
Message-ID: <1276549827-2688-12-git-send-email-konkers@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Erik Gilling <konkers@android.com>
---
 arch/arm/mach-tegra/Makefile              |    1 +
 arch/arm/mach-tegra/board-harmony-panel.c |   65 +++++++++++++++++++++++++++++
 arch/arm/mach-tegra/board-harmony.c       |    1 +
 arch/arm/mach-tegra/board-harmony.h       |    1 +
 4 files changed, 68 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/board-harmony-panel.c

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 51e9370..c832aa8 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
 
 obj-${CONFIG_MACH_HARMONY}              += board-harmony.o
 obj-${CONFIG_MACH_HARMONY}              += board-harmony-pinmux.o
+obj-${CONFIG_MACH_HARMONY}              += board-harmony-panel.o
diff --git a/arch/arm/mach-tegra/board-harmony-panel.c b/arch/arm/mach-tegra/board-harmony-panel.c
new file mode 100644
index 0000000..79b83f1
--- /dev/null
+++ b/arch/arm/mach-tegra/board-harmony-panel.c
@@ -0,0 +1,65 @@
+/*
+ * arch/arm/mach-tegra/board-harmony-panel.c
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/resource.h>
+#include <linux/platform_device.h>
+#include <asm/mach-types.h>
+#include <mach/irqs.h>
+#include <mach/iomap.h>
+#include <mach/tegra_fb.h>
+
+/* Framebuffer */
+static struct resource fb_resource[] = {
+	[0] = {
+		.start  = INT_DISPLAY_GENERAL,
+		.end    = INT_DISPLAY_GENERAL,
+		.flags  = IORESOURCE_IRQ,
+	},
+	[1] = {
+		.start	= TEGRA_DISPLAY_BASE,
+		.end	= TEGRA_DISPLAY_BASE + TEGRA_DISPLAY_SIZE-1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[2] = {
+		.start	= 0x1c012000,
+		.end	= 0x1c012000 + 0x500000 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct tegra_fb_lcd_data tegra_fb_lcd_platform_data = {
+	.lcd_xres	= 1024,
+	.lcd_yres	= 600,
+	.fb_xres	= 1024,
+	.fb_yres	= 600,
+	.bits_per_pixel	= 16,
+};
+
+static struct platform_device tegra_fb_device = {
+	.name		= "tegrafb",
+	.id		= 0,
+	.resource	= fb_resource,
+	.num_resources	= ARRAY_SIZE(fb_resource),
+	.dev = {
+		.platform_data = &tegra_fb_lcd_platform_data,
+	},
+};
+
+void __init harmony_panel_init(void)
+{
+	platform_device_register(&tegra_fb_device);
+}
+
diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index 05e78dd..5887311 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -111,6 +111,7 @@ static void __init tegra_harmony_init(void)
 	tegra_clk_init_from_table(harmony_clk_init_table);
 
 	harmony_pinmux_init();
+	harmony_panel_init();
 
 	platform_add_devices(harmony_devices, ARRAY_SIZE(harmony_devices));
 }
diff --git a/arch/arm/mach-tegra/board-harmony.h b/arch/arm/mach-tegra/board-harmony.h
index 09ca775..94053c9 100644
--- a/arch/arm/mach-tegra/board-harmony.h
+++ b/arch/arm/mach-tegra/board-harmony.h
@@ -18,5 +18,6 @@
 #define _MACH_TEGRA_BOARD_HARMONY_H
 
 void harmony_pinmux_init(void);
+void harmony_panel_init(void);
 
 #endif
-- 
1.6.5.6
