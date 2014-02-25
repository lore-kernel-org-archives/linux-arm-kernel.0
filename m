From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 25 Feb 2014 18:34:01 +0100
Subject: [PATCH v3 3/5] ARM: kirkwood: Add HP T5325 thin client
In-Reply-To: <1393349643-6652-1-git-send-email-andrew@lunn.ch>
References: <1393349643-6652-1-git-send-email-andrew@lunn.ch>
Message-ID: <1393349643-6652-4-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the kirkwood t5325-setup.c to mostly device tree for
mach-mvebu. Part of the audio setup needs to remain in C for the
moment until suitable bindings are designed and implemented. So add
board code, triggered by the compatibility string.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
v2:
Remove spaces around KEY_POWER
Correct indentation of help text in Kconfig.
Put dts file into a patch of its own.
v3:
Defer dts Makefile patch to next patch.
---
 arch/arm/mach-mvebu/Kconfig       |  7 +++++++
 arch/arm/mach-mvebu/Makefile      |  1 +
 arch/arm/mach-mvebu/board-t5325.c | 41 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mvebu/board.h       | 22 +++++++++++++++++++++
 arch/arm/mach-mvebu/kirkwood.c    | 11 ++++++++++-
 5 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-mvebu/board-t5325.c
 create mode 100644 arch/arm/mach-mvebu/board.h

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 529f9164a8ca..5de7ada19191 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -92,6 +92,13 @@ config MACH_KIRKWOOD
 	  Say 'Y' here if you want your kernel to support boards based
 	  on the Marvell Kirkwood device tree.
 
+config MACH_T5325
+	bool "HP T5325 thin client"
+	depends on MACH_KIRKWOOD
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  HP T5325 Thin client
+
 endmenu
 
 endif
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index d7672f1c8a6a..bbeb41ee3e75 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_ARCH_MVEBU)	 += coherency.o coherency_ll.o pmsu.o
 obj-$(CONFIG_SMP)                += platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)        += hotplug.o
 obj-$(CONFIG_MACH_KIRKWOOD)	 += kirkwood.o kirkwood-pm.o
+obj-$(CONFIG_MACH_T5325)	 += board-t5325.o
diff --git a/arch/arm/mach-mvebu/board-t5325.c b/arch/arm/mach-mvebu/board-t5325.c
new file mode 100644
index 000000000000..65ace6db9f28
--- /dev/null
+++ b/arch/arm/mach-mvebu/board-t5325.c
@@ -0,0 +1,41 @@
+/*
+ * HP T5325 Board Setup
+ *
+ * Copyright (C) 2014
+ *
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <sound/alc5623.h>
+#include "board.h"
+
+static struct platform_device hp_t5325_audio_device = {
+	.name		= "t5325-audio",
+	.id		= -1,
+};
+
+static struct alc5623_platform_data alc5621_data = {
+	.add_ctrl = 0x3700,
+	.jack_det_ctrl = 0x4810,
+};
+
+static struct i2c_board_info i2c_board_info[] __initdata = {
+	{
+		I2C_BOARD_INFO("alc5621", 0x1a),
+		.platform_data = &alc5621_data,
+	},
+};
+
+void __init t5325_init(void)
+{
+	i2c_register_board_info(0, i2c_board_info, ARRAY_SIZE(i2c_board_info));
+	platform_device_register(&hp_t5325_audio_device);
+}
diff --git a/arch/arm/mach-mvebu/board.h b/arch/arm/mach-mvebu/board.h
new file mode 100644
index 000000000000..de7f0a191394
--- /dev/null
+++ b/arch/arm/mach-mvebu/board.h
@@ -0,0 +1,22 @@
+/*
+ * Board functions for Marvell System On Chip
+ *
+ * Copyright (C) 2014
+ *
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ARCH_MVEBU_BOARD_H
+#define __ARCH_MVEBU_BOARD_H
+
+#ifdef CONFIG_MACH_T5325
+void t5325_init(void);
+#else
+static inline void t5325_init(void) {};
+#endif
+
+#endif
diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkwood.c
index 8a38b10532e5..120207fc36f1 100644
--- a/arch/arm/mach-mvebu/kirkwood.c
+++ b/arch/arm/mach-mvebu/kirkwood.c
@@ -25,6 +25,7 @@
 #include "kirkwood.h"
 #include "kirkwood-pm.h"
 #include "common.h"
+#include "board.h"
 
 static struct resource kirkwood_cpufreq_resources[] = {
 	[0] = {
@@ -158,6 +159,11 @@ void kirkwood_disable_mbus_error_propagation(void)
 	writel(readl(cpu_config) & ~CPU_CONFIG_ERROR_PROP, cpu_config);
 }
 
+static struct of_dev_auxdata auxdata[] __initdata = {
+	OF_DEV_AUXDATA("marvell,kirkwood-audio", 0xf10a0000,
+		       "mvebu-audio", NULL),
+	{ /* sentinel */ }
+};
 
 static void __init kirkwood_dt_init(void)
 {
@@ -174,7 +180,10 @@ static void __init kirkwood_dt_init(void)
 	kirkwood_pm_init();
 	kirkwood_dt_eth_fixup();
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	if (of_machine_is_compatible("hp,t5325"))
+		t5325_init();
+
+	of_platform_populate(NULL, of_default_bus_match_table, auxdata, NULL);
 }
 
 static const char * const kirkwood_dt_board_compat[] = {
-- 
1.8.5.3
